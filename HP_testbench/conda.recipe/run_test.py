# -*- coding: utf-8 -*-
'''
**hptestbench: OpenModelica Heatpump Testbench in Python**

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


Module run_test
---------------
Tests to run during build process.
'''

import unittest
import logging
import hptestbench


def check_JAZ():
    '''This python test determines the JAZ for the default heat pump
    '''
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
    JAZ = data['heatPump1.CoP_out'].mean()

    return JAZ


class TestMethods(unittest.TestCase):
    def test(self):
        self.assertAlmostEqual(check_JAZ(), 2.25969269, places=4)


if __name__ == '__main__':
    unittest.main()
