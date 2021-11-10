within Q100_DistrictModel.Components;
model Producer_HePu_opt "HeatPump with pump and simple and optimized control"
  extends Modelica.Icons.Package;
  parameter Modelica.SIunits.Temperature T_Out = 323.15 "Output temperature" annotation (
    Dialog(tab = "General"));
  parameter Real uLow = -5 "Value of deltaT for switching on" annotation (
    Dialog(tab = "General"));
  parameter Real uHigh = 5 "Value of deltaT for switching off" annotation (
    Dialog(tab = "General"));
  parameter Real Scale_Factor = 1 "Scale factor for heat production power" annotation (
    Dialog(tab = "General"));
  Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation (
    Placement(visible = true, transformation(origin = {160, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation (
    Placement(visible = true, transformation(origin = {-160, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation (
    Placement(visible = true, transformation(origin = {0, -150}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_T_Out(k = T_Out) annotation (
    Placement(visible = true, transformation(origin = {110, -120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PID_pump(initType = .Modelica.Blocks.Types.InitPID.InitialOutput, limitsAtInit = true, yMax = 1000, yMin = 0, y_start = 0.1) annotation (
    Placement(visible = true, transformation(origin = {40, -100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  AixLib.FastHVAC.Components.Pumps.Pump pump annotation (
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation (
    Placement(visible = true, transformation(origin = {0, -58}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation (
    Placement(visible = true, transformation(origin = {0, 98}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation (
    Placement(visible = true, transformation(origin = {0, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation (
    Placement(visible = true, transformation(origin = {-92, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation (
    Placement(visible = true, transformation(origin = {-110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = uHigh, uLow = uLow) annotation (
    Placement(visible = true, transformation(origin = {-80, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Q100_DistrictModel.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI_ annotation (
    Placement(visible = true, transformation(origin = {-46, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_control_value annotation (
    Placement(visible = true, transformation(origin = {-80, 160}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-78, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation (
    Placement(visible = true, transformation(origin = {-40, 160}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-38, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput y_dotQ = heatPump.innerCycle.PerformanceDataHPHeating.QCon annotation (
    Placement(visible = true, transformation(origin = {-40, -150}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput y_P = heatPump.innerCycle.PerformanceDataHPHeating.Pel annotation (
    Placement(visible = true, transformation(origin = {40, -150}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump(redeclare
      model PerDataHea =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (                                                                                           dataTable = AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(tableQdot_con = [0, -15, -7, 2, 7, 10, 20, 30; 35, 3020 * Scale_Factor, 3810 * Scale_Factor, 2610 * Scale_Factor, 3960 * Scale_Factor, 4340 * Scale_Factor, 5350 * Scale_Factor, 6610 * Scale_Factor; 45, 3020 * Scale_Factor, 3780 * Scale_Factor, 2220 * Scale_Factor, 3870 * Scale_Factor, 4120 * Scale_Factor, 5110 * Scale_Factor, 6310 * Scale_Factor; 55, 3120 * Scale_Factor, 3790 * Scale_Factor, 2430 * Scale_Factor, 3610 * Scale_Factor, 3910 * Scale_Factor, 4850 * Scale_Factor, 6000 * Scale_Factor], tableP_ele = [0, -15, -7, 2, 7, 10, 20, 30; 35, 1290 * Scale_Factor, 1310 * Scale_Factor, 730 * Scale_Factor, 870 * Scale_Factor, 850 * Scale_Factor, 830 * Scale_Factor, 780 * Scale_Factor; 45, 1550 * Scale_Factor, 1600 * Scale_Factor, 870 * Scale_Factor, 1110 * Scale_Factor, 1090 * Scale_Factor, 1080 * Scale_Factor, 1040 * Scale_Factor; 55, 1870 * Scale_Factor, 1940 * Scale_Factor, 1170 * Scale_Factor, 1370 * Scale_Factor, 1370 * Scale_Factor, 1370 * Scale_Factor, 1350 * Scale_Factor], mFlow_conNom = 3960 / 4180 / 5 * Scale_Factor, mFlow_evaNom = 2250 * 1.2 / 3600 * Scale_Factor, tableUppBou = [-20, 50; -10, 60; 30, 60; 35, 55], tableLowBou = [-20, 25; 25, 25; 35, 35])), redeclare
      model PerDataChi =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (                                                                                                                                                                                                        dataTable = AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(tableQdot_con = [0, 20, 25, 27, 30, 35; 7, 2540 * Scale_Factor, 2440 * Scale_Factor, 2370 * Scale_Factor, 2230 * Scale_Factor, 2170 * Scale_Factor; 18, 5270 * Scale_Factor, 5060 * Scale_Factor, 4920 * Scale_Factor, 4610 * Scale_Factor, 4500 * Scale_Factor], tableP_ele = [0, 20, 25, 27, 30, 35; 7, 1380 * Scale_Factor, 1590 * Scale_Factor, 1680 * Scale_Factor, 1800 * Scale_Factor, 1970 * Scale_Factor; 18, 950 * Scale_Factor, 1060 * Scale_Factor, 1130 * Scale_Factor, 1200 * Scale_Factor, 1350 * Scale_Factor], mFlow_conNom = 3960 / 4180 / 5 * Scale_Factor, mFlow_evaNom = 2250 * 1.2 / 3600 * Scale_Factor, tableUppBou = [20, 20; 35, 20], tableLowBou = [20, 5; 35, 5])), CCon = 100, CEva = 100, GCon = 5, GEva = 5, Q_useNominal = 0, TAmbCon_nominal = 288.15, TCon_start(displayUnit = "K"), TEva_start(displayUnit = "K"), VCon = 0.4, VEva = 0.04, allowFlowReversalEva = true, deltaM_con = 0.1, deltaM_eva = 0.1, mFlow_conNominal = 0.5, mFlow_evaNominal = 0.5, refIneFre_constant = 1, transferHeat = true, use_ConCap = false, use_EvaCap = false, use_autoCalc = false, use_refIne = true, use_revHP = true) annotation (
    Placement(visible = true, transformation(origin = {-8, 28.6667}, extent = {{-13.3333, 16}, {13.3333, -16}}, rotation = 90)));
  AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource annotation (
    Placement(visible = true, transformation(origin = {-72, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.FastHVAC.Components.Sinks.Vessel vessel annotation (
    Placement(visible = true, transformation(origin = {-66, 6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation (
    Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_T_fluid_source annotation (
    Placement(visible = true, transformation(origin = {-160, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_dotm_source annotation (
    Placement(visible = true, transformation(origin = {-160, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 24}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(const_T_Out.y, PID_pump.u_m) annotation (
    Line(points = {{99, -120}, {40.5, -120}, {40.5, -112}, {40, -112}}, color = {0, 0, 127}));
  connect(PID_pump.y, pump.dotm_setValue) annotation (
    Line(points = {{29, -100}, {8, -100}}, color = {0, 0, 127}));
  connect(pump.enthalpyPort_a, enthalpyPort_a) annotation (
    Line(points = {{0, -109.6}, {0, -150}}, color = {176, 0, 0}));
  connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation (
    Line(points = {{-0.1, -66.8}, {-0.1, -78.4}, {0, -78.4}, {0, -90.4}}, color = {176, 0, 0}));
  connect(TemperatureOutput.T, PID_pump.u_s) annotation (
    Line(points = {{11, 99}, {60, 99}, {60, -100}, {52, -100}}, color = {0, 0, 127}));
  connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation (
    Line(points = {{-0.1, 107}, {-0.1, 128}, {0, 128}, {0, 150}}, color = {176, 0, 0}));
  connect(u_T_setpoint_specification, add.u2) annotation (
    Line(points = {{-160, -60}, {-122, -60}}, color = {0, 0, 127}));
  connect(add.y, hysteresis.u) annotation (
    Line(points = {{-99, -54}, {-92, -54}}, color = {0, 0, 127}));
  connect(add.u1, u_T_setpoint) annotation (
    Line(points = {{-122, -48}, {-122, -47}, {-130, -47}, {-130, 120}, {90, 120}, {90, -60}, {160, -60}}, color = {0, 0, 127}));
  connect(booleanToReal.y, control_opt_SI_BooleanSI_.u_control_standard) annotation (
    Line(points = {{-81, -20}, {-58, -20}}, color = {0, 0, 127}));
  connect(control_opt_SI_BooleanSI_.u_control_value, u_control_value) annotation (
    Line(points = {{-46, -8}, {-46, 110}, {-80, 110}, {-80, 160}}, color = {0, 0, 127}));
  connect(control_opt_SI_BooleanSI_.u_control_boolean, u_control_boolean) annotation (
    Line(points = {{-40, -8}, {-40, 160}}, color = {255, 0, 255}));
  connect(hysteresis.y, booleanToReal.u) annotation (
    Line(points = {{-69, -54}, {-60, -54}, {-60, -36}, {-120, -36}, {-120, -20}, {-104, -20}, {-104, -20}}, color = {255, 0, 255}));
  connect(control_opt_SI_BooleanSI_.y_control, heatPump.nSet) annotation (
    Line(points = {{-35, -20}, {-6, -20}, {-6, 13.2001}, {-5.33333, 13.2001}}, color = {0, 0, 127}));
  connect(control_opt_SI_BooleanSI_.y_control_boolean, heatPump.modeSet) annotation (
    Line(points = {{-35, -14}, {-10, -14}, {-10, 13.2001}, {-10.4, 13.2001}}, color = {255, 0, 255}));
  connect(const.y, heatPump.iceFac_in) annotation (
    Line(points = {{-79, 20}, {-26, 20}, {-26, 18.5334}, {-26.1333, 18.5334}}, color = {0, 0, 127}));
  connect(u_T_fluid_source, fluidSource.T_fluid) annotation (
    Line(points = {{-160, 100}, {-100, 100}, {-100, 66.2}, {-80, 66.2}}, color = {0, 0, 127}));
  connect(u_dotm_source, fluidSource.dotm) annotation (
    Line(points = {{-160, 60}, {-82, 60}, {-82, 59.4}, {-80, 59.4}}, color = {0, 0, 127}));
  connect(fluidSource.enthalpyPort_b, heatPump.enthalpyPort_a2) annotation (
    Line(points = {{-62, 63}, {-44, 63}, {-44, 64}, {-16, 64}, {-16, 42}}, color = {176, 0, 0}));
  connect(vessel.enthalpyPort_a, heatPump.enthalpyPort_b2) annotation (
    Line(points = {{-59, 6}, {-16, 6}, {-16, 15.3334}}, color = {176, 0, 0}));
  connect(TemperatureOutput.enthalpyPort_a, heatPump.enthalpyPort_b1) annotation (
    Line(points = {{-0.1, 89.2}, {-0.1, 65.6}, {0, 65.6}, {0, 42}}, color = {176, 0, 0}));
  connect(heatPump.enthalpyPort_a1, TemperatureInput.enthalpyPort_b) annotation (
    Line(points = {{0, 15.3334}, {0, -49}, {-0.1, -49}}, color = {176, 0, 0}));
  annotation (
    Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system.

    <p>
    Parameter:
    <p>
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump


    </html>"),
    Diagram(coordinateSystem(extent = {{-140, -140}, {140, 140}})),
    Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
end Producer_HePu_opt;
