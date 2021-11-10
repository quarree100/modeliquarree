# Copyright (C) 2020 Joris Zimmermann

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program. If not, see https://www.gnu.org/licenses/.

"""OpenModelica simulation in Python.

Module run_test
---------------
Tests to run during build process.
"""

import os
import sys
import unittest
import logging
import pandas as pd
from OMPython import ModelicaSystem  # requires >=3.2.0

# Import from other file in the same repository
sys.path.append("../../HP_testbench")
import hptestbench

# Define the logging function
logger = logging.getLogger(__name__)


class Tester():
    """Define functions for testing modelica simulations."""

    def __init__(self,
                 model='Q100_DistrictModel.Simulations.Gesamt_Sim_noLP'
                 ):
        """Prepare all the settings."""
        self.model = model  # Set model name
        self.data = pd.DataFrame()  # Prepare empty DataFrame for results
        # Store current working directory to change back to it later
        self.cwd = os.getcwd()
        # separate windows and linux
        self.sim_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                    'sim_'+sys.platform,
                                    model.replace('.', '_'))
        # set default resulting FMU filename
        self.filename_fmu = os.path.join(self.sim_dir, self.model+'.fmu')
        # Define some paths
        self.file = os.path.abspath(
            os.path.join(os.path.dirname(os.path.abspath(__file__)),
                         '../modelica/Q100_DistrictModel/package.mo'))

        # Define the output value that should be tested, depending on the model
        if model == 'Q100_DistrictModel.Simulations.Gesamt_Sim_noLP':
            self.value = \
                'fMU_PhyModel.heatStorageVariablePorts_central.Heat_loss'
        elif model == 'Q100_DistrictModel.Simulations.Gesamt_Sim':
            self.value = \
                'fMU_PhyModel.heatStorageVariablePorts_central.Heat_loss'
        elif model == 'Q100_DistrictModel.FMUs.FMU_PhyModel':
            self.value = 'heatStorageVariablePorts_central.Heat_loss'
        elif model == 'Q100_DistrictModel.ElectrolysisSystem.Quarree100':
            self.value = 'comp_electrolysisSystem.out_H2'
        else:
            raise ValueError("Model {} not defined".format(model))

        # Prepare a simulation directory
        if os.path.exists(self.sim_dir) is False:
            os.makedirs(self.sim_dir)

    def run_modelica_system(self):
        """Create a ``ModelicaSystem`` object and run the simulation.

        Change to a simulation directory for the simulation.
        """
        # Change to a simulation directory
        os.chdir(self.sim_dir)
        # Setup the Modelica session and load the module, use "new frontend"
        mod = ModelicaSystem(fileName=self.file.replace("\\", "/"),
                             modelName=self.model,
                             commandLineOptions='-d=newInst')

        mod.setSimulationOptions(["stopTime=86400", "stepSize=900"])

        try:
            # Run simulations
            mod.simulate()

            # Get list of simulation variables for which results are available
            solution_vars = mod.getSolutions()

            # Compare existing and required solutions
            solution_list = ['time', self.value]
            for item in solution_list:
                if item not in solution_vars:
                    raise ValueError('Item "{}" is not among the solutions '
                                     'of model "{}".'.format(item, self.model))

            solution_data = mod.getSolutions(solution_list)

            # Create DataFrame from results
            self.data = pd.DataFrame(data=solution_data.T,
                                     columns=solution_list)
        except Exception:
            # Change back to original working directory
            os.chdir(self.cwd)
            raise
        else:
            # Change back to original working directory
            os.chdir(self.cwd)

        return self.data

    def convert_fmu(self):
        """Convert the prepared model to an FMU."""
        # Change to a simulation directory
        os.chdir(self.sim_dir)

        # Set up Modelica session and load the module, use "new frontend"
        mod = ModelicaSystem(fileName=self.file.replace("\\", "/"),
                             modelName=self.model,
                             commandLineOptions='-d=newInst')
        # Convert model to FMU 'modelName.fmu' in current working directory
        filename_fmu = mod.convertMo2Fmu()
        if self.filename_fmu != filename_fmu:
            logger.info('Unexpected new FMU filename "%s", expected "%s"',
                        filename_fmu, self.filename_fmu)
            self.filename_fmu = filename_fmu

        # Alternative: Try to get Windows and Linux FMU at the same time.
        # The platforms argument does not seem to have an effect.
        # platforms = '{"x86_64-linux-gnu", "x86_64-w64-mingw32"}'
        # platforms = '{"x86_64-w64-mingw32"}'  # creates no FMU
        # platforms = '{"static"}'  # same as "mod.convertMo2Fmu()"
        # expr = ('buildModelFMU({}, version="2.0", fmuType="me_cs",'
        #         'platforms={})'.format(model, platforms))
        # filename_fmu = mod.getconn.sendExpression(expr)
        # print(expr, filename_fmu)

        # Change back to original working directory
        os.chdir(self.cwd)

        return self.filename_fmu

    def run_fmu(self, fmi_package='pyfmi'):
        """Run the test with the previously defined FMU file."""
        # Change to a simulation directory
        os.chdir(self.sim_dir)
        # Define list of wanted solutions
        solutions = [self.value]
        try:
            # Run FMU simulation
            if fmi_package == 'pyfmi':
                self.data = hptestbench.run_FMU(
                    self.filename_fmu, solutions, stepSize=900,
                    stopTime=86400, fmu_log_level=7)
            elif fmi_package == 'fmpy':
                self.data = self.run_fmu_fmpy()
            else:
                raise ValueError("FMI package {} unknown".format(fmi_package))
        except Exception:
            # Change back to original working directory
            os.chdir(self.cwd)
            raise
        else:
            # Change back to original working directory
            os.chdir(self.cwd)

        return self.data

    def run_fmu_fmpy(self, fmi_logging=True):
        """Run FMU simulation with the package fmpy."""
        import fmpy
        self.data = fmpy.simulate_fmu(
            filename=self.filename_fmu,
            validate=False,
            start_time=0,
            stop_time=86400,
            # solver=solver,
            step_size=900,
            fmi_type='CoSimulation',
            # output_interval=2e-2,
            # record_events=events,
            # start_values={},
            output=[self.value],
            fmi_call_logger=(
                lambda s: print('[FMI] ' + s) if fmi_logging else None)
            )
        return self.data

    def test_result(self):
        """Test the simulation result for some condition.

        Test condition: Mean of the given variable must not be zero.
        """
        logger.info('Description of resulting data:\n%s\n',
                    self.data.describe().to_string())

        condition = self.data[self.value].mean() != 0
        return condition


