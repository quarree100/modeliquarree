within Q100_DistrictModel.Components;
model Producer_Boiler_opt "Gasboiler with simple and optimized control and with pump"
  extends Modelica.Icons.Package;
  parameter Modelica.SIunits.Temperature T_start = 353.15 "Inital temperature" annotation (
    Dialog(tab = "General"));
  parameter Modelica.SIunits.Temperature T_Out = 353.15 "Output temperature" annotation (
    Dialog(tab = "General"));
  parameter Modelica.SIunits.Temperature uLow = 341.15 "Value of deltaT for switching on" annotation (
    Dialog(tab = "General"));
  parameter Modelica.SIunits.Temperature uHigh = 343.15 "Value of deltaT for switching off" annotation (
    Dialog(tab = "General"));
  parameter Real Q_nom = 200000 "Nominal power of gasboiler" annotation (
    Dialog(tab = "General"));
  parameter Real Q_min = 200000 * 0.0 "Minimal power of gasboiler" annotation (
    Dialog(tab = "General"));
  Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation (
    Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation (
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation (
    Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation (
    Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation (
    Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  AixLib.FastHVAC.Components.HeatGenerators.Boiler.Boiler Boiler(T_start = T_start, paramBoiler = AixLib.FastHVAC.Data.Boiler.General.Boiler_Vitocrossal200_311kW(Q_nom = Q_nom, Q_min = Q_min)) annotation (
    Placement(visible = true, transformation(origin = {22, 0}, extent = {{-20, -22}, {20, 22}}, rotation = 0)));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation (
    Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Q100_DistrictModel.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI_ annotation (
    Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_control_value annotation (
    Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation (
    Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput y_dotE = Boiler.dotE_gas annotation (
    Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput y_dotQ = Boiler.heater.Q_flow annotation (
    Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Continuous.LimPID pid(Ti = 1, controllerType = .Modelica.Blocks.Types.SimpleController.PID, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.0001, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0) annotation (
    Placement(visible = true, transformation(origin = {-80, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Logical.Switch switch1 annotation (
    Placement(visible = true, transformation(origin = {-40, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation (
    Placement(visible = true, transformation(origin = {-95, 43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uHigh = uHigh, uLow = uLow) annotation (
    Placement(visible = true, transformation(origin = {-40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0.000000000001, y_start = 0.000000000001) annotation (
    Placement(visible = true, transformation(origin = {30, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  AixLib.FastHVAC.Components.Pumps.Pump pump annotation (
    Placement(visible = true, transformation(origin = {0, -70}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const1(k = T_Out) annotation (
    Placement(visible = true, transformation(origin = {70, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(Boiler.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation (
    Line(points = {{32, 0}, {39.9, 0}, {39.9, 41.2}}, color = {176, 0, 0}));
  connect(TemperatureInput.enthalpyPort_b, Boiler.enthalpyPort_a1) annotation (
    Line(points = {{-60.1, -21}, {-60.1, -0.44}, {12, -0.44}}, color = {176, 0, 0}));
  connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation (
    Line(points = {{39.9, 59}, {39.9, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
  connect(control_opt_SI_BooleanSI_.y_control_boolean, Boiler.onOff_boiler) annotation (
    Line(points = {{1, 26}, {28, 26}, {28, 15.4}}, color = {255, 0, 255}));
  connect(control_opt_SI_BooleanSI_.y_control, Boiler.dotQ_rel) annotation (
    Line(points = {{1, 20}, {17.975, 20}, {17.975, 15.4275}}, color = {0, 0, 127}));
  connect(control_opt_SI_BooleanSI_.u_control_value, u_control_value) annotation (
    Line(points = {{-10, 32}, {-10, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
  connect(control_opt_SI_BooleanSI_.u_control_boolean, u_control_boolean) annotation (
    Line(points = {{-4, 32}, {-4, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
  connect(pid.u_s, u_T_setpoint_specification) annotation (
    Line(points = {{-92, 12}, {-92, -60}, {-120, -60}}, color = {0, 0, 127}));
  connect(pid.u_m, u_T_setpoint) annotation (
    Line(points = {{-80, 24}, {-80, 70}, {80, 70}, {80, -60}, {120, -60}}, color = {0, 0, 127}));
  connect(const.y, switch1.u3) annotation (
    Line(points = {{-89.5, 43}, {-60, 43}, {-60, 28}, {-52, 28}, {-52, 28}}, color = {0, 0, 127}));
  connect(hysteresis.y, switch1.u2) annotation (
    Line(points = {{-51, 50}, {-66, 50}, {-66, 20}, {-52, 20}, {-52, 20}}, color = {255, 0, 255}));
  connect(u_T_setpoint, hysteresis.u) annotation (
    Line(points = {{120, -60}, {80, -60}, {80, 70}, {-20, 70}, {-20, 50}, {-28, 50}, {-28, 50}}, color = {0, 0, 127}));
  connect(pump.enthalpyPort_a, enthalpyPort_a) annotation (
    Line(points = {{0, -79.6}, {0, -79.6}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
  connect(pump.dotm_setValue, PID_Pump.y) annotation (
    Line(points = {{8, -70}, {19, -70}}, color = {0, 0, 127}));
  connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation (
    Line(points = {{-60.1, -38.8}, {-60.1, -38.8}, {-60.1, -50}, {0, -50}, {0, -60.4}, {0, -60.4}}, color = {176, 0, 0}));
  connect(const1.y, PID_Pump.u_m) annotation (
    Line(points = {{59, -90}, {30, -90}, {30, -82}, {30, -82}}, color = {0, 0, 127}));
  connect(TemperatureOutput.T, PID_Pump.u_s) annotation (
    Line(points = {{51, 51}, {60, 51}, {60, -70}, {42, -70}, {42, -70}}, color = {0, 0, 127}));
  connect(pid.y, control_opt_SI_BooleanSI_.u_control_standard) annotation (
    Line(points = {{-69, 12}, {-60, 12}, {-60, 4}, {-22, 4}, {-22, 20}, {-22, 20}}, color = {0, 0, 127}));
  connect(switch1.u1, pid.y) annotation (
    Line(points = {{-52, 12}, {-68, 12}, {-68, 12}, {-69, 12}}, color = {0, 0, 127}));
  annotation (
    Documentation(info = "<html>
<p>
This component simiulate a basboiler with a simple control system.

<p>
Parameter:
<p>
<strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump


</html>"),
    Diagram,
    Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
end Producer_Boiler_opt;
