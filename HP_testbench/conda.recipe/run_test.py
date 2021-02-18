# Copyright (C) 2019 Joris Zimmermann

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

"""OpenModelica Heatpump Testbench in Python.

hptestbench
===========

This Python package allows simulating heatpumps with OpenModelica, in order
to evaluate their performance and integrate the results in other workflows.


Module run_test
---------------
Tests to run during build process.
"""

import unittest
import logging
import hptestbench


def check_SPF():
    """Determine the seasonal performance factor of the default heat pump."""
    # Define the logging function
    logging.basicConfig(format='%(asctime)-15s %(levelname)-8s %(message)s')
    log_level = 'ERROR'
    logging.getLogger('hptestbench').setLevel(level=log_level)
    logging.getLogger('OMPython').setLevel(level=log_level.upper())

    # Create our testbench:
    bench = hptestbench.testbench()

    # Run the tests via the functional mockup interface (FMI)
    bench.test_with_FMU()  # Does not require OpenModelica and OMPython

    # Evaluate the results
    data = bench.evaluate(plot_show=False)
    SPF = (data['heatPump_IO.P_th_cond'].sum()
           / data['heatPump_IO.P_el'].sum())

    return SPF


class TestMethods(unittest.TestCase):
    """Definition of test functions."""

    def test(self):
        """Compare the resulting SPF to a given value."""
        self.assertAlmostEqual(check_SPF(), 1.8118525941677075, places=4)


if __name__ == '__main__':
    unittest.main()
