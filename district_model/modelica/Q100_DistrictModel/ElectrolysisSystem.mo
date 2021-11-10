within Q100_DistrictModel;
package ElectrolysisSystem "package for electrolysis system"
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;
  import Const = Modelica.Constants;

  model Quarree100 "Electrolyser in heat grid with quaree100 boundary conditions"
    extends Modelica.Icons.Example;
    Model.ElectrolysisSystem comp_electrolysisSystem(
      redeclare model CellModel = DetailedModel.Cell,
      param_outputPumpMassFlow=true,
      param_stack_i_max=3e4,
      param_stack_T_init=60 + 273.15,
      param_stack_T_op=70 + 273.15,
      param_stack_T_crit=85 + 273.15,
      param_stack_T_in=60 + 273.15,
      param_stack_cell_area=600e-4,
      param_stack_cell_d=150e-6,
      param_stack_cell_length=0.3,
      param_stack_cell_depth=0.02,
      param_p_comp_h2=35000000,
      param_stack_P_el_max=300e3,
      param_stack_P_el_min=20e3,
      param_stack_p_op_anode=1400000,
      param_stack_p_op_cathode=3000000,
      param_pump_Qmax=12/3600) "electrolyser with integrated heat pump"
      annotation (Placement(transformation(extent={{-16,2},{18,36}})));
    AixLib.FastHVAC.Components.Pumps.FluidSource comp_fluidSource annotation (
        Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=90,
          origin={-13,-35})));
    AixLib.FastHVAC.Components.Sinks.Vessel comp_vessel
      annotation (Placement(transformation(extent={{46,-30},{66,-10}})));
    Modelica.Blocks.Sources.CombiTimeTable table_lowerStorageTemp(
      tableOnFile=true,
      tableName="lowerStorageTemp",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/loadprofiles/inputDataCombined.txt"),
      columns={2},
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      timeScale=15*60)
      annotation (Placement(transformation(extent={{-68,-80},{-54,-66}})));

    Modelica.Blocks.Sources.CombiTimeTable table_upperStorageTemp(
      tableOnFile=true,
      tableName="upperStorageTemp",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/loadprofiles/inputDataCombined.txt"),
      columns={2},
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      timeScale=15*60)
      annotation (Placement(transformation(extent={{10,-66},{24,-52}})));

    Modelica.Blocks.Sources.CombiTimeTable table_inputPower(
      tableOnFile=true,
      tableName="power",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/loadprofiles/inputDataCombined.txt"),
      columns={2},
      smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
      timeScale=15*60)
      annotation (Placement(transformation(extent={{-64,30},{-50,44}})));
    Modelica.Blocks.Math.Add block_add
      annotation (Placement(transformation(extent={{-34,-76},{-26,-68}})));
    Modelica.Blocks.Sources.RealExpression exp_T_offset(y=273.15) "offset for conversion to Kelvin"
      annotation (Placement(transformation(extent={{-74,-58},{-54,-38}})));
    Modelica.Blocks.Math.Gain block_gain(k=5) "multiply signal with max mass flow rate"
      annotation (Placement(transformation(extent={{0,-60},{-8,-52}})));
    Modelica.Blocks.Logical.LessEqualThreshold block_load_storage(threshold=90 +
          273.15) "storage temperature at which heat pump has to turn off"
      annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=90,
          origin={11,-31})));
    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 comp_weather(
      computeWetBulbTemperature=false,
      pAtmSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      ceiHeiSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      totSkyCovSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      opaSkyCovSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      TDewPoiSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      TBlaSkySou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      relHumSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      winSpeSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      winDirSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      HInfHorSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
      filNam=ModelicaServices.ExternalReferences.loadResource(
          "modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/weather/TRY2015_541957091051_Jahr.mos"))
      "weather data of Heide"
      annotation (Placement(transformation(extent={{-80,4},{-66,18}})));
    AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-42,6},{-32,18}}), iconTransformation(extent={{
              -118,96},{-98,116}})));
  equation

    connect(comp_fluidSource.enthalpyPort_b, comp_electrolysisSystem.port_inlet_cooling)
      annotation (Line(points={{-13.9,-26},{-14,-26},{-14,-14},{-11.75,-14},{-11.75,
            4.125}}, color={176,0,0}));
    connect(comp_electrolysisSystem.port_outlet_cooling, comp_vessel.enthalpyPort_a)
      annotation (Line(points={{13.75,4.125},{13.75,-20},{49,-20}}, color={176,0,
            0}));
    connect(table_lowerStorageTemp.y[1], block_add.u2) annotation (Line(points={{-53.3,-73},{-44.65,-73},
            {-44.65,-74.4},{-34.8,-74.4}}, color={0,0,127}));
    connect(block_add.y, comp_fluidSource.T_fluid)
      annotation (Line(points={{-25.6,-72},{-18,-72},{-18,-42.2},{-16.78,-42.2}}, color={0,0,127}));
    connect(exp_T_offset.y, block_add.u1)
      annotation (Line(points={{-53,-48},{-44,-48},{-44,-69.6},{-34.8,-69.6}}, color={0,0,127}));
    connect(comp_electrolysisSystem.out_hp_cond_mflow, block_gain.u) annotation (Line(points={{-4.3125,
            0.9375},{-4.3125,-24},{2,-24},{2,-56},{0.8,-56}}, color={0,0,127}));
    connect(block_gain.y, comp_fluidSource.dotm)
      annotation (Line(points={{-8.4,-56},{-10,-56},{-10,-42.2},{-10.66,-42.2}}, color={0,0,127}));
    connect(table_inputPower.y[1], comp_electrolysisSystem.inp_P_av) annotation (
        Line(points={{-49.3,37},{-30.65,37},{-30.65,28.5625},{-14.9375,28.5625}},
          color={0,0,127}));
    connect(table_upperStorageTemp.y[1], block_load_storage.u) annotation (Line(
          points={{24.7,-59},{34,-59},{34,-40},{11,-40},{11,-34.6}}, color={0,0,
            127}));
    connect(comp_electrolysisSystem.inp_hp_on, block_load_storage.y) annotation (
        Line(points={{6.3125,0.9375},{6.3125,-22},{11,-22},{11,-27.7}}, color={
            255,0,255}));
    connect(comp_weather.weaBus, weaBus) annotation (Line(
        points={{-66,11},{-66,12},{-37,12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(weaBus.TDryBul, comp_electrolysisSystem.inp_T_air)
      annotation (Line(
        points={{-37,12},{-26.5,12},{-26.5,24.3125},{-14.9375,24.3125}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-92,94},{-42,70}},
            lineColor={0,0,127},
            pattern=LinePattern.Dot,
            horizontalAlignment=TextAlignment.Left,
            textString="Due to a 2.5MW heat pump in quarree100 the heat produced
by the electrolyser has nearly no effect on the storage
temperature. That is why both, lower and upper storage
temperature, are inputs from a table. Input power is the
avaiable excess power for the electrolyser")}),
      experiment(
        StopTime=31536000,
        Interval=180,
        __Dymola_Algorithm="Dassl"));
  end Quarree100;

  package Model
  extends Modelica.Icons.Package;

    model ElectrolysisSystem "electrolysis system with all components and heat pump"
      // media models for H2 and O2
      replaceable package H2 = Media.Gases.H2andWaterVapor;
      replaceable package O2 = Media.Gases.O2andWaterVapor;
      // parameter for whole system
      parameter SI.Temperature param_T_container(displayUnit = "K") = 30 + 273.15 "temperature inside electrolyser container" annotation (
        Dialog(group = "general parameter"));
      parameter SI.Efficiency param_transformer_eta = 0.95 "constant efficiency of transformer" annotation (
        Dialog(group = "general parameter"));
      // user inputs
      replaceable model CellModel = PartialModels.PartialCell constrainedby
        PartialModels.PartialCell                                                                     "choose whether to use simple or detailed model for electrolysis" annotation (
         choices(choice(redeclare model CellModel = DetailedModel.Cell "detailed model"), choice(redeclare
              model                                                                                              CellModel =
                SimpleModel.Cell                                                                                                              "simple model")));
      parameter Boolean param_outputPumpMassFlow = true "output controlled mass flow rate to get desired heat pump outlet temperature" annotation (
        choices(checkBox = true),
        Dialog(descriptionLabel = true));
      // operating parameter for stack
      parameter Units.VolumetricEnergy param_stack_kWh_per_m3 = 4.4 "simple model: constant specific energy demand for H2 production of stack in kWh per normcubicmeter (0 °C, 1,01325 bar)" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter Units.VolumetricEnergy param_stack_HHV_h2 = 3.5403 "higher heating value of H2 at norm conditions (0 °C, 1,01325 bar)" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Power param_stack_P_el_min = 10e3 "minimal power of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Power param_stack_P_el_max = 100e3 "nominal power of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.CurrentDensity param_stack_i_min = 0.2e4 "minimum current density in electrolysis cell" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.CurrentDensity param_stack_i_max = 2.5e4 "maximum current density in electrolysis cell" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Temperature param_stack_T_init(displayUnit = "K") = 50 + 273.15 "initial temperature of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Temperature param_stack_T_op(displayUnit = "K") = 65 + 273.15 "desired operating temperature of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Temperature param_stack_T_crit(displayUnit = "K") = 75 + 273.15 "critical temperature at which electrolyser turns off" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Temperature param_stack_T_in(displayUnit = "K") = 55 + 273.15 "desired inlet temperature of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      SI.Pressure param_stack_p_op_cathode = 1e5 "operating pressure at cathode" annotation (
        Dialog(group = "electrolysis parameter"));
      SI.Pressure param_stack_p_op_anode = 1e5 "operating pressure at anode" annotation (
        Dialog(group = "electrolysis parameter"));
      // general parameter of stack
      parameter Integer param_stack_cell_n = 100 "number of cells in electrolyser" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Area param_stack_cell_area = 600e-4 "membrane area of one cell [m²]" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Distance param_stack_cell_d = 200e-6 "thickness of cell membrane [m]" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Distance param_stack_cell_length = 0.35 "length of one cell including frame thickness [m]" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Distance param_stack_cell_depth = 0.02 "depth of one cell including frame [m]" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Mass param_stack_mass = 2000 "mass of electrolyser (without cooling liquid)" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.SpecificHeatCapacity param_stack_cp = 420 "mean specific heat capacity of electrolyser" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Mass param_stack_mass_h2o = 100 "mass of electrolyser cooling liquid" annotation (
        Dialog(group = "stack parameter"));
      // operating parameter for peripheral components
      parameter Real param_ppm_h2o_h2 = 5 "desired water fraction of hydrogen after gas dryer in ppm" annotation (
        Dialog(group = "peripheral parameter"));
      parameter SI.Pressure param_p_comp_h2 = 200e5 "pressure of compressed hydrogen for storage purposes" annotation (
        Dialog(group = "peripheral parameter"));
      parameter Integer param_n_comp_h2 = 5 "number of compressor stages" annotation (
        Dialog(group = "peripheral parameter"));
      // cooling pump parameter
      parameter SI.VolumeFlowRate param_pump_Qmax = 5e-3 "maximal volume flow rate of pump at 25°C [m³/s]" annotation (
        Dialog(group = "cooling pump parameter"));
      parameter SI.Pressure param_pump_dp = 2e5 "system pressure loss at maximum volume flow rate [Pa]" annotation (
        Dialog(group = "cooling pump parameter"));
      parameter SI.Efficiency param_pump_eta = 0.6 "cooling pump efficiency at operating condition" annotation (
        Dialog(group = "cooling pump parameter"));
      // heat pump parameter
      parameter SI.Temperature param_hp_T_init(displayUnit = "K") = 50 + 273.15 "initial temperature of heat pump" annotation (
        Dialog(group = "heat pump parameter"));
      parameter SI.Temperature param_hp_T_out_cond(displayUnit = "K") = 82 + 273.15 "desired output temperature of heat pump condenser" annotation (
        Dialog(group = "heat pump parameter", enable = param_outputPumpMassFlow));
      parameter SI.Power param_hp_P_max_el = 50e3 "maximum power consumption" annotation (
        Dialog(group = "heat pump parameter"));
      parameter Real param_hp_COP = 3 "constant COP of heat pump" annotation (
        Dialog(group = "heat pump parameter"));
      // variables
      SI.Power var_P_ex(start = 0.0, fixed = false) "excess power not used";
      SI.Energy var_P_cons(start = 0.0, fixed = true) "integrated power consumption";
      Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons) "integrated power consumption in kWh";
      Real var_P_av_kWh = SI.Conversions.to_kWh(block_max.y) "integrated power avaiable in kWh";
      SI.Volume var_Vnorm_H2(start = 0.0, fixed = true) "integrated normal volume of produced hydrogen [Nm3]";
      // components
      Electrolyser comp_electrolyser(comp_stack(redeclare package O2 = O2, redeclare
            package                                                                          H2 = H2, redeclare CellModel comp_cell(redeclare
              package                                                                                                                                 H2 = H2, redeclare
              package                                                                                                                                                            O2 = O2, param_p_op_cathode = param_stack_p_op_cathode, param_p_op_anode = param_stack_p_op_anode, param_kWh_per_m3 = param_stack_kWh_per_m3, param_HHV_h2 = param_stack_HHV_h2, param_membrane_area = param_stack_cell_area, param_membrane_d = param_stack_cell_d), comp_heater(param_T_op_min = param_stack_T_op - 5)), param_stack_kWh_per_m3 = param_stack_kWh_per_m3, param_stack_HHV_h2 = param_stack_HHV_h2, param_stack_P_el_min = param_stack_P_el_min, param_stack_P_el_max = param_stack_P_el_max, param_stack_i_min = 0.2e4, param_stack_i_max = param_stack_i_max, param_stack_T_init = param_stack_T_init, param_stack_T_op = param_stack_T_op, param_stack_T_crit = param_stack_T_crit, param_stack_T_in = param_stack_T_in, param_stack_p_op_cathode = param_stack_p_op_cathode, param_stack_p_op_anode = param_stack_p_op_anode, param_stack_cell_n = param_stack_cell_n, param_stack_cell_area = param_stack_cell_area, param_stack_cell_d = param_stack_cell_d, param_stack_cell_length = param_stack_cell_length, param_stack_cell_depth = param_stack_cell_depth, param_stack_mass = param_stack_mass, param_stack_cp = param_stack_cp, param_stack_mass_h2o = param_stack_mass_h2o, param_ppm_h2o_h2 = param_ppm_h2o_h2, param_p_comp_h2 = param_p_comp_h2, param_n_comp_h2 = param_n_comp_h2, param_pump_Qmax = param_pump_Qmax, param_pump_dp = param_pump_dp, param_pump_eta = param_pump_eta) annotation (
        Placement(transformation(extent = {{-14, 24}, {18, 56}})));
      HeatPump.HeatPump comp_heatPump(param_COP = param_hp_COP, param_T_set_evap = param_stack_T_in, param_T_init = param_hp_T_init, param_P_el = param_hp_P_max_el) annotation (
        Placement(transformation(extent = {{-20, -50}, {20, -10}})));
      Modelica.Blocks.Sources.RealExpression exp_P_av_electrolyser(y = block_transformer.y - comp_heatPump.port_P_el.P) "power available for electrolyser" annotation (
        Placement(transformation(extent = {{-92, 44}, {-72, 64}})));
      Modelica.Blocks.Sources.RealExpression exp_P_av_heatpump(y = block_transformer.y) "power available for heat pump" annotation (
        Placement(transformation(extent = {{-88, -32}, {-68, -12}})));
      Tools.Connectors.PowerConnector port_P_el annotation (
        Placement(transformation(extent = {{-140, 140}, {-120, 160}}), iconTransformation(extent = {{-160, 120}, {-120, 160}})));
      Modelica.Blocks.Interfaces.BooleanInput inp_hp_on "if false heat pump does not turn on" annotation (
        Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin = {-156, 0}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {50, -170})));
      Modelica.Blocks.Interfaces.RealInput inp_P_av "available power for electrolysis" annotation (
        Placement(transformation(extent = {{-180, 60}, {-140, 100}}), iconTransformation(extent = {{-160, 80}, {-140, 100}})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_inlet_cooling annotation (
        Placement(transformation(extent = {{-136, -154}, {-116, -134}}), iconTransformation(extent = {{-140, -160}, {-100, -120}})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet_cooling annotation (
        Placement(transformation(extent = {{100, -160}, {120, -140}}), iconTransformation(extent = {{100, -160}, {140, -120}})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor meas_T_hp_cond if param_outputPumpMassFlow annotation (
        Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 0, origin = {34, -48})));
      AixLib.Controls.Continuous.LimPID contr_hp_cond_mflow(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.1, Td = 0.1, Ti = 0.5, reverseAction = true, strict = true, yMax = 1, yMin = 1e-5, y_start = 0.01) if param_outputPumpMassFlow "mass flow controller for condenser of heat pump" annotation (
        Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 0, origin = {74, 0})));
      Modelica.Blocks.Interfaces.RealOutput out_hp_cond_mflow if param_outputPumpMassFlow " mass flow rate to get desired hp outlet temperature" annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {144, 0}), iconTransformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-50, -170})));
      Modelica.Blocks.Sources.RealExpression exp_T_set_hp_cond(y = param_hp_T_out_cond) if param_outputPumpMassFlow "setpoint temperature for condenser outlet" annotation (
        Placement(transformation(extent = {{36, -10}, {56, 10}})));
      Modelica.Blocks.Logical.And block_and "if true heat pump turns on (assuming P_av is high enough)" annotation (
        Placement(transformation(extent = {{-46, -14}, {-38, -6}})));
      Modelica.Blocks.Math.Gain block_transformer(k = param_transformer_eta) "transformer with constant efficiency" annotation (
        Placement(transformation(extent = {{-68, 76}, {-48, 96}})));
      Modelica.Blocks.Math.Max block_max annotation (
        Placement(transformation(extent = {{-110, 76}, {-90, 96}})));
      Modelica.Blocks.Sources.RealExpression exp_zero(y = 0) "zero value" annotation (
        Placement(transformation(extent = {{-148, 92}, {-128, 112}})));
      Modelica.Blocks.Interfaces.RealInput inp_T_air "outside air temperature" annotation (
        Placement(transformation(extent = {{-180, 8}, {-140, 48}}), iconTransformation(extent = {{-160, 40}, {-140, 60}})));
      Modelica.Blocks.Interfaces.RealOutput out_P_th(final quantity = "Power", final unit = "W", displayUnit = "W", min = 0) "thermal power output of electrolysis system [W]" annotation (
        Placement(visible = true, transformation(extent = {{140, 80}, {160, 100}}, rotation = 0), iconTransformation(extent = {{140, 80}, {160, 100}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput out_P_el(final quantity = "Power", final unit = "W", displayUnit = "W", min = 0) "electrical power demand of electrolysis system [W]" annotation (
        Placement(visible = true, transformation(extent = {{140, 100}, {160, 120}}, rotation = 0), iconTransformation(extent = {{140, 100}, {160, 120}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput out_H2(final quantity = "Volume flow", final unit = "m3/h", displayUnit = "m3/h", min = 0) "hydrogen production of electrolysis system [Nm3/h]" annotation (
        Placement(visible = true, transformation(extent = {{140, 60}, {160, 80}}, rotation = 0), iconTransformation(extent = {{140, 60}, {160, 80}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput out_O(final quantity = "Volume flow", final unit = "m3/h", displayUnit = "m3/h", min = 0) "oxygen production of electrolysis system [Nm3/h]" annotation (
        Placement(visible = true, transformation(extent = {{140, 40}, {160, 60}}, rotation = 0), iconTransformation(extent = {{140, 40}, {160, 60}}, rotation = 0)));
      Q100_DistrictModel.ElectrolysisSystem.Tools.Components.GasConverter gasConverter_H2(redeclare
          package                                                                                           Gas =
            Media.Gases.H2andWaterVapor)                                                                                                       annotation (
        Placement(visible = true, transformation(extent = {{60, 60}, {80, 80}}, rotation = 0)));
      Q100_DistrictModel.ElectrolysisSystem.Tools.Components.GasConverter gasConverter_O(redeclare
          package                                                                                          Gas =
            Media.Gases.O2andWaterVapor)                                                                                                      annotation (
        Placement(visible = true, transformation(origin = {70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      var_P_ex = block_max.y - comp_electrolyser.port_P_el.P - comp_heatPump.port_P_el.P;
      port_P_el.P = (comp_electrolyser.port_P_el.P + comp_heatPump.port_P_el.P) / param_transformer_eta;
      out_P_el = (comp_electrolyser.port_P_el.P + comp_heatPump.port_P_el.P) / param_transformer_eta;
      out_P_th = comp_heatPump.heatflow_dotQCond.Q_flow;
      der(var_P_cons) = port_P_el.P;
      der(var_Vnorm_H2) = gasConverter_H2.Vdot_norm / 3600; // Convert from m3/h to m3/s
    // mass flow output
      if param_outputPumpMassFlow then
        connect(contr_hp_cond_mflow.y, out_hp_cond_mflow) annotation (
          Line(points = {{80.6, 0}, {144, 0}}, color = {0, 0, 127}));
        connect(meas_T_hp_cond.T, contr_hp_cond_mflow.u_m) annotation (
          Line(points = {{34.6, -41.4}, {34, -41.4}, {34, -28}, {74, -28}, {74, -7.2}}, color = {0, 0, 127}));
        connect(exp_T_set_hp_cond.y, contr_hp_cond_mflow.u_s) annotation (
          Line(points = {{57, 0}, {66.8, 0}}, color = {0, 0, 127}));
        connect(meas_T_hp_cond.enthalpyPort_a, comp_heatPump.port_cond_out);
        connect(meas_T_hp_cond.enthalpyPort_b, port_outlet_cooling);
      else
        connect(comp_electrolyser.port_outlet_cooling, port_outlet_cooling);
      end if;
    // connect statements
      connect(port_inlet_cooling, comp_heatPump.port_cond_in) annotation (
        Line(points = {{-126, -144}, {-126, -84}, {-18, -84}, {-18, -48}}, color = {176, 0, 0}));
      connect(comp_electrolyser.port_outlet_cooling, comp_heatPump.port_evap_in) annotation (
        Line(points = {{12, 26}, {12, 0}, {28, 0}, {28, -12}, {18, -12}}, color = {176, 0, 0}));
      connect(comp_electrolyser.port_inlet_cooling, comp_heatPump.port_evap_out) annotation (
        Line(points = {{-8, 26}, {-8, 0}, {-28, 0}, {-28, -12}, {-18, -12}}, color = {176, 0, 0}));
      connect(exp_P_av_electrolyser.y, comp_electrolyser.inp_P_av) annotation (
        Line(points = {{-71, 54}, {-40, 54}, {-40, 44}, {-15, 44}}, color = {0, 0, 127}));
      connect(exp_P_av_heatpump.y, comp_heatPump.inp_P_av) annotation (
        Line(points = {{-67, -22}, {-44, -22}, {-44, -24}, {-22, -24}}, color = {0, 0, 127}));
      connect(block_and.y, comp_heatPump.inp_offSwitch) annotation (
        Line(points = {{-37.6, -10}, {-30, -10}, {-30, -16}, {-22, -16}}, color = {255, 0, 255}));
      connect(comp_electrolyser.out_cooling_system_on, block_and.u1) annotation (
        Line(points = {{-15, 26}, {-36, 26}, {-36, 14}, {-56, 14}, {-56, -10}, {-46.8, -10}}, color = {255, 0, 255}));
      connect(block_and.u2, inp_hp_on) annotation (
        Line(points = {{-46.8, -13.2}, {-60, -13.2}, {-60, 0}, {-156, 0}}, color = {255, 0, 255}));
      connect(inp_P_av, block_max.u2) annotation (
        Line(points = {{-160, 80}, {-112, 80}}, color = {0, 0, 127}));
      connect(block_max.y, block_transformer.u) annotation (
        Line(points = {{-89, 86}, {-70, 86}}, color = {0, 0, 127}));
      connect(exp_zero.y, block_max.u1) annotation (
        Line(points = {{-127, 102}, {-120, 102}, {-120, 92}, {-112, 92}}, color = {0, 0, 127}));
      connect(inp_T_air, comp_electrolyser.inp_T_air) annotation (
        Line(points = {{-160, 28}, {-88, 28}, {-88, 36}, {-15, 36}}, color = {0, 0, 127}));
      connect(out_P_th, out_P_th) annotation (
        Line(points = {{150, 90}, {150, 90}}, color = {0, 0, 127}));
      connect(comp_electrolyser.port_outlet_h2, gasConverter_H2.gasConnector) annotation (
        Line(points = {{16, 54}, {30, 54}, {30, 70}, {62, 70}}));
      connect(comp_electrolyser.port_outlet_o2, gasConverter_O.gasConnector) annotation (
        Line(points = {{16, 50}, {62, 50}}));
      connect(gasConverter_H2.Vdot_norm, out_H2) annotation (
        Line(points = {{79, 70}, {150, 70}}, color = {0, 0, 127}));
      connect(gasConverter_O.Vdot_norm, out_O) annotation (
        Line(points = {{79, 50}, {150, 50}}, color = {0, 0, 127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -160}, {160, 160}}), graphics={  Ellipse(origin = {17, 45}, extent = {{-117, 107}, {83, -93}}, endAngle = 360), Line(points = {{-120, -148}, {-120, -110}, {120, -110}, {120, -150}}, thickness = 0.5), Line(points = {{90, -68}, {90, -88}, {-90, -88}, {-90, -68}}, thickness = 0.5), Text(origin = {-23.76, 35.82}, extent = {{-44.24, 48.18}, {11.76, -17.82}}, textString = "P"), Text(origin = {58.66, 35.82}, extent = {{-42.66, 48.18}, {11.34, -17.82}}, textString = "H"), Text(origin = {57.0526, 38.6666}, extent = {{-5.05259, 3.33338}, {18.9474, -16.6666}}, textString = "2"), Polygon(fillColor = {76, 76, 76},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{-10, 64}, {14, 52}, {-10, 38}, {-10, 64}}), Text(origin = {-46.3632, 39.1428}, extent = {{-3.63632, 2.85714}, {16.3632, -17.1428}}, textString = "el"), Rectangle(fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-30, -78}, {30, -120}}), Text(fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-30, -78}, {30, -120}}, textString = "HP"), Polygon(fillColor = {28, 108, 200},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, points = {{-100, -68}, {-90, -48}, {-80, -68}, {-100, -68}}), Polygon(origin = {86, -53}, rotation = 180, fillColor = {238, 46, 47},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, points = {{6, -5}, {-4, 15}, {-14, -5}, {6, -5}}), Ellipse(fillColor = {255, 255, 255},
                fillPattern =                                                                                                                                                                                                        FillPattern.Solid,
                lineThickness =                                                                                                                                                                                                        0.5, extent = {{-36, -78}, {-56, -98}}, endAngle = 360), Line(points = {{-46, -78}, {-56, -88}, {-46, -98}}, thickness = 0.5)}),
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -160}, {160, 160}})),
        experiment(StopTime = 2000000, __Dymola_NumberOfIntervals = 1000));
    end ElectrolysisSystem;

    model Electrolyser "temperature-controlled electrolysis system"
      replaceable model CellModel = PartialModels.PartialCell constrainedby
        PartialModels.PartialCell                                                                     "choose whether to use simple or detailed model for electrolysis" annotation (
         choices(choice(redeclare model CellModel = DetailedModel.Cell "detailed model"), choice(redeclare
              model                                                                                              CellModel =
                SimpleModel.Cell                                                                                                              "simple model")));
      parameter SI.Temperature param_T_container(displayUnit = "K") = 30 + 273.15 "temperature inside electrolyser container" annotation (
        Dialog(group = "general parameter"));
      // operating parameter for stack
      parameter Units.VolumetricEnergy param_stack_kWh_per_m3 = 4.4 "simple model: constant specific energy demand for H2 production of stack in kWh per normcubicmeter (0 °C, 1,01325 bar)" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter Units.VolumetricEnergy param_stack_HHV_h2 = 3.5403 "higher heating value of H2 at norm conditions (0 °C, 1,01325 bar)" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Power param_stack_P_el_min = 10e3 "minimal power of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Power param_stack_P_el_max = 100e3 "nominal power of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.CurrentDensity param_stack_i_min = 0.2e4 "minimum current density in electrolysis cell" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.CurrentDensity param_stack_i_max = 2.5e4 "maximum current density in electrolysis cell" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Temperature param_stack_T_init(displayUnit = "K") = 50 + 273.15 "initial temperature of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Temperature param_stack_T_op(displayUnit = "K") = 65 + 273.15 "desired operating temperature of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Temperature param_stack_T_crit(displayUnit = "K") = 75 + 273.15 "critical temperature at which electrolyser turns off" annotation (
        Dialog(group = "electrolysis parameter"));
      parameter SI.Temperature param_stack_T_in(displayUnit = "K") = 55 + 273.15 "desired inlet temperature of electrolyser stack" annotation (
        Dialog(group = "electrolysis parameter"));
      SI.Pressure param_stack_p_op_cathode "operating pressure at cathode" annotation (
        Dialog(group = "electrolysis parameter"));
      SI.Pressure param_stack_p_op_anode "operating pressure at anode" annotation (
        Dialog(group = "electrolysis parameter"));
      // general parameter of stack
      parameter Integer param_stack_cell_n = 100 "number of cells in electrolyser" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Area param_stack_cell_area = 600e-4 "membrane area of one cell [m²]" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Distance param_stack_cell_d = 200e-6 "thickness of cell membrane [m]" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Distance param_stack_cell_length = 0.35 "length of one cell including frame thickness [m]" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Distance param_stack_cell_depth = 0.02 "depth of one cell including frame [m]" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Mass param_stack_mass = 2000 "mass of electrolyser (without cooling liquid)" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.SpecificHeatCapacity param_stack_cp = 420 "mean specific heat capacity of electrolyser" annotation (
        Dialog(group = "stack parameter"));
      parameter SI.Mass param_stack_mass_h2o = 100 "mass of electrolyser cooling liquid" annotation (
        Dialog(group = "stack parameter"));
      // operating parameter for peripheral components
      parameter Real param_ppm_h2o_h2 = 5 "desired water fraction of hydrogen after gas dryer in ppm" annotation (
        Dialog(group = "peripheral parameter"));
      parameter SI.Pressure param_p_comp_h2 = 200e5 "pressure of compressed hydrogen for storage purposes" annotation (
        Dialog(group = "peripheral parameter"));
      parameter Integer param_n_comp_h2 = 5 "number of compressor stages" annotation (
        Dialog(group = "peripheral parameter"));
      // cooling pump parameter
      parameter SI.VolumeFlowRate param_pump_Qmax = 5e-3 "maximal volume flow rate of pump at 25°C [m³/s]" annotation (
        Dialog(group = "cooling pump parameter"));
      parameter SI.Pressure param_pump_dp = 2e5 "system pressure loss at maximum volume flow rate [Pa]" annotation (
        Dialog(group = "cooling pump parameter"));
      parameter SI.Efficiency param_pump_eta = 0.6 "cooling pump efficiency at operating condition" annotation (
        Dialog(group = "cooling pump parameter"));
      // variables
      SI.Power var_P_ex(start = 0, fixed = false) "excess power which is not used";
      SI.Power var_P_av_elec(start = 0, fixed = false) "available power for the electrolyser stack";
      SI.Energy var_P_cons(start = 0.0, fixed = true) "integrated power consumption";
      Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons) "integrated power consumption in kWh";
      // components of system
      Stack comp_stack(redeclare CellModel comp_cell(redeclare package H2 = H2, redeclare
            package                                                                               O2 = O2, param_p_op_cathode = param_stack_p_op_cathode, param_p_op_anode = param_stack_p_op_anode, param_kWh_per_m3 = param_stack_kWh_per_m3, param_HHV_h2 = param_stack_HHV_h2, param_membrane_area = param_stack_cell_area, param_membrane_d = param_stack_cell_d), comp_heater(param_T_op_min = param_stack_T_op - 5), redeclare
          package                                                                                                                                                                                                         O2 = O2, redeclare
          package                                                                                                                                                                                                         H2 = H2, param_stack_kWh_per_m3 = param_stack_kWh_per_m3, param_stack_HHV_h2 = param_stack_HHV_h2, param_stack_P_el_min = param_stack_P_el_min, param_stack_P_el_max = param_stack_P_el_max, param_stack_i_min = 0.2e4, param_stack_i_max = param_stack_i_max, param_stack_T_init = param_stack_T_init, param_stack_T_op = param_stack_T_op, param_stack_T_crit = param_stack_T_crit, param_stack_T_in = param_stack_T_in, param_stack_p_op_cathode = param_stack_p_op_cathode, param_stack_p_op_anode = param_stack_p_op_anode, param_stack_cell_n = param_stack_cell_n, param_stack_cell_area = param_stack_cell_area, param_stack_cell_d = param_stack_cell_d, param_stack_cell_length = param_stack_cell_length, param_stack_cell_depth = param_stack_cell_depth, param_stack_mass = param_stack_mass, param_stack_cp = param_stack_cp, param_stack_mass_h2o = param_stack_mass_h2o) annotation (
        Placement(transformation(extent = {{-40, -2}, {40, 78}})));
      Pump.Pump comp_pump(param_Q_max = param_pump_Qmax) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-6, -42})));
      Cooler.AirCooler comp_airCooler(param_T_Set = param_stack_T_in, param_T_init = param_stack_T_init) "cools fluid against ambient" annotation (
        Placement(transformation(extent = {{-120, -100}, {-100, -80}})));
      GasDryer.GasDryer comp_gasDryerH2(param_ppm_h2o = param_ppm_h2o_h2, param_use_water_outlet = false) annotation (
        Placement(transformation(extent = {{60, 130}, {80, 150}})));
      GasCompressor.H2Compressor comp_gasCompressorH2(param_p_end = param_p_comp_h2, param_n_compStage = param_n_comp_h2) annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {100, 140})));
      // sensors
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor meas_T_stack_in "Inlet temperature of stack" annotation (
        Placement(transformation(extent = {{-60, -110}, {-40, -90}})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor meas_T_stack "temperature of stack" annotation (
        Placement(transformation(extent = {{40, -110}, {60, -90}})));
      // connectors
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_inlet_cooling(m_flow(start = comp_pump.param_Q_min / 1000, fixed = false)) annotation (
        Placement(transformation(extent = {{-120, -160}, {-80, -120}})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet_cooling annotation (
        Placement(transformation(extent = {{80, -160}, {120, -120}})));
      Tools.Connectors.GasConnector port_outlet_h2(redeclare package Gas = H2) annotation (
        Placement(transformation(extent = {{120, 120}, {160, 160}})));
      Q100_DistrictModel.ElectrolysisSystem.Tools.Connectors.GasConnector port_outlet_o2(redeclare
          package                                                                                          Gas = O2) annotation (
        Placement(visible = true, transformation(extent = {{120, 80}, {160, 120}}, rotation = 0), iconTransformation(extent = {{120, 80}, {160, 120}}, rotation = 0)));
      Q100_DistrictModel.ElectrolysisSystem.Tools.Connectors.PowerConnector port_P_el annotation (
        Placement(visible = true, transformation(extent = {{-160, 120}, {-120, 160}}, rotation = 0), iconTransformation(extent = {{-160, 120}, {-120, 160}}, rotation = 0)));
      // controllers
      AixLib.Controls.Continuous.LimPID contr_pump_mflow(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 5e-4, Td = 0.25, Ti = 100, initType = Modelica.Blocks.Types.InitPID.InitialOutput, xi_start = param_stack_T_init, reverseAction = true, strict = true, yMax = comp_pump.param_Q_max, yMin = comp_pump.param_Q_min, y_start = comp_pump.param_Q_min) annotation (
        Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 0, origin = {-66, -42})));
      // external input blocks
      Modelica.Blocks.Interfaces.RealInput inp_P_av "power available for electrolyser system" annotation (
        Placement(transformation(extent = {{-200, 10}, {-160, 50}}), iconTransformation(extent = {{-180, 30}, {-160, 50}})));
      Modelica.Blocks.Interfaces.RealInput inp_T_air "outside air temperature" annotation (
        Placement(transformation(extent = {{-198, -102}, {-158, -62}}), iconTransformation(extent = {{-180, -50}, {-160, -30}})));
      // internal input blocks
      Modelica.Blocks.Sources.RealExpression exp_P_stack_av(y = var_P_av_elec) "available power for electrolyser stack" annotation (
        Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-94, 34})));
      Modelica.Blocks.Sources.RealExpression exp_set_T_stack(y = param_stack_T_op) "setpoint temperature for stack" annotation (
        Placement(visible = true, transformation(extent = {{-118, -52}, {-98, -32}}, rotation = 0)));
      Modelica.Blocks.Sources.RealExpression exp_is_T_stack(y = meas_T_stack.T) "current temperature of stack" annotation (
        Placement(visible = true, transformation(extent = {{-118, -70}, {-98, -50}}, rotation = 0)));
      // media packages
      Modelica.Blocks.Logical.Hysteresis block_hyst_cooling_on(uLow = param_stack_T_op - 1, uHigh = param_stack_T_op) "turns cooling system on if T_op is exceeded by one degree" annotation (
        Placement(transformation(extent = {{-164, -56}, {-152, -44}})));
      Modelica.Blocks.Interfaces.BooleanOutput out_cooling_system_on "true if cooling system is needed" annotation (
        Placement(transformation(extent = {{-160, -150}, {-180, -130}})));
      Modelica.Blocks.Continuous.FirstOrder block_firstOrder(T = 6, initType = Modelica.Blocks.Types.Init.InitialOutput, y_start = 0) annotation (
        Placement(transformation(extent = {{-44, -48}, {-32, -36}})));
      Modelica.Blocks.Sources.BooleanExpression exp_true(y = comp_stack.port_P_el.P > 1) "cooling cycle on" annotation (
        Placement(visible = true, transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-146, -92})));
    protected
      package H2 = Media.Gases.H2andWaterVapor;
      package O2 = Media.Gases.O2andWaterVapor;
    equation
    // assert statements in case something doesn't check out
      assert(port_P_el.P >= (-Const.eps), "power consumption <0", AssertionLevel.warning);
    // actual power consumption
      port_P_el.P = inp_P_av - var_P_ex;
      der(var_P_cons) = port_P_el.P;
    // specific assert statement
      assert(comp_stack.port_P_el.P >= (-Const.eps) and comp_gasCompressorH2.port_P_el.P >= (-Const.eps) and comp_gasDryerH2.port_P_el.P >= (-Const.eps) and comp_pump.port_P_el.P >= (-Const.eps), "at least one value <0" + ", stack: " + String(comp_stack.port_P_el.P) + ", h2comp: " + String(comp_gasCompressorH2.port_P_el.P) + ", h2dryer: " + String(comp_gasDryerH2.port_P_el.P) + ", pump: " + String(comp_pump.port_P_el.P), AssertionLevel.warning);
    // remaining power for stack
      var_P_av_elec = inp_P_av - abs(comp_gasCompressorH2.port_P_el.P) - abs(comp_gasDryerH2.port_P_el.P) - abs(comp_pump.port_P_el.P) - abs(comp_airCooler.port_P_el.P);
    // balance power consumption
      0 = port_P_el.P - (abs(comp_stack.port_P_el.P) + abs(comp_gasCompressorH2.port_P_el.P) + abs(comp_gasDryerH2.port_P_el.P) + abs(comp_pump.port_P_el.P));
      connect(comp_airCooler.port_outlet, meas_T_stack_in.enthalpyPort_a) annotation (
        Line(points = {{-101, -100}, {-78, -100}, {-78, -100.1}, {-58.8, -100.1}}, color = {176, 0, 0}));
      connect(meas_T_stack_in.enthalpyPort_b, comp_pump.port_inlet) annotation (
        Line(points = {{-41, -100.1}, {-6, -100.1}, {-6, -52}}, color = {176, 0, 0}));
      connect(meas_T_stack.enthalpyPort_b, port_outlet_cooling) annotation (
        Line(points = {{59, -100.1}, {140, -100.1}, {140, -140}, {100, -140}}, color = {176, 0, 0}));
      connect(comp_airCooler.port_inlet, port_inlet_cooling) annotation (
        Line(points = {{-119, -100}, {-140, -100}, {-140, -140}, {-100, -140}}, color = {176, 0, 0}));
      connect(exp_set_T_stack.y, contr_pump_mflow.u_s) annotation (
        Line(points = {{-97, -42}, {-73.2, -42}}, color = {0, 0, 127}));
      connect(inp_T_air, comp_airCooler.inp_T_Amb) annotation (
        Line(points = {{-178, -82}, {-121, -82}}, color = {0, 0, 127}));
      connect(exp_P_stack_av.y, comp_stack.inp_P_av) annotation (
        Line(points = {{-83, 34}, {-44, 34}}, color = {0, 0, 127}));
      connect(block_hyst_cooling_on.u, contr_pump_mflow.u_m) annotation (
        Line(points = {{-165.2, -50}, {-170, -50}, {-170, -72}, {-66, -72}, {-66, -49.2}}, color = {0, 0, 127}));
      connect(exp_is_T_stack.y, contr_pump_mflow.u_m) annotation (
        Line(points = {{-97, -60}, {-66, -60}, {-66, -49.2}}, color = {0, 0, 127}));
      connect(comp_pump.inp_Q, block_firstOrder.y) annotation (
        Line(points = {{-17, -42}, {-31.4, -42}}, color = {0, 0, 127}));
      connect(contr_pump_mflow.y, block_firstOrder.u) annotation (
        Line(points = {{-59.4, -42}, {-45.2, -42}}, color = {0, 0, 127}));
      connect(exp_true.y, comp_airCooler.inp_offSwitch) annotation (
        Line(points = {{-135, -92}, {-126, -92}, {-126, -88}, {-121, -88}}, color = {255, 0, 255}));
      connect(block_hyst_cooling_on.y, out_cooling_system_on) annotation (
        Line(points = {{-151.4, -50}, {-144, -50}, {-144, -28}, {-196, -28}, {-196, -120}, {-150, -120}, {-150, -140}, {-170, -140}}, color = {255, 0, 255}));
      connect(inp_P_av, comp_stack.inp_P_av_tot) annotation (
        Line(points = {{-180, 30}, {-132, 30}, {-132, 50}, {-44, 50}}, color = {0, 0, 127}));
      connect(comp_stack.port_outlet_h2, comp_gasDryerH2.port_inlet_gas) annotation (
        Line(points = {{48, 70}, {50, 70}, {50, 140}, {60, 140}}, color = {0, 0, 0}));
      connect(comp_gasDryerH2.port_outlet_gas, comp_gasCompressorH2.port_inlet_gas) annotation (
        Line(points = {{80, 140}, {90, 140}}, color = {0, 0, 0}));
      connect(comp_gasCompressorH2.port_outlet_gas, port_outlet_h2) annotation (
        Line(points = {{110, 140}, {140, 140}}, color = {0, 0, 0}));
      connect(comp_stack.port_outlet_o2, port_outlet_o2) annotation (
        Line(points = {{48, 54}, {94, 54}, {94, 100}, {140, 100}}));
      connect(comp_pump.port_outlet, comp_stack.port_inlet_cooling) annotation (
        Line(points = {{-6, -32}, {-6, -16}, {-20, -16}, {-20, 2}}, color = {176, 0, 0}));
      connect(comp_stack.port_outlet_cooling, meas_T_stack.enthalpyPort_a) annotation (
        Line(points = {{20, 2}, {20, -100.1}, {41.2, -100.1}}, color = {176, 0, 0}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -160}, {160, 160}}), graphics = {Ellipse(origin = {28.03, -11.2}, extent = {{-186.03, 171.2}, {131.97, -148.8}}, endAngle = 360), Text(origin = {-44.38, -30.8}, extent = {{-61.62, 116.8}, {16.38, -43.2}}, textString = "P"), Text(origin = {-74.7272, -11.714}, extent = {{-7.2728, 11.7142}, {32.7272, -70.286}}, textString = "el"), Text(origin = {86.46, -34.26}, extent = {{-58.46, 118.26}, {15.54, -43.74}}, textString = "H"), Text(origin = {108, -14.6664}, extent = {{-7.99999, 12.6664}, {30, -63.3336}}, textString = "2"), Polygon(fillColor = {76, 76, 76}, fillPattern = FillPattern.Solid, points = {{-20, 20}, {20, 0}, {-20, -20}, {-20, -20}, {-20, 20}})}),
        Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -160}, {160, 160}})),
        experiment(StopTime = 10800, __Dymola_Algorithm = "Rkfix4"));
    end Electrolyser;

    model Stack "stack model for electrolyser"

      replaceable model CellModel = PartialModels.PartialCell constrainedby
        PartialModels.PartialCell "choose whether to use simple or detailed model for electrolysis"
          annotation(choices(
            choice(redeclare model CellModel =
                DetailedModel.Cell                                        "detailed model"),
            choice(redeclare model CellModel =
                SimpleModel.Cell                                        "simple model")));

      // media models for H2 and O2
      replaceable package H2 = Media.Gases.H2andWaterVapor;
      replaceable package O2 = Media.Gases.O2andWaterVapor;

      // ambient temperature
      parameter SI.Temperature param_T_container(displayUnit="K") = 30+273.15 "temperature inside electrolyser container" annotation(Dialog(group="general parameter"));

      // operating parameter for stack
      parameter Units.VolumetricEnergy param_stack_kWh_per_m3 = 4.4 "simple model: constant specific energy demand for H2 production of stack in kWh per normcubicmeter (0 °C, 1,01325 bar)" annotation(Dialog(group="electrolysis parameter"));
        parameter Units.VolumetricEnergy param_stack_HHV_h2 = 3.5403 "higher heating value of H2 at norm conditions (0 °C, 1,01325 bar)"
                                                                                                                                         annotation(Dialog(group="electrolysis parameter"));
      parameter SI.Power param_stack_P_el_min = 10e3 "minimal power of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
      parameter SI.Power param_stack_P_el_max = 100e3 "nominal power of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
      parameter SI.CurrentDensity param_stack_i_min = 0.2e4 "minimum current density in electrolysis cell" annotation(Dialog(group="electrolysis parameter"));
      parameter SI.CurrentDensity param_stack_i_max = 2.5e4 "maximum current density in electrolysis cell" annotation(Dialog(group="electrolysis parameter"));
      parameter SI.Temperature param_stack_T_init(displayUnit="K") = 50+273.15 "initial temperature of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
      parameter SI.Temperature param_stack_T_op(displayUnit="K")= 65+273.15 "desired operating temperature of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
      parameter SI.Temperature param_stack_T_crit(displayUnit="K") = 75+273.15 "critical temperature at which electrolyser turns off" annotation(Dialog(group="electrolysis parameter"));
      parameter SI.Temperature param_stack_T_in(displayUnit="K")= 55+273.15 "desired inlet temperature of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
      SI.Pressure param_stack_p_op_cathode "operating pressure at cathode"
                                                                          annotation(Dialog(group="electrolysis parameter"));
      SI.Pressure param_stack_p_op_anode "operating pressure at anode"
                                                                      annotation(Dialog(group="electrolysis parameter"));

      // general parameter of stack
      parameter Integer param_stack_cell_n=100 "number of cells in electrolyser"
                                                                                annotation(Dialog(group="stack parameter"));
      parameter SI.Area param_stack_cell_area=600e-4 "membrane area of one cell [m²]"   annotation (Dialog(group="stack parameter"));
      parameter SI.Distance param_stack_cell_d=200e-6 "thickness of cell membrane [m]"   annotation (Dialog(group="stack parameter"));
      parameter SI.Distance param_stack_cell_length=0.35 "length of one cell including frame thickness [m]"    annotation (Dialog(group="stack parameter"));
      parameter SI.Distance param_stack_cell_depth=0.02 "depth of one cell including frame [m]"    annotation (Dialog(group="stack parameter"));
      parameter SI.Mass param_stack_mass = 2000 "mass of electrolyser (without cooling liquid)" annotation(Dialog(group="stack parameter"));
      parameter SI.SpecificHeatCapacity param_stack_cp = 420 "mean specific heat capacity of electrolyser" annotation(Dialog(group="stack parameter"));
      parameter SI.Mass param_stack_mass_h2o = 100 "mass of electrolyser cooling liquid" annotation(Dialog(group="stack parameter"));

      // other parameter of stack
      parameter SI.Distance param_frame_thickness=0.03    "width of frame around cell [m]"    annotation (Dialog(group="detailed stack parameter"));
      parameter SI.ThermalConductivity param_frame_lambda=0.23    "thermal conducivity of frame [W/(m.K)]"    annotation (Dialog(group="detailed stack parameter"));
      parameter SI.Distance param_endplate_thickness=0.12    "width of endplates of stack"    annotation (Dialog(group="detailed stack parameter"));
      parameter SI.ThermalConductivity param_endplate_lambda=15    "thermal conducivity of frame [W/(m.K)]"    annotation (Dialog(group="detailed stack parameter"));
      parameter SI.CoefficientOfHeatTransfer param_alpha_inside=210    "heat transfer coefficient from cell to frame/endplate [W/(m2.K)]"    annotation (Dialog(group="detailed stack parameter"));
      parameter SI.CoefficientOfHeatTransfer param_alpha_ambient=3.8    "heat transfer coefficient from frame/endplate to ambient [W/(m2.K)]"    annotation (Dialog(group="detailed stack parameter"));

      // variables
      SI.Temperature var_T_stack=comp_heatCapacity.T
        "current stack temperature";

      // production of gas, power consumption, efficiency
      SI.Mass var_h2_prod(start=0, fixed=true)  "mass of produced hydrogen [kg]";
      SI.Mass var_o2_prod(start=0, fixed=true)    "mass of produced oxygen [kg]";
      SI.Energy var_P_cons(start=0.0, fixed=true) "integrated power consumption";
      Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons) "integrated power consumption [kWh]";
      SI.Energy var_Q_cool(start=0.0, fixed=true) "integrated extra cooling need";
      SI.Energy var_Q_tot(start=0.0, fixed=true) "integrated heat production";
      Real var_Q_cool_kWh = SI.Conversions.to_kWh(var_Q_cool) "integrated extra cooling need [kWh]";
      Real var_Q_tot_kWh = SI.Conversions.to_kWh(var_Q_tot) "integrated heat production in kWh";
      SI.Volume var_h2_prod_Nm3=var_h2_prod/param_dens_h2 "produced hydrogen as norm-cubicmeter (0 °C, 1,01325 bar)";
      SI.Volume var_o2_prod_Nm3=var_o2_prod/param_dens_o2 "produced oxygen as norm-cubicmeter (0 °C, 1,01325 bar)";
      Real var_h2_prod_kWh=param_stack_HHV_h2 * var_h2_prod_Nm3 "produced hydrogen as kWh (higher heating value)";

      // variables for heat flow calculation
      SI.HeatFlowRate var_Q_amb_cell  "Heat flow to ambient of one cell [W]";
      SI.HeatFlowRate var_Q_amb_endplate   "Heat flow to ambient at endplate [W]";
      SI.HeatFlowRate var_Q_amb  "Heat flow to ambient of whole electrolyser [W]";
      SI.HeatFlowRate var_Q_coolingSystem   "heat flow from/to cooling system";

      //components
      replaceable CellModel comp_cell(
        redeclare package H2 = H2,
        redeclare package O2 = O2,
        param_p_op_cathode=param_stack_p_op_cathode,
        param_p_op_anode=param_stack_p_op_anode,
        param_kWh_per_m3=param_stack_kWh_per_m3,
        param_HHV_h2=param_stack_HHV_h2,
        param_membrane_area=param_stack_cell_area,
        param_membrane_d=param_stack_cell_d) constrainedby
        PartialModels.PartialCell
        "model of one cell, can be scaled due to assumed uniform temperature throughout stack"
        annotation (Placement(visible=true, transformation(extent={{78,-14},{98,6}}, rotation=0)));
      AixLib.FastHVAC.BaseClasses.EnergyBalance comp_energyBalance    annotation (Placement(transformation(extent={{-12,-102},{12,-80}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor comp_heatCapacity(C=
            param_hc + param_hc_h2o, T(fixed=true, start=param_stack_T_init))
        "heat capacity of electrolyser and water inside electrolyser"    annotation (Placement(transformation(extent={{-30,-62},{-10,-42}})));
      Rectifier.Rectifier comp_rectifier(param_P_rated=param_stack_P_el_max)
        annotation (Placement(transformation(extent={{-88,-80},{-68,-60}})));

      // connectors
      Tools.Connectors.PowerConnector port_P_el "power input for electrolyser" annotation (
          Placement(transformation(extent={{-120,-80},{-100,-60}}), iconTransformation(extent={{-140,
                -100},{-100,-60}})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_inlet_cooling "cooling inlet"
        annotation (Placement(transformation(extent={{-60,-100},{-40,-80}}),
            iconTransformation(extent={{-60,-100},{-40,-80}})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet_cooling
        "cooling outlet" annotation (Placement(transformation(extent={{40,-100},{60,
                -80}}), iconTransformation(extent={{40,-100},{60,-80}})));
      Tools.Connectors.GasConnector port_outlet_o2(redeclare package Gas = O2)
        "outlet port of produced oxygen" annotation (Placement(transformation(extent={{-100,60},{-80,
                80}}), iconTransformation(extent={{100,20},{140,60}})));
      Tools.Connectors.GasConnector port_outlet_h2(redeclare package Gas = H2)
        "outlet port of produced hydrogen" annotation (Placement(transformation(extent={{80,60},{100,
                80}}), iconTransformation(extent={{100,60},{140,100}})));

      // controller, inputs and tools
      AixLib.Controls.Continuous.LimPID contr_stack_temperature(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=0.5,
        yMax=1,
        reverseAction=false)
        "controls stack power consumption due to stack temperature"
        annotation (Placement(transformation(extent={{-60,46},{-52,54}})));
      Modelica.Blocks.Interfaces.RealInput inp_P_av "avaiable power" annotation (
          Placement(transformation(extent={{-140,-40},{-100,0}}),
            iconTransformation(extent={{-120,-20},{-100,0}})));
      Tools.Components.Switch block_switch_greater_i_min
        "limits power due to minimal power consumption"
        annotation (Placement(transformation(extent={{0,18},{12,30}})));

      Modelica.Blocks.Math.Product block_limiter_P
        "limits power of cell due to boundary conditions"
        annotation (Placement(transformation(extent={{-22,18},{-10,30}})));
      Modelica.Blocks.Continuous.FirstOrder block_PT1_stack_temperature(T=1,
                                            y(start=param_stack_T_init, fixed=true))
        annotation (Placement(transformation(extent={{-74,30},{-66,38}})));
      Modelica.Blocks.Math.Division block_divisor
        "divides available power through number of cells"
        annotation (Placement(transformation(extent={{44,16},{54,26}})));
      Modelica.Blocks.Sources.RealExpression exp_n_cells(y=param_stack_cell_n)
        "number of cells in stack"
        annotation (Placement(transformation(extent={{-4,-8},{10,4}})));
      Modelica.Blocks.Math.Min block_min
        annotation (Placement(transformation(extent={{-54,-14},{-46,-6}})));
      Modelica.Blocks.Sources.RealExpression exp_P_max(y=param_stack_P_el_max)
        "max power consumption of stack"
        annotation (Placement(transformation(extent={{-100,-6},{-86,6}})));
      Modelica.Blocks.Math.Product block_powerLimiter_imax1
        "limits power of cell due to maximum current density"
        annotation (Placement(transformation(extent={{-72,-28},{-62,-18}})));
      Modelica.Blocks.Sources.RealExpression exp_rectifier_eta(y=comp_rectifier.var_eta)
        annotation (Placement(transformation(extent={{-100,-46},{-86,-34}})));
      Heater.Heater comp_heater(
        param_P_el_max=0.3*param_stack_P_el_max,
        param_T_op=param_stack_T_op)
        annotation (Placement(transformation(extent={{-32,-36},{-20,-24}})));
      Modelica.Blocks.Sources.RealExpression exp_T_stack(y=var_T_stack)
        "stack temperature"
        annotation (Placement(transformation(extent={{-60,-48},{-46,-36}})));
      Modelica.Blocks.Sources.RealExpression exp_P_av_stack(y=max(block_min.y -
            comp_heater.port_P_el.P, 0)) "available power for stack"
        annotation (Placement(transformation(extent={{-50,14},{-36,26}})));
      AixLib.Controls.Continuous.LimPID contr_cell_i(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2,
        Ti=0.5,
        yMax=param_stack_i_max,
        yMin=0,
        initType=Modelica.Blocks.Types.InitPID.InitialOutput,
        xi_start=0,
        y_start=0,
        reverseAction=false) "controls cell current density"
        annotation (Placement(transformation(extent={{48,-12},{58,-2}})));
      Modelica.Blocks.Sources.RealExpression exp_P_cell(y=comp_cell.port_P_el.P)
        "power consumption of one cell"
        annotation (Placement(transformation(extent={{30,-28},{46,-16}})));
      Tools.Components.DynHysteresis block_hyst_greater_i_min(uLow=param_U_rev*param_stack_i_min*
            param_stack_cell_n*comp_cell.param_membrane_area, uHigh=(param_U_rev*param_stack_i_min*
            param_stack_cell_n*comp_cell.param_membrane_area)*1.05)
        annotation (Placement(transformation(extent={{-4,40},{4,48}})));
      Modelica.Blocks.Sources.RealExpression exp_T_cell(y=var_T_stack)
        "temperature of cell (equals stack temperature)"
        annotation (Placement(transformation(extent={{46,-36},{62,-24}})));
      Modelica.Blocks.Sources.RealExpression exp_T_crit(y=param_stack_T_crit)
        "critical stack temperature"
        annotation (Placement(transformation(extent={{-96,44},{-82,56}})));
      Modelica.Blocks.Sources.RealExpression exp_T_stack1(y=var_T_stack)
        "stack temperature"
        annotation (Placement(transformation(extent={{-96,28},{-82,40}})));
      Tools.Components.Switch block_filter_small_values
        "blocks very small controller outputs (<1e-12)"
        annotation (Placement(transformation(extent={{66,0},{72,6}})));
      Modelica.Blocks.Interfaces.RealInput inp_P_av_tot "avaiable power for total system" annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-30,100}), iconTransformation(extent={{-120,20},{-100,40}})));
    protected
      Modelica.Blocks.Interfaces.RealOutput inp_wasteHeatFlow
        "heat flow from/to cooling system" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={14,-46})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_wasteHeat(alpha=0)
        "waste heat" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={22,-56})));

    protected
      parameter SI.MolarMass param_M_h2=H2.molarMass(H2.setState_pTX(101325,273.15,{1,0})) "molar mass of hydrogen";
      parameter SI.MolarMass param_M_o2 = O2.molarMass(O2.setState_pTX(101325,288.15,{1,0})) "molar mass of oxygen";
      parameter SI.Density param_dens_o2 = O2.density(H2.setState_pTX(101325,273.15,{1,0})) "density of O2 at norm conditions (0 °C, 1,01325 bar)";
      parameter SI.Density param_dens_h2 = H2.density(H2.setState_pTX(101325,273.15,{1,0})) "density of H2 at norm conditions (0 °C, 1,01325 bar)";
      parameter SI.HeatCapacity param_hc=param_stack_mass*param_stack_cp "heat capacity of electrolyser without water";
      parameter SI.HeatCapacity param_hc_h2o=4182*param_stack_mass_h2o  "heat capacity of water inside electrolyser";

      parameter SI.Voltage param_U_rev=
        (-Media.Functions.H2O.deltaH(param_stack_T_op)
          -param_stack_T_op*(Media.Functions.H2.S(param_stack_T_op)
          +0.5*Media.Functions.O2.S(param_stack_T_op)-Media.Functions.H2O.S(param_stack_T_op)))
          /(2*Const.F) "reversibel cell voltage for hysteresis power controller";

      parameter SI.CoefficientOfHeatTransfer param_alpha_res_frame=
          (1/param_alpha_inside + param_frame_thickness/param_frame_lambda + 1/param_alpha_ambient)^(-1)
        "resulting heat transfer coefficient frame to ambient";
      parameter SI.CoefficientOfHeatTransfer param_alpha_res_endplate=
          (1/param_alpha_inside + param_endplate_thickness/param_endplate_lambda + 1/param_alpha_ambient)^(-1)
        "resulting heat transfer coefficient endplate to ambient";

    equation

      assert(comp_heatCapacity.T>=283.15, "temperature lower than 10°C: " + String(comp_heatCapacity.T), AssertionLevel.error);

      // hydrogen port
      port_outlet_h2.n_flow = max(comp_cell.port_outlet_h2.n_flow*param_stack_cell_n,Const.eps);
      port_outlet_h2.h = comp_cell.port_outlet_h2.h;
      port_outlet_h2.p = comp_cell.port_outlet_h2.p;
      port_outlet_h2.X = comp_cell.port_outlet_h2.X;

      // oxygen port
      port_outlet_o2.n_flow = max(comp_cell.port_outlet_o2.n_flow*param_stack_cell_n,Const.eps);
      port_outlet_o2.h = comp_cell.port_outlet_o2.h;
      port_outlet_o2.p = comp_cell.port_outlet_o2.p;
      port_outlet_o2.X = comp_cell.port_outlet_o2.X;

      // integrators
      der(var_h2_prod) = max(port_outlet_h2.n_flow*port_outlet_h2.X[1]*param_M_h2,0);
      der(var_o2_prod) =max(port_outlet_o2.n_flow*port_outlet_o2.X[1]*param_M_o2,0);
      der(var_Q_tot) = max(comp_cell.var_Q_prod*param_stack_cell_n,0);
      der(var_Q_cool) = max(var_Q_coolingSystem,0);

      // heat loss to ambient
      var_Q_amb_cell =param_alpha_res_frame*4*(param_stack_cell_length)*param_stack_cell_depth*(var_T_stack
         - param_T_container);
      var_Q_amb_endplate =param_alpha_res_endplate*(param_stack_cell_length)^2*(var_T_stack
         - param_T_container);
      var_Q_amb = (param_stack_cell_n*var_Q_amb_cell + 2*var_Q_amb_endplate);

      //load for cooling system
      var_Q_coolingSystem =comp_cell.var_Q_prod*param_stack_cell_n - var_Q_amb;
      inp_wasteHeatFlow = var_Q_coolingSystem+comp_heater.out_P_heat;

      // power consumption
      comp_rectifier.port_P_el_out.P = max(comp_cell.port_P_el.P*param_stack_cell_n+comp_heater.port_P_el.P,0);
      der(var_P_cons) = comp_cell.port_P_el.P*param_stack_cell_n;

      // connect statements
      connect(comp_heatCapacity.port, comp_energyBalance.heatPort_a) annotation (
          Line(points={{-20,-62},{-20,-82.2},{0,-82.2}}, color={191,0,0}));
      connect(heatflow_wasteHeat.port, comp_energyBalance.heatPort_a)
        annotation (Line(points={{22,-66},{22,-82.2},{0,-82.2}}, color={191,0,0}));
      connect(port_inlet_cooling, comp_energyBalance.enthalpyPort_a) annotation (
          Line(points={{-50,-90},{-50,-91},{-9.6,-91}}, color={176,0,0}));
      connect(port_outlet_cooling, comp_energyBalance.enthalpyPort_b)
        annotation (Line(points={{50,-90},{50,-91},{9.6,-91}}, color={176,0,0}));
      connect(heatflow_wasteHeat.Q_flow, inp_wasteHeatFlow)
        annotation (Line(points={{22,-46},{14,-46}},color={0,0,127}));
      connect(block_limiter_P.y, block_switch_greater_i_min.u)
        annotation (Line(points={{-9.4,24},{-1.2,24}}, color={0,0,127}));
      connect(block_PT1_stack_temperature.y, contr_stack_temperature.u_m)
        annotation (Line(points={{-65.6,34},{-56,34},{-56,45.2}},
                                                                color={0,0,127}));
      connect(exp_n_cells.y, block_divisor.u2)
        annotation (Line(points={{10.7,-2},{16,-2},{16,18},{43,18}},
                                                                   color={0,0,127}));
      connect(comp_rectifier.port_P_el_in, port_P_el) annotation (Line(points={{-88,
              -70},{-102,-70},{-102,-70},{-110,-70}}, color={0,0,0}));
      connect(inp_P_av, block_powerLimiter_imax1.u1)
        annotation (Line(points={{-120,-20},{-73,-20}}, color={0,0,127}));
      connect(exp_P_max.y, block_min.u1) annotation (Line(points={{-85.3,0},{-66,0},
              {-66,-7.6},{-54.8,-7.6}}, color={0,0,127}));
      connect(block_powerLimiter_imax1.y, block_min.u2) annotation (Line(points={{-61.5,
              -23},{-58,-23},{-58,-12},{-56,-12},{-56,-12.4},{-54.8,-12.4}}, color={
              0,0,127}));
      connect(exp_rectifier_eta.y, block_powerLimiter_imax1.u2) annotation (Line(
            points={{-85.3,-40},{-80,-40},{-80,-26},{-73,-26}}, color={0,0,127}));
      connect(block_min.y, comp_heater.inp_P_av) annotation (Line(points={{-45.6,-10},
              {-40,-10},{-40,-25.2},{-33.2,-25.2}}, color={0,0,127}));
      connect(exp_T_stack.y, comp_heater.inp_T_is) annotation (Line(points={{-45.3,-42},
              {-42,-42},{-42,-30},{-33.2,-30}}, color={0,0,127}));
      connect(exp_P_av_stack.y, block_limiter_P.u2) annotation (Line(points={{-35.3,
              20},{-28,20},{-28,20.4},{-23.2,20.4}}, color={0,0,127}));
      connect(block_divisor.y, contr_cell_i.u_s) annotation (Line(points={{54.5,21},
              {60,21},{60,6},{38,6},{38,-7},{47,-7}}, color={0,0,127}));
      connect(exp_P_cell.y, contr_cell_i.u_m)
        annotation (Line(points={{46.8,-22},{53,-22},{53,-13}}, color={0,0,127}));
      connect(contr_stack_temperature.y, block_limiter_P.u1) annotation (Line(
            points={{-51.6,50},{-38.75,50},{-38.75,27.6},{-23.2,27.6}}, color={0,0,127}));
      connect(block_hyst_greater_i_min.y, block_switch_greater_i_min.onOffSignal)
        annotation (Line(points={{4.4,44},{6,44},{6,31.2}}, color={255,0,255}));
      connect(exp_T_cell.y, comp_cell.inp_T) annotation (Line(points={{62.8,-30},{72,
              -30},{72,-1},{77,-1}}, color={0,0,127}));
      connect(exp_T_crit.y, contr_stack_temperature.u_s)
        annotation (Line(points={{-81.3,50},{-60.8,50}}, color={0,0,127}));
      connect(exp_T_stack1.y, block_PT1_stack_temperature.u)
        annotation (Line(points={{-81.3,34},{-74.8,34}}, color={0,0,127}));
      connect(contr_cell_i.y, block_filter_small_values.u) annotation (Line(points=
              {{58.5,-7},{60.25,-7},{60.25,3},{65.4,3}}, color={0,0,127}));
      connect(block_filter_small_values.y, comp_cell.inp_i)
        annotation (Line(points={{72.6,3},{77,3}}, color={0,0,127}));
      connect(block_filter_small_values.onOffSignal, block_switch_greater_i_min.onOffSignal)
        annotation (Line(points={{69,6.6},{69,40},{6,40},{6,31.2}}, color={255,0,
              255}));
      connect(block_switch_greater_i_min.y, block_divisor.u1)
        annotation (Line(points={{13.2,24},{43,24}}, color={0,0,127}));
      connect(block_hyst_greater_i_min.u, inp_P_av_tot)
        annotation (Line(points={{-4.8,44},{-30,44},{-30,100}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-60,18},{-50,-46}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{43,12},{46,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{39,12},{42,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{35,12},{38,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{31,12},{34,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{27,12},{30,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{23,12},{26,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{19,12},{22,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{15,12},{18,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{11,12},{14,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{7,12},{10,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{3,12},{6,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-1,12},{2,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-5,12},{-2,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-9,12},{-6,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-13,12},{-10,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-17,12},{-14,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-21,12},{-18,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-25,12},{-22,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-29,12},{-26,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-33,12},{-30,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-37,12},{-34,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-41,12},{-38,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-45,12},{-42,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-49,12},{-46,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{50,18},{60,-46}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-52,62},{-32,30}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.None,
              textString="H"),
            Text(
              extent={{26,62},{46,30}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.None,
              textString="H"),
            Text(
              extent={{-28,62},{-8,30}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.None,
              textString="O"),
            Text(
              extent={{-36,44},{-24,26}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.None,
              textString="2"),
            Text(
              extent={{42,44},{54,26}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.None,
              textString="2"),
            Polygon(
              points={{2,52},{2,40},{12,46},{2,52}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{47,12},{50,-38}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
                                            Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),                                Diagram(
          coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=10000000,
          __Dymola_NumberOfIntervals=10000,
          __Dymola_Algorithm="Lsodar"));
    end Stack;

    model CheckElectrolyser "check of temperature-controlled electrolyser system"
      extends Modelica.Icons.Example;

      Electrolyser                                  detailedElectrolyser(
      redeclare model CellModel = SimpleModel.Cell,
      param_stack_p_op_cathode=100000,
      param_stack_p_op_anode=100000,
        param_n_comp_h2=7)
        annotation (Placement(transformation(extent={{-16,-16},{16,16}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=10 + 273.15)
                                                                         annotation (Placement(transformation(extent={{-84,-40},
                {-64,-20}})));
      AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(T0=detailedElectrolyser.param_stack_T_init,
                                                                       m_fluid=1000)    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=0,
            origin={0,-70})));
      Modelica.Blocks.Sources.Constant
                                   const(k=100e3)
        annotation (Placement(transformation(extent={{-72,-6},{-52,14}})));
    equation

      connect(detailedElectrolyser.port_outlet_cooling, workingFluid.enthalpyPort_a)
        annotation (Line(points={{10,-14},{10,-40},{40,-40},{40,-70},{9,-70}},
            color={176,0,0}));
      connect(detailedElectrolyser.port_inlet_cooling, workingFluid.enthalpyPort_b)
        annotation (Line(points={{-10,-14},{-10,-40},{-40,-40},{-40,-70},{-9,-70}},
            color={176,0,0}));
      connect(realExpression2.y, detailedElectrolyser.inp_T_air) annotation (Line(
            points={{-63,-30},{-40,-30},{-40,-4},{-17,-4}}, color={0,0,127}));
      connect(const.y, detailedElectrolyser.inp_P_av)
        annotation (Line(points={{-51,4},{-17,4}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=100000,
          __Dymola_NumberOfIntervals=10000,
          __Dymola_Algorithm="Cvode"));
    end CheckElectrolyser;

    model CheckStack
      extends Modelica.Icons.Example;
      Stack                                  stack(
      redeclare model CellModel = SimpleModel.Cell,
      param_stack_p_op_cathode=100000,
      param_stack_p_op_anode=100000)
        annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
      AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(T0=323.15, m_fluid=1000) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-32,-68})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=0.005) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-88,-42})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=500e3,
        duration=1e7,
        startTime=0)   annotation (Placement(transformation(extent={{-88,-12},{-68,
                8}})));
      Pump.Pump pump annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-10,-38})));
    equation

      connect(stack.port_inlet_cooling, pump.port_outlet)
        annotation (Line(points={{-10,-18},{-10,-28}}, color={176,0,0}));
      connect(pump.port_inlet, workingFluid.enthalpyPort_b) annotation (Line(
            points={{-10,-48},{-10,-68},{-23,-68}}, color={176,0,0}));
      connect(workingFluid.enthalpyPort_a, stack.port_outlet_cooling) annotation (
          Line(points={{-41,-68},{-54,-68},{-54,-90},{10,-90},{10,-18}}, color={176,
              0,0}));
      connect(realExpression2.y, pump.inp_Q)
        annotation (Line(points={{-77,-42},{-64,-42},{-64,-38},{-21,-38}},
                                                       color={0,0,127}));
      connect(ramp.y, stack.inp_P_av)
        annotation (Line(points={{-67,-2},{-22,-2}}, color={0,0,127}));
      connect(stack.inp_P_av_tot, stack.inp_P_av)
        annotation (Line(points={{-22,6},{-54,6},{-54,-2},{-22,-2}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=10000000, __Dymola_NumberOfIntervals=10000));
    end CheckStack;
  end Model;

  package SimpleModel
  extends Modelica.Icons.Package;
    model Cell "simple model of electrolysis cell"
      extends PartialModels.PartialCell;

      parameter Units.VolumetricEnergy param_kWh_per_m3 = 4.4 "constant specific energy demand in kWh per normcubicmeter (0 °C, 1,01325 bar)";

      // resulting efficiency
      parameter SI.Efficiency param_eta=param_HHV_h2/param_kWh_per_m3 "resulting constant efficiency of electrolysis";

      // variables: molar fraction of water in hydrogen and oxygen
      SI.MolarFlowRate var_n_h2_port "molar flow rate of produced hydrogen";
      SI.MolarFlowRate var_n_o2_port "molar flow rate of produced hydrogen";

       // heat balance variables
      SI.HeatFlux var_q_cell "total heat flow of one cell";
      SI.HeatFlux var_q_vap "evaporation heat flow of one cell";
      SI.HeatFlux var_q_rea "reaction heat flow of one cell";

      Modelica.Blocks.Tables.CombiTable2D inp_volt_characteristic(
        tableOnFile=true,
        tableName="curr_volt_T_Q100",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/parameter/CurrentVoltageCharacteristicTemperature.txt"),
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
        "current voltage characteristic curve"
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

    protected
      parameter Units.MolePerJoule param_mpj= 1/(param_HHV_h2*3600000)*param_dens_h2/param_M_h2 "mole per joule (HHV) for norm conditions (0 °C, 1,01325 bar)";
    equation

      inp_volt_characteristic.u1 = inp_i/1e4; // expected input is in A/cm2
      inp_volt_characteristic.u2 = inp_T;
      var_U_cell = inp_volt_characteristic.y;

      // simplified constant efficiency approach
      // temperature and pressure dependency is neglected
      // var_n_h2_port = max(port_P_el.P*param_eta_electrolysis/var_delta_Hr,0);
      var_n_h2_port = max(param_eta*port_P_el.P*param_mpj, 0);
      var_n_o2_port = 0.5*var_n_h2_port;

      //heat balance
      var_q_cell = var_q_vap + var_q_rea;
      var_q_rea = (var_U_cell - var_U_therm)*inp_i;
      var_q_vap =-Tools.Functions.WaterEvaporationEnthalpy(inp_T)*(var_n_h2_port/
        param_membrane_area*var_x_h2o_h2 + var_n_o2_port/param_membrane_area*var_x_h2o_o2);

      //cell heat production
      var_Q_prod = param_membrane_area*var_q_cell;

      // calculate molar flow rates in ports
      port_outlet_h2.n_flow = max(var_n_h2_port/(1-var_x_h2o_h2), 0);
      port_outlet_o2.n_flow = max(var_n_o2_port/(1-var_x_h2o_o2), 0);

     annotation (
          Placement(transformation(extent={{-100,-100},{-80,-80}}),
            iconTransformation(extent={{-100,-100},{-60,-60}})),
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Polygon(
              points={{-74,50},{46,70},{46,-30},{-74,-50},{-74,50}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
            Polygon(
              points={{-62,40},{38,58},{38,-22},{-62,-40},{-62,40}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-58,36},{42,54},{42,-26},{-58,-44},{-58,36}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-54,32},{46,50},{46,-30},{-54,-48},{-54,32}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,30},{-40,-72},{80,-50},{80,50},{-40,30}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=100000000000, __Dymola_NumberOfIntervals=1000000));
    end Cell;

    model CheckCell
    extends Modelica.Icons.Example;

      ElectrolysisSystem.SimpleModel.Cell singleCell(param_p_op_cathode=100000, param_p_op_anode=100000)
        annotation (Placement(transformation(extent={{10,-12},{30,8}})));
      Modelica.Blocks.Sources.Ramp inp_current(
        height=2.5e4,
        duration=10e8,
        offset=0) "current input"
        annotation (Placement(transformation(extent={{-60,8},{-40,28}})));
      Modelica.Blocks.Sources.RealExpression inp_temperature(y=80 + 273.15)
        "cel temperature"
        annotation (Placement(transformation(extent={{-58,-42},{-38,-22}})));
    equation

      connect(inp_current.y, singleCell.inp_i)
        annotation (Line(points={{-39,18},{-20,18},{-20,5},{9,5}},
                                                                 color={0,0,127}));
      connect(inp_temperature.y, singleCell.inp_T) annotation (Line(points={{-37,
              -32},{-14,-32},{-14,1},{9,1}}, color={0,0,127}));
        annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=1000000000, __Dymola_NumberOfIntervals=100000));
    end CheckCell;
  end SimpleModel;

  package DetailedModel
  extends Modelica.Icons.Package;
    model Cell "detailed model of electrolysis cell"
      extends PartialModels.PartialCell(table_hydrogen(verboseExtrapolation=false),
          table_oxygen(extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
            verboseExtrapolation=false));

      // membrane parameters
      parameter Units.MembraneHumidity param_lambda=25
        "constant humidity of membrane"    annotation (Dialog(group="membrane parameters"));
      parameter Units.ResistanceArea param_r_ele=0.096/1e4
        "electric resistivity of membrane [Ohm*m²]"    annotation (Dialog(group="membrane parameters"));

      // coefficients for calculation
      parameter Units.CombinedDiffHydrThickFactor param_A_cs=2.4*1e5/1e4
        "constant cathode current collector thickness / (2*F(diffusion coefficient * hydraulic conductivity))"  annotation (Dialog(group="coefficients for calculation"));
      parameter Units.CombinedDiffHydrThickFactor param_A_as=2.8*1e5/1e4
        "constant anode current collector thickness / (2*F(diffusion coefficient * hydraulic conductivity))" annotation (Dialog(group="coefficients for calculation"));
      parameter Units.PermeabilityCoefficient param_perm_coeff_h2=4e-14
        "permeability coefficient of hydrogen (80°C)"  annotation (Dialog(group="coefficients for calculation"));
      parameter Units.PermeabilityCoefficient param_perm_coeff_o2=2e-14
        "permeability coefficient of oxygen (80°C)"  annotation (Dialog(group="coefficients for calculation"));
      parameter SI.MoleFraction param_epsilon_d=0.27
        "coefficient for electroosmotic drag of water through membrane [mol H2O / mol H2]"  annotation (Dialog(group="coefficients for calculation"));

      // variables: pressure at cathode
      SI.Pressure var_p_h2_ca
        "partial pressure of hydrogen at cathode";
      SI.Pressure var_p_h2_cc
        "partial pressure of hydrogen in channel on cathode side";
      SI.Pressure var_p_h2o_cc
        "partial pressure of water vapor in channel on cathode side";

      // variables: pressure at anode
      SI.Pressure var_p_o2_an
        "partial pressure of oxygen at anode";
      SI.Pressure var_p_o2_ac
        "partial pressure of oxygen in channel on anode side";
      SI.Pressure var_p_h2o_ac
        "partial pressure of water vapor in channel on anode side";

      // variables: currents
      SI.CurrentDensity var_i_loss "mass losses";

      // variables: efficiencies
      SI.Efficiency var_eta_cell "cell efficiency";
      SI.Efficiency var_eta_volt "voltage efficiency";
      SI.Efficiency var_eta_curr "current efficiency";

      // variables: molar flows in channels
      Units.MolarFlowRateDensity var_n_h2_ac
        "hydrogen flow in anode channel [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_h2o_ac
        "water flow in anode channel [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_o2_ac
        "oxygen flow in anode channel [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_h2_cc
        "hydrogen flow in cathode channel [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_h2o_cc
        "water flow in cathode channel [mol/(s*m²)]";

      // variables: molar flows produced / consumed
      Units.MolarFlowRateDensity var_n_h2o_cons
        "consumed water flow at anode [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_o2_prod
        "produced oxygen flow at anode [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_h2_prod
        "produced hydrogen flow at cathode [mol/(s*m²)]";

      // variables: molar permeation flows
      Units.MolarFlowRateDensity var_n_h2_per
        "permeation hydrogen flow to anode [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_h2o_per
        "permeation water flow to cathode [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_o2_per
        "permeation oxygen flow to cathode [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_h2o_dis
        "water flow from recombination of permeated oxygen and produced hydrogen at cathode [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_h2o_h2
        "water vapor in saturated hydrogen [mol/(s*m²)]";
      Units.MolarFlowRateDensity var_n_h2o_o2
        "water vapor in saturated oxygen [mol/(s*m²)]";

      // cell voltage variables
      SI.Voltage var_U_nernst "nernst voltage";
      SI.Voltage var_U_act "activation overvoltage";
      SI.Voltage var_U_ohm "ohmic overvoltage";
      SI.Voltage var_U_conc=0 "concentration overvoltage";

      // variable membrane parameter
      SI.Voltage var_alpha
        "combined Durchtrittsfaktor (from curve fitting 80°C) [V]";
      SI.CurrentDensity inp_i_0
        "combined exchange current density (from curve fitting 80°C) [A/m²]";
      Units.ResistanceArea var_r_ion
        "ionic resistivity of membrane [Ohm*m²]";
      SI.Conductivity var_sigma_mem "conductivity of membran";

      // heat balance variables
      SI.HeatFlux var_q_cell "total heat flow of one cell";
      SI.HeatFlux var_q_vap "evaporation heat flow of one cell";
      SI.HeatFlux var_q_rea "reaction heat flow of one cell";

      // temperature dependent input data from table
      Modelica.Blocks.Tables.CombiTable1Ds table_parameter(
        tableOnFile=true,
        tableName="elecData",
        fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/parameter/cell.txt"),
        columns=2:3,
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        verboseExtrapolation=false) "temperature dependent parameter data for cell"
        annotation (Placement(transformation(extent={{-60,18},{-40,38}})));

    protected
      final parameter SI.Pressure param_var_p_h2_ref=101325
        "reference pressure in Nernst equation";
      final parameter SI.Pressure param_var_p_o2_ref=101325
        "reference pressure in Nernst equation";

      Real tmp "tmp variable for permeation split";

    equation

    assert(
        inp_i >= -Const.eps,
        "current density negative: " + String(inp_i),
        AssertionLevel.warning);
    assert(
        inp_i_0 >= -Const.eps,
        "i_0 negative: " + String(inp_i_0),
        AssertionLevel.warning);

      // table for interpolation data
      table_parameter.u = inp_T;
      var_alpha =table_parameter.y[1];
      inp_i_0 =table_parameter.y[2]*1e4;

      var_p_h2o_ac = var_x_h2o_o2*param_p_op_anode;
      var_p_h2o_cc = var_x_h2o_h2*param_p_op_cathode;

      // pressure in channels assuming there is no o2 at cathode and no h2 at anode
      param_p_op_anode = var_p_o2_ac + var_p_h2o_ac;
      param_p_op_cathode = var_p_h2_cc + var_p_h2o_cc;

      // partial pressure of hydrogen/oxygen at cathode / anode
      var_p_h2_ca = max(var_p_h2_cc + inp_i*param_A_cs,0);
      var_p_o2_an = max(var_p_o2_ac + inp_i*param_A_as,0);

      // cell efficiency
      var_eta_volt = var_U_nernst/var_U_cell;
      var_eta_curr = if noEvent(inp_i > var_i_loss) then max((inp_i - var_i_loss)/inp_i,0) else 0;
      var_eta_cell = var_eta_volt*var_eta_curr;

      // voltage losses
      var_U_cell = var_U_nernst + var_U_act + var_U_ohm + var_U_conc;
      var_U_act = if noEvent(inp_i>Const.eps) then max(var_alpha*log(inp_i/inp_i_0),0) else 0;

      if noEvent(var_p_o2_an>Const.eps) then
        var_U_nernst = var_U_rev + Const.R*inp_T/(2*Const.F)*log(sqrt(var_p_o2_an/1e5)*var_p_h2_ca/1e5);
      else
        var_U_nernst = var_U_rev;
      end if;

      // times 100 for conversion 1/(Ohm*cm) -> 1/(Ohm*m)
      var_sigma_mem = (0.005139*param_lambda - 0.00326)*Modelica.Math.exp(1268*(1/303 - 1/(min(max(inp_T,273.15),373.15))))*100;
      var_r_ion = param_membrane_d/var_sigma_mem;
      var_U_ohm = (var_r_ion + param_r_ele)*inp_i;

      // mass losses
      var_i_loss = 2*Const.F*(var_n_h2_per + 2*var_n_o2_per);

      // mass balance
      // anode
      var_n_h2_ac = var_n_h2_per;
      var_n_o2_ac = var_n_o2_prod - var_n_o2_per;
      // liquid water needed for electrolysis
      var_n_h2o_ac = var_n_h2o_cons + var_n_h2o_per + var_n_h2o_h2 + var_n_h2o_o2;
      // cathode
      var_n_h2_prod = var_n_h2_cc + var_n_h2_per + 2*var_n_o2_per;
      //permeated oxygen reacts to h2o, twice the amount of hydrogen needed
      var_n_h2o_cc = var_n_h2o_per + var_n_h2o_dis;
      var_n_h2o_dis = var_n_o2_per;
      // 1 mol oxygen reacts with 2 mol hydrogen to 1 mol water
      // production

      var_n_h2_prod = inp_i/(2*Const.F);
      var_n_o2_prod = 0.5*var_n_h2_prod;
      var_n_h2o_cons = var_n_h2_prod;

      tmp = 0.5;
      var_n_h2_per = min(param_perm_coeff_h2/param_membrane_d*var_p_h2_ca, tmp*var_n_h2_prod);
      var_n_o2_per = min(param_perm_coeff_o2/param_membrane_d*var_p_o2_an, (1-tmp)*var_n_h2_prod);

      // also simplified approach for electroosmotic water drag
      var_n_h2o_per = param_epsilon_d*var_n_h2_prod;

      // var_x_h2o is calculated in partial model
      var_n_h2o_h2 = var_n_h2_cc *var_x_h2o_h2/(1-var_x_h2o_h2);
      var_n_h2o_o2 = var_n_o2_ac * var_x_h2o_o2/(1-var_x_h2o_o2);

      //heat balance
      var_q_cell = var_q_vap + var_q_rea;
      var_q_rea = (var_U_cell - var_U_therm)*inp_i;
      var_q_vap =-Tools.Functions.WaterEvaporationEnthalpy(inp_T)*(var_n_h2o_h2 + var_n_h2o_o2);
                                                                                          //+var_n_h2o_cons);

      //cell heat production
      var_Q_prod = param_membrane_area*var_q_cell;

      // calculate molar flow rates in ports (rest in partial model)
      port_outlet_h2.n_flow = max(var_n_h2_cc/var_X_cc[1]*param_membrane_area, 0);
      port_outlet_o2.n_flow = max(var_n_o2_ac/var_X_ac[1]*param_membrane_area, 0);

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Polygon(
              points={{-74,50},{46,70},{46,-30},{-74,-50},{-74,50}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
            Polygon(
              points={{-62,40},{38,58},{38,-22},{-62,-40},{-62,40}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-58,36},{42,54},{42,-26},{-58,-44},{-58,36}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-54,32},{46,50},{46,-30},{-54,-48},{-54,32}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,30},{-40,-72},{80,-50},{80,50},{-40,30}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=100000000000, __Dymola_NumberOfIntervals=1000000));
    end Cell;

    model CheckCell
    extends Modelica.Icons.Example;

      ElectrolysisSystem.DetailedModel.Cell singleCell(
        param_p_op_cathode=3000000,
        param_p_op_anode=1400000,
        param_membrane_area=600e-4,
        param_membrane_d=150e-6) annotation (Placement(transformation(extent={{10,-12},{30,8}})));
      Modelica.Blocks.Sources.Ramp currentDensity(
        height=3e4,
        duration=10e10,
        offset=0) annotation (Placement(transformation(extent={{-58,12},{-38,32}})));
      Modelica.Blocks.Sources.RealExpression T_cell(y=80 + 273.15)
        annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
    equation

      connect(currentDensity.y, singleCell.inp_i) annotation (Line(points={{-37,22},
              {-16,22},{-16,5},{9,5}}, color={0,0,127}));
      connect(T_cell.y, singleCell.inp_T) annotation (Line(points={{-39,-8},{-16,-8},
              {-16,1},{9,1}},      color={0,0,127}));
        annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=100000000000, __Dymola_NumberOfIntervals=5000));
    end CheckCell;
  end DetailedModel;

  package Rectifier "rectifier model for electrolyser"
   extends Modelica.Icons.Package;

    model Rectifier "rectifier for input power"
      //parameter SI.Power ratedPower = 1e6 "rated power of electrolyser [W]";

      parameter SI.Power param_P_rated=100e3
        "rated power output of rectifier [W]";

      SI.Energy var_P_cons(start=0.0, fixed=true)
        "integrated power consumption";
      Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
        "integrated power consumption in kWh";

      SI.Power var_P_loss "power loss of rectifier [W]";
      SI.Efficiency var_eta "current efficiency of rectifier";
      Tools.Connectors.PowerConnector port_P_el_in "power input connector" annotation (Placement(
            transformation(extent={{-120,-20},{-100,0}}), iconTransformation(extent={{-120,-20},{-80,
                20}})));
      Tools.Connectors.PowerConnector port_P_el_out(P(start=0, fixed=false))
        "power output connector" annotation (Placement(transformation(extent={{80,-20},{100,0}}),
            iconTransformation(extent={{80,-20},{120,20}})));
      Modelica.Blocks.Tables.CombiTable1Ds table_efficiency(
        tableOnFile=true,
        tableName="recEff",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/parameter/rectifierEfficiency.txt"),
        columns=2:2,
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
                     "table wirth rectifier efficiency depending on load"
        annotation (Placement(transformation(extent={{-86,60},{-66,80}})));

    equation

      //interpolation data
      table_efficiency.u = port_P_el_out.P/param_P_rated;
      var_eta=table_efficiency.y[1];

      port_P_el_in.P*var_eta = port_P_el_out.P;
      var_P_loss =port_P_el_in.P - port_P_el_out.P;

      assert(
        port_P_el_out.P >= -Const.eps,
        "power output of rectifier is <0",
        AssertionLevel.warning);
      assert(
        port_P_el_in.P >= -Const.eps,
        "power input of rectifier is <0",
        AssertionLevel.warning);

      der(var_P_cons) = port_P_el_in.P;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-30,30},{30,-30}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.None),
            Line(points={{-26,-28}}, color={0,0,0}),
            Line(points={{-90,0},{-82,0}}, color={0,0,0}),
            Line(points={{30,0},{90,0}}, color={0,0,0}),
            Line(points={{-30,-30},{30,30}},color={0,0,0}),
            Text(
              extent={{-22,38},{0,-14}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
              textString="~"),
            Text(
              extent={{0,12},{24,-40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
              textString="="),
            Line(points={{-90,0},{-30,0}},color={0,0,0}),
                                            Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Rectifier;

    model Check
      extends Modelica.Icons.Example;
      Rectifier rectifier
        annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
      Tools.Boundaries.PowerSource powerBoundary1(P=10e3)
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    equation
      connect(rectifier.port_P_el_out, powerBoundary1.powerConnector)
        annotation (Line(points={{8,0},{40,0}}, color={0,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Check;
  end Rectifier;

  package Pump "FastHVAC pump with power consumption and efficiency"
  extends Modelica.Icons.Package;
    model Pump "FastHVAC pump with power consumption and efficiency"

      replaceable package H2O = Modelica.Media.Water.WaterIF97_R1pT; //R1 is liquid, R2 is vapor
      H2O.ThermodynamicState stateH2O;

      //parameters
      parameter SI.VolumeFlowRate param_Q_min=param_Q_max*0.001
        "minimal volume flow rate of pump at 25°C [m³/s]";
      parameter SI.VolumeFlowRate param_Q_max=5e-3
        "maximal volume flow rate of pump at 25°C [m³/s]";
      parameter SI.Pressure param_p_loss=2e5
        "system pressure loss at maximum volume flow rate [Pa]";
      parameter SI.Efficiency param_eta=0.6
        "cooling pump efficiency at operating condition";

      parameter SI.Distance param_l=100
        "estimated total pipe length [m]";
      parameter SI.Distance param_k=100e-6
        "pipe surface roughness";
      parameter SI.Temperature param_T_init=55+273.15
        "temperature at which param_p_loss was measured";
      parameter SI.Temperature param_T_op=55+273.15
        "assumed constant temperature for property calculation";

      parameter SI.Distance param_d(start=0.05, fixed=false) "hydraulic diameter (be careful with start value)";

      // variables
      SI.Energy var_P_cons(start=0.0, fixed=true)
        "integrated power consumption";
      Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
        "integrated power consumption in kWh";
      SI.Pressure var_dp "current pressure loss";
      SI.KinematicViscosity var_my "kinematic viscosity water";
      SI.Density var_dens "density of water";

      // components
      Modelica.Blocks.Interfaces.RealInput inp_Q "input volume flow" annotation (
          Placement(transformation(extent={{-22,82},{18,122}}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,110})));
      Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-100,-100},
                {-80,-80}}), iconTransformation(extent={{-120,-120},{-80,-80}})));
      AixLib.FastHVAC.Components.Pumps.Pump comp_pump annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,0})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_inlet annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={
                {-110,-10},{-90,10}})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet annotation (Placement(
            transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,
                -10},{110,10}})));
      SI.VolumeFlowRate var_Q=min(max(inp_Q,param_Q_min),param_Q_max);
        // 'variables' to calculate only once
      parameter SI.Velocity param_w_max(fixed=false) "max flow velocity";
      parameter SI.ReynoldsNumber param_Re_max(fixed=false) "max Reynolds number";
      parameter Real param_lambda_max(start=0.02, fixed=false) "maximum friction coefficient";
      parameter Real var_a_init(fixed=false);
      parameter Real var_b_init(fixed=false);
      parameter Real var_c_init(fixed=false);

      SI.Velocity var_w "mean flow velocity";
      Real var_lambda(start=0.002, fixed=false);
      SI.ReynoldsNumber var_Re;

      Real var_a(fixed=false);
      Real var_b(fixed=false);
      Real var_c(fixed=false);

    initial equation

      // solve only once for hydraulic diameter param_d
      param_w_max = param_Q_max/(Const.pi/4*param_d^2);
      param_Re_max = param_w_max*param_d/(H2O.dynamicViscosity(H2O.setState_pT(1+param_p_loss/2, param_T_init))/H2O.density(H2O.setState_pT(1+param_p_loss/2, param_T_init)));

      // meet boundary condition maximum pressure loss for pipe diameter
      param_p_loss = param_lambda_max*param_l/param_d*H2O.density(H2O.setState_pT(1+param_p_loss/2, param_T_init))*param_w_max^2/2;

      // implicit formulation of lambda
      // 1/sqrt(param_lambda_max) = -2*log10(2.51/(param_Re_max*sqrt(param_lambda_max))+param_k/(3.71*param_d));

      // explicit formulation of lambda with Lambert W-function
      var_a_init = 2.51/param_Re_max;
      var_b_init = param_k/(3.71*param_d);
      var_c_init = Modelica.Fluid.Dissipation.Utilities.Functions.General.LambertW(log(10)/(2*var_a_init)*10^(var_b_init/(2*var_a_init)));
      param_lambda_max = 1/(2*var_c_init/log(10)-var_b_init/var_a_init)^2;

    equation

      assert(
        port_P_el.P >= -Const.eps,
        "power input is below zero",
        AssertionLevel.error);

        // kinematic viscosity at atmospheric pressure + 0.5*pressure increase
        stateH2O = H2O.setState_pT(1e5+param_p_loss/2, param_T_op);
        // min value is triple point density
        var_dens = max(H2O.density(stateH2O), 0.0048546);
        var_my= H2O.dynamicViscosity(stateH2O)/var_dens;

        // calculation of velocity and reynolds number
        var_w = var_Q/(Const.pi/4*param_d^2);
        var_Re = var_w*param_d/var_my;

        if noEvent(var_Re>1000) then
          // explicit formulation of lambda with Lambert W-function
          var_a = 2.51/var_Re;
          var_b = param_k/(3.71*param_d);
          // term for lambert w function
          var_c = Modelica.Fluid.Dissipation.Utilities.Functions.General.LambertW(log(10)/(2*var_a)*10^(var_b/(2*var_a)));
          var_lambda = 1/(2*var_c/log(10)-var_b/var_a)^2;
        else
          var_a=0;
          var_b=0;
          var_c=0;
          var_lambda=0.1;
        end if;

        // pressure loss at current operating point
        var_dp = var_lambda*param_l/param_d*var_dens*var_w^2/2;

        // power consumption via pressure loss
        port_P_el.P = var_Q*var_dp/param_eta;
        der(var_P_cons) = port_P_el.P;

        // input for pump component
        comp_pump.dotm_setValue = var_Q*var_dens;
      connect(comp_pump.enthalpyPort_b, port_outlet) annotation (Line(points={{6.66134e-16,
              9.6},{6.66134e-16,30},{100,30},{100,0}}, color={176,0,0}));
      connect(port_inlet, comp_pump.enthalpyPort_a) annotation (Line(points={{-100,0},
              {-100,-28},{-6.66134e-16,-28},{-6.66134e-16,-9.6}}, color={176,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Line(points={{-20,98},{100,0},{-20,-98}},
                color={0,0,0})}),                                    Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Pump;

    model Check
    extends Modelica.Icons.Example;
      Pump pump
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(T0=323.15, m_fluid=10)
        annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
      Modelica.Blocks.Sources.Ramp           ramp1(height=pump.param_Q_max, duration=10e10)
        annotation (Placement(transformation(extent={{-28,72},{-8,92}})));
    equation
      connect(pump.port_outlet, workingFluid.enthalpyPort_b) annotation (Line(
            points={{10,0},{32,0},{32,-80},{9,-80}}, color={176,0,0}));
      connect(workingFluid.enthalpyPort_a, pump.port_inlet) annotation (Line(points=
             {{-9,-80},{-40,-80},{-40,0},{-10,0}}, color={176,0,0}));
      connect(ramp1.y, pump.inp_Q)
        annotation (Line(points={{-7,82},{-7,47},{0,47},{0,11}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=100000000000, __Dymola_NumberOfIntervals=10000));
    end Check;
  end Pump;

  package Heater "electrical heater unit for stack"
  extends Modelica.Icons.Package;
    model Heater

      parameter SI.Power param_P_el_max = 10e3 "maximum power consumption" annotation (Dialog(group="heater parameters"));
      parameter SI.Efficiency param_eta = 0.99 "electrical efficiency of heater" annotation (Dialog(group="heater parameters"));

      parameter SI.Temperature param_T_op = 65+273.15 "temperature up to which heater is active" annotation (Dialog(group="stack parameters"));
      parameter SI.Temperature param_T_op_min = 60+273.15 "temperature at which heating is started again" annotation (Dialog(group="stack parameters"));

      SI.Energy var_P_cons(start=0.0, fixed=true)
        "integrated power consumption";
      Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
        "integrated power consumption in kWh";

      // connector
      Tools.Connectors.PowerConnector port_P_el "actual power consumption" annotation (Placement(
            transformation(extent={{-100,-100},{-80,-80}}), iconTransformation(extent={{-140,-100},{
                -100,-60}})));

      // in- and output
      Modelica.Blocks.Interfaces.RealInput inp_T_is "current temperature"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
            iconTransformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealInput inp_P_av "power avaiable"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
            iconTransformation(extent={{-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealOutput out_P_heat annotation (Placement(
            transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={
                {100,-10},{120,10}})));
      Modelica.Blocks.Math.Min block_min
        annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
      Modelica.Blocks.Math.Gain block_gain(k=param_eta)
        annotation (Placement(transformation(extent={{82,-6},{94,6}})));
      Modelica.Blocks.Sources.RealExpression exp_P_av(y=max(inp_P_av, 0))
        annotation (Placement(transformation(extent={{-38,-16},{-18,4}})));
      Modelica.Blocks.Logical.Hysteresis block_hysteresis(uLow=param_T_op_min,
          uHigh=param_T_op)
        annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
      Tools.Components.Switch block_switch
        annotation (Placement(transformation(extent={{22,10},{42,-10}})));
      Modelica.Blocks.Logical.Not block_inv
        annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
      Modelica.Blocks.Sources.RealExpression exp_P_max(y=param_P_el_max)
        annotation (Placement(transformation(extent={{-38,-4},{-18,16}})));
      Modelica.Blocks.Continuous.FirstOrder block_firstOrder(T=6,
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0)
        annotation (Placement(transformation(extent={{54,-10},{74,10}})));
    equation

      // power consumption
      port_P_el.P = max(block_firstOrder.y,0);
      der(var_P_cons) = port_P_el.P;

      connect(exp_P_av.y, block_min.u2)
        annotation (Line(points={{-17,-6},{-8,-6}},
                                                  color={0,0,127}));
      connect(block_hysteresis.y, block_inv.u)
        annotation (Line(points={{-59,-40},{-52,-40}}, color={255,0,255}));
      connect(block_min.y, block_switch.u)
        annotation (Line(points={{15,0},{20,0}}, color={0,0,127}));
      connect(block_gain.y, out_P_heat)
        annotation (Line(points={{94.6,0},{110,0}}, color={0,0,127}));
      connect(block_min.u1, exp_P_max.y)
        annotation (Line(points={{-8,6},{-17,6}}, color={0,0,127}));
      connect(block_inv.y, block_switch.onOffSignal)
        annotation (Line(points={{-29,-40},{32,-40},{32,-12}}, color={255,0,255}));
      connect(inp_T_is, block_hysteresis.u) annotation (Line(points={{-120,0},{-90,0},
              {-90,-40},{-82,-40}}, color={0,0,127}));
      connect(block_firstOrder.y, block_gain.u)
        annotation (Line(points={{75,0},{80.8,0}}, color={0,0,127}));
      connect(block_firstOrder.u, block_switch.y)
        annotation (Line(points={{52,0},{44,0}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-26,90},{30,-66}},
              lineColor={0,0,0},
              textString="q"),
            Text(
              extent={{-28,166},{28,10}},
              lineColor={0,0,0},
              textString="."),              Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Heater;

    model Check
      extends Modelica.Icons.Example;

        // components

        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor comp_heatCapacity(C=1250000,
            T(fixed=true, start=30 + 273.15))
          "heat capacity of electrolyser and water inside electrolyser"    annotation (Placement(transformation(extent={{-10,-10},
                  {10,10}},
              rotation=0,
              origin={58,-2})));
        Heater heater(
          param_P_el_max=30000,
          param_eta=0.99)
          annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=comp_heatCapacity.T)
          annotation (Placement(transformation(extent={{-80,14},{-60,34}})));
        Modelica.Blocks.Sources.RealExpression exp_const_cool(y=-250)
          annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=250e3,
          duration=1e8,
          offset=0)
          annotation (Placement(transformation(extent={{-110,-8},{-90,12}})));
    protected
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_wasteHeat(alpha=0)
          "waste heat" annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={10,0})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_cooling(alpha=0)
          "waste heat" annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={10,-40})));
    equation

        connect(heatflow_wasteHeat.port, comp_heatCapacity.port) annotation (Line(
              points={{20,-1.33227e-15},{32,-1.33227e-15},{32,-22},{58,-22},{58,-12}},
              color={191,0,0}));
        connect(realExpression.y, heater.inp_T_is) annotation (Line(points={{-59,24},
                {-52,24},{-52,0},{-42,0}}, color={0,0,127}));
        connect(heater.out_P_heat, heatflow_wasteHeat.Q_flow) annotation (Line(
              points={{-19,0},{-12,0},{-12,1.11022e-15},{0,1.11022e-15}}, color={0,
                0,127}));
        connect(heatflow_cooling.port, comp_heatCapacity.port)
          annotation (Line(points={{20,-40},{58,-40},{58,-12}}, color={191,0,0}));
        connect(exp_const_cool.y, heatflow_cooling.Q_flow)
          annotation (Line(points={{-19,-40},{0,-40}}, color={0,0,127}));
        connect(ramp.y, heater.inp_P_av) annotation (Line(points={{-89,2},{-66,2},{
                -66,8},{-42,8}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=100000000, __Dymola_NumberOfIntervals=10000));
    end Check;
  end Heater;

  package Cooler "simple fan cooler"
  extends Modelica.Icons.Package;
    model AirCooler
      "cools fluid down to given setpoint temperature, new alpha model, with Power Connector"

     // medium to use
      parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple water=
          AixLib.FastHVAC.Media.WaterSimple() "water inside heat exchanger";

      //parameters
      parameter SI.Temperature param_T_Set=298.15
        "setpoint temperature to which fluid is cooled"
        annotation (Dialog(group="operating parameters"));
      parameter SI.Temperature param_T_init=298.15
        "initial temperature of fluid inside heat exchanger"
        annotation (Dialog(group="operating parameters"));

      // for example: https://www.thermokey.de/uploads/media/Power_line_Power_J.pdf
      // WR1180.B (delta circuit)
      parameter SI.Power param_P_el=310
        "power consumption at design point (ENV 1048)"
        annotation (Dialog(group="design parameters"));
      parameter SI.Power param_P_cool=33.7e3
        "cooling power at design point (ENV 1048)"
        annotation (Dialog(group="design parameters"));
      parameter SI.VolumeFlowRate param_airflowrate=9000/3600
        "air flow rate at design point (ENV 1048)"
        annotation (Dialog(group="design parameters"));
      parameter SI.Distance param_d_radiator=0.8
        "diameter of radiator" annotation (Dialog(group="design parameters"));
      parameter Integer param_n_radiator=1 "number of radiators" annotation(Dialog(group="design parameters"));
      parameter SI.Area param_surfaceArea=113
        "surface area for heat transfer"
        annotation (Dialog(group="design parameters"));
      parameter SI.Volume param_V=0.022
        "inner volume of heat exchanger"
        annotation (Dialog(group="design parameters"));
      parameter SI.CoefficientOfHeatTransfer param_alpha_ambient=2.5
        "heat transfer coefficient to ambient without radiator"
        annotation (Dialog(group="design parameters"));

      // variables
      SI.Energy var_P_therm_rem(start=0.0, fixed=true) "intergrated removed heat";
      Real var_P_therm_rem_kWh = SI.Conversions.to_kWh(var_P_therm_rem) "intergrated removed heat in kWh";
      SI.Energy var_P_cons(start=0.0, fixed=true)
        "integrated power consumption";
      Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
        "integrated power consumption in kWh";
      SI.CoefficientOfHeatTransfer var_alpha_eff(start=
            param_alpha_ambient);
      Real var_delta_T(start=10, fixed=false) "mean temperature difference";

      // components
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_inlet(T(start=303.15, fixed=false))
        annotation (Placement(transformation(extent={{-100,-110},{-80,-90}}),
            iconTransformation(extent={{-100,-110},{-80,-90}})));
      Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-10,-114},
                {10,-94}}), iconTransformation(extent={{80,80},{120,120}})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet(T(start=param_T_init,
            fixed=false))
        annotation (Placement(transformation(extent={{80,-110},{100,-90}}),
            iconTransformation(extent={{80,-110},{100,-90}})));
      Modelica.Blocks.Interfaces.RealInput inp_T_Amb(unit="K")
        "ambient temperature"
        annotation (Placement(transformation(extent={{-140,50},{-100,90}}),
            iconTransformation(extent={{-120,70},{-100,90}})));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      AixLib.FastHVAC.BaseClasses.WorkingFluid comp_workingFluid(
        medium=water,
        m_fluid=param_V*water.rho,
        T0=param_T_init)
        annotation (Placement(transformation(extent={{-12,-62},{12,-38}})));
      Tools.Components.ThreeWayConnector threeWayConnector
        annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor meas_T_out
        annotation (Placement(transformation(extent={{72,-56},{84,-44}})));
      AixLib.Controls.Continuous.LimPID contr_valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.001,
        Ti=0.25,
        Td=0.25,
        yMax=1,
        reverseAction=true,
        reset=AixLib.Types.Reset.Parameter,
        y_reset=0) annotation (Placement(transformation(extent={{60,-6},{48,6}})));
      Modelica.Blocks.Sources.RealExpression exp_set_T_valve(y=param_T_Set)
        annotation (Placement(transformation(extent={{92,-10},{72,10}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_Q_res(T_ref=
            273.15)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,-24})));

      AixLib.Controls.Continuous.LimPID contr_air_speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=10,
        Ti=1,
        Td=0.25,
        yMax=1,
        reverseAction=true,
        reset=AixLib.Types.Reset.Parameter,
        y_reset=0)
        annotation (Placement(transformation(extent={{38,36},{26,48}})));
      Modelica.Blocks.Sources.RealExpression exp_set_T_airspeed(y=param_T_Set)
        annotation (Placement(transformation(extent={{86,32},{66,52}})));
      Modelica.Blocks.Sources.RealExpression exp_meas_T_modified(y=if
            greaterEqualThreshold.y then meas_T_out.T else 0)
        "modifies measured temperature so that valve opens first, then ventilator"
        annotation (Placement(transformation(extent={{68,12},{48,32}})));
      Modelica.Blocks.Interfaces.BooleanInput inp_offSwitch
        "if true the cooler turns on"      annotation (Placement(transformation(
              extent={{-140,0},{-100,40}}), iconTransformation(extent={{-120,10},{
                -100,30}})));
      Tools.Components.Switch switch annotation (Placement(transformation(
            extent={{-6,6},{6,-6}},
            rotation=270,
            origin={-50,-16})));
      Modelica.Blocks.Math.Gain block_gain(k=param_air_speed)
        "multiply by max airspeed"
        annotation (Placement(transformation(extent={{10,36},{-2,48}})));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
           0.99, y(start=false, fixed=false))
              annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=90,
            origin={20,14})));
      Modelica.Blocks.Sources.RealExpression exp_meas_T_modified1(y=if
            inp_offSwitch then meas_T_out.T else 0)
        "modifies measured temperature so that valve opens first, then ventilator"
        annotation (Placement(transformation(extent={{98,-26},{78,-6}})));
    protected
      parameter SI.Velocity param_air_speed=param_airflowrate/
          param_n_radiator/(param_d_radiator^2/4*Const.pi)
        "velocity of air at design point";
      parameter SI.CoefficientOfHeatTransfer param_alpha_design=
          param_P_cool/param_surfaceArea/12.3316 "12.3316 is mean temperature difference ENV 1048";
      parameter Real param_corrector=param_alpha_design/(7.14*param_air_speed^(0.78))  "corrector for alpha";

    //  SI.Temperature var_T_mod "modified temperature for air speed controller";

    equation

      // simplified equation by Kuchling: Taschenbuch der Physik
      var_alpha_eff =max(7.14*block_gain.y^(0.78)/param_corrector, param_alpha_ambient);

      // only use cooler if outside is cool enough
      var_delta_T =max(comp_workingFluid.heatCapacitor.T - inp_T_Amb, 0);

      heatflow_Q_res.Q_flow = -var_alpha_eff*param_surfaceArea*var_delta_T;
      der(var_P_therm_rem) =port_inlet.m_flow*port_inlet.c*(port_inlet.T-port_outlet.T);

      // law of correlation P ~ (Q/Qref)^3
      port_P_el.P = param_P_el*((block_gain.y)/param_air_speed)^3;

      // integrator
      der(var_P_cons) = port_P_el.P;

      connect(threeWayValve.enthalpyPort_a, comp_workingFluid.enthalpyPort_a)
        annotation (Line(points={{-40,-50},{-10.8,-50}}, color={176,0,0}));
      connect(comp_workingFluid.enthalpyPort_b, threeWayConnector.inlet1)
        annotation (Line(points={{10.8,-50},{40,-50}}, color={176,0,0}));
      connect(threeWayValve.enthalpyPort_b, threeWayConnector.inlet2) annotation (
          Line(points={{-50,-60},{-50,-74},{50,-74},{50,-60}}, color={176,0,0}));
      connect(threeWayConnector.outlet, meas_T_out.enthalpyPort_a) annotation (Line(
            points={{59.8,-50},{66,-50},{66,-50.06},{72.72,-50.06}}, color={176,0,0}));
      connect(meas_T_out.enthalpyPort_b, port_outlet) annotation (Line(points={{83.4,
              -50.06},{90,-50.06},{90,-100}}, color={176,0,0}));
      connect(threeWayValve.enthalpyPort_ab, port_inlet) annotation (Line(points={{-59.8,
              -50},{-90,-50},{-90,-100}}, color={176,0,0}));
      connect(exp_set_T_valve.y, contr_valve.u_s)
        annotation (Line(points={{71,0},{61.2,0}}, color={0,0,127}));
      connect(comp_workingFluid.heatPort, heatflow_Q_res.port)
        annotation (Line(points={{0,-38.72},{0,-34}}, color={191,0,0}));
      connect(exp_set_T_airspeed.y, contr_air_speed.u_s)
        annotation (Line(points={{65,42},{39.2,42}}, color={0,0,127}));
      connect(threeWayValve.opening, switch.y)
        annotation (Line(points={{-50,-41},{-50,-23.2}}, color={0,0,127}));
      connect(switch.u, contr_valve.y)
        annotation (Line(points={{-50,-8.8},{-50,0},{47.4,0}}, color={0,0,127}));
      connect(inp_offSwitch, switch.onOffSignal) annotation (Line(points={{-120,20},
              {-78,20},{-78,-16},{-57.2,-16}}, color={255,0,255}));
      connect(contr_valve.trigger, switch.onOffSignal) annotation (Line(points={{58.8,
              -7.2},{58.8,-28},{-78,-28},{-78,-16},{-57.2,-16}}, color={255,0,255}));
      connect(greaterEqualThreshold.u, contr_valve.y)
        annotation (Line(points={{20,6.8},{20,0},{47.4,0}},
                                                          color={0,0,127}));
      connect(exp_meas_T_modified1.y, contr_valve.u_m)
        annotation (Line(points={{77,-16},{54,-16},{54,-7.2}}, color={0,0,127}));
      connect(exp_meas_T_modified.y, contr_air_speed.u_m)
        annotation (Line(points={{47,22},{32,22},{32,34.8}}, color={0,0,127}));
      connect(contr_air_speed.trigger, greaterEqualThreshold.y) annotation (Line(
            points={{36.8,34.8},{36.8,26},{20,26},{20,20.6}}, color={255,0,255}));
      connect(contr_air_speed.y, block_gain.u)
        annotation (Line(points={{25.4,42},{11.2,42}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Line(points={{-90,0},{-86,0},{-86,80},{80,80},{80,70},{-80,70},{-80,60},
                  {80,60},{80,50},{-80,50},{-80,40},{80,40},{80,30},{-80,30},{-80,20},
                  {80,20},{80,10},{-80,10},{-80,0},{80,0},{80,-10},{-80,-10},{-80,-20},
                  {80,-20},{80,-30},{-80,-30},{-80,-40},{80,-40},{80,-50},{-80,-50},
                  {-80,-60},{80,-60},{80,-70},{-80,-70},{-80,-80},{86,-80},{86,0},{92,
                  0}}, color={0,0,0}),
            Ellipse(
              extent={{-80,80},{80,-80}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-78,78},{78,-78}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-8,6},{-18,22},{-28,44},{-30,64},{-24,74},{-2,78},{4,44},{2,20},
                  {2,20},{0,10},{-8,6}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{5,-37},{-5,-21},{-15,1},{-17,21},{-11,31},{11,35},{17,1},{15,
                  -23},{15,-23},{13,-33},{5,-37}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              origin={-43,-13},
              rotation=90),
            Polygon(
              points={{5,-37},{-5,-21},{-15,1},{-17,21},{-11,31},{11,35},{17,1},{15,
                  -23},{15,-23},{13,-33},{5,-37}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              origin={13,-43},
              rotation=180),
            Polygon(
              points={{5,-37},{-5,-21},{-15,1},{-17,21},{-11,31},{11,35},{17,1},{15,
                  -23},{15,-23},{13,-33},{5,-37}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid,
              origin={43,13},
              rotation=270),
            Ellipse(
              extent={{-10,10},{10,-10}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid)}),                      Diagram(
            coordinateSystem(preserveAspectRatio=false), graphics={Text(
              extent={{-56,88},{96,66}},
              lineColor={28,108,200},
              horizontalAlignment=TextAlignment.Left,
              textString="cools fluid down to setpoint temperature
1.partially redirecting flow through cooler, cooling to ambient
2. turn on radiator if that isn't enough

")}));
    end AirCooler;

    model Check "electrolyser system with all components"
    extends Modelica.Icons.Example;

      // components

      AirCooler airCoolerNewNew(param_T_Set=318.15, param_T_init=328.15)
        annotation (Placement(transformation(extent={{18,-6},{38,14}})));
      Modelica.Blocks.Sources.RealExpression T_amb(y=15 + 273.15)
        annotation (Placement(transformation(extent={{-22,2},{-2,22}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=5)
        annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
      Modelica.Blocks.Sources.Ramp           ramp(
        height=40,
        duration=10e6,
        offset=40 + 273.15,
        startTime=0)
        annotation (Placement(transformation(extent={{-74,-78},{-54,-58}})));
      AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource
        annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));
      AixLib.FastHVAC.Components.Sinks.Vessel vessel
        annotation (Placement(transformation(extent={{54,-46},{74,-26}})));
      Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=10e3)
        annotation (Placement(transformation(extent={{-36,-20},{-16,0}})));
    equation

      connect(T_amb.y, airCoolerNewNew.inp_T_Amb)
        annotation (Line(points={{-1,12},{17,12}}, color={0,0,127}));
      connect(airCoolerNewNew.port_outlet, vessel.enthalpyPort_a) annotation (Line(
            points={{37,-6},{37,-21},{57,-21},{57,-36}}, color={176,0,0}));
      connect(airCoolerNewNew.port_inlet, fluidSource.enthalpyPort_b) annotation (
          Line(points={{19,-6},{10,-6},{10,-51},{0,-51}}, color={176,0,0}));
      connect(realExpression.y, fluidSource.dotm) annotation (Line(points={{-57,-30},
              {-36,-30},{-36,-47.4},{-18,-47.4}}, color={0,0,127}));
      connect(ramp.y, fluidSource.T_fluid) annotation (Line(points={{-53,-68},{-36,
              -68},{-36,-54.2},{-18,-54.2}}, color={0,0,127}));
      connect(booleanStep.y, airCoolerNewNew.inp_offSwitch) annotation (Line(points=
             {{-15,-10},{0,-10},{0,6},{17,6}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
                  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=10000000, __Dymola_NumberOfIntervals=10000));
    end Check;
  end Cooler;

  package GasDryer "gas dryer model for electrolyser"
   extends Modelica.Icons.Package;

    model GasDryer "model of continuous gas dryer with MSL Media"

      // media model
      package H2O = Modelica.Media.Water.WaterIF97_R1pT;
      package Gas = Media.Gases.H2andWaterVapor;
      Gas.ThermodynamicState state_cold;
      Gas.ThermodynamicState state_hot;
      H2O.ThermodynamicState state_h2o;
      SI.SpecificHeatCapacity var_cp;

      // parameters
      parameter SI.Temperature param_T_ac=40 + 273.15
        "temperature after cooling against ambient";
      parameter Real param_ppm_h2o=5 "ppm of water vapor in hydrogen after dryer";
      parameter SI.Efficiency param_eta_h=0.98
        "efficiency of electrical heating units";
      parameter Boolean param_use_water_outlet=true "if true then there is a enthalpy port out for the condensed water";
      parameter SI.MolarEnthalpy param_adsorp_enth=48.6e3
        "constant adsorption enthalpy";
      parameter Units.Fraction param_feedbackFlow=0.2
        "fraction of gas mass flow in feedback loop";

      // variables
      SI.Energy var_P_cons(start=0.0, fixed=true)
        "integrated power consumption";
      Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
        "integrated power consumption in kWh";
      SI.HeatFlowRate var_Q_heat "power demand for heater";
      SI.HeatFlowRate var_Q_des "heating power demand for desorption";
      SI.Mass var_total_water_removed(start=0.0, fixed=true) "total mass of adsorbed water";
      SI.Temperature var_T_heater(start=param_T_ac, fixed=false) "gas temperature after heater in feedback loop";

      // actual in and output flow rates of gas dryer
      SI.MolarFlowRate var_n_gas_in;
      SI.MolarFlowRate var_n_h2o_in;
      SI.MolarFlowRate var_n_gas_out;
      SI.MolarFlowRate var_n_h2o_out;

      // temporary molar flow rates
      SI.MolarFlowRate var_n_condenser_in(start=0.0, fixed=false);
      SI.MolarFlowRate var_n_gas_condenser_in;
      SI.MolarFlowRate var_n_h2o_condenser_in;
      SI.MolarFlowRate var_n_condenser_out;
      SI.MolarFlowRate var_n_gas_condenser_out;
      SI.MolarFlowRate var_n_h2o_condenser_out;

      SI.MolarFlowRate var_n_drybed_in;
      SI.MolarFlowRate var_n_gas_drybed_in;
      SI.MolarFlowRate var_n_h2o_drybed_in;
      SI.MolarFlowRate var_n_drybed_out;
      SI.MolarFlowRate var_n_gas_drybed_out;
      SI.MolarFlowRate var_n_h2o_drybed_out;

      SI.MolarFlowRate var_n_feedback_in;
      SI.MolarFlowRate var_n_gas_feedback_in(start=0.0, fixed=false);
      SI.MolarFlowRate var_n_h2o_feedback_in;
      SI.MolarFlowRate var_n_feedback_out;
      SI.MolarFlowRate var_n_gas_feedback_out;
      SI.MolarFlowRate var_n_h2o_feedback_out(start=0.0, fixed=false);

      // temporary molar fractions
      SI.MoleFraction var_x_h2o_condenser_in;
      // SI.MoleFraction var_x_gas_condenser_in;
      SI.MoleFraction var_x_h2o_condenser_out;
      SI.MoleFraction var_x_gas_condenser_out;
      SI.MoleFraction var_x_h2o_drybed_in;
      SI.MoleFraction var_x_h2o_drybed_out;
      SI.MoleFraction var_x_gas_drybed_out;

      /*
  Real var_x_h2o_condenser_in;
  Real var_x_gas_condenser_in; 
  Real var_x_h2o_condenser_out;

  Real var_x_h2o_drybed_in;
  Real var_x_h2o_drybed_out;
  Real var_x_gas_drybed_out;
  */

      // absorbed water
      SI.MolarFlowRate var_delta_h2o;

      // connectors and components
      Tools.Connectors.GasConnector port_inlet_gas(redeclare package Gas = Gas) annotation (
          Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-120,-20},
                {-80,20}})));
      Tools.Connectors.GasConnector port_outlet_gas(redeclare package Gas = Gas) annotation (
          Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{80,-20},
                {120,20}})));
      Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-100,-100},
                {-80,-80}}), iconTransformation(extent={{-20,-120},{20,-80}})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet_water if param_use_water_outlet  annotation (Placement(transformation(extent={{80,-100},{100,-80}}),
            iconTransformation(extent={{80,-100},{100,-80}})));
      AixLib.FastHVAC.Components.Sinks.Vessel comp_waterSink if not param_use_water_outlet;

      Modelica.Blocks.Tables.CombiTable2D table_humidity_condenser(
        tableOnFile=true,
        tableName="humidity",
        fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/H2_humidity.txt"),
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        verboseExtrapolation=true)
        "calculation of hydrogen water content after condenser"
        annotation (Placement(transformation(extent={{-50,30},{-30,50}})));

      Modelica.Blocks.Tables.CombiTable2D table_temperature_heater(
        u2(start=param_T_ac),
        tableOnFile=true,
        tableName="humidity",
        fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/H2_humidity_backward.txt"),
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        verboseExtrapolation=true) "table to determine temperature after heater"
        annotation (Placement(transformation(extent={{-50,0},{-30,20}})));

    protected
      parameter SI.MoleFraction param_x_h2o_dry=param_ppm_h2o*1e-6;
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_tmpOut "temporary port";
      SI.Pressure var_p=port_inlet_gas.p "pressure inside dryer";

    equation

      assert(var_p<=60e5, "reverse data for water content of hydrogen was only calculated up to 60 bar", AssertionLevel.error);

      // table
      table_humidity_condenser.u1 = SI.Conversions.to_bar(var_p);
      table_humidity_condenser.u2 = param_T_ac;

      // input
      var_n_gas_in =max(port_inlet_gas.X[1]*port_inlet_gas.n_flow,0);
      var_n_h2o_in =max(port_inlet_gas.X[2]*port_inlet_gas.n_flow,0);

      // condenser (always cooling to 40°C)
      var_n_gas_condenser_in = max(var_n_gas_in + var_n_gas_feedback_out,0);
      var_n_h2o_condenser_in = max(var_n_h2o_in + var_n_h2o_feedback_out,0);
      var_n_condenser_in = var_n_gas_condenser_in+var_n_h2o_condenser_in;

      var_x_h2o_condenser_in = if noEvent(var_n_condenser_in>Const.eps)
        then var_n_h2o_condenser_in/var_n_condenser_in else 0;

      var_x_h2o_condenser_out =min(table_humidity_condenser.y,
        var_x_h2o_condenser_in);
      var_x_gas_condenser_out = 1-var_x_h2o_condenser_out;

      assert(var_x_gas_condenser_out>0.1, "mole fraction of gas is zero, table_humidity_condenser.y: "
       + String(table_humidity_condenser.y), AssertionLevel.error);

      var_n_gas_condenser_out = var_n_gas_condenser_in;
      var_n_condenser_out = if noEvent(var_x_gas_condenser_out>0) then
        var_n_gas_condenser_out/var_x_gas_condenser_out else 0;
      var_n_h2o_condenser_out = var_n_condenser_out*var_x_h2o_condenser_out;

      // dry bed absorber
      var_n_gas_drybed_in = var_n_gas_condenser_out;
      var_n_h2o_drybed_in = var_n_h2o_condenser_out;
      var_n_drybed_in = var_n_gas_drybed_in+var_n_h2o_drybed_in;
      var_x_h2o_drybed_in = var_x_h2o_condenser_out;

      var_n_gas_drybed_out = var_n_gas_drybed_in;
      var_n_h2o_drybed_out = var_n_drybed_out*var_x_h2o_drybed_out;
      var_n_drybed_out = var_n_gas_drybed_out/var_x_gas_drybed_out;
      var_x_h2o_drybed_out = max(min(param_x_h2o_dry, var_x_h2o_drybed_in),0);
      var_x_gas_drybed_out = 1-var_x_h2o_drybed_out;

      // absorbed water
      var_delta_h2o =  var_n_drybed_in - var_n_drybed_out;
      var_n_gas_out = var_n_gas_drybed_out * (1-param_feedbackFlow);

      // actual output of gas dryer
      var_n_h2o_out = var_n_h2o_drybed_out * (1-param_feedbackFlow);

      // feedback loop with heater and desorption
      var_n_gas_feedback_in = var_n_gas_drybed_out * param_feedbackFlow;
      var_n_h2o_feedback_in = var_n_h2o_drybed_out * param_feedbackFlow;
      var_n_feedback_in = var_n_gas_feedback_in+var_n_h2o_feedback_in;

      // determine temperature of hydrogen so that saturation pressure is high enough to
      // desorp water from dry bed
      table_temperature_heater.u1 = SI.Conversions.to_bar(var_p);

      if noEvent(var_delta_h2o>0) then
        // input is mole fraction of water vapor
        table_temperature_heater.u2 = max((var_delta_h2o+var_n_h2o_feedback_in)/(var_n_feedback_in+var_delta_h2o),0);
      else
        table_temperature_heater.u2 = 0;
      end if;
      var_T_heater = max(table_temperature_heater.y, param_T_ac);

      // power consumption of heating of gas and desorptin
      state_cold = Gas.setState_pTX(var_p, param_T_ac, {var_x_gas_drybed_out, var_x_h2o_drybed_out});
      state_hot = Gas.setState_pTX(var_p, var_T_heater, {var_x_gas_drybed_out, var_x_h2o_drybed_out});
      var_cp = (Gas.specificHeatCapacityCp(state_cold)+Gas.specificHeatCapacityCp(state_hot))/2;
      var_Q_heat = max(var_cp*Gas.molarMass(state_cold)*var_n_feedback_in*(var_T_heater-param_T_ac),0);
      var_Q_des = param_adsorp_enth * var_delta_h2o;

      // states after desorption
      var_n_feedback_out = var_n_gas_feedback_out+var_n_h2o_feedback_out;
      var_n_gas_feedback_out = var_n_gas_feedback_in;
      var_n_h2o_feedback_out = var_n_h2o_feedback_in+var_delta_h2o;

      // outlet port
      port_outlet_gas.n_flow = var_n_gas_out+var_n_h2o_out;
      port_outlet_gas.p = var_p;
      port_outlet_gas.X = {var_x_gas_drybed_out, var_x_h2o_drybed_out};
      port_outlet_gas.h = Gas.specificEnthalpy(Gas.setState_pTX(
        var_p, param_T_ac, port_outlet_gas.X));

      // total water removed from gas stream
      der(var_total_water_removed) = port_tmpOut.m_flow;

      // power consumption for heating
      port_P_el.P = max((var_Q_des + var_Q_heat)/param_eta_h,0);
      der(var_P_cons) = port_P_el.P;

      // water outlet
      state_h2o = H2O.setState_pT(var_p, param_T_ac);
      port_tmpOut.m_flow= var_delta_h2o * H2O.molarMass(state_h2o);
      port_tmpOut.T = param_T_ac;
      port_tmpOut.c = H2O.specificHeatCapacityCp(state_h2o);
      port_tmpOut.h = H2O.specificEnthalpy(state_h2o);

      if param_use_water_outlet then
        connect(port_outlet_water, port_tmpOut);
      else
        connect(comp_waterSink.enthalpyPort_a, port_tmpOut);
      end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-70,30},{-10,-30}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.None),
            Rectangle(
              extent={{16,30},{50,-40}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.None),
            Line(points={{-26,-28}}, color={0,0,0}),
            Line(points={{-52,-46},{-52,10},{-40,-10},{-28,10},{-28,-46}}, color={0,
                  0,0}),
            Line(points={{16,-14},{50,-14}},
                                           color={0,0,0}),
            Polygon(
              points={{40,-10},{48,-10},{44,-14},{40,-10}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.None),
            Line(points={{-90,0},{-70,0}}, color={0,0,0}),
            Line(points={{-10,0},{16,0}}, color={0,0,0}),
            Line(points={{50,0},{90,0}}, color={0,0,0}),
                                            Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end GasDryer;

    model Check
    extends Modelica.Icons.Example;
      GasDryer gasDryer(param_use_water_outlet=false)
        annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

      SI.MolarFlowRate n_dot = 1;
      Modelica.Blocks.Sources.Sine sine_signal(freqHz = 0.1, offset = 0.8)  annotation (
        Placement(visible = true, transformation(origin = {-84, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      ElectrolysisSystem.Tools.Boundaries.GasSource gasSource(T=338.15) annotation (Placement(
            visible=true, transformation(
            origin={-80,-36},
            extent={{-10,-10},{10,10}},
            rotation=0)));
    equation
      gasDryer.port_inlet_gas.n_flow = sine_signal.y;
      gasDryer.port_inlet_gas.p = 1e5;
      gasDryer.port_inlet_gas.h = gasSource.gasConnector.h;
      gasDryer.port_inlet_gas.X = {0.9,0.1};
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=120, __Dymola_NumberOfIntervals=5000));
    end Check;
  end GasDryer;

  package GasCompressor "compressor model for electrolyser"
   extends Modelica.Icons.Package;

    model H2Compressor "partial model for gas compressor"

      // media model
      package Gas = Media.Gases.H2andWaterVapor;

      // parameters for compressor
      parameter SI.Pressure param_p_end=50e5
        "pressure at the end of compression";
    //  parameter SI.Pressure
      parameter SI.Temperature param_T_start=40 + 273.15
        "temperature after intercooler";
      parameter SI.Temperature param_T_end=135 + 273.15
        "maximum temperatue allowed during compression";
      parameter Real param_kappa=1.50 "constant isentropix exponent of hydrogen for calculation of number of stages";
      parameter SI.Efficiency param_eta_mech=0.8
        "mechanical efficiency of compressor";

      /*
  // Modelica doesn't allow component array with 'variable' size 
  // -> ThermodynamicState-Arrays are the problem, without them this approach would work
  parameter Integer param_n_compStage=
    integer(ceil(log(param_p_end/port_inlet_gas.p)/log((param_T_end/param_T_start)^(param_kappa/(param_kappa-1)))))
      "number of compressor stages (calculated with constant kappa)";
  */
      parameter Integer param_n_compStage=5 "number of compressor stages";

      // variables
      SI.Energy var_P_cons(start=0.0, fixed=true)
        "integrated power consumption";
      Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
        "integrated power consumption in kWh";

      SI.Pressure var_p_in[param_n_compStage];
      SI.Pressure var_p_out[param_n_compStage];
      Real var_Z_in[param_n_compStage];
    //  Real var_Z_out[param_n_compStage];
    //  Real var_Z_stage[param_n_compStage];
      Real var_k_in[param_n_compStage];
      Real var_k_out[param_n_compStage];
      Real var_k_stage[param_n_compStage];
      SI.SpecificEnthalpy var_h_in[param_n_compStage];
      SI.SpecificEnthalpy var_h_out[param_n_compStage];
      Real var_ratio;
      SI.MolarEnergy var_w_t_stage[param_n_compStage];
      SI.MolarEnergy var_w_t;
      SI.Power var_P_comp "power for compression";
      SI.Power var_P_el "electrical power consumption";
      SI.Power var_P_cool[param_n_compStage + 1] "cooling power";
      Gas.ThermodynamicState state_in[param_n_compStage];
      Gas.ThermodynamicState state_out[param_n_compStage];

      // Connectors
      Tools.Connectors.GasConnector port_inlet_gas(redeclare package Gas = Gas) annotation (
          Placement(transformation(extent={{-68,-10},{-48,10}}), iconTransformation(extent={{-120,-20},
                {-80,20}})));
      Tools.Connectors.GasConnector port_outlet_gas(redeclare package Gas = Gas) annotation (
          Placement(transformation(extent={{52,-12},{72,8}}), iconTransformation(extent={{80,-20},{120,
                20}})));
      Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-10,-108},
                {10,-88}}), iconTransformation(extent={{-20,-120},{20,-80}})));

      Modelica.Blocks.Tables.CombiTable2D table_kappa[2*param_n_compStage](each
        tableOnFile=true,
        each tableName="kappa",
        each fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/H2_kappa.txt"),
        each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        each extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
        each verboseExtrapolation=true) "real gas isentropic exponent of hydrogen"
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));

      Modelica.Blocks.Tables.CombiTable2D table_z[param_n_compStage](
        each tableOnFile=true,
        each tableName="z",
        each fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/H2_z.txt"),
        each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        each extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
        each verboseExtrapolation=true) "compressibility factor of real gas hydrogen"
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));

    protected
      Real var_m_gas "constant molar mass of gas";
      Gas.ThermodynamicState state_init;
      Gas.ThermodynamicState state_end;

      Real var_X[2];
      parameter Real var_ratio_tmp(fixed=false);
      parameter Integer param_n_compStage_min(fixed=false) "minimal number of compressor
  stages to fit boundary condition max temperature";

    initial algorithm
      //compression ratio due to boundary condition max temperature
      var_ratio_tmp := min((param_T_end/param_T_start)^(param_kappa/(param_kappa-1)), max(param_p_end/port_inlet_gas.p,1));
      // calculate the needed # of stages once
      param_n_compStage_min := if var_ratio>1 then
        integer(ceil(log(param_p_end/port_inlet_gas.p)/log(var_ratio_tmp)))
          else 1;
    equation

      assert(
        port_P_el.P >= -Const.eps,
        "power input is below zero",
        AssertionLevel.warning);

      // output warning if # of compression stags is too low
      // to fit boundary condition max temperature
      assert(
        param_n_compStage >= param_n_compStage_min,
        "the compressor needs to have more stages (at least "
          + String(param_n_compStage_min) + ")"
          + " if input pressure is " + String(port_inlet_gas.p/1e5) + " bar and "
          + "desired output pressure is " + String(param_p_end/1e5) + " bar. ",
        AssertionLevel.error);

      assert(port_inlet_gas.p*var_ratio_tmp^param_n_compStage>=param_p_end,
        "input pressure is too low to reach specified end pressure. Raise number of stages!"
        + ", reachable pressure: " + String(port_inlet_gas.p*var_ratio^param_n_compStage),
        AssertionLevel.error);

      for i in 1:size(port_inlet_gas.X, 1) loop
        var_X[i] =port_inlet_gas.X[i];
      end for;

      // formula if compStage is caculated
      //var_ratio=if param_p_end>var_p_in[1] then (param_T_end/param_T_start)^(param_kappa/(param_kappa-1)) else 1;
      // otherwise if n_compStage is constant then just
      var_ratio = max(min(
         (param_T_end/param_T_start)^(param_kappa/(param_kappa-1)),
         (param_p_end/port_inlet_gas.p)^(1/param_n_compStage)),1);

      for i in 1:param_n_compStage loop
        // input pressure of stage
        if i==1 then
          var_p_in[i] =port_inlet_gas.p;
        else
          var_p_in[i]=var_p_out[i-1];
        end if;

        // output pressure of stage
        if i==param_n_compStage then
          var_p_out[i] = param_p_end;
        else
          var_p_out[i]=var_p_in[i]*var_ratio;
        end if;

        // get density and kappa before compression
        state_in[i] = Gas.setState_pTX(var_p_in[i], param_T_start, var_X);
        state_out[i] = Gas.setState_pTX(var_p_out[i], param_T_end, var_X);

        table_kappa[2*(i-1)+1].u1 = SI.Conversions.to_bar(var_p_in[i]);
        table_kappa[2*(i-1)+1].u2 = param_T_start;
        var_k_in[i] = table_kappa[2*(i-1)+1].y;

        table_kappa[2*(i-1)+2].u1 = SI.Conversions.to_bar(var_p_out[i]);
        table_kappa[2*(i-1)+2].u2 = param_T_end;
        var_k_out[i] = table_kappa[2*(i-1)+2].y;

        var_k_stage[i] = (var_k_in[i]+var_k_out[i])/2;

        var_h_in[i] = Gas.specificEnthalpy(state_in[i]);
        var_h_out[i] = Gas.specificEnthalpy(state_out[i]);

        table_z[i].u1 = SI.Conversions.to_bar(var_p_in[i]);
        table_z[i].u2 = param_T_start;
        var_Z_in[i] = table_z[i].y;

        // specific work of stage
        var_w_t_stage[i] = var_k_stage[i]/(var_k_stage[i] - 1)*
          Const.R*param_T_start*var_Z_in[i]*(var_ratio^((
          var_k_stage[i] - 1)/var_k_stage[i]) - 1);
      end for;

      // cooling load
      state_init =Gas.setState_phX(
        port_inlet_gas.p,
        port_inlet_gas.h,
        port_inlet_gas.X);
      // gas gets cooled after last stage
      state_end = Gas.setState_pTX(var_p_out[param_n_compStage], param_T_start, var_X);
      var_m_gas = Gas.molarMass(state_init);

      //cooling before compression
      var_P_cool[1] =var_m_gas*port_inlet_gas.n_flow*(Gas.specificEnthalpy(state_init) -
        Gas.specificEnthalpy(state_in[1]));
      //cooling during compression
      for i in 1:param_n_compStage-1 loop
        var_P_cool[i+1] =var_m_gas*port_inlet_gas.n_flow*(var_h_out[i] - var_h_in[i + 1]);
      end for;
      //cooling after compression
      var_P_cool[param_n_compStage+1] =var_m_gas*port_inlet_gas.n_flow*(Gas.specificEnthalpy(
        state_out[param_n_compStage]) - Gas.specificEnthalpy(state_end));

      // mass balance
      port_inlet_gas.n_flow = port_outlet_gas.n_flow;
      port_inlet_gas.X = port_outlet_gas.X;
      port_outlet_gas.p = var_p_out[param_n_compStage];
      port_outlet_gas.h = Gas.specificEnthalpy(state_end);

      var_w_t = sum(var_w_t_stage);
      var_P_comp =var_w_t*abs(port_inlet_gas.n_flow);
      var_P_el = var_P_comp/param_eta_mech;
      port_P_el.P = var_P_el;
      der(var_P_cons) = port_P_el.P;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-60,80},{92,40}}, color={0,0,0}),
            Line(points={{-60,-80},{92,-40}}, color={0,0,0}),
                                            Text(
            extent={{-150,150},{150,110}},
            textString="%name",
            lineColor={0,0,255})}),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end H2Compressor;

    model Check
    extends Modelica.Icons.Example;
      H2Compressor h2Compressor(param_n_compStage=5)
                                annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.Sine sine_signal(freqHz=0.1, offset=0.8)      annotation (
        Placement(visible = true, transformation(origin = {-84, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Tools.Boundaries.GasSource gasSource(T=368.15, p=300000) annotation (Placement(visible=true,
            transformation(
            origin={-80,-36},
            extent={{-10,-10},{10,10}},
            rotation=0)));
    equation
      h2Compressor.port_inlet_gas.n_flow = sine_signal.y;
      h2Compressor.port_inlet_gas.p = 1e5;
      h2Compressor.port_inlet_gas.h = gasSource.gasConnector.h;
      h2Compressor.port_inlet_gas.X = {0.9,0.1};

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=120));
    end Check;
  end GasCompressor;

  package HeatPump "FastHVAC heat pump with control and power port"
  extends Modelica.Icons.Package;
    model HeatPump
      "simple inverter heat pump model with constant COP"

        // medium to use
        parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple param_medium_evap=
            AixLib.FastHVAC.Media.WaterSimple() "medium type on evaporator side";
        parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple param_medium_cond=
            AixLib.FastHVAC.Media.WaterSimple() "medium type on condenser side";

        // heat pump parameter
        parameter Real param_COP = 3.00 "constant COP" annotation(Dialog(group="heat pump parameters"));
        parameter SI.Power param_P_el=10e3 "maximum power consumption" annotation(Dialog(group="heat pump parameters"));
        parameter SI.Temperature param_T_set_evap=55+273.15
        "desired outlet temperature of evaporator"
                                                  annotation(Dialog(group="heat pump parameters"));
        parameter SI.Temperature param_T_init=35+273.15
        "initial temperature of heat pump"
                                          annotation(Dialog(group="heat pump parameters"));

        // other parameters
        parameter SI.Temperature param_T_init_evap=param_T_init
        "Initial evaporator temperatur"                                                    annotation(Dialog(group="initial parameters"));
        parameter SI.Volume param_V_evap = 0.1 "Volume of evaporator"
                                                                     annotation(Dialog(group="initial parameters"));
        parameter SI.Temperature param_T_init_cond=param_T_init
        "Initial condenser temperature"                                                    annotation(Dialog(group="initial parameters"));
        parameter SI.Volume param_V_cond = param_V_evap "Volume of condenser"
                                                                             annotation(Dialog(group="initial parameters"));

        // variables
        SI.Power var_P_therm "current thermal power output";
        SI.Energy var_P_therm_rem(start=0.0, fixed=true) "intergrated removed heat";
        Real var_P_therm_rem_kWh = SI.Conversions.to_kWh(var_P_therm_rem) "intergrated removed heat in kWh";
        SI.Power var_P_el "current electrical power consumption";
        SI.Energy var_P_cons(start=0.0, fixed=true) "integrated power consumption";
        Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons) "integrated power consumption in kWh";

        // components
        AixLib.FastHVAC.BaseClasses.WorkingFluid comp_evapFluid(
        medium=param_medium_evap,
        m_fluid=param_V_evap*param_medium_evap.rho,
        T0=param_T_init_evap) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,90})));
        AixLib.FastHVAC.BaseClasses.WorkingFluid comp_condFluid(
        medium=param_medium_cond,
        m_fluid=param_V_cond*param_medium_cond.rho,
        T0=param_T_init_cond) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,-90})));

        // in- and output enthalpy ports
        AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_evap_out annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,90}), iconTransformation(extent={{-100,80},{-80,100}})));
        AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_cond_in annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,-90}), iconTransformation(extent={{-100,-100},{-80,-80}})));
        AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_cond_out annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={90,-90}), iconTransformation(extent={{80,-100},{100,-80}})));
        AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_evap_in annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={90,90}), iconTransformation(extent={{80,80},{100,100}})));

        // sensors
        AixLib.FastHVAC.Components.Sensors.TemperatureSensor meas_T_evap
        "outlet temperature of evaporator" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-50,90})));

        // heat flows
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_dotQCond
        annotation (Placement(transformation(
            origin={0,-64},
            extent={{10,-10},{-10,10}},
            rotation=90)));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_dotQEvap
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={0,62})));

        // inputs / connectors
        Modelica.Blocks.Interfaces.RealInput inp_P_av
        "power available for heat pump" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-120,20}), iconTransformation(extent={{-10,-10},{10,10}},
              origin={-110,30})));
      Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-120,-20},
                {-100,0}}), iconTransformation(extent={{-140,-80},{-100,-40}})));

        // power controlling components
        Modelica.Blocks.Sources.RealExpression exp_set_T_evap(y=param_T_set_evap)
        "setpoint temperature evaporator outlet" annotation (Placement(visible=true,
            transformation(extent={{-36,-12},{-16,8}},  rotation=0)));
      AixLib.Controls.Continuous.LimPID contr_hp_temp(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.5,
        Td=0.2,
        Ti=30,
        reverseAction=true,
        strict=true,
        yMax=1,
        yMin=0,
        y_start=0.01,
        reset=AixLib.Types.Reset.Parameter,
        y_reset=0,
        addPID(y(start=0, fixed=false))) "controls hp power consumption due to setpoint temperature" annotation (Placement(
            transformation(
            extent={{-6,-6},{6,6}},
            rotation=0,
            origin={26,0})));
      Modelica.Blocks.Sources.RealExpression exp_is_T_evap(y=if block_and.y then
            block_firstOrder.y else param_T_set_evap)
        "temperature after heatpump evaporator" annotation (Placement(visible=true,
            transformation(extent={{-36,-32},{-16,-12}}, rotation=0)));
      Modelica.Blocks.Math.Min
                     block_min
        annotation (Placement(transformation(extent={{-26,22},{-14,34}})));
      Modelica.Blocks.Math.Product block_limit_power
        "actual electrical power for heatpump"
        annotation (Placement(transformation(extent={{48,4},{60,16}})));

      Tools.Components.Switch block_switch_hp "on/off switch for heatpump"
        annotation (Placement(transformation(extent={{18,22},{30,34}})));
        Modelica.Blocks.Sources.RealExpression exp_P_max(y=param_P_el)
        "maximum power consumption" annotation (Placement(visible=true,
            transformation(extent={{-68,-2},{-48,18}},  rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput inp_offSwitch
        "if false the heatpump is not used"
                                           annotation (Placement(transformation(
              extent={{-140,40},{-100,80}}),iconTransformation(extent={{-120,60},{-100,
                80}})));
      Modelica.Blocks.Continuous.FirstOrder block_firstOrder(T=2, initType=Modelica.Blocks.Types.Init.InitialOutput)
        "temperature sensor response time" annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={-51,73})));
        Modelica.Blocks.Sources.RealExpression exp_zero(y=0) "zero" annotation (
          Placement(visible=true, transformation(extent={{-80,34},{-68,44}},
              rotation=0)));
      Modelica.Blocks.Math.Max block_max
        annotation (Placement(transformation(extent={{-56,26},{-44,38}})));
      Modelica.Blocks.Sources.BooleanExpression block_greaterThreshold(y=block_min.y
             > 5) annotation (Placement(transformation(extent={{-8,34},{-2,40}})));
      Modelica.Blocks.Logical.And block_and
        annotation (Placement(transformation(extent={{4,36},{12,44}})));
    equation

      // limit power
      var_P_el = block_limit_power.y;
      var_P_therm = var_P_el*(param_COP-1);

      // heat extraction evaporator
      heatflow_dotQCond.Q_flow = var_P_therm+var_P_el;
      heatflow_dotQEvap.Q_flow = -var_P_therm;
      der(var_P_therm_rem) = var_P_therm;

      // actual electricity demand
      port_P_el.P = var_P_el;
      der(var_P_cons) = port_P_el.P;

      // connect statements

      connect(comp_evapFluid.enthalpyPort_b, meas_T_evap.enthalpyPort_a)
        annotation (Line(points={{-9,90},{-23.75,90},{-23.75,90.1},{-41.2,90.1}},
            color={176,0,0}));
      connect(meas_T_evap.enthalpyPort_b, port_evap_out) annotation (Line(points={{-59,
              90.1},{-72.5,90.1},{-72.5,90},{-90,90}}, color={176,0,0}));
      connect(comp_evapFluid.heatPort, heatflow_dotQEvap.port) annotation (Line(
            points={{-1.16573e-15,80.6},{0,80.6},{0,72},{1.77636e-15,72}}, color={
              191,0,0}));
      connect(comp_condFluid.heatPort, heatflow_dotQCond.port)
        annotation (Line(points={{0,-80.6},{0,-74}}, color={191,0,0}));
      connect(comp_evapFluid.enthalpyPort_a, port_evap_in)
        annotation (Line(points={{9,90},{90,90}}, color={176,0,0}));
      connect(comp_condFluid.enthalpyPort_b, port_cond_out)
        annotation (Line(points={{9,-90},{90,-90}}, color={176,0,0}));
      connect(port_cond_in, comp_condFluid.enthalpyPort_a)
        annotation (Line(points={{-90,-90},{-9,-90}}, color={176,0,0}));
      connect(block_switch_hp.y, block_limit_power.u1) annotation (Line(points={{31.2,28},
              {42,28},{42,13.6},{46.8,13.6}},     color={0,0,127}));
      connect(block_min.y, block_switch_hp.u)
        annotation (Line(points={{-13.4,28},{16.8,28}},  color={0,0,127}));
      connect(exp_set_T_evap.y, contr_hp_temp.u_s)
        annotation (Line(points={{-15,-2},{-6,-2},{-6,0},{18.8,0}},
                                                     color={0,0,127}));
      connect(contr_hp_temp.y, block_limit_power.u2) annotation (Line(points={{32.6,0},
              {38,0},{38,6.4},{46.8,6.4}},  color={0,0,127}));
      connect(meas_T_evap.T, block_firstOrder.u)
        annotation (Line(points={{-51,79},{-51,76.6}}, color={0,0,127}));
      connect(exp_is_T_evap.y, contr_hp_temp.u_m) annotation (Line(points={{-15,-22},
              {26,-22},{26,-7.2}},   color={0,0,127}));
      connect(exp_P_max.y, block_min.u2) annotation (Line(points={{-47,8},{-38,8},{
              -38,24.4},{-27.2,24.4}}, color={0,0,127}));
      connect(exp_zero.y, block_max.u1) annotation (Line(points={{-67.4,39},{-62,39},
              {-62,35.6},{-57.2,35.6}}, color={0,0,127}));
      connect(inp_P_av, block_max.u2) annotation (Line(points={{-120,20},{-88,20},{
              -88,28.4},{-57.2,28.4}}, color={0,0,127}));
      connect(block_max.y, block_min.u1) annotation (Line(points={{-43.4,32},{-38,
              32},{-38,31.6},{-27.2,31.6}}, color={0,0,127}));
      connect(contr_hp_temp.trigger, block_switch_hp.onOffSignal) annotation (Line(
            points={{21.2,-7.2},{21.2,-12},{14,-12},{14,40},{24,40},{24,35.2}},
            color={255,0,255}));
      connect(block_and.y, block_switch_hp.onOffSignal)
        annotation (Line(points={{12.4,40},{24,40},{24,35.2}}, color={255,0,255}));
      connect(block_greaterThreshold.y, block_and.u2) annotation (Line(points={{
              -1.7,37},{1.15,37},{1.15,36.8},{3.2,36.8}}, color={255,0,255}));
      connect(inp_offSwitch, block_and.u1) annotation (Line(points={{-120,60},{-64,
              60},{-64,46},{0,46},{0,40},{3.2,40}}, color={255,0,255}));
      annotation (Icon(graphics={
              Line(points={{0,80},{0,70},{-20,70},{20,60},{-20,50},{20,40},{-20,30},{20,20},{-20,10},{20,0},{-20,-10},
                  {20,-20},{-20,-30},{20,-40},{-20,-50},{20,-60},{-19.9609,-69.9902},{0,-70},{0,-80}},  color={0,0,127},
              origin={0,60},
              rotation=90),
              Line(points={{0,80},{0,70},{-20,70},{20,60},{-20,50},{20,40},{-20,30},{20,20},{-20,10},{20,0},{-20,-10},
                  {20,-20},{-20,-30},{20,-40},{-20,-50},{20,-60},{-19.9609,-69.99},{0,-70},{0,-80}},
                                                                                      color={238,46,47},
              origin={0,-60},
              rotation=90),
              Text(
                extent={{-64,33},{64,-33}},
                lineColor={28,108,200},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                textString=DynamicSelect("COP", "COP="+String(COP,  format="1.2f")),
                origin={-1,0},
                rotation=180),
              Polygon(
                points={{0,-14},{10,14},{-10,14},{0,-14}},
                lineColor={28,108,200},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
              origin={-54,90},
              rotation=270),
              Polygon(
                points={{0,14},{10,-14},{-10,-14},{0,14}},
                lineColor={238,46,47},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
              origin={54,-90},
              rotation=270),
              Line(points={{-60,0},{60,0}},   color={28,108,200},
              origin={-80,0},
              rotation=90),
              Line(points={{0,69},{-2.20424e-15,-51}},
                                              color={238,46,47},
              origin={80,9},
              rotation=180),
            Line(points={{40,-90},{-68,-90}}, color={238,46,47}),
            Line(points={{-40,90},{70,90}}, color={28,108,200})}), experiment(
            StopTime=10800, __Dymola_NumberOfIntervals=10000));
    end HeatPump;

    model Check
      extends Modelica.Icons.Example;
      HeatPump heatPump(param_P_el=100e3, param_T_init=50 + 273.15)
        annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=333.15)
        annotation (Placement(transformation(extent={{-106,-66},{-86,-46}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1)
        annotation (Placement(transformation(extent={{-106,-80},{-86,-60}})));
      AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource
        annotation (Placement(transformation(extent={{-58,-72},{-38,-52}})));
      AixLib.FastHVAC.Components.Sinks.Vessel vessel_cond
        annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
      Modelica.Blocks.Sources.Step           step(
        height=20,
        offset=323.15,
        startTime=100)
        annotation (Placement(transformation(extent={{94,62},{74,82}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=0.5)
        annotation (Placement(transformation(extent={{94,44},{74,64}})));
      AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource1
        annotation (Placement(transformation(extent={{42,50},{22,70}})));
      AixLib.FastHVAC.Components.Sinks.Vessel vessel_evap
        annotation (Placement(transformation(extent={{-22,50},{-42,70}})));
      Modelica.Blocks.Sources.RealExpression realExpression4(y=50e3)
        annotation (Placement(transformation(extent={{-76,-16},{-56,4}})));
      Modelica.Blocks.Sources.Sine sine(
        amplitude=20,
        freqHz=1/1200,
        offset=323.15)
        annotation (Placement(transformation(extent={{68,80},{48,100}})));
      Modelica.Blocks.Sources.BooleanExpression
                                             booleanExpression(y=true)
        annotation (Placement(transformation(extent={{-78,4},{-58,24}})));
    equation
      connect(realExpression.y,fluidSource. dotm) annotation (Line(points={{-85,-70},{-82,-70},{-82,-64.6},{-56,-64.6}}, color={0,0,127}));
      connect(realExpression1.y,fluidSource. T_fluid) annotation (Line(points={{-85,-56},{-80,-56},{-80,-57.8},{-56,
              -57.8}},                                                                                                       color={0,0,127}));
      connect(fluidSource.enthalpyPort_b, heatPump.port_cond_in) annotation (Line(
            points={{-38,-61},{-38,-60},{-18,-60},{-18,-18}}, color={176,0,0}));
      connect(vessel_cond.enthalpyPort_a, heatPump.port_cond_out)
        annotation (Line(points={{43,-60},{18,-60},{18,-18}}, color={176,0,0}));
      connect(fluidSource1.dotm, realExpression3.y)
        annotation (Line(points={{40,57.4},{57,57.4},{57,54},{73,54}}, color={0,0,127}));
      connect(fluidSource1.enthalpyPort_b, heatPump.port_evap_in) annotation (Line(
            points={{22,61},{22,39.5},{18,39.5},{18,18}}, color={176,0,0}));
      connect(heatPump.port_evap_out, vessel_evap.enthalpyPort_a)
        annotation (Line(points={{-18,18},{-18,60},{-25,60}}, color={176,0,0}));
      connect(realExpression4.y, heatPump.inp_P_av)
        annotation (Line(points={{-55,-6},{-44,-6},{-44,6},{-22,6}},
                                                   color={0,0,127}));
      connect(booleanExpression.y, heatPump.inp_offSwitch)
        annotation (Line(points={{-57,14},{-22,14}}, color={255,0,255}));
      connect(step.y, fluidSource1.T_fluid) annotation (Line(points={{73,72},{58,72},
              {58,64.2},{40,64.2}}, color={0,0,127}));
      annotation (experiment(StopTime=10000, __Dymola_NumberOfIntervals=1000));
    end Check;
  end HeatPump;

  package Media "Media data"
  extends Modelica.Icons.Package;

    package Gases
                  extends Modelica.Icons.Package;

      package H2andWaterVapor "H2 with fraction of H2O vapor"
        extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
          mediumName="H2WithWaterFraction",
          data={Modelica.Media.IdealGases.Common.SingleGasesData.H2,
         Modelica.Media.IdealGases.Common.SingleGasesData.H2O},
          fluidConstants={Modelica.Media.IdealGases.Common.FluidData.H2,
            Modelica.Media.IdealGases.Common.FluidData.H2O},
          substanceNames = {"Hydrogen", "H2O"},
          reference_X={0.95,0.05});
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end H2andWaterVapor;

      package O2andWaterVapor "O2 with fraction of H2O vapor"
        extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
          mediumName="O2WithWaterFraction",
          data={Modelica.Media.IdealGases.Common.SingleGasesData.O2,
         Modelica.Media.IdealGases.Common.SingleGasesData.H2O},
          fluidConstants={Modelica.Media.IdealGases.Common.FluidData.O2,
            Modelica.Media.IdealGases.Common.FluidData.H2O},
          substanceNames = {"Oxygen", "H2O"},
          reference_X={0.95,0.05});
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end O2andWaterVapor;

      partial model GasWithWater "base class for gas with water"

        replaceable package Gas =
            Modelica.Media.Interfaces.PartialMixtureMedium;

        parameter Gas.MassFraction X[Gas.nX];
        Gas.ThermodynamicState state;
        Gas.SpecificEnthalpy h;
        Gas.Density d;
        Gas.SpecificHeatCapacity cp;

        SI.AbsolutePressure p=1e5;
        SI.Temperature T=298.15;

      equation
        state = Gas.setState_pTX(p, T, X);
        h = Gas.specificEnthalpy(state);
        d = Gas.density(state);
        cp = Gas.specificHeatCapacityCp(state)
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end GasWithWater;

      model H2WithWater "gas mixture model for H2 with water vapor fraction"
        extends GasWithWater(redeclare package Gas = H2andWaterVapor, X=
              H2andWaterVapor.reference_X) annotation (Icon(coordinateSystem(
                preserveAspectRatio=false)), Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end H2WithWater;

      model O2WithWater "gas mixture model for O2 with water vapor fraction"
        extends GasWithWater(redeclare package Gas = O2andWaterVapor, X=
              O2andWaterVapor.reference_X) annotation (Icon(coordinateSystem(
                preserveAspectRatio=false)), Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end O2WithWater;
    end Gases;

    package Functions "standalone property functions"

      package H2
        function cp "specific heat capacity based on shomate equation"

          //https://webbook.nist.gov/cgi/cbook.cgi?ID=C1333740&Mask=1&Type=JANAFG&Plot=on
          input SI.Temperature T;
          output SI.SpecificHeatCapacityAtConstantPressure shc;

          // coefficient for range 298-1000K
        protected
          Real A= 33.066178;
          Real B= -11.363417;
          Real C= 11.432816;
          Real D= -2.772874;
          Real E= -0.158558;

          Real t= T/1000;

        algorithm

          shc:= A + B*t + C*t^2 + D*t^3 + E/t^2;

        end cp;

        function S "temperature dependent molar entropy of hydrogen"

          //https://webbook.nist.gov/cgi/cbook.cgi?ID=C1333740&Mask=1&Type=JANAFG&Plot=on
          input SI.Temperature T;
          output SI.MolarEntropy ent;

          // coefficient for range 298-1000K
        protected
           Real A= 33.066178;
          Real B= -11.363417;
          Real C= 11.432816;
          Real D= -2.772874;
          Real E= -0.158558;
          Real G= 172.707974;

          Real t= min(max(T,298),1000)/1000;
        algorithm
          ent :=A*log(t)+B*t+C*t^2/2+D*t^3/3-E/(2*t^2)+G;
        end S;
      end H2;

      package O2
        function cp "specific heat capacity based on shomate equation"

          //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782447&Mask=1
          input SI.Temperature T;
          output SI.SpecificHeatCapacityAtConstantPressure shc;

          // coefficient for range 100-700K
        protected
          Real A= 31.32234;
          Real B= -20.23531;
          Real C= 57.86644;
          Real D= -36.50624;
          Real E= -0.007374;

          Real t= T/1000;

        algorithm

          shc:= A + B*t + C*t^2 + D*t^3 + E/t^2;

        end cp;

        function S "temperature dependent molar entropy of oxygen"

          //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782447&Mask=1
          input SI.Temperature T;
          output SI.MolarEntropy ent;

          // coefficient for range 100-700K
        protected
          Real A= 31.32234;
          Real B= -20.23531;
          Real C= 57.86644;
          Real D= -36.50624;
          Real E= -0.007374;
          Real G= 246.7945;

          Real t= min(max(T,100),700)/1000;
        algorithm
          ent :=A*log(t)+B*t+C*t^2/2+D*t^3/3-E/(2*t^2)+G;
        end S;
      end O2;

      package H2O
        function cp "specific heat capacity based on shomate equation"

          //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Type=JANAFL&Plot=on
          input SI.Temperature T;
          output SI.SpecificHeatCapacityAtConstantPressure shc;

          // coefficient for range 298-500K
        protected
          Real A= -203.6060;
          Real B= 1523.290;
          Real C= -3196.413;
          Real D= 2474.455;
          Real E= 3.855326;

          Real t= T/1000;

        algorithm

          shc:= A + B*t + C*t^2 + D*t^3 + E/t^2;

        end cp;

        function deltaH "temperature dependent molar enthalpy of water"

          //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Type=JANAFL&Plot=on
          input SI.Temperature T;
          output SI.MolarEnthalpy ent;

          // coefficient for range 298-500K
        protected
          Real A= -203.6060;
          Real B= 1523.290;
          Real C= -3196.413;
          Real D= 2474.455;
          Real E= 3.855326;
          Real F= -256.5478;
          Real G= -488.7163;
          Real H= -285.8304;

          Real t= T/1000;
          Real H0 = -285.830;
        algorithm

          ent := (H0 + A*t + B*t^2/2 + C*t^3/3 + D*t^4/4 - E/t + F - H)*1000;

        end deltaH;

        function S "temperature dependent molar entropy of water"

          //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Type=JANAFL&Plot=on
          input SI.Temperature T;
          output SI.MolarEntropy ent;

          // coefficient for range 298-500K
        protected
          Real A= -203.6060;
          Real B= 1523.290;
          Real C= -3196.413;
          Real D= 2474.455;
          Real E= 3.855326;
          Real G= -488.7163;

          Real t= min(max(T,298),500)/1000;
        algorithm
          ent :=A*log(t)+B*t+C*t^2/2+D*t^3/3-E/(2*t^2)+G;
        end S;
      end H2O;
    end Functions;
  end Media;

  package Tools "different blocks used in electrolyser model"
   extends Modelica.Icons.Package;

    package Functions
    extends Modelica.Icons.Package;

      function WaterEvaporationEnthalpy
        "calculates the evaporation enthalpy based on VDI-Waermeatlas Eq. 46b in J/mol"
        input SI.Temperature T "temperature in K";
        output SI.MolarEnthalpy delta_hv
          "evaporation enthalpy of water";

      protected
        final parameter Real A=6.85307;
        final parameter Real B=7.43804;
        final parameter Real C=-2.937595;
        final parameter Real D=-3.282093;
        final parameter Real E=8.397378;
        final parameter SI.Temperature T_c=647;
        final parameter Real R =  Const.R;
        Real tao=max(1-T/T_c,0);

      algorithm
       // assert(T<T_c, "setting delta_hv=0 because temperature is higher than triple point temperature: " + String(T) + " K", AssertionLevel.warning);

        if T>=T_c then
            delta_hv := 0;
        else
            delta_hv :=Const.R*T_c*(A*tao^(1/3)+B*tao^(2/3)+C*tao+D*tao^2+E*tao^6);
        end if;

      end WaterEvaporationEnthalpy;
    end Functions;

    package Connectors "used connectors for gas mass flows"
    extends Modelica.Icons.Package;

      connector PowerConnector
        SI.Power P "Power in W";
        annotation (
          Icon(graphics={  Ellipse(origin = {-17, -51}, fillColor = {255, 255, 255},
                  fillPattern =                                                                    FillPattern.Solid, extent = {{-83, 151}, {117, -49}}, endAngle = 360), Text(origin = {-22, 35}, extent = {{-30, 35}, {74, -95}}, textString = "P"), Text(origin = {9, -5}, extent = {{-15, -7}, {27, -59}}, textString = "el")}, coordinateSystem(initialScale = 0.1)));
      end PowerConnector;

      connector GasConnector
        "Connector without flow/stream variables, so decoupled pressure/nflow"

        replaceable package Gas = Modelica.Media.Interfaces.PartialMedium
            "gas model" annotation (choicesAllMatching=true);

        Gas.AbsolutePressure p "pressure of gas [Pa]";
        SI.MolarFlowRate n_flow "molar flow rate of gas [mol/s]";
        Gas.SpecificEnthalpy h "specific enthalpy flow rate of gas [J/kg]";
        Units.MolarFraction X[Gas.nXi]
          "mass fractions of gas";
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-22,46},{22,-54}},
                lineColor={0,0,0},
                textString="n"),
              Text(
                extent={{-22,102},{22,2}},
                lineColor={0,0,0},
                textString=".")}),                                     Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end GasConnector;
    end Connectors;

    package Boundaries
    extends Modelica.Icons.Package;

      model PowerSource
        // power boundary with either a prescribed power input or an input connector
        parameter SI.Power P=1e3 "Boundary Power in W"
          annotation (Dialog(enable=not usePowerInput));
        parameter Boolean usePowerInput = false "Use external power input" annotation (
          Evaluate = true,
          HideResult = true);
        Modelica.Blocks.Interfaces.RealInput powerInput(final unit = "W") if usePowerInput "Input for external power in W" annotation (
          Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-25,63},    extent = {{-9, -9}, {9, 9}}, rotation = 0)));
        Connectors.PowerConnector powerConnector annotation (
            Placement(
            visible=true,
            transformation(
              origin={0,0},
              extent={{-10,-10},{10,10}},
              rotation=0),
            iconTransformation(
              origin={-5.32907e-15,0},
              extent={{-30,-30},{30,30}},
              rotation=0)));
      protected
        Modelica.Blocks.Interfaces.RealInput internalPowerInput(final unit = "W") "Only needed to connect to conditional connector";
      equation
        if not usePowerInput then
          // overwrite input from connector
          internalPowerInput = P;
        end if;
        powerConnector.P = internalPowerInput;
        connect(powerInput, internalPowerInput);
        annotation (
          Icon(graphics={  Line(origin = {0, 0.79}, points = {{0, 99.5}, {0, -100.5}}),
                                              Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})},                                                     coordinateSystem(initialScale = 0.1)));
      end PowerSource;

      model GasSource

        replaceable package Gas = Media.Gases.H2andWaterVapor
          constrainedby Modelica.Media.Interfaces.PartialMedium;

        //  parameter
        parameter SI.Temperature T=298.15 "temperature of gas";
        parameter SI.AbsolutePressure p=1e5 "pressure of gas";
        parameter SI.MolarFlowRate n_dot_gas=0.9
          "molar flow rate of gas";
        parameter SI.MolarFlowRate n_dot_h2o=0.1
          "molar flow rate of water vapor";

        Connectors.GasConnector gasConnector(redeclare package Gas =
                          Gas) annotation (Placement(transformation(extent={{-20,-20},
                  {20,20}}), iconTransformation(extent={{-30,-30},{30,30}})));

      protected
        Real X[2];
      equation

        X[1] = n_dot_gas/(n_dot_gas+n_dot_h2o);
        X[2] = 1-X[1];

        gasConnector.p = p;
        gasConnector.X = X;
        gasConnector.n_flow = (n_dot_gas + n_dot_h2o);
        gasConnector.h = Gas.specificEnthalpy(Gas.setState_pTX(
          p,
          T,
          X));

        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
                  points={{0,100},{0,-100}},
                                           color={0,0,0}),
                                              Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),                        Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end GasSource;
    end Boundaries;

    package Components "simple custom components"
      model Switch "Input signal if on, zero if off"
        Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
                extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},
                  {-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
                extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-20},{
                  140,20}})));
        Modelica.Blocks.Interfaces.BooleanInput onOffSignal(start=false, fixed = false) "boolean on-off-signal"
          annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
              iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={0,120})));
      equation
        y = if onOffSignal then u else 0.0;
        annotation (
          Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
                  fillPattern =                                                                                                                                                            FillPattern.Solid), Line(points={{
                    -100,0},{-34,0}},                                                                                                                                                                                                        color = {0, 0, 0}, thickness = 0.5),                                                                                                                                                                                                        Line(points={{
                    30,-2},{100,-2}},                                                                                                                                                                                                        color = {0, 0, 0}, thickness = 0.5),
                                                                                                                                                                                                        Line(points={{
                    -32,0},{24,26}},                                                                                                                                                                                                        color={255,
                    0,255},                                                                                                                                                                                                        thickness=
                    0.5),
              Ellipse(
                extent={{-36,4},{-28,-4}},
                lineColor={255,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio = false)));
      end Switch;

      model ThreeWayConnector "inverted three way valve"

        /* *******************************************************************
      Components
     ******************************************************************* */

        AixLib.FastHVAC.Interfaces.EnthalpyPort_a inlet1 annotation (Placement(
              transformation(extent={{-100,-10},{-80,10}}), iconTransformation(extent=
                 {{90,-10},{110,10}})));
        AixLib.FastHVAC.Interfaces.EnthalpyPort_b outlet annotation (Placement(
              transformation(extent={{82,-10},{102,10}}), iconTransformation(extent={
                  {-108,-10},{-88,10}})));
        AixLib.FastHVAC.Interfaces.EnthalpyPort_a inlet2 annotation (Placement(
              transformation(extent={{-10,-102},{10,-82}}), iconTransformation(extent=
                 {{-10,-110},{10,-90}})));

      equation

        // mass balance
        outlet.m_flow = inlet1.m_flow + inlet2.m_flow;

        // enthalpy balance
        if noEvent(outlet.m_flow>0) then
          outlet.h*outlet.m_flow = inlet1.h*inlet1.m_flow + inlet2.h*inlet2.m_flow;
        else
          outlet.h = inlet1.h;
        end if;
        // temperature balance assuming c_p is constant
        outlet.T*outlet.m_flow = inlet1.T*inlet1.m_flow + inlet2.T*inlet2.m_flow;

        outlet.c = inlet1.c;

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})),  Icon(graphics={Polygon(
                        points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},
                  {-100,50}},
                        lineColor={0,0,0},
                        lineThickness=0.5),            Line(
                        points={{-50,0},{50,50},{50,-50},{-50,0}},
                        color={0,0,0},
                        smooth=Smooth.None,
                        origin={0,-50},
                        rotation=270,
                        thickness=0.5),
              Line(points={{80,0},{36,0},{46,6}}, color={0,0,0}),
              Line(points={{36,0},{46,-6}}, color={0,0,0}),
              Line(points={{-36,0},{-80,0},{-70,6}}, color={0,0,0}),
              Line(points={{-80,0},{-70,-6}}, color={0,0,0}),
              Line(
                points={{23,-2},{-21,-2},{-11,4}},
                color={0,0,0},
                origin={2,-57},
                rotation=270),
              Line(
                points={{-5,3},{5,-3}},
                color={0,0,0},
                origin={-3,-41},
                rotation=270)}),
           Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a three way valve
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars2.png\" alt=\"\" />
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The instreaming flow can be divided into two flows. The ratio of the
  two flows is controlled by the external input.
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 22, 2014&#160;</i> by Markus Schumacher:<br/>
    Implemented.
  </li>
