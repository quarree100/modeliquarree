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
    run_ModelicaSystem()
#    run_OpenModelica_CLI()


def run_ModelicaSystem():
    '''Create a ``ModelicaSystem`` object which provides functions to
    load, configure and simulate a model. Plotting is done with Python.

    For this example, we run the simulations for different heights 'h' from
    where the bouncing ball is dropped.
    '''
    # Create and change into a subdirectory to create all simulation files
    # there
    sim_dir = './sim'
    if os.path.exists(sim_dir) is False:
        os.mkdir(sim_dir)
    os.chdir(sim_dir)

    # Setup the Modelica session and load the module
    omc = OMCSessionZMQ()
    model_path = (omc.sendExpression('getInstallationDirectoryPath()')
                  + '/share/doc/omc/testmodels/')
    mod = ModelicaSystem(model_path + 'BouncingBall.mo', 'BouncingBall')
    # Increase from 1 to 2 seconds
    mod.setSimulationOptions(stepSize=.1, stopTime=2.0)

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
