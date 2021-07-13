# -*- coding: utf-8 -*-
"""hptestbench: OpenModelica Heatpump Testbench in Python.

Copyright (C) 2019 Joris Nettelstroth

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see https://www.gnu.org/licenses/.


hptestbench
===========

This Python package allows simulating heatpumps with OpenModelica, in order
to evaluate their performance and integrate the results in other workflows.

TODO: "Installation" of different heatpump does not actually work,
because setElementModifierValue() is not behaving as expected. See:
https://github.com/OpenModelica/OpenModelica/issues/7182
"""

import os
import sys
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import logging

# Define the logging function
logger = logging.getLogger(__name__)

# Use Pandas plotting style with matplotlib
pd.plotting.register_matplotlib_converters()


def main():
    """Run the main workflow with the heatpump testbench."""
    # Create our testbench:
    bench = testbench()

    # Optionally, install a specific heat pump
    # bench.install_HP('Q100_air_water_001')  # optional (custom)
    # bench.install_HP('EN14511.AlphaInnotec_SW170I')  # optional (AixLib)
    # bench.install_HP('EN14511.Vitocal350BWH113')  # optional (AixLib)

    # Run the simulation with Modelica
    bench.test_with_modelica(make_FMU=True)

    # (or) Run the simulation via the functional mockup interface (FMI)
    # bench.test_with_FMU()

    # Evaluate the results
    data = bench.evaluate()
    COP_mean = data['heatPump_IO.COP'].mean()

    logger.info('The annual mean COP is {:.3f}'.format(COP_mean))