</ul>
</html>"));
      end ThreeWayConnector;

      block DynHysteresis
        "Transform Real to Boolean signal with Hysteresis, uLow and uHigh are variable"

        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Real uLow=0 "if y=true and u<=uLow, switch to y=false" annotation (Dialog(group="Time varying bounds"));
        Real uHigh=1 "if y=false and u>=uHigh, switch to y=true" annotation (Dialog(group="Time varying bounds"));
        parameter Boolean pre_y_start=false "Value of pre(y) at initial time";

        Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(extent={
                  {-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput y annotation (Placement(transformation(
                extent={{100,-10},{120,10}})));

      initial equation
        pre(y) = pre_y_start;
      equation
        assert(uHigh > uLow,"Hysteresis limits wrong (uHigh <= uLow)");
        y = not pre(y) and u > uHigh or pre(y) and u >= uLow;
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Polygon(
                  points={{-65,89},{-73,67},{-57,67},{-65,89}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-65,67},{-65,-81}},
                color={192,192,192}),Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
                Polygon(
                  points={{90,-70},{68,-62},{68,-78},{90,-70}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{70,-80},{94,-100}},
                  lineColor={160,160,164},
                  textString="u"),Text(
                  extent={{-65,93},{-12,75}},
                  lineColor={160,160,164},
                  textString="y"),Line(
                  points={{-80,-70},{30,-70}},
                  thickness=0.5),Line(
                  points={{-50,10},{80,10}},
                  thickness=0.5),Line(
                  points={{-50,10},{-50,-70}},
                  thickness=0.5),Line(
                  points={{30,10},{30,-70}},
                  thickness=0.5),Line(
                  points={{-10,-65},{0,-70},{-10,-75}},
                  thickness=0.5),Line(
                  points={{-10,15},{-20,10},{-10,5}},
                  thickness=0.5),Line(
                  points={{-55,-20},{-50,-30},{-44,-20}},
                  thickness=0.5),Line(
                  points={{25,-30},{30,-19},{35,-30}},
                  thickness=0.5),Text(
                  extent={{-99,2},{-70,18}},
                  lineColor={160,160,164},
                  textString="true"),Text(
                  extent={{-98,-87},{-66,-73}},
                  lineColor={160,160,164},
                  textString="false"),Text(
                  extent={{19,-87},{44,-70}},
                  textString="uHigh"),Text(
                  extent={{-63,-88},{-38,-71}},
                  textString="uLow"),Line(points={{-69,10},{-60,10}}, color={160,
                160,164})}),
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-29}}, color={192,192,192}),
              Polygon(
                points={{92,-29},{70,-21},{70,-37},{92,-29}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-79,-29},{84,-29}}, color={192,192,192}),
              Line(points={{-79,-29},{41,-29}}),
              Line(points={{-15,-21},{1,-29},{-15,-36}}),
              Line(points={{41,51},{41,-29}}),
              Line(points={{33,3},{41,22},{50,3}}),
              Line(points={{-49,51},{81,51}}),
              Line(points={{-4,59},{-19,51},{-4,43}}),
              Line(points={{-59,29},{-49,11},{-39,29}}),
              Line(points={{-49,51},{-49,-29}}),
              Text(
                extent={{-92,-49},{-9,-92}},
                lineColor={192,192,192},
                textString="%uLow"),
              Text(
                extent={{2,-49},{91,-92}},
                lineColor={192,192,192},
                textString="%uHigh"),
              Rectangle(extent={{-91,-49},{-8,-92}}, lineColor={192,192,192}),
              Line(points={{-49,-29},{-49,-49}}, color={192,192,192}),
              Rectangle(extent={{2,-49},{91,-92}}, lineColor={192,192,192}),
              Line(points={{41,-29},{41,-49}}, color={192,192,192})}),
          Documentation(info="<html>
<p>
This block transforms a <strong>Real</strong> input signal into a <strong>Boolean</strong>
output signal:
</p>
<ul>
<li> When the output was <strong>false</strong> and the input becomes
     <strong>greater</strong> than parameter <strong>uHigh</strong>, the output
     switches to <strong>true</strong>.</li>
<li> When the output was <strong>true</strong> and the input becomes
     <strong>less</strong> than parameter <strong>uLow</strong>, the output
     switches to <strong>false</strong>.</li>
</ul>
<p>
The start value of the output is defined via parameter
<strong>pre_y_start</strong> (= value of pre(y) at initial time).
The default value of this parameter is <strong>false</strong>.
</p>
</html>"));
      end DynHysteresis;

      model CheckThreeWayValve "check for three way valve"
        extends Modelica.Icons.Example;
        AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource
          annotation (Placement(transformation(extent={{-68,-10},{-50,8}})));
        AixLib.FastHVAC.Components.Sinks.Vessel vessel
          annotation (Placement(transformation(extent={{46,-10},{66,10}})));
        Modelica.Blocks.Sources.RealExpression mflow1(y=5)
          annotation (Placement(transformation(extent={{-118,-14},{-98,6}})));
        Modelica.Blocks.Sources.RealExpression T1(y=25 + 273.15)
          annotation (Placement(transformation(extent={{-118,6},{-98,26}})));
        AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve
          annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));
        Modelica.Blocks.Sources.RealExpression T2(y=0.2)
          annotation (Placement(transformation(extent={{-20,22},{0,42}})));
        Components.ThreeWayConnector threeWayConnector
          annotation (Placement(transformation(extent={{28,-10},{8,10}})));
      equation
        connect(mflow1.y, fluidSource.dotm) annotation (Line(points={{-97,-4},{-82,-4},
                {-82,-3.34},{-66.2,-3.34}}, color={0,0,127}));
        connect(T1.y, fluidSource.T_fluid) annotation (Line(points={{-97,16},{-82,16},
                {-82,2.78},{-66.2,2.78}}, color={0,0,127}));
        connect(fluidSource.enthalpyPort_b, threeWayValve.enthalpyPort_ab)
          annotation (Line(points={{-50,-0.1},{-30,-0.1},{-30,0},{-25.8,0}}, color={
                176,0,0}));
        connect(T2.y, threeWayValve.opening) annotation (Line(points={{1,32},{16,32},
                {16,18},{-16,18},{-16,9}}, color={0,0,127}));
        connect(threeWayValve.enthalpyPort_a, threeWayConnector.inlet1)
          annotation (Line(points={{-6,0},{8,0}}, color={176,0,0}));
        connect(threeWayValve.enthalpyPort_b, threeWayConnector.inlet2) annotation (
            Line(points={{-16,-10},{-16,-20},{18,-20},{18,-10}}, color={176,0,0}));
        connect(threeWayConnector.outlet, vessel.enthalpyPort_a)
          annotation (Line(points={{27.8,0},{49,0}}, color={176,0,0}));
        annotation (experiment(StopTime=30));
      end CheckThreeWayValve;

      model GasConverter "Convert gas properties to individual outputs"
        replaceable package Gas = Modelica.Media.Interfaces.PartialMedium
            "gas model, e.g. Media.Gases.H2andWaterVapor" annotation (choicesAllMatching=true);
        Connectors.GasConnector gasConnector(redeclare package Gas = Gas) annotation (Placement(transformation(
                extent={{-100,-20},{-80,0}}),  iconTransformation(extent={{-100,-20},{
                  -60,20}})));
        Modelica.Blocks.Interfaces.RealOutput Mdot(final quantity = "Massflow", final unit = "kg/h", displayUnit = "kg/h", min = 0) "Massflow of gas [kg/h]" annotation (
          Placement(transformation(extent={{80,70},{100,90}}),      iconTransformation(extent={{80,70},
                  {100,90}})));
        Modelica.Blocks.Interfaces.RealOutput Vdot(final quantity = "Volume flow", final unit = "m3/h", displayUnit = "m3/h", min = 0) "Volume flow of gas [m³/h]" annotation (Placement(transformation(
                extent={{80,30},{100,50}}), iconTransformation(extent={{80,30},{100,50}})));
        Modelica.Blocks.Interfaces.RealOutput Vdot_norm(final quantity="Volume flow", final unit="m3/h", displayUnit="m3/h", min=0) "'Normal' volume flow of gas [Nm³/h]" annotation (Placement(transformation(
                extent={{80,-10},{100,10}}),iconTransformation(extent={{80,-10},{100,10}})));
        Modelica.Blocks.Interfaces.RealOutput p(final quantity = "Pressure", final unit = "Pa", displayUnit = "Pa", min = 0) "Pressure of gas [Pa]" annotation (Placement(transformation(
                extent={{80,-50},{100,-30}}),
                                            iconTransformation(extent={{80,-50},{100,-30}})));
        Modelica.Blocks.Interfaces.RealOutput T(final quantity = "Temperature", final unit = "K", displayUnit = "K", min = 0) "Temperature of gas [K]" annotation (Placement(transformation(
                extent={{80,-90},{100,-70}}), iconTransformation(extent={{80,-90},{100,
                  -70}})));
        Modelica.SIunits.AbsolutePressure p_norm = 101325 "Normal pressure [Pa]";
        Modelica.SIunits.TemperatureDifference T_norm = 273.15 "Normal temperature [K]";
        Modelica.SIunits.MolarMass M_molar;
        Modelica.SIunits.TemperatureDifference T_calc;
        Gas.ThermodynamicState state;
      equation
        state = gasConnector.Gas.setState_phX(gasConnector.p, gasConnector.h, gasConnector.X);
        M_molar = gasConnector.Gas.molarMass(state);
        Mdot = M_molar * gasConnector.n_flow * 3600; // Convert from kg/s to kg/h
        T_calc = gasConnector.Gas.temperature_phX(gasConnector.p, gasConnector.h, gasConnector.X);
        // R = 8.3144598 J/(mol.K) in p*V=n*R*T, with [p] = Pa, [V] = m3, T] = K, [n] = mol
        Vdot = (gasConnector.n_flow * Modelica.Constants.R * T_calc / gasConnector.p) * 3600;  // Convert from m3/s to m3/h
        Vdot_norm = Vdot * (p/p_norm) * (T_norm/T);
        p = gasConnector.p;
        T = T_calc;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Line(points={{-80,0},{80,-40}}, color={0,0,0}),
              Line(points={{-80,0},{80,80}}, color={0,0,0}),
              Line(points={{-80,0},{80,40}}, color={0,0,0}),
              Line(points={{-80,0},{80,-80}}, color={0,0,0}),
              Line(points={{-80,0},{80,0}}, color={0,0,0})}),          Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end GasConverter;
    end Components;
  end Tools;

  package Units "custom units not covered by Modelica.SIunits"
  extends Modelica.Icons.Package;

    type MolarFlowRateDensity = Real (final quantity="Molar Flow Rate Density",
          final unit="mol.s-1.m-2") "moles per second and square meter";

    type ResistanceArea = Real (final quantity="Resistance Times Area", final
          unit="Ohm.m2") "resistance times area, ohm*m²";

    type PermeabilityCoefficient = Real (final quantity="Molar Flow Rate Density",
          final unit="mol.m-1.s-1.Pa-1")
      "moles per meter, second, and Pascal [mol/(m.s.Pa)]";

    type CombinedDiffHydrThickFactor = Real (final quantity="Factor", final unit="Pa.m2.A-1")
      "factor combining diffusion coefficient, hydraulic conductivity and membrane thickness [Pa.m2.A-1]";

    type MembraneHumidity = Real (
        final quantity="Membrane Humidity",
        final unit="1",
        min=7,
        max=25) "humidity of membrane 7-25";

    type Fraction = Real (
        final quantity="Fraction",
        final unit="1",
        min=0,
        max=1) "Type For Fraction";

    type UniversalGasConstant = Real (final quantity="Universal Gas Constant",
          final unit="J.mol-1.K-1") "universal gas constant";

    type MolarFraction = Real (
        final quantity="MolarFraction",
        final unit="1",
        min=0,
        max=1);

    type VolumetricEnergy =Real (
        final quantity="VolumetricEnergy",
        final unit="kW.h.m-3",
        min=0);

    type MolePerJoule =Real (
        final quantity="MolePerJoule",
        final unit="mol.J-1",
        min=0);
  end Units;

  package Resources "data needed for model to run properly"
  extends Modelica.Icons.Package;

  end Resources;

  package PartialModels "base class for both simple and detailed model"
  extends Modelica.Icons.Package;
    partial model PartialCell

      // media models
      replaceable package H2O = Modelica.Media.Water.WaterIF97_R1pT; //R1 is liquid, R2 is vapor
      replaceable package H2 = Media.Gases.H2andWaterVapor;
      replaceable package O2 = Media.Gases.O2andWaterVapor;

      // operating parameter
      parameter Units.VolumetricEnergy param_kWh_per_m3 = 4.4 "simple model: constant specific energy demand for H2 production of stack in kWh per normcubicmeter (0 °C, 1,01325 bar)" annotation(Dialog(group="electrolysis parameter"));
      parameter Units.VolumetricEnergy param_HHV_h2 = 3.5403 "higher heating value of H2 at norm conditions (0 °C, 1,01325 bar)"
                                                                                                                                 annotation(Dialog(group="electrolysis parameter"));
       SI.Pressure param_p_op_cathode
        "total pressure in channel on cathode side"  annotation (Dialog(group="operating parameter"));
       SI.Pressure param_p_op_anode
        "total pressure in channel on anode side"   annotation (Dialog(group="operating parameter"));
      parameter SI.Area param_membrane_area=600e-4  "active area of cell [m²]"   annotation (Dialog(group="membrane parameter"));
      parameter SI.Distance param_membrane_d=200e-6 "membrane thickness [m]"   annotation (Dialog(group="membrane parameter"));

      // variable evaporation enthalpy
      SI.MolarEnthalpy var_delta_Hr=-Media.Functions.H2O.deltaH(inp_T)
          "temperature dependent evaporation enthalpy of electrolyssis";

      // results
      SI.MoleFraction var_X_cc[2] "mole fractions hydrogen/vapor in cathode channel";
      SI.MoleFraction  var_X_ac[2] "mole fractions oxygen/vapor in anode channel";

      SI.Voltage var_U_rev "reversible cell voltage";
      SI.Voltage var_U_therm "thermoneutral cell voltage";
      SI.Voltage var_U_cell "current voltage of cell";
      SI.Power var_Q_prod "heat production of single cell";

      SI.Temperature var_T_cc=inp_T
        "temperature of cell cathode channel (no differentiation as of now)";
      SI.Temperature var_T_ac=inp_T
        "temperature of cell cathode channel (no differentiation as of now)";

      // variables: molar fraction of water in hydrogen and oxygen
      Units.MolarFraction var_x_h2o_h2
        "water vapor in saturated hydrogen [mol/mol]";
      Units.MolarFraction var_x_h2o_o2
        "water vapor in saturated oxygen [mol/mol]";

      // connectors
      Tools.Connectors.GasConnector port_outlet_h2(redeclare package Gas = H2) annotation (
          Placement(transformation(extent={{60,60},{80,80}}), iconTransformation(extent={{60,60},{100,
                100}})));
      Tools.Connectors.GasConnector port_outlet_o2(redeclare package Gas = O2) annotation (
          Placement(transformation(extent={{60,-100},{80,-80}}), iconTransformation(extent={{60,-100},
                {100,-60}})));
      Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-100,-100},
                {-80,-80}}), iconTransformation(extent={{-100,-100},{-60,-60}})));

      Modelica.Blocks.Interfaces.RealInput inp_i "input for current density"
        annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
            iconTransformation(extent={{-120,60},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput inp_T "cell temperature"
        annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
            iconTransformation(extent={{-120,20},{-100,40}})));
      Modelica.Blocks.Tables.CombiTable2D table_hydrogen(
        tableOnFile=true,
        tableName="humidity",
        fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/H2_humidity.txt"),
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
        verboseExtrapolation=false)
                                   "water vapor content of hydrogen"
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));

      Modelica.Blocks.Tables.CombiTable2D table_oxygen(
        tableOnFile=true,
        tableName="humidity",
        fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/O2_humidity.txt"),
        smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        verboseExtrapolation=false)
                                   "water vapor content of oxygen"
        annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

    protected
      H2.ThermodynamicState state_h2;
      O2.ThermodynamicState state_o2;
      parameter SI.Density param_dens_h2 = H2.density(H2.setState_pTX(101325,273.15,{1,0})) "density of H2 at norm conditions (0 °C, 1,01325 bar)";
      parameter SI.Density param_dens_o2 = O2.density(H2.setState_pTX(101325,273.15,{1,0})) "density of O2 at norm conditions (0 °C, 1,01325 bar)";
      parameter SI.MolarMass param_M_h2 = H2.molarMass(H2.setState_pTX(101325,273.15,{1,0})) "molar mass of H2";
    equation

      assert(var_T_cc>274, "temperature too low (=" + String(var_T_cc) + " K)",  AssertionLevel.error);
      assert(param_p_op_cathode>=1e5, "pressure too low (=" + String(param_p_op_cathode) + " Pa)",  AssertionLevel.error);
      assert(param_p_op_anode<=27e5, "data for water content of oxygen is only valid up to 27 bar", AssertionLevel.error);

      // gas data
      table_hydrogen.u1 = SI.Conversions.to_bar(param_p_op_cathode);
      table_hydrogen.u2 = inp_T;
      table_oxygen.u1 = SI.Conversions.to_bar(param_p_op_anode);
      table_oxygen.u2 = inp_T;

      // reversible cell voltage
      var_U_rev =
        (-Media.Functions.H2O.deltaH(inp_T)
        -inp_T*(Media.Functions.H2.S(inp_T) +0.5*Media.Functions.O2.S(inp_T)-Media.Functions.H2O.S(inp_T)))
        /(2*Const.F);
      var_U_therm = var_delta_Hr/(2*Const.F);

      // water vapor in gases [mole H2O per mole gas] (assumption: saturated gas)
      // Huang (2007): Humidity Standard of Compressed Hydrogen for Fuel Cell Technology
      // Huang (2008): Humidity Standard of Compressed Oxygen for Future Generation PEM Fuel Cells
      var_x_h2o_h2 = table_hydrogen.y;
      var_x_h2o_o2 = table_oxygen.y;

      // thermodynamic states to calculate h for port
      state_h2 = H2.setState_pTX(param_p_op_cathode,var_T_cc,var_X_cc);
      state_o2 = O2.setState_pTX(param_p_op_anode,var_T_ac,var_X_ac);

      // port variables except n_flow
      var_X_cc = {(1-var_x_h2o_h2), var_x_h2o_h2};
      port_outlet_h2.p = param_p_op_cathode;
      port_outlet_h2.h = H2.specificEnthalpy(state_h2);
      port_outlet_h2.X = var_X_cc;

      var_X_ac = {(1-var_x_h2o_o2), var_x_h2o_o2};
      port_outlet_o2.p = param_p_op_anode;
      port_outlet_o2.h = O2.specificEnthalpy(state_o2);
      port_outlet_o2.X = var_X_ac;

      port_P_el.P = max(var_U_cell * inp_i * param_membrane_area,0);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Polygon(
              points={{-74,50},{46,70},{46,-30},{-74,-50},{-74,50}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Ellipse(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
            Polygon(
              points={{-62,40},{38,58},{38,-22},{-62,-40},{-62,40}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-58,36},{42,54},{42,-26},{-58,-44},{-58,36}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-54,32},{46,50},{46,-30},{-54,-48},{-54,32}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,30},{-40,-72},{80,-50},{80,50},{-40,30}},
              lineColor={0,0,0},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=100000000000, __Dymola_NumberOfIntervals=1000000));
    end PartialCell;
  end PartialModels;
  annotation (uses(
      AixLib(version="0.10.7"),
      ModelicaServices(version="3.2.3"),
      Modelica(version="3.2.3")));
end ElectrolysisSystem;
