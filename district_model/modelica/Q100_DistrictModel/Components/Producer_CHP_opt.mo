within Q100_DistrictModel.Components;
model Producer_CHP_opt "CHP with pump and simple and optimized control"
  extends Modelica.Icons.Package;
  parameter Modelica.SIunits.Temperature T_Out = 353.15 "Output temperature" annotation (
    Dialog(tab = "General"));
  parameter Modelica.SIunits.Temperature T0 = 353.15 "Initial temperature" annotation (
    Dialog(tab = "General"));
  parameter Real uLow = -5 "Value of deltaT for switching on" annotation (
    Dialog(tab = "General"));
  parameter Real uHigh = 5 "Value of deltaT for switching off" annotation (
    Dialog(tab = "General"));
  parameter Real eta_el = 0.35 "Efficiency of electrical production" annotation (
    Dialog(tab = "General"));
  parameter Real eta_th = 0.6 "Efficiency of thermal production" annotation (
    Dialog(tab = "General"));
  parameter Real capP_el = 9000 "Electrical power" annotation (
    Dialog(tab = "General"));
  Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation (
    Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation (
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation (
    Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_T_Out(k = T_Out) annotation (
    Placement(visible = true, transformation(origin = {70, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.LimPID PID_pump(initType = .Modelica.Blocks.Types.InitPID.InitialOutput, limitsAtInit = true, yMax = 100, yMin = 0.000000000001, y_start = 0.000000000001) annotation (
    Placement(visible = true, transformation(origin = {20, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  AixLib.FastHVAC.Components.Pumps.Pump pump annotation (
    Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation (
    Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation (
    Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation (
    Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation (
    Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation (
    Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = uHigh, uLow = uLow) annotation (
    Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Q100_DistrictModel.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI_ annotation (
    Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_control_value annotation (
    Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation (
    Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  AixLib.FastHVAC.Components.HeatGenerators.CHP.CHP_PT1 chp(T0 = T0, capP_el = capP_el, eta_el = eta_el, eta_th = eta_th, selectable = false) annotation (
    Placement(visible = true, transformation(origin = {10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_dotE = chp.Capacity[3] annotation (
    Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput y_dotQ = chp.Capacity[2] annotation (
    Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput y_P = chp.Capacity[1] annotation (
    Placement(visible = true, transformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(const_T_Out.y, PID_pump.u_m) annotation (
    Line(points = {{59, -80}, {20, -80}, {20, -72}, {20, -72}}, color = {0, 0, 127}));
  connect(PID_pump.y, pump.dotm_setValue) annotation (
    Line(points = {{9, -60}, {-50, -60}, {-50, -60}, {-52, -60}}, color = {0, 0, 127}));
  connect(pump.enthalpyPort_a, enthalpyPort_a) annotation (
    Line(points = {{-60, -69.6}, {-60, -69.6}, {-60, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
  connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation (
    Line(points = {{-60.1, -38.8}, {-60.1, -38.8}, {-60.1, -50.4}, {-60, -50.4}}, color = {176, 0, 0}));
  connect(TemperatureOutput.T, PID_pump.u_s) annotation (
    Line(points = {{51, 51}, {60, 51}, {60, -60}, {32, -60}, {32, -60}}, color = {0, 0, 127}));
  connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation (
    Line(points = {{39.9, 59}, {39.9, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
  connect(u_T_setpoint_specification, add.u2) annotation (
    Line(points = {{-120, -60}, {-90, -60}, {-90, 54}, {-82, 54}}, color = {0, 0, 127}));
  connect(add.y, hysteresis.u) annotation (
    Line(points = {{-59, 60}, {-52, 60}}, color = {0, 0, 127}));
  connect(add.u1, u_T_setpoint) annotation (
    Line(points = {{-82, 66}, {-90, 66}, {-90, 90}, {90, 90}, {90, -60}, {120, -60}}, color = {0, 0, 127}));
  connect(booleanToReal.y, control_opt_SI_BooleanSI_.u_control_standard) annotation (
    Line(points = {{-49, 20}, {-26, 20}}, color = {0, 0, 127}));
  connect(booleanToReal.u, hysteresis.y) annotation (
    Line(points = {{-72, 20}, {-80, 20}, {-80, 40}, {-20, 40}, {-20, 60}, {-29, 60}}, color = {255, 0, 255}));
  connect(control_opt_SI_BooleanSI_.u_control_value, u_control_value) annotation (
    Line(points = {{-14, 32}, {-14, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
  connect(control_opt_SI_BooleanSI_.u_control_boolean, u_control_boolean) annotation (
    Line(points = {{-8, 32}, {-8, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
  connect(control_opt_SI_BooleanSI_.y_control, chp.P_elRel) annotation (
    Line(points = {{-3, 20}, {16, 20}, {16, -0.8}, {15, -0.8}}, color = {0, 0, 127}));
  connect(control_opt_SI_BooleanSI_.y_control_boolean, chp.onOff) annotation (
    Line(points = {{-3, 26}, {6, 26}, {6, -0.8}, {6, -0.8}}, color = {255, 0, 255}));
  connect(chp.enthalpyPort_a, TemperatureInput.enthalpyPort_b) annotation (
    Line(points = {{0, -10}, {-60, -10}, {-60, -21}, {-60.1, -21}}, color = {176, 0, 0}));
  connect(chp.enthalpyPort_b, TemperatureOutput.enthalpyPort_a) annotation (
    Line(points = {{20, -10}, {40, -10}, {40, 41.2}, {39.9, 41.2}}, color = {176, 0, 0}));
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
end Producer_CHP_opt;