class testbench(object):
    """The heatpump testbench.

    Prepare, (optionally) install a heatpump, test, and evaluate the results.
    """

    def __init__(self):
        """Set all required options of ``self``.

        This includes the modelica model name, the weather data (its location
        is user dependend), simulation times and the desired solutions.

        .. note::
            We change directory to a simulation folder
        """
        # Create and change to a subdirectory to create all simulation
        # files there
        sim_dir = os.path.join(
                os.path.dirname(os.path.abspath(__file__)),
                '..', 'modelica',
                'sim_'+sys.platform  # separate windows and linux
                )
        if os.path.exists(sim_dir) is False:
            os.mkdir(sim_dir)
        os.chdir(sim_dir)

        # We need to be careful with file paths. Modelica does not seem
        # to work with relative paths. Therefore we have to replace the
        # absolute path with Python
        weather_file_rel = '../TRY2015_541957091051_Jahr.mos'
        weather_file_abs = os.path.abspath(weather_file_rel)

        model_path = r'../'  # Path relative to our sim folder!
        self.fileName = os.path.join(model_path, 'HP_testbench.mo')
        self.modelName = 'HP_testbench.HeatPump_weather'
        self.FMU_path = self.modelName+'.fmu'

        self.stepSize = 60*15  # seconds
        self.stopTime = 60*60*24*365  # seconds

        # We have to create a selection of all the results we want to read
        # from the simulation. They are grouped by types of units, to
        # allow unit conversions in post_processing()
        self.solutions = dict(
                # Convert K to °C
                temperatures=['heatPump_IO.T_evap_in',
                              'heatPump_IO.T_evap_out',
                              'heatPump_IO.T_cond_in',
                              'heatPump_IO.T_cond_out',
                              ],
                normalized=['heatPump_IO.COP'],
                # Convert W to kW
                power=['heatPump_IO.P_th_cond',
                       'heatPump_IO.P_el',
                       ],
                )

        # These paramters will be replaced in the selected models
        self.parameters = {
                'T_cond_in.k': 75+273.15,
                'dotm_co2.k': 76000/3600,
                'weaDat.filNam': weather_file_abs,
                }

        # Other settings:
        self.HP_dict = dict()  # filled by install_HP(), if necessary

    def install_HP(self, HP_select='Q100_air_water_001'):
        """Install a specific heat pump.

        Prepare the settings for ``self.HP_dict`` for a variety of
        heat pumps. Those stored in the AixLib can be called directly.
        For others, special cases have to be hardcoded here.
        ``HP_dict['path']`` becomes the path to the *.mo file that
        includes the record. ``HP_dict['replace_expression']`` stores the
        OpenModelica CLI ``setComponentModifierValue()`` expression to
        replace the data_table.

        Args:
            HP_select (str, optional): String name of a heatpump defined
            in the AixLib at ``AixLib.DataBase.HeatPump.EN255.*``.
            Defaults to 'Q100_air_water_001'.

        Returns:
            None.

        """
        if HP_select == 'Q100_air_water_001':
            # This particular heatpump is based on confidential data.
            # We load it from the owncloud folder
            database_path = os.path.join(
                    os.path.expanduser("~"),
                    'ownCloud/FhG-owncloud-Quarree-AB3/Modelica',
                    'private_database', 'HP_database.mo')

            if not os.path.exists(database_path):
                logging.warning('The following path does not exist, but is '
                                'required to load the heat pump data of "{}": '
                                '"{}".'
                                .format(HP_select, database_path))

            self.HP_dict['path'] = os.path.abspath(database_path)

            self.HP_dict['replace_expressions'] = [
                '''setElementModifierValue(
                HP_testbench.HeatPump_IO,
                heatPump.PerDataHea,
                $Code((
                    redeclare model PerDataHea =
                    AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D
                    (dataTable=HP_database.Q100_air_water_001())))
                )'''
                ]

            # Set default for FMU, depending on operating system:
            self.FMU_path = os.path.join(
                os.path.expanduser("~"),
                'ownCloud/FhG-owncloud-Quarree-AB3/Modelica/private_database',
                'Q100_air_water_001_{}.fmu'.format(sys.platform))

        else:
            # Assume the heatpump is part of the AixLib
            self.HP_dict['replace_expressions'] = [
                '''getElementModifierNames(HP_testbench.HeatPump_IO,
                                           "heatPump")''',
                '''getElementModifierValue(HP_testbench.HeatPump_IO,
                                           heatPump.PerDataHea)''',
                '''removeElementModifiers(HP_testbench.HeatPump_IO,
                                          "heatPump", false)''',
                '''setElementModifierValue(
                HP_testbench.HeatPump_IO,
                heatPump.PerDataHea,
                $Code((
                    redeclare model PerDataHea =
                    AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D
                    (dataTable=AixLib.DataBase.HeatPump.{}())))
                )'''.format(HP_select),
                '''getElementModifierNames(HP_testbench.HeatPump_IO,
                                           "heatPump")''',
                '''getElementModifierValue(HP_testbench.HeatPump_IO,
                                           heatPump.PerDataHea)''',
                ]

    def test_with_modelica(self, make_FMU=False):
        """Run direct simulation with modelica model."""
        self.data = run_ModelicaSystem(self.fileName, self.modelName,
                                       self.solutions, self.stepSize,
                                       self.stopTime, self.parameters,
                                       make_FMU=make_FMU,
                                       HP_dict=self.HP_dict)

    def test_with_FMU(self):
        """Run direct simulation with FMU created from modelica model."""
        self.data = run_FMU(self.FMU_path, self.solutions,
                            self.stepSize, self.stopTime, self.parameters)

    def evaluate(self, plot_show=True):
        """Combine post-processing, printing and plotting."""
        data = post_processing(self.data, self.solutions, self.stepSize)

        logger.info('Resulting DataFrame:')
        if logger.isEnabledFor(logging.INFO):
            print(data)

        if plot_show:
            plt.show(block=True)

        os.chdir('..')

        return data


