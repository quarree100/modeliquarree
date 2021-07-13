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
from OMPython import ModelicaSystem

# Define the logging function
logger = logging.getLogger(__name__)


def run_ModelicaSystem():
    """Create a ``ModelicaSystem`` object and run the simulation."""
    # Create a subdirectory for the simulation
    sim_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                           'sim_'+sys.platform)  # separate windows and linux

    # Define some paths
    file = os.path.abspath(
        os.path.join(os.path.dirname(os.path.abspath(__file__)),
                     '../modelica/Q100_DistrictModel/package.mo'))
    model = 'Q100_DistrictModel.FMUs.FMU_PhyModel'
    input_path = os.path.join(os.path.dirname(os.path.abspath(file)), 'input/')

    # Change to a simulation directory
    if os.path.exists(sim_dir) is False:
        os.mkdir(sim_dir)
    os.chdir(sim_dir)

    # Setup the Modelica session and load the module, use "new frontend"
    mod = ModelicaSystem(fileName=file.replace("\\", "/"),
                         modelName=model,
                         commandLineOptions='-d=newInst')

    # Adapt the path of all the input files
    # cmd = '''setComponentModifierValue(
    #          Q100_DistrictModel.Simulations.SIM_RI_Schema,
    #          inputData.Pfad,
    #          $Code(="{}"))'''.format(input_path.replace("\\", "/"))
    # mod.sendExpression(cmd)

    # Rebuild the model afterwards, for the changes to take effect
    mod.buildModel()

    try:
        mod.setSimulationOptions(["stopTime=86400", "stepSize=900"])
    except Exception:
        mod.setSimulationOptions(stopTime=86400, stepSize=900)

    # Run simulations
    mod.simulate()

    solution_list = ['time', 'heatStorageVariablePorts_central.Heat_loss']
    solution_data = mod.getSolutions(solution_list)

    # Create DataFrame from results
    data = pd.DataFrame(data=solution_data.T, columns=solution_list)
    print(data)

    # Evaluate some variable just to see if the simulation finished:
    condition = data['heatStorageVariablePorts_central.Heat_loss'].mean() < 0
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

    def test(self):
        """Run an OpenModelica simulation."""
        self.assertTrue(run_ModelicaSystem())


if __name__ == '__main__':
    unittest.main()
