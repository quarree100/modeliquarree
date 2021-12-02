within Q100_DistrictModel.ElectrolysisSystem.Model;
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
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -160}, {160, 160}}), graphics = {Ellipse(origin = {17, 45}, extent = {{-117, 107}, {83, -93}}, endAngle = 360), Line(points = {{-120, -148}, {-120, -110}, {120, -110}, {120, -150}}, thickness = 0.5), Line(points = {{90, -68}, {90, -88}, {-90, -88}, {-90, -68}}, thickness = 0.5), Text(origin = {-23.76, 35.82}, extent = {{-44.24, 48.18}, {11.76, -17.82}}, textString = "P"), Text(origin = {58.66, 35.82}, extent = {{-42.66, 48.18}, {11.34, -17.82}}, textString = "H"), Text(origin = {57.0526, 38.6666}, extent = {{-5.05259, 3.33338}, {18.9474, -16.6666}}, textString = "2"), Polygon(fillColor = {76, 76, 76}, fillPattern = FillPattern.Solid, points = {{-10, 64}, {14, 52}, {-10, 38}, {-10, 64}}), Text(origin = {-46.3632, 39.1428}, extent = {{-3.63632, 2.85714}, {16.3632, -17.1428}}, textString = "el"), Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-30, -78}, {30, -120}}), Text(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-30, -78}, {30, -120}}, textString = "HP"), Polygon(fillColor = {28, 108, 200}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-100, -68}, {-90, -48}, {-80, -68}, {-100, -68}}), Polygon(origin = {86, -53}, rotation = 180, fillColor = {238, 46, 47}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{6, -5}, {-4, 15}, {-14, -5}, {6, -5}}), Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-36, -78}, {-56, -98}}, endAngle = 360), Line(points = {{-46, -78}, {-56, -88}, {-46, -98}}, thickness = 0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -160}, {160, 160}})),
    experiment(StopTime = 2000000, __Dymola_NumberOfIntervals = 1000));
end ElectrolysisSystem;