def run_ModelicaSystem(fileName, modelName, solutions, stepSize=1,
                       stopTime=60, parameters=dict(), list_models=[],
                       make_FMU=False, HP_dict=dict()):
    """Run the simulation with OpenModelica.

    Create a ``ModelicaSystem`` object which provides functions to
    load, configure and simulate a model.

    Args:
        fileName (str): Name (including path) of a *.mo file with the model

        modelName (str): Name of the model

        solutions (dict): Dict of all solutions (column names) to load
        from the results

        stepSize (int): Simulation step in seconds

        stopTime (int): Simulation lenth in seconds

        parameters (dict): Key, value pairs handed to ``setParameters()``

        list_models (list): List of file paths to additional *.mo that need
        to be loaded

        make_FMU (boolean): Should we create an FMU from the model?

        HP_dict (dict): Dict with settings for replacing the simulated heatpump

    Returns:
        data (DataFrame): Pandas DataFrame with the requested ``solutions``

    .. note::
        OMPython changed the input style for ``setSimulationOptions()``,
        ``setParameters()``, etc. dramatically after v3.1.2.
        As of 2019-12-04 this script requires the latest version from
        https://github.com/OpenModelica/OMPython

    """
    from OMPython import ModelicaSystem  # import only if necessary

    # If we want to simulate with some other than the default heatpump,
    # we have to include the record database for that heatpump.
    # For this, we need to load the *.mo file of that database into
    # the ModelicaSystem, via the argument ``lmodel``.
    if HP_dict.get('path', False):
        # Add to the list of additionally loaded modules
        list_models.append(HP_dict['path'].replace("\\", "/"))

    # Setup the Modelica session and load the module
    mod = ModelicaSystem(fileName=fileName, modelName=modelName,
                         lmodel=list_models)

    if HP_dict.get('replace_expressions', False):
        # This part is tricky! If we want to change the heat pump that is
        # used in the simulation, we cannot simply use setParameters(),
        # because we are replacing the reference to a "record".
        # Instead we have to modify the component value directly...
        for expression in HP_dict['replace_expressions']:
            answer = mod.sendExpression(expression)
            logger.debug(expression)
            logger.debug(answer)
        # ... and re-build the model afterwards, for the changes to take effect
        mod.buildModel()

    # Set some simulation options (valid until v3.1.2)
#    mod.setSimulationOptions(stepSize=stepSize, stopTime=stopTime)

    # Attention! For the current master branch of OMPython, we need the
    # following style (https://github.com/OpenModelica/OMPython)
    text = ["stepSize={}".format(stepSize),
            "stopTime={}".format(stopTime)]
    mod.setSimulationOptions(text)  # current master branch of OMPython

    # Print some useful information
    quantities = pd.DataFrame(mod.getQuantities())

    # Use this code snippet to find out of which kind (parameter, continuous)
    # a given quantity is:
    search_str = None
    if search_str is not None:
        mask = [search_str in quantity for quantity in quantities['name']]
        logger.debug('Results for "{}":'.format(search_str))
        if logger.isEnabledFor(logging.DEBUG):
            print(quantities[mask].to_string())

    # Set simulation parameters
    text = ["{}={}".format(key, value) for (key, value) in parameters.items()]
    mod.setParameters(text)  # current master branch of OMPython
#    mod.setParameters(**parameters)  # Until v3.1.2

    # Run simulations
    mod.simulate()

    # Get list of simulation variables for which results are available
    solution_vars = mod.getSolutions()

    # List required evaluation values:
    solution_list = ['time']
    for items in solutions.values():
        for item in items:
            if item not in solution_vars:
                logger.error('Skipping requested column "{}", since it'
                             ' is not among the solutions'.format(item))
            else:
                solution_list.append(item)

    # Read the results from your harddrive (this can take quite a long time)
    solution_data = mod.getSolutions(solution_list)

    # Create DataFrame from results
    data = pd.DataFrame(data=solution_data.T, columns=solution_list)

    if make_FMU:
        # Convert model to FMU 'modelName.fmu' in the current working directory
        mod.convertMo2Fmu()

        # Alternative: Try to produce Windows and Linux FMU at the same time
        # The platforms argument does not seem to have an effect
#        platforms = '{"x86_64-linux-gnu", "x86_64-w64-mingw32"}'
#        expr = ('buildModelFMU({}, version="2.0", fmuType="me_cs",'
#                'platforms={})'.format(modelName, platforms))
#        mod.getconn.sendExpression(expr)

    return data


