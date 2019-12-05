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

Setup script
------------

Run the following command to install into your Python environment:

.. code:: sh

    python setup.py install

'''
from setuptools import setup

# The setup function
setup(
    # Set version with setuptools_scm, depends on `git describe`
    use_scm_version={'root': '..', 'relative_to': __file__,
                     'version_scheme': 'post-release'},
    setup_requires=['setuptools_scm'],
    name='hptestbench',
    description='OpenModelica Heatpump Testbench in Python',
    long_description=open('../README.md').read(),
    license='GPL-3.0',
    author='Joris Nettelstroth',
    author_email='joris.nettelstroth@stw.de',
    url='https://github.com/quarree100/modeliquarree',
    install_requires=[],
    python_requires='>=3.7',
    packages=['hptestbench', 'modelica'],
    include_package_data=True,
    package_data={'modelica': ['HP_testbench.mo',
                               'TRY2015_541957091051_Jahr.mos',
                               'sim_win32/HP_testbench.HeatPump_weather.fmu',
                               'sim_linux/HP_testbench.HeatPump_weather.fmu',
                               ],
                  },
    entry_points={
        'console_scripts': ['hptestbench = hptestbench.__main__:main'],
        }
)
