# -*- coding: utf-8 -*-
'''
**BouncingBall: OpenModelica Python Interface example**

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


BouncingBall
============

Example implementation of OMPython (OpenModelica Python Interface) using
the BouncingBall Modelica example project.

To install OMPython, follow the instructions at:
https://github.com/OpenModelica/OMPython

For further information, see the full documentation:
https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/ompython.html
'''

import os
import pandas as pd
import matplotlib.pyplot as plt
from OMPython import OMCSessionZMQ
from OMPython import ModelicaSystem


def main():
    '''Choose one of the example methods
    '''
    # Create and change to a subdirectory to create all simulation files there
    sim_dir = './sim'
    if os.path.exists(sim_dir) is False:
        os.mkdir(sim_dir)
    os.chdir(sim_dir)

    run_ModelicaSystem()  # direct simulation with modelica model
#    run_FMU()  # direct simulation with FMU created from modelica model
#    run_OpenModelica_CLI()  # call to modelica command line interface

    os.chdir('..')


def run_ModelicaSystem():
    '''Create a ``ModelicaSystem`` object which provides functions to
    load, configure and simulate a model. Plotting is done with Python.

    For this example, we run the simulations for different heights 'h' from
    where the bouncing ball is dropped.
    '''

    # Setup the Modelica session and load the module
    omc = OMCSessionZMQ()
    model_path = (omc.sendExpression('getInstallationDirectoryPath()')
                  + '/share/doc/omc/testmodels/')
    mod = ModelicaSystem(model_path + 'BouncingBall.mo', 'BouncingBall')
    # Set some simulation options
    mod.setSimulationOptions(stepSize=.05, stopTime=2.0)

    # Print some useful information
    quant = pd.DataFrame(mod.getQuantities())
    print(quant)

    # Modify and run simulations
    for h_start in [1, 2, 3]:
        mod.setContinuous(h=h_start)  # `h` is a `continuous` variable
        mod.simulate()
        time, h = mod.getSolutions('time', 'h')

        plt.plot(time, h, label='h_start = {0} m'.format(h_start))

    plt.legend()
    plt.xlabel(r'time $t$ in [s]')
    plt.ylabel(r'height $h$ in [m]')
    plt.show(block=False)


def run_FMU():
    '''Perform the BouncingBall simulation with an FMU by using the
    PyFMI package. Install PyFMI with Anaconda:

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
    '''
    import pyfmi

    def make_fmu():
        '''Create an FMU from the Modelica model to use for testing
        '''
        # Setup the Modelica session and load the module
        omc = OMCSessionZMQ()
        model_path = (omc.sendExpression('getInstallationDirectoryPath()')
                      + '/share/doc/omc/testmodels/')
        mod = ModelicaSystem(model_path + 'BouncingBall.mo', 'BouncingBall')
        # Convert model to FMU 'BouncingBall.fmu'
        mod.convertMo2Fmu()

    make_fmu()  # Use this to create the FMU file

#    pyfmi.check_packages()  # Verify installation (seems to break plt.plot())
    mod = pyfmi.load_fmu('BouncingBall.fmu')
    opts = mod.simulate_options()  # Get the default options
    opts['ncp'] = 100  # Set to 100 output points

    for h_start in [1, 2, 3]:
        mod.reset()  # without this, the loop causes trouble
        mod.set('h', h_start)  # set the start height of the ball

        # With FMI, simulate() returns a result object
        res = mod.simulate(final_time=2.0, options=opts)
        time = res['time']
        h = res['h']

        plt.plot(time, h, '--', label='FMU h_start = {0} m'.format(h_start))

    plt.legend()
    plt.xlabel(r'time $t$ in [s]')
    plt.ylabel(r'height $h$ in [m]')
    plt.show()


def run_OpenModelica_CLI():
    '''Use calls to the OpenModelica command line interface to load,
    simulate and plot a model.
    '''
    omc = OMCSessionZMQ()
    cmds = [
      ('loadFile(getInstallationDirectoryPath()'
       + ' + "/share/doc/omc/testmodels/BouncingBall.mo")'),
      'simulate(BouncingBall)',
      'plot(h)',
      ]
    for cmd in cmds:
        answer = omc.sendExpression(cmd)
        print('\n{}:\n{}'.format(cmd, answer))


if __name__ == '__main__':
    main()