def run_FMU(fileName, solutions, stepSize=1, stopTime=60,
            parameters=dict(), make_FMU=False):
    """Perform the simulation with an FMU by using the PyFMI package.

    This is using the "Model Exchange" method.

    Args:
        fileName (str): Name (including path) of a *.fmu file with the model

        solutions (dict): Dict of all solutions (column names) to load
        from the results

        stepSize (int): Simulation step in seconds

        stopTime (int): Simulation lenth in seconds

        parameters (dict): Key, value pairs handed to ``setParameters()``

    Returns:
        data (DataFrame): Pandas DataFrame with the requested ``solutions``


    Install PyFMI with Anaconda
    ===========================

    .. code::

        conda install pyfmi

    In order to create the FMU in the first place, we can use OMPython
    with the implementation in the local function ``make_fmu()``.


    Please note: With the first installation of PyFMI from Anaconda,
    the following error appeared when trying to simulate:

    .. code::

        pyfmi.common.algorithm_drivers.InvalidAlgorithmOptionException:
        'Invalid algorithm options object: The solver: CVode is unknown.'

    This fixed it:

    .. code::

        conda install -c conda-forge assimulo
    """
    import pyfmi

    try:
        mod = pyfmi.load_fmu(fileName)
    except pyfmi.fmi.FMUException:
        logger.error('FMU file missing: {}'.format(fileName))
        raise

    opts = mod.simulate_options()  # Get the default options
    opts['ncp'] = int(stopTime/stepSize)  # Set to n output points

    # Set simulation parameters
    for key, value in parameters.items():
        try:
            mod.set(key, value)
        except TypeError:  # "expected bytes, str found" for file path
            mod.set(key, value.encode('utf-8'))

    # With FMI, simulate() returns a result object
    res = mod.simulate(final_time=stopTime, options=opts)

    # required evaluation values:
    solution_list = ['time']
    for items in solutions.values():
        solution_list += items

    # Create DataFrame from results
    data = pd.DataFrame()
    for solution in solution_list:
        data[solution] = res[solution]

    return data


def post_processing(data, eval_values, stepSize,
                    origin=pd.Timestamp('2018-01-01')):
    """Perform post processing steps.

    - Apply a time index, while removing the first and all other time
      steps that do not match the stepSize (modelica can simulate with a
      variable time step)
    - Apply unit conversions
    - Plot data
    - Return data
    """
    # Create a time index for our data
    data['time'] = pd.to_datetime(data['time'], unit='s', origin=origin)
    data.set_index('time', drop=True, inplace=True)

    freq = pd.to_timedelta(stepSize, unit='s')

    new_index = pd.date_range(start=origin + freq,
                              freq=freq,
                              end=origin + pd.Timedelta('365 days'),
                              )

    # There will be several dublicate indices, because of how the solvers work
    data = data.resample(freq).first()
    # Apply a new index with the first timestamp (zero) missing
    data = data.reindex(index=new_index)

    # Apply unit conversions
    temperatures = eval_values['temperatures']
    data[temperatures] -= 273.15  # Convert K to °C

    normalized = eval_values['normalized']

    power = eval_values['power']
    data[power] *= 1/1000  # Convert W to kW

    f, (ax1, ax2, ax3) = plt.subplots(3, 1, sharex=True)
    for label in temperatures:
        ax1.plot(data[label], label=label)
    for label in normalized:
        ax2.plot(data[label], label=label)
    for label in power:
        ax3.plot(data[label], label=label)

    ax1.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
    ax2.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
    ax3.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
    plt.xlabel(r'time')
    ax1.set_ylabel(r'Temperature in [°C]')
    ax2.set_ylabel(r'Factor in [-]')
    ax3.set_ylabel(r'Power in [kW]')
    ax3.xaxis.set_tick_params(rotation=30)  # rotation is useful sometimes
    ax3.xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d %H:%M'))
    plt.tight_layout()

    return data


def setup():
    """Set up Pandas' terminal output, logger and colours."""
    # Define the logging function
    logging.basicConfig(format='%(asctime)-15s %(levelname)-8s %(message)s')

    # Set loggers of imported modules:
#    log_level = 'DEBUG'
#    log_level = 'INFO'
    log_level = 'WARNING'
    logger.setLevel(level=log_level.upper())  # Logger for this module
    logging.getLogger('OMPython').setLevel(level=log_level.upper())


if __name__ == '__main__':
    setup()
    main()