def test_model(model, fmi=False, skip_fmu_conversion=False,
               fmi_package='pyfmi'):
    """Test a given model, either with OpenModelica or via FMI."""
    setup()
    logger.info('Test model %s', model)

    tester = Tester(model)
    if fmi:  # Use functional mock-up interface
        if not skip_fmu_conversion:
            tester.convert_fmu()
        tester.run_fmu(fmi_package)

    else:  # Use OpenModelica
        tester.run_modelica_system()
    condition = tester.test_result()
    return condition


def setup():
    """Set up logger."""
    # Define the logging function
    logging.basicConfig(format='%(asctime)-15s %(levelname)-8s %(message)s')

    # Set loggers of imported modules:
    log_level = 'DEBUG'
    # log_level = 'INFO'
    # log_level = 'WARNING'
    logger.setLevel(level=log_level.upper())  # Logger for this module
    logging.getLogger('OMPython').setLevel(level=log_level.upper())


class TestMethods(unittest.TestCase):
    """Definition of test functions."""

    # def test_complete_sim(self):
    #     """Run OpenModelica simulation with the complete simulation."""
    #     model = 'Q100_DistrictModel.Simulations.Gesamt_Sim_noLP'
    #     self.assertTrue(test_model(model))

    # def test_physical_model(self):
    #     """Run OpenModelica simulation with the physical model."""
    #     model = 'Q100_DistrictModel.FMUs.FMU_PhyModel'
    #     self.assertTrue(test_model(model))

    # def test_physical_model_fmu(self):
    #     """Run FMU simulation with the physical model."""
    #     model = 'Q100_DistrictModel.FMUs.FMU_PhyModel'
    #     condition = test_model(model, fmi=True,
    #                            # skip_fmu_conversion=True,  # for debugging
    #                            )
    #     self.assertTrue(condition)

    def test_electrolysis_fmu(self):
        """Run FMU simulation with the standalone electrolysis system."""
        model = 'Q100_DistrictModel.ElectrolysisSystem.Quarree100'
        condition = test_model(model, fmi=True,
                                skip_fmu_conversion=True,  # for debugging
                                # fmi_package='pyfmi',
                               fmi_package='fmpy',
                               )
        self.assertTrue(condition)


if __name__ == '__main__':
    unittest.main()
