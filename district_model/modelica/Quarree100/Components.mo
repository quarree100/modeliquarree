within Quarree100;

package Components
  extends Modelica.Icons.Package;

  model Producer_Boiler "Gasboiler with pump and simple control"
    extends Modelica.Icons.Package;
    parameter Modelica.SIunits.Temperature T_Out = 353.15 "Output temperature" annotation(
      Dialog(tab = "General"));
    parameter Modelica.SIunits.Temperature T_start = 353.15 "Inital temperature" annotation(
      Dialog(tab = "General"));
    parameter Real uLow = -5 "Value of deltaT for switching on" annotation(
      Dialog(tab = "General"));
    parameter Real uHigh = 5 "Value of deltaT for switching off" annotation(
      Dialog(tab = "General"));
    parameter Real Q_nom = 55000 "Nominal power of gasboiler" annotation(
      Dialog(tab = "General"));
    parameter Real Q_min = 55000 * 0.0 "Minimal power of gasboiler" annotation(
      Dialog(tab = "General"));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
      Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const_T_Out(k = T_Out) annotation(
      Placement(visible = true, transformation(origin = {70, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PID_pump(initType = .Modelica.Blocks.Types.InitPID.InitialOutput, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {20, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump annotation(
      Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.HeatGenerators.Boiler.Boiler Boiler(T_start = T_start) annotation(
      Placement(visible = true, transformation(origin = {-6, 0}, extent = {{-20, -22}, {20, 22}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
      Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
      Placement(visible = true, transformation(origin = {-20, 46}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation(
      Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = uHigh, uLow = uLow) annotation(
      Placement(visible = true, transformation(origin = {-40, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_dotE = Boiler.dotE_gas annotation(
      Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotQ = Boiler.heater.Q_flow annotation(
      Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(const_T_Out.y, PID_pump.u_m) annotation(
      Line(points = {{60, -80}, {20, -80}, {20, -72}, {20, -72}}, color = {0, 0, 127}));
    connect(PID_pump.y, pump.dotm_setValue) annotation(
      Line(points = {{10, -60}, {-50, -60}, {-50, -60}, {-52, -60}}, color = {0, 0, 127}));
    connect(pump.enthalpyPort_a, enthalpyPort_a) annotation(
      Line(points = {{-60, -70}, {-60, -70}, {-60, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation(
      Line(points = {{-60, -38}, {-60, -38}, {-60, -50}, {-60, -50}}, color = {176, 0, 0}));
    connect(TemperatureOutput.T, PID_pump.u_s) annotation(
      Line(points = {{52, 52}, {60, 52}, {60, -60}, {32, -60}, {32, -60}}, color = {0, 0, 127}));
    connect(Boiler.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation(
      Line(points = {{4, 0}, {40, 0}, {40, 42}, {40, 42}, {40, 42}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_b, Boiler.enthalpyPort_a1) annotation(
      Line(points = {{-60, -20}, {-60, -20}, {-60, 0}, {-16, 0}, {-16, 0}}, color = {176, 0, 0}));
    connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
      Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
    connect(booleanToReal.y, Boiler.dotQ_rel) annotation(
      Line(points = {{-20, 35}, {-20, 28}, {-10, 28}, {-10, 15}}, color = {0, 0, 127}));
    connect(u_T_setpoint_specification, add.u2) annotation(
      Line(points = {{-120, -60}, {-90, -60}, {-90, 64}, {-82, 64}}, color = {0, 0, 127}));
    connect(add.y, hysteresis.u) annotation(
      Line(points = {{-59, 70}, {-52, 70}}, color = {0, 0, 127}));
    connect(hysteresis.y, booleanToReal.u) annotation(
      Line(points = {{-29, 70}, {-20, 70}, {-20, 58}}, color = {255, 0, 255}));
    connect(hysteresis.y, Boiler.onOff_boiler) annotation(
      Line(points = {{-29, 70}, {0, 70}, {0, 15}}, color = {255, 0, 255}));
    connect(add.u1, u_T_setpoint) annotation(
      Line(points = {{-82, 76}, {-90, 76}, {-90, 90}, {90, 90}, {90, -60}, {120, -60}}, color = {0, 0, 127}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-6, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
      experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
  end Producer_Boiler;

  model Producer_Boiler_opt "Gasboiler with pump and simple and optimized control"
    extends Modelica.Icons.Package;
    parameter Modelica.SIunits.Temperature T_Out = 353.15 "Output temperature" annotation(
      Dialog(tab = "General"));
    parameter Modelica.SIunits.Temperature T_start = 353.15 "Inital temperature" annotation(
      Dialog(tab = "General"));
    parameter Real uLow = -5 "Value of deltaT for switching on" annotation(
      Dialog(tab = "General"));
    parameter Real uHigh = 5 "Value of deltaT for switching off" annotation(
      Dialog(tab = "General"));
    parameter Real Q_nom = 200000 "Nominal power of gasboiler" annotation(
      Dialog(tab = "General"));
    parameter Real Q_min = 200000 * 0.0 "Minimal power of gasboiler" annotation(
      Dialog(tab = "General"));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
      Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const_T_Out(k = T_Out) annotation(
      Placement(visible = true, transformation(origin = {70, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PID_pump(initType = .Modelica.Blocks.Types.InitPID.InitialOutput, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {20, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump annotation(
      Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.HeatGenerators.Boiler.Boiler Boiler(T_start = T_start, paramBoiler = AixLib.FastHVAC.Data.Boiler.General.Boiler_Vitocrossal200_311kW(Q_nom = Q_nom, Q_min = Q_min)) annotation(
      Placement(visible = true, transformation(origin = {14, 0}, extent = {{-20, -22}, {20, 22}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
      Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
      Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation(
      Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = uHigh, uLow = uLow) annotation(
      Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation(
      Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
      Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
      Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotE = Boiler.dotE_gas annotation(
      Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotQ = Boiler.heater.Q_flow annotation(
      Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(const_T_Out.y, PID_pump.u_m) annotation(
      Line(points = {{60, -80}, {20, -80}, {20, -72}, {20, -72}}, color = {0, 0, 127}));
    connect(PID_pump.y, pump.dotm_setValue) annotation(
      Line(points = {{10, -60}, {-50, -60}, {-50, -60}, {-52, -60}}, color = {0, 0, 127}));
    connect(pump.enthalpyPort_a, enthalpyPort_a) annotation(
      Line(points = {{-60, -70}, {-60, -70}, {-60, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation(
      Line(points = {{-60, -38}, {-60, -38}, {-60, -50}, {-60, -50}}, color = {176, 0, 0}));
    connect(TemperatureOutput.T, PID_pump.u_s) annotation(
      Line(points = {{52, 52}, {60, 52}, {60, -60}, {32, -60}, {32, -60}}, color = {0, 0, 127}));
    connect(Boiler.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation(
      Line(points = {{24, 0}, {40, 0}, {40, 42}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_b, Boiler.enthalpyPort_a1) annotation(
      Line(points = {{-60, -20}, {-60, 0}, {4, 0}}, color = {176, 0, 0}));
    connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
      Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
    connect(u_T_setpoint_specification, add.u2) annotation(
      Line(points = {{-120, -60}, {-90, -60}, {-90, 54}, {-82, 54}}, color = {0, 0, 127}));
    connect(add.y, hysteresis.u) annotation(
      Line(points = {{-59, 60}, {-52, 60}}, color = {0, 0, 127}));
    connect(add.u1, u_T_setpoint) annotation(
      Line(points = {{-82, 66}, {-90, 66}, {-90, 90}, {90, 90}, {90, -60}, {120, -60}}, color = {0, 0, 127}));
    connect(booleanToReal.y, control_opt_SI_BooleanSI.u_control_standard) annotation(
      Line(points = {{-48, 20}, {-26, 20}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.y_control_boolean, Boiler.onOff_boiler) annotation(
      Line(points = {{-3, 26}, {20, 26}, {20, 15}}, color = {255, 0, 255}));
    connect(control_opt_SI_BooleanSI.y_control, Boiler.dotQ_rel) annotation(
      Line(points = {{-3, 20}, {10, 20}, {10, 15}}, color = {0, 0, 127}));
    connect(booleanToReal.u, hysteresis.y) annotation(
      Line(points = {{-72, 20}, {-80, 20}, {-80, 40}, {-20, 40}, {-20, 60}, {-29, 60}}, color = {255, 0, 255}));
    connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation(
      Line(points = {{-14, 32}, {-14, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation(
      Line(points = {{-8, 32}, {-8, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
  end Producer_Boiler_opt;

  model Producer_Boiler_opt_through "Gasboiler with simple and optimized control and without pump"
    extends Modelica.Icons.Package;
    parameter Modelica.SIunits.Temperature T_start = 353.15 "Inital temperature" annotation(
      Dialog(tab = "General"));
    parameter Real uLow = -5 "Value of deltaT for switching on" annotation(
      Dialog(tab = "General"));
    parameter Real uHigh = 5 "Value of deltaT for switching off" annotation(
      Dialog(tab = "General"));
    parameter Real Q_nom = 200000 "Nominal power of gasboiler" annotation(
      Dialog(tab = "General"));
    parameter Real Q_min = 200000 * 0.0 "Minimal power of gasboiler" annotation(
      Dialog(tab = "General"));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
      Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.HeatGenerators.Boiler.Boiler Boiler(T_start = T_start, paramBoiler = AixLib.FastHVAC.Data.Boiler.General.Boiler_Vitocrossal200_311kW(Q_nom = Q_nom, Q_min = Q_min)) annotation(
      Placement(visible = true, transformation(origin = {14, 0}, extent = {{-20, -22}, {20, 22}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
      Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation(
      Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
      Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
      Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotE = Boiler.dotE_gas annotation(
      Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotQ = Boiler.heater.Q_flow annotation(
      Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.LimPID pid(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0) annotation(
      Placement(visible = true, transformation(origin = {-54, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  equation
    connect(Boiler.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation(
      Line(points = {{24, 0}, {40, 0}, {40, 42}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_b, Boiler.enthalpyPort_a1) annotation(
      Line(points = {{-60, -20}, {-60, 0}, {4, 0}}, color = {176, 0, 0}));
    connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
      Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
    connect(control_opt_SI_BooleanSI.y_control_boolean, Boiler.onOff_boiler) annotation(
      Line(points = {{-3, 26}, {20, 26}, {20, 15}}, color = {255, 0, 255}));
    connect(control_opt_SI_BooleanSI.y_control, Boiler.dotQ_rel) annotation(
      Line(points = {{-3, 20}, {10, 20}, {10, 15}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation(
      Line(points = {{-14, 32}, {-14, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation(
      Line(points = {{-8, 32}, {-8, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
    connect(TemperatureInput.enthalpyPort_a, enthalpyPort_a) annotation(
      Line(points = {{-60, -38}, {-60, -38}, {-60, -60}, {0, -60}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
    connect(pid.y, control_opt_SI_BooleanSI.u_control_standard) annotation(
      Line(points = {{-42, 20}, {-26, 20}, {-26, 20}, {-26, 20}}, color = {0, 0, 127}));
    connect(pid.u_s, u_T_setpoint_specification) annotation(
      Line(points = {{-66, 20}, {-90, 20}, {-90, -60}, {-120, -60}, {-120, -60}}, color = {0, 0, 127}));
    connect(pid.u_m, u_T_setpoint) annotation(
      Line(points = {{-54, 32}, {-54, 32}, {-54, 70}, {80, 70}, {80, -60}, {120, -60}, {120, -60}}, color = {0, 0, 127}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
  end Producer_Boiler_opt_through;

  model Producer_CHP_opt "CHP with pump and simple and optimized control"
    extends Modelica.Icons.Package;
    parameter Modelica.SIunits.Temperature T_Out = 353.15 "Output temperature" annotation(
      Dialog(tab = "General"));
    parameter Modelica.SIunits.Temperature T0 = 353.15 "Initial temperature" annotation(
      Dialog(tab = "General"));
    parameter Real uLow = -5 "Value of deltaT for switching on" annotation(
      Dialog(tab = "General"));
    parameter Real uHigh = 5 "Value of deltaT for switching off" annotation(
      Dialog(tab = "General"));
    parameter Real eta_el = 0.35 "Efficiency of electrical production" annotation(
      Dialog(tab = "General"));
    parameter Real eta_th = 0.6 "Efficiency of thermal production" annotation(
      Dialog(tab = "General"));
    parameter Real capP_el = 9000 "Electrical power" annotation(
      Dialog(tab = "General"));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
      Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const_T_Out(k = T_Out) annotation(
      Placement(visible = true, transformation(origin = {70, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PID_pump(initType = .Modelica.Blocks.Types.InitPID.InitialOutput, limitsAtInit = true, yMax = 100, yMin = 0.000000000001, y_start = 0.000000000001) annotation(
      Placement(visible = true, transformation(origin = {20, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump annotation(
      Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
      Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
      Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation(
      Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = uHigh, uLow = uLow) annotation(
      Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation(
      Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
      Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
      Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    AixLib.FastHVAC.Components.HeatGenerators.CHP.CHP_PT1 chp(T0 = T0, capP_el = capP_el, eta_el = eta_el, eta_th = eta_th, selectable = false) annotation(
      Placement(visible = true, transformation(origin = {10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_dotE = chp.Capacity[3] annotation(
      Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotQ = chp.Capacity[2] annotation(
      Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_P = chp.Capacity[1] annotation(
      Placement(visible = true, transformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(const_T_Out.y, PID_pump.u_m) annotation(
      Line(points = {{60, -80}, {20, -80}, {20, -72}, {20, -72}}, color = {0, 0, 127}));
    connect(PID_pump.y, pump.dotm_setValue) annotation(
      Line(points = {{10, -60}, {-50, -60}, {-50, -60}, {-52, -60}}, color = {0, 0, 127}));
    connect(pump.enthalpyPort_a, enthalpyPort_a) annotation(
      Line(points = {{-60, -70}, {-60, -70}, {-60, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation(
      Line(points = {{-60, -38}, {-60, -38}, {-60, -50}, {-60, -50}}, color = {176, 0, 0}));
    connect(TemperatureOutput.T, PID_pump.u_s) annotation(
      Line(points = {{52, 52}, {60, 52}, {60, -60}, {32, -60}, {32, -60}}, color = {0, 0, 127}));
    connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
      Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
    connect(u_T_setpoint_specification, add.u2) annotation(
      Line(points = {{-120, -60}, {-90, -60}, {-90, 54}, {-82, 54}}, color = {0, 0, 127}));
    connect(add.y, hysteresis.u) annotation(
      Line(points = {{-59, 60}, {-52, 60}}, color = {0, 0, 127}));
    connect(add.u1, u_T_setpoint) annotation(
      Line(points = {{-82, 66}, {-90, 66}, {-90, 90}, {90, 90}, {90, -60}, {120, -60}}, color = {0, 0, 127}));
    connect(booleanToReal.y, control_opt_SI_BooleanSI.u_control_standard) annotation(
      Line(points = {{-48, 20}, {-26, 20}}, color = {0, 0, 127}));
    connect(booleanToReal.u, hysteresis.y) annotation(
      Line(points = {{-72, 20}, {-80, 20}, {-80, 40}, {-20, 40}, {-20, 60}, {-29, 60}}, color = {255, 0, 255}));
    connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation(
      Line(points = {{-14, 32}, {-14, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation(
      Line(points = {{-8, 32}, {-8, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
    connect(control_opt_SI_BooleanSI.y_control, chp.P_elRel) annotation(
      Line(points = {{-2, 20}, {16, 20}, {16, 0}, {16, 0}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.y_control_boolean, chp.onOff) annotation(
      Line(points = {{-2, 26}, {6, 26}, {6, 0}, {6, 0}}, color = {255, 0, 255}));
    connect(chp.enthalpyPort_a, TemperatureInput.enthalpyPort_b) annotation(
      Line(points = {{0, -10}, {-60, -10}, {-60, -20}, {-60, -20}}, color = {176, 0, 0}));
    connect(chp.enthalpyPort_b, TemperatureOutput.enthalpyPort_a) annotation(
      Line(points = {{20, -10}, {40, -10}, {40, 42}, {40, 42}}, color = {176, 0, 0}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
  end Producer_CHP_opt;

  model Producer_CHP_opt_through "CHP with simple and optimized control and without pump"
    extends Modelica.Icons.Package;
    parameter Modelica.SIunits.Temperature T0 = 353.15 "Initial temperature" annotation(
      Dialog(tab = "General"));
    parameter Real uLow = -5 "Value of deltaT for switching on" annotation(
      Dialog(tab = "General"));
    parameter Real uHigh = 5 "Value of deltaT for switching off" annotation(
      Dialog(tab = "General"));
    parameter Real eta_el = 0.35 "Efficiency of electrical production" annotation(
      Dialog(tab = "General"));
    parameter Real eta_th = 0.6 "Efficiency of thermal production" annotation(
      Dialog(tab = "General"));
    parameter Real capP_el = 9000 "Electrical power" annotation(
      Dialog(tab = "General"));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
      Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
      Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
      Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation(
      Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = uHigh, uLow = uLow) annotation(
      Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation(
      Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
      Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
      Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    AixLib.FastHVAC.Components.HeatGenerators.CHP.CHP_PT1 chp(T0 = T0, capP_el = capP_el, eta_el = eta_el, eta_th = eta_th, selectable = false) annotation(
      Placement(visible = true, transformation(origin = {10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_dotE = chp.Capacity[3] annotation(
      Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotQ = chp.Capacity[2] annotation(
      Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_P = chp.Capacity[1] annotation(
      Placement(visible = true, transformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
      Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
    connect(u_T_setpoint_specification, add.u2) annotation(
      Line(points = {{-120, -60}, {-90, -60}, {-90, 54}, {-82, 54}}, color = {0, 0, 127}));
    connect(add.y, hysteresis.u) annotation(
      Line(points = {{-59, 60}, {-52, 60}}, color = {0, 0, 127}));
    connect(add.u1, u_T_setpoint) annotation(
      Line(points = {{-82, 66}, {-90, 66}, {-90, 90}, {90, 90}, {90, -60}, {120, -60}}, color = {0, 0, 127}));
    connect(booleanToReal.y, control_opt_SI_BooleanSI.u_control_standard) annotation(
      Line(points = {{-48, 20}, {-26, 20}}, color = {0, 0, 127}));
    connect(booleanToReal.u, hysteresis.y) annotation(
      Line(points = {{-72, 20}, {-80, 20}, {-80, 40}, {-20, 40}, {-20, 60}, {-29, 60}}, color = {255, 0, 255}));
    connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation(
      Line(points = {{-14, 32}, {-14, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation(
      Line(points = {{-8, 32}, {-8, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
    connect(control_opt_SI_BooleanSI.y_control, chp.P_elRel) annotation(
      Line(points = {{-2, 20}, {16, 20}, {16, 0}, {16, 0}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.y_control_boolean, chp.onOff) annotation(
      Line(points = {{-2, 26}, {6, 26}, {6, 0}, {6, 0}}, color = {255, 0, 255}));
    connect(chp.enthalpyPort_a, TemperatureInput.enthalpyPort_b) annotation(
      Line(points = {{0, -10}, {-60, -10}, {-60, -20}, {-60, -20}}, color = {176, 0, 0}));
    connect(chp.enthalpyPort_b, TemperatureOutput.enthalpyPort_a) annotation(
      Line(points = {{20, -10}, {40, -10}, {40, 42}, {40, 42}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_a, enthalpyPort_a) annotation(
      Line(points = {{-60, -38}, {-60, -38}, {-60, -60}, {0, -60}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
  end Producer_CHP_opt_through;

  model Producer_HePu_opt "HeatPump with pump and simple and optimized control"
    extends Modelica.Icons.Package;
    parameter Modelica.SIunits.Temperature T_Out = 323.15 "Output temperature" annotation(
      Dialog(tab = "General"));
    parameter Real uLow = -5 "Value of deltaT for switching on" annotation(
      Dialog(tab = "General"));
    parameter Real uHigh = 5 "Value of deltaT for switching off" annotation(
      Dialog(tab = "General"));
    parameter Real Scale_Factor = 1 "Scale factor for heat production power" annotation(
      Dialog(tab = "General"));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
      Placement(visible = true, transformation(origin = {160, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
      Placement(visible = true, transformation(origin = {-160, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
      Placement(visible = true, transformation(origin = {0, -150}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const_T_Out(k = T_Out) annotation(
      Placement(visible = true, transformation(origin = {110, -120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PID_pump(initType = .Modelica.Blocks.Types.InitPID.InitialOutput, limitsAtInit = true, yMax = 1000, yMin = 0, y_start = 0.1) annotation(
      Placement(visible = true, transformation(origin = {40, -100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump annotation(
      Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {0, -58}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {0, 98}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
      Placement(visible = true, transformation(origin = {0, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
      Placement(visible = true, transformation(origin = {-92, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation(
      Placement(visible = true, transformation(origin = {-110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = uHigh, uLow = uLow) annotation(
      Placement(visible = true, transformation(origin = {-80, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation(
      Placement(visible = true, transformation(origin = {-46, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
      Placement(visible = true, transformation(origin = {-80, 160}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-78, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
      Placement(visible = true, transformation(origin = {-40, 160}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-38, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotQ = heatPump.innerCycle.PerformanceDataHPHeating.QCon annotation(
      Placement(visible = true, transformation(origin = {-40, -150}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_P = heatPump.innerCycle.PerformanceDataHPHeating.Pel annotation(
      Placement(visible = true, transformation(origin = {40, -150}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump(redeclare model PerDataHea = AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D(dataTable = AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(tableQdot_con = [0, -15, -7, 2, 7, 10, 20, 30; 35, 3020 * Scale_Factor, 3810 * Scale_Factor, 2610 * Scale_Factor, 3960 * Scale_Factor, 4340 * Scale_Factor, 5350 * Scale_Factor, 6610 * Scale_Factor; 45, 3020 * Scale_Factor, 3780 * Scale_Factor, 2220 * Scale_Factor, 3870 * Scale_Factor, 4120 * Scale_Factor, 5110 * Scale_Factor, 6310 * Scale_Factor; 55, 3120 * Scale_Factor, 3790 * Scale_Factor, 2430 * Scale_Factor, 3610 * Scale_Factor, 3910 * Scale_Factor, 4850 * Scale_Factor, 6000 * Scale_Factor], tableP_ele = [0, -15, -7, 2, 7, 10, 20, 30; 35, 1290 * Scale_Factor, 1310 * Scale_Factor, 730 * Scale_Factor, 870 * Scale_Factor, 850 * Scale_Factor, 830 * Scale_Factor, 780 * Scale_Factor; 45, 1550 * Scale_Factor, 1600 * Scale_Factor, 870 * Scale_Factor, 1110 * Scale_Factor, 1090 * Scale_Factor, 1080 * Scale_Factor, 1040 * Scale_Factor; 55, 1870 * Scale_Factor, 1940 * Scale_Factor, 1170 * Scale_Factor, 1370 * Scale_Factor, 1370 * Scale_Factor, 1370 * Scale_Factor, 1350 * Scale_Factor], mFlow_conNom = 3960 / 4180 / 5 * Scale_Factor, mFlow_evaNom = 2250 * 1.2 / 3600 * Scale_Factor, tableUppBou = [-20, 50; -10, 60; 30, 60; 35, 55], tableLowBou = [-20, 25; 25, 25; 35, 35])), redeclare model PerDataChi = AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D(dataTable = AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(tableQdot_con = [0, 20, 25, 27, 30, 35; 7, 2540 * Scale_Factor, 2440 * Scale_Factor, 2370 * Scale_Factor, 2230 * Scale_Factor, 2170 * Scale_Factor; 18, 5270 * Scale_Factor, 5060 * Scale_Factor, 4920 * Scale_Factor, 4610 * Scale_Factor, 4500 * Scale_Factor], tableP_ele = [0, 20, 25, 27, 30, 35; 7, 1380 * Scale_Factor, 1590 * Scale_Factor, 1680 * Scale_Factor, 1800 * Scale_Factor, 1970 * Scale_Factor; 18, 950 * Scale_Factor, 1060 * Scale_Factor, 1130 * Scale_Factor, 1200 * Scale_Factor, 1350 * Scale_Factor], mFlow_conNom = 3960 / 4180 / 5 * Scale_Factor, mFlow_evaNom = 2250 * 1.2 / 3600 * Scale_Factor, tableUppBou = [20, 20; 35, 20], tableLowBou = [20, 5; 35, 5])), CCon = 100, CEva = 100, GCon = 5, GEva = 5, Q_useNominal = 0, TAmbCon_nominal = 288.15, TCon_start(displayUnit = "K"), TEva_start(displayUnit = "K"), VCon = 0.4, VEva = 0.04, allowFlowReversalEva = true, deltaM_con = 0.1, deltaM_eva = 0.1, mFlow_conNominal = 0.5, mFlow_evaNominal = 0.5, refIneFre_constant = 1, transferHeat = true, use_ConCap = false, use_EvaCap = false, use_autoCalc = false, use_refIne = true, use_revHP = true) annotation(
      Placement(visible = true, transformation(origin = {-8, 28.6667}, extent = {{-13.3333, 16}, {13.3333, -16}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource annotation(
      Placement(visible = true, transformation(origin = {-72, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel annotation(
      Placement(visible = true, transformation(origin = {-66, 6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_T_fluid_source annotation(
      Placement(visible = true, transformation(origin = {-160, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_dotm_source annotation(
      Placement(visible = true, transformation(origin = {-160, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 24}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    connect(const_T_Out.y, PID_pump.u_m) annotation(
      Line(points = {{99, -120}, {40.5, -120}, {40.5, -112}, {40, -112}}, color = {0, 0, 127}));
    connect(PID_pump.y, pump.dotm_setValue) annotation(
      Line(points = {{29, -100}, {8, -100}}, color = {0, 0, 127}));
    connect(pump.enthalpyPort_a, enthalpyPort_a) annotation(
      Line(points = {{0, -109.6}, {0, -150}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation(
      Line(points = {{-0.1, -66.8}, {-0.1, -78.4}, {0, -78.4}, {0, -90.4}}, color = {176, 0, 0}));
    connect(TemperatureOutput.T, PID_pump.u_s) annotation(
      Line(points = {{11, 99}, {60, 99}, {60, -100}, {52, -100}}, color = {0, 0, 127}));
    connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
      Line(points = {{-0.1, 107}, {-0.1, 128}, {0, 128}, {0, 150}}, color = {176, 0, 0}));
    connect(u_T_setpoint_specification, add.u2) annotation(
      Line(points = {{-160, -60}, {-122, -60}}, color = {0, 0, 127}));
    connect(add.y, hysteresis.u) annotation(
      Line(points = {{-99, -54}, {-92, -54}}, color = {0, 0, 127}));
    connect(add.u1, u_T_setpoint) annotation(
      Line(points = {{-122, -48}, {-122, -47}, {-130, -47}, {-130, 120}, {90, 120}, {90, -60}, {160, -60}}, color = {0, 0, 127}));
    connect(booleanToReal.y, control_opt_SI_BooleanSI.u_control_standard) annotation(
      Line(points = {{-81, -20}, {-58, -20}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation(
      Line(points = {{-46, -8}, {-46, 110}, {-80, 110}, {-80, 160}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation(
      Line(points = {{-40, -8}, {-40, 160}}, color = {255, 0, 255}));
    connect(heatPump.enthalpyPort_a, TemperatureInput.enthalpyPort_b) annotation(
      Line(points = {{0, 15.3334}, {0, 15.3334}, {0, -49}, {-0.1, -49}}, color = {176, 0, 0}));
    connect(TemperatureOutput.enthalpyPort_a, heatPump.enthalpyPort_b) annotation(
      Line(points = {{-0.1, 89.2}, {-0.1, 89.2}, {-0.1, 42}, {0, 42}}, color = {176, 0, 0}));
    connect(hysteresis.y, booleanToReal.u) annotation(
      Line(points = {{-69, -54}, {-60, -54}, {-60, -36}, {-120, -36}, {-120, -20}, {-104, -20}, {-104, -20}}, color = {255, 0, 255}));
    connect(control_opt_SI_BooleanSI.y_control, heatPump.nSet) annotation(
      Line(points = {{-35, -20}, {-6, -20}, {-6, 13.2001}, {-5.33333, 13.2001}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.y_control_boolean, heatPump.modeSet) annotation(
      Line(points = {{-35, -14}, {-10, -14}, {-10, 13.2001}, {-10.4, 13.2001}}, color = {255, 0, 255}));
    connect(vessel.enthalpyPort_a, heatPump.enthalpyPort_b1) annotation(
      Line(points = {{-59, 6}, {-16, 6}, {-16, 15.3334}, {-16, 15.3334}}, color = {176, 0, 0}));
    connect(fluidSource.enthalpyPort_b, heatPump.enthalpyPort_a1) annotation(
      Line(points = {{-62, 63}, {-16, 63}, {-16, 42}}, color = {176, 0, 0}));
    connect(const.y, heatPump.iceFac_in) annotation(
      Line(points = {{-79, 20}, {-26, 20}, {-26, 18.5334}, {-26.1333, 18.5334}}, color = {0, 0, 127}));
    connect(u_T_fluid_source, fluidSource.T_fluid) annotation(
      Line(points = {{-160, 100}, {-100, 100}, {-100, 66.2}, {-80, 66.2}}, color = {0, 0, 127}));
    connect(u_dotm_source, fluidSource.dotm) annotation(
      Line(points = {{-160, 60}, {-82, 60}, {-82, 59.4}, {-80, 59.4}}, color = {0, 0, 127}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
      Diagram(coordinateSystem(extent = {{-140, -140}, {140, 140}})),
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
  end Producer_HePu_opt;

  model control_opt_Bus "Control unit for optimization"
    extends Modelica.Icons.Package;
    Modelica.Blocks.Interfaces.RealInput u_control_standard annotation(
      Placement(visible = true, transformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180), iconTransformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealOutput y_control annotation(
      Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold = 0.0001) annotation(
      Placement(visible = true, transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch1 annotation(
      Placement(visible = true, transformation(origin = {50, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Logical.LogicalSwitch logicalSwitch annotation(
      Placement(visible = true, transformation(origin = {50, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Interfaces.BooleanOutput y_control_boolean annotation(
      Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus annotation(
      Placement(visible = true, transformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, 99}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  equation
    connect(realToBoolean.y, switch1.u2) annotation(
      Line(points = {{-18, 20}, {-10, 20}, {-10, 0}, {38, 0}}, color = {255, 0, 255}));
    connect(u_control_standard, realToBoolean.u) annotation(
      Line(points = {{-120, 0}, {-60, 0}, {-60, 20}, {-42, 20}, {-42, 20}}, color = {0, 0, 127}));
    connect(u_control_standard, switch1.u1) annotation(
      Line(points = {{-120, 0}, {-60, 0}, {-60, -8}, {38, -8}, {38, -8}}, color = {0, 0, 127}));
    connect(switch1.y, y_control) annotation(
      Line(points = {{62, 0}, {102, 0}, {102, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(logicalSwitch.u1, realToBoolean.y) annotation(
      Line(points = {{38, 52}, {-10, 52}, {-10, 20}, {-18, 20}, {-18, 20}}, color = {255, 0, 255}));
    connect(logicalSwitch.u2, realToBoolean.y) annotation(
      Line(points = {{38, 60}, {-10, 60}, {-10, 20}, {-18, 20}, {-18, 20}}, color = {255, 0, 255}));
    connect(logicalSwitch.y, y_control_boolean) annotation(
      Line(points = {{62, 60}, {102, 60}, {102, 60}, {110, 60}}, color = {255, 0, 255}));
    connect(logicalSwitch.u3, controlBus.control_boolean) annotation(
      Line(points = {{38, 68}, {0, 68}, {0, 100}, {0, 100}}, color = {255, 0, 255}));
    connect(switch1.u3, controlBus.control_value) annotation(
      Line(points = {{38, 8}, {0, 8}, {0, 100}, {0, 100}}, color = {0, 0, 127}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component represents the control unit for optimized control. 
    
    <p>
    
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-4, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
      experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
  end control_opt_Bus;

  model control_opt_SI_BooleanSI "Control unit for optimization"
    extends Modelica.Icons.Package;
    Modelica.Blocks.Interfaces.RealInput u_control_standard annotation(
      Placement(visible = true, transformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180), iconTransformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealOutput y_control annotation(
      Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold = 0.0001) annotation(
      Placement(visible = true, transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch1 annotation(
      Placement(visible = true, transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Logical.LogicalSwitch logicalSwitch annotation(
      Placement(visible = true, transformation(origin = {70, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Interfaces.BooleanOutput y_control_boolean annotation(
      Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
      Placement(visible = true, transformation(origin = {0, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90), iconTransformation(origin = {0, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90)));
    Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
      Placement(visible = true, transformation(origin = {40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  equation
    connect(realToBoolean.y, switch1.u2) annotation(
      Line(points = {{-18, 20}, {-10, 20}, {-10, 0}, {58, 0}}, color = {255, 0, 255}));
    connect(u_control_standard, realToBoolean.u) annotation(
      Line(points = {{-120, 0}, {-60, 0}, {-60, 20}, {-42, 20}, {-42, 20}}, color = {0, 0, 127}));
    connect(u_control_standard, switch1.u1) annotation(
      Line(points = {{-120, 0}, {-60, 0}, {-60, -8}, {58, -8}}, color = {0, 0, 127}));
    connect(switch1.y, y_control) annotation(
      Line(points = {{81, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(logicalSwitch.u1, realToBoolean.y) annotation(
      Line(points = {{58, 52}, {-10, 52}, {-10, 20}, {-18, 20}}, color = {255, 0, 255}));
    connect(logicalSwitch.u2, realToBoolean.y) annotation(
      Line(points = {{58, 60}, {-10, 60}, {-10, 20}, {-18, 20}}, color = {255, 0, 255}));
    connect(logicalSwitch.y, y_control_boolean) annotation(
      Line(points = {{81, 60}, {110, 60}}, color = {255, 0, 255}));
    connect(switch1.u3, u_control_value) annotation(
      Line(points = {{58, 8}, {0, 8}, {0, 120}, {0, 120}}, color = {0, 0, 127}));
    connect(logicalSwitch.u3, u_control_boolean) annotation(
      Line(points = {{58, 68}, {40, 68}, {40, 120}, {40, 120}}, color = {255, 0, 255}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component represents the control unit for optimized control. 
    
    <p>
    
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {2, -246}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
      experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
  end control_opt_SI_BooleanSI;

  model bus2SOBoolean_SO
    extends Modelica.Icons.Package;
    AixLib.BoundaryConditions.WeatherData.Bus controlBus annotation(
      Placement(visible = true, transformation(origin = {-99, -1}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_control_value annotation(
      Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanOutput y_control_boolean annotation(
      Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(y_control_boolean, controlBus.control_boolean) annotation(
      Line(points = {{110, 40}, {0, 40}, {0, 0}, {-98, 0}, {-98, 0}}, color = {255, 0, 255}));
    connect(y_control_value, controlBus.control_value) annotation(
      Line(points = {{110, -40}, {0, -40}, {0, 0}, {-98, 0}, {-98, 0}}, color = {0, 0, 127}));
    annotation(
      Documentation(info = "<html>
    <p>
    This cmoponent simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
      experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
  end bus2SOBoolean_SO;

  model Consumer_simple
    extends Modelica.Icons.Package;
    parameter Modelica.SIunits.Temperature T0 = 343.15 "Inital temperature" annotation(
      Dialog(tab = "General"));
    AixLib.FastHVAC.Components.Sinks.Sink sink(fluid(T0 = T0)) annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add1(k1 = -1) annotation(
      Placement(visible = true, transformation(origin = {44, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
      Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
      Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_sink annotation(
      Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_deltaT annotation(
      Placement(visible = true, transformation(origin = {108, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_Tin annotation(
      Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(u_sink, sink.Load) annotation(
      Line(points = {{-80, 120}, {-80, 80}, {0, 80}, {0, 11}}, color = {0, 0, 127}));
    connect(add1.y, y_deltaT) annotation(
      Line(points = {{44, 71}, {44, 80}, {108, 80}}, color = {0, 0, 127}));
    connect(TemperatureOutput.T, add1.u1) annotation(
      Line(points = {{52, 12}, {50, 12}, {50, 48}}, color = {0, 0, 127}));
    connect(enthalpyPort_a, TemperatureInput.enthalpyPort_a) annotation(
      Line(points = {{-110, 0}, {-59, 0}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_b, sink.enthalpyPort_a1) annotation(
      Line(points = {{-41, 0}, {-11, 0}}, color = {176, 0, 0}));
    connect(sink.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation(
      Line(points = {{11, 0}, {42, 0}}));
    connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
      Line(points = {{60, 0}, {104, 0}, {104, 0}, {110, 0}}, color = {176, 0, 0}));
    connect(y_Tin, TemperatureInput.T) annotation(
      Line(points = {{110, 40}, {-50, 40}, {-50, 12}, {-48, 12}}, color = {0, 0, 127}));
    connect(add1.u2, TemperatureInput.T) annotation(
      Line(points = {{38, 48}, {38, 48}, {38, 40}, {-50, 40}, {-50, 12}, {-48, 12}}, color = {0, 0, 127}));
    annotation(
      Diagram,
      Icon(graphics = {Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
  end Consumer_simple;

  model busbar_4consumer
    extends Modelica.Icons.Package;
    Modelica.Blocks.Interfaces.RealOutput y_DirectConsumptionCHP annotation(
      Placement(visible = true, transformation(origin = {210, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_ProductionCHP annotation(
      Placement(visible = true, transformation(origin = {-80, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput uProductionPV annotation(
      Placement(visible = true, transformation(origin = {-20, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput u_DemandHeatPump annotation(
      Placement(visible = true, transformation(origin = {-220, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_DemandHouses annotation(
      Placement(visible = true, transformation(origin = {-220, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_FeedInCHP annotation(
      Placement(visible = true, transformation(origin = {210, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DirectConsumptionPV annotation(
      Placement(visible = true, transformation(origin = {210, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_LoadToBattery annotation(
      Placement(visible = true, transformation(origin = {210, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_PVProductionToBattery annotation(
      Placement(visible = true, transformation(origin = {210, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.busbar_1consumer Busbar_CHP annotation(
      Placement(visible = true, transformation(origin = {-71, 153}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
    Simulationsumgebung.Components.busbar_1consumer Busbar_PV annotation(
      Placement(visible = true, transformation(origin = {-27, 91}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput u_EMob annotation(
      Placement(visible = true, transformation(origin = {-220, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_1 annotation(
      Placement(transformation(extent = {{-178, 30}, {-158, 50}})));
    Modelica.Blocks.Math.Add add annotation(
      Placement(transformation(extent = {{-140, 100}, {-120, 120}})));
    Modelica.Blocks.Interfaces.RealInput u_DemandElectrolyser annotation(
      Placement(visible = true, transformation(origin = {-220, 180}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    connect(Busbar_PV.y_GridLoad, y_LoadToBattery) annotation(
      Line(points = {{-27, 78.625}, {-27, -20}, {210, -20}}, color = {0, 0, 127}));
    connect(Busbar_PV.y_FeedIn, y_PVProductionToBattery) annotation(
      Line(points = {{-33.75, 78.625}, {-33.75, -40}, {210, -40}}, color = {0, 0, 127}));
    connect(uProductionPV, Busbar_PV.u_Production) annotation(
      Line(points = {{-20, 220}, {-20, 104.5}, {-20.25, 104.5}}, color = {0, 0, 127}));
    connect(Busbar_CHP.y_GridLoad, Busbar_PV.u_Demand) annotation(
      Line(points = {{-71, 140.625}, {-71, 128}, {-33.75, 128}, {-33.75, 104.5}}, color = {0, 0, 127}));
    connect(Busbar_PV.y_DirectConsumption, y_DirectConsumptionPV) annotation(
      Line(points = {{-20.25, 78.625}, {-20.25, 60}, {210, 60}}, color = {0, 0, 127}));
    connect(Busbar_CHP.y_FeedIn, y_FeedInCHP) annotation(
      Line(points = {{-77.75, 140.625}, {-77.75, 120}, {210, 120}}, color = {0, 0, 127}));
    connect(Busbar_CHP.y_DirectConsumption, y_DirectConsumptionCHP) annotation(
      Line(points = {{-64.25, 140.625}, {210, 140.625}, {210, 140}}, color = {0, 0, 127}));
    connect(u_ProductionCHP, Busbar_CHP.u_Production) annotation(
      Line(points = {{-80, 220}, {-80, 188}, {-64.25, 188}, {-64.25, 166.5}}, color = {0, 0, 127}));
    connect(u_DemandHeatPump, add3_1.u1) annotation(
      Line(points = {{-220, 120}, {-190, 120}, {-190, 48}, {-180, 48}}, color = {0, 0, 127}));
    connect(u_DemandHouses, add3_1.u2) annotation(
      Line(points = {{-220, 20}, {-200, 20}, {-200, 40}, {-180, 40}}, color = {0, 0, 127}));
    connect(u_EMob, add3_1.u3) annotation(
      Line(points = {{-220, -40}, {-190, -40}, {-190, 32}, {-180, 32}}, color = {0, 0, 127}));
    connect(add.y, Busbar_CHP.u_Demand) annotation(
      Line(points = {{-119, 110}, {-108, 110}, {-108, 180}, {-77.75, 180}, {-77.75, 166.5}}, color = {0, 0, 127}));
    connect(u_DemandElectrolyser, add.u1) annotation(
      Line(points = {{-220, 180}, {-142, 180}, {-142, 116}}, color = {0, 0, 127}));
    connect(add3_1.y, add.u2) annotation(
      Line(points = {{-157, 40}, {-150, 40}, {-150, 104}, {-142, 104}}, color = {0, 0, 127}));
    annotation(
      experiment(StartTime = 0, StopTime = 345600, Tolerance = 1e-06, Interval = 900),
      __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
      Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
      __OpenModelica_commandLineOptions = "");
  end busbar_4consumer;

  model busbar_1consumer
    extends Modelica.Icons.Package;
    Modelica.Blocks.Interfaces.RealInput u_Production annotation(
      Placement(visible = true, transformation(origin = {-220, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_Demand annotation(
      Placement(visible = true, transformation(origin = {-220, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_FeedIn annotation(
      Placement(visible = true, transformation(origin = {210, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption annotation(
      Placement(visible = true, transformation(origin = {210, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add1(k1 = -1, k2 = +1) annotation(
      Placement(visible = true, transformation(origin = {-110, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1 annotation(
      Placement(visible = true, transformation(origin = {-70, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch1 annotation(
      Placement(visible = true, transformation(origin = {-10, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch11 annotation(
      Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_GridLoad annotation(
      Placement(visible = true, transformation(origin = {210, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add3(k1 = +1, k2 = -1) annotation(
      Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = -1) annotation(
      Placement(visible = true, transformation(origin = {30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(gain1.y, y_GridLoad) annotation(
      Line(points = {{42, 20}, {72, 20}, {72, 0}, {210, 0}, {210, 0}}, color = {0, 0, 127}));
    connect(gain1.y, add3.u2) annotation(
      Line(points = {{42, 20}, {72, 20}, {72, 34}, {98, 34}}, color = {0, 0, 127}));
    connect(switch11.y, gain1.u) annotation(
      Line(points = {{2, 20}, {18, 20}, {18, 22}, {18, 22}, {18, 20}}, color = {0, 0, 127}));
    connect(add3.y, y_DirectConsumption) annotation(
      Line(points = {{121, 40}, {210, 40}}, color = {0, 0, 127}));
    connect(u_Demand, add3.u1) annotation(
      Line(points = {{-220, -40}, {-140, -40}, {-140, 46}, {98, 46}}, color = {0, 0, 127}));
    connect(add1.u1, u_Demand) annotation(
      Line(points = {{-122, -26}, {-140, -26}, {-140, -40}, {-220, -40}, {-220, -40}}, color = {0, 0, 127}));
    connect(u_Production, add1.u2) annotation(
      Line(points = {{-220, 40}, {-180, 40}, {-180, -14}, {-122, -14}, {-122, -14}}, color = {0, 0, 127}));
    connect(add1.y, switch1.u1) annotation(
      Line(points = {{-99, -20}, {-92, -20}, {-92, -48}, {-22, -48}}, color = {0, 0, 127}));
    connect(add1.y, switch11.u3) annotation(
      Line(points = {{-99, -20}, {-92, -20}, {-92, 12}, {-22, 12}}, color = {0, 0, 127}));
    connect(add1.y, greaterThreshold1.u) annotation(
      Line(points = {{-99, -20}, {-83, -20}, {-83, -18}, {-84, -18}, {-84, -20}, {-83, -20}}, color = {0, 0, 127}));
    connect(const.y, switch1.u3) annotation(
      Line(points = {{-98, 80}, {-32, 80}, {-32, -32}, {-22, -32}, {-22, -32}}, color = {0, 0, 127}));
    connect(const.y, switch11.u1) annotation(
      Line(points = {{-98, 80}, {-32, 80}, {-32, 28}, {-22, 28}, {-22, 28}}, color = {0, 0, 127}));
    connect(greaterThreshold1.y, switch11.u2) annotation(
      Line(points = {{-59, -20}, {-39, -20}, {-39, 20}, {-21, 20}, {-21, 20}, {-23, 20}, {-23, 20}}, color = {255, 0, 255}));
    connect(switch1.y, y_FeedIn) annotation(
      Line(points = {{1, -40}, {210, -40}}, color = {0, 0, 127}));
    connect(greaterThreshold1.y, switch1.u2) annotation(
      Line(points = {{-59, -20}, {-39, -20}, {-39, -40}, {-21, -40}, {-21, -39}, {-23, -39}, {-23, -40}}, color = {255, 0, 255}));
    annotation(
      experiment(StartTime = 0, StopTime = 345600, Tolerance = 1e-06, Interval = 900),
      __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
      Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
      Icon(coordinateSystem(extent = {{-80, -80}, {80, 80}}, initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name"), Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
      __OpenModelica_commandLineOptions = "");
  end busbar_1consumer;

  model Producer_SolarThermalCollector "A solar thermal collector"
    extends Modelica.Icons.Package;
    replaceable package Medium = AixLib.Media.Water constrainedby Modelica.Media.Interfaces.PartialMedium "Medium model";
    Sources.Boundary_pT source(nPorts = 1, redeclare package Medium = Medium, p = system.p_ambient + solarThermal.pressureDropCoeff * (solarThermal.m_flow_nominal / 995) ^ 2 + pipe.dp_nominal) annotation(
      Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
    Sources.Boundary_pT sink(nPorts = 1, redeclare package Medium = Medium, p = system.p_ambient) annotation(
      Placement(transformation(extent = {{100, -10}, {80, 10}})));
    AixLib.Fluid.Sensors.MassFlowRate massFlowSensor(redeclare package Medium = Medium) annotation(
      Placement(transformation(extent = {{-54, -10}, {-34, 10}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort T1(redeclare package Medium = Medium, m_flow_nominal = system.m_flow_nominal) annotation(
      Placement(transformation(extent = {{-28, -10}, {-8, 10}})));
    AixLib.Fluid.FixedResistances.PressureDrop pipe(redeclare package Medium = Medium, m_flow_nominal = system.m_flow_nominal, dp_nominal = 200) annotation(
      Placement(transformation(extent = {{54, -10}, {74, 10}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort T2(redeclare package Medium = Medium, m_flow_nominal = system.m_flow_nominal) annotation(
      Placement(transformation(extent = {{28, -10}, {48, 10}})));
    Modelica.Blocks.Sources.CombiTimeTable hotSummerDay(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 21, 0; 3600, 20.6, 0; 7200, 20.5, 0; 10800, 20.4, 0; 14400, 20, 6; 18000, 20.5, 106; 21600, 22.4, 251; 25200, 24.1, 402; 28800, 26.3, 540; 32400, 28.4, 657; 36000, 30, 739; 39600, 31.5, 777; 43200, 31.5, 778; 46800, 32.5, 737; 50400, 32.5, 657; 54000, 32.5, 544; 57600, 32.5, 407; 61200, 32.5, 257; 64800, 31.6, 60; 68400, 30.8, 5; 72000, 22.9, 0; 75600, 21.2, 0; 79200, 20.6, 0; 82800, 20.3, 0], offset = {273.15, 0.01}) annotation(
      Placement(transformation(extent = {{-26, 62}, {-6, 82}})));
    inner Modelica.Fluid.System system(m_flow_start = system.m_flow_nominal, use_eps_Re = true, m_flow_nominal = 1.5 * solarThermal.A / 60 * 995 / 1000, p_ambient = 300000) annotation(
      Placement(transformation(extent = {{-90, 70}, {-70, 90}})));
    AixLib.Utilities.Interfaces.SolarRad_in IcTotalRad "Solar radiation in W/m2" annotation(
      Placement(visible = true, transformation(extent = {{-124, -132}, {-100, -106}}, rotation = 0), iconTransformation(extent = {{-136, -20}, {-100, 18}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression realExpression(y = IcTotalRad.I) annotation(
      Placement(visible = true, transformation(extent = {{-96, -130}, {-76, -110}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput T_air annotation(
      Placement(visible = true, transformation(origin = {-120, -180}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource annotation(
      Placement(visible = true, transformation(origin = {100, 168}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1 annotation(
      Placement(visible = true, transformation(origin = {100, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.Fluid.Solar.Thermal.SolarThermal solarThermal(redeclare package Medium = Medium, A = 2000, Collector = AixLib.DataBase.SolarThermal.FlatCollector(), m_flow_nominal = 0.01, volPip = 1) annotation(
      Placement(visible = true, transformation(origin = {100, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.Fluid.Sensors.TemperatureTwoPort temperatureSensor(redeclare package Medium = Medium, m_flow_nominal = 0.01) annotation(
      Placement(visible = true, transformation(origin = {100, 10}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    Modelica.Blocks.Continuous.LimPID PI(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.05, Ti = 60, yMax = 0.999, yMin = 0) annotation(
      Placement(visible = true, transformation(origin = {156, 10}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    Modelica.Blocks.Math.Add add(k2 = -1) annotation(
      Placement(visible = true, transformation(origin = {150, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Sources.Constant const1(k = 1) annotation(
      Placement(visible = true, transformation(origin = {127, 33}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
    AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium, m_flow_nominal = 0.01) annotation(
      Placement(visible = true, transformation(origin = {100, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.Fluid.Sources.MassFlowSource_T boundary(redeclare package Medium = Medium, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
      Placement(visible = true, transformation(origin = {100, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.Fluid.Actuators.Valves.SimpleValve simpleValve(redeclare package Medium = Medium, Kvs = 2) annotation(
      Placement(visible = true, transformation(origin = {100, 69}, extent = {{-11, 10}, {11, -10}}, rotation = 90)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1 annotation(
      Placement(visible = true, transformation(origin = {100, -210}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {50, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel1 annotation(
      Placement(visible = true, transformation(origin = {100, -154}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature annotation(
      Placement(visible = true, transformation(origin = {100, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealInput u_Temp_Regelung annotation(
      Placement(visible = true, transformation(origin = {-120, -10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = 10) annotation(
      Placement(visible = true, transformation(origin = {150, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Interfaces.RealOutput y_SolarThermalCollector_Qth = solarThermal.heater.Q_flow annotation(
      Placement(visible = true, transformation(origin = {190, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanOutput y_SolarThermalCollector_OnOff annotation(
      Placement(visible = true, transformation(origin = {190, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold = 0.1) annotation(
      Placement(visible = true, transformation(origin = {150, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(greaterThreshold1.u, gain1.y) annotation(
      Line(points = {{138, -70}, {130, -70}, {130, -20}, {172, -20}, {172, 104}, {150, 104}, {150, 102}, {150, 102}, {150, 104}}, color = {0, 0, 127}));
    connect(greaterThreshold1.y, y_SolarThermalCollector_OnOff) annotation(
      Line(points = {{162, -70}, {182, -70}, {182, -70}, {190, -70}}, color = {255, 0, 255}));
    connect(gain1.y, boundary.m_flow_in) annotation(
      Line(points = {{150, 104}, {172, 104}, {172, -138}, {92, -138}, {92, -122}, {92, -122}}, color = {0, 0, 127}));
    connect(fluidSource.dotm, gain1.y) annotation(
      Line(points = {{98, 160}, {98, 160}, {98, 126}, {150, 126}, {150, 104}, {150, 104}}, color = {0, 0, 127}));
    connect(gain1.u, add.y) annotation(
      Line(points = {{150, 80}, {150, 80}, {150, 62}, {150, 62}}, color = {0, 0, 127}));
    connect(u_Temp_Regelung, PI.u_s) annotation(
      Line(points = {{-120, -10}, {156, -10}, {156, -2}, {156, -2}}, color = {0, 0, 127}));
    connect(boundary.T_in, temperature.T) annotation(
      Line(points = {{96, -122}, {96, -122}, {96, -134}, {80, -134}, {80, -178}, {88, -178}, {88, -178}}, color = {0, 0, 127}));
    connect(vessel1.enthalpyPort_a, temperature.enthalpyPort_b) annotation(
      Line(points = {{100, -162}, {100, -162}, {100, -170}, {100, -170}}, color = {176, 0, 0}));
    connect(temperature.enthalpyPort_a, enthalpyPort_a1) annotation(
      Line(points = {{100, -188}, {100, -188}, {100, -210}, {100, -210}}, color = {176, 0, 0}));
    connect(temperatureSensor.T, fluidSource.T_fluid) annotation(
      Line(points = {{112, 10}, {118, 10}, {118, 140}, {104, 140}, {104, 160}, {104, 160}}, color = {0, 0, 127}));
    connect(boundary.ports[1], senTem.port_a) annotation(
      Line(points = {{100, -100}, {100, -100}, {100, -80}, {100, -80}}, color = {0, 127, 255}));
    connect(simpleValve.port_a, temperatureSensor.port_b) annotation(
      Line(points = {{100, 58}, {100, 58}, {100, 20}, {100, 20}}, color = {0, 127, 255}));
    connect(simpleValve.opening, add.y) annotation(
      Line(points = {{108, 70}, {150, 70}, {150, 62}, {150, 62}}, color = {0, 0, 127}));
    connect(PI.y, add.u2) annotation(
      Line(points = {{156, 22}, {156, 22}, {156, 38}, {156, 38}}, color = {0, 0, 127}));
    connect(temperatureSensor.T, PI.u_m) annotation(
      Line(points = {{112, 10}, {142, 10}, {142, 10}, {144, 10}}, color = {0, 0, 127}));
    connect(const1.y, add.u1) annotation(
      Line(points = {{134, 34}, {144, 34}, {144, 38}, {144, 38}}, color = {0, 0, 127}));
    connect(fluidSource.enthalpyPort_b, enthalpyPort_b1) annotation(
      Line(points = {{101, 178}, {100, 178}, {100, 210}}, color = {176, 0, 0}));
    annotation(
      Diagram(coordinateSystem(extent = {{-100, -200}, {180, 200}})),
      Icon(coordinateSystem(extent = {{-80, -80}, {80, 80}}, initialScale = 0.1), graphics = {Text(lineColor = {0, 0, 255}, extent = {{-200, -100}, {200, -200}}, textString = "Solarthermie")}),
      __OpenModelica_commandLineOptions = "",
      uses(Modelica(version = "3.2.3"), AixLib(version = "0.7.3")),
      version = "");
  end Producer_SolarThermalCollector;

  model StorageSolarCollector
    extends Modelica.Icons.Package;
    import AixLib;
    replaceable package Medium = AixLib.Media.Water;
    AixLib.Fluid.Movers.Pump pump(ControlStrategy = 1, redeclare package Medium = Medium, m_flow_small = 1e-4) annotation(
      Placement(visible = true, transformation(origin = {-40, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.Fluid.Sources.Boundary_pT boundary_p(nPorts = 1, redeclare package Medium = Medium) annotation(
      Placement(transformation(extent = {{-86, 70}, {-66, 90}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {36, 70})));
    Modelica.Fluid.Pipes.DynamicPipe pipe(redeclare package Medium = Medium, length = 10, diameter = 0.05) annotation(
      Placement(visible = true, transformation(extent = {{-6, -10}, {14, 10}}, rotation = 0)));
    AixLib.Fluid.Solar.Thermal.SolarThermal solarThermal(Collector = AixLib.DataBase.SolarThermal.FlatCollector(), A = 20, redeclare package Medium = Medium, m_flow_nominal = 0.01, volPip = 1) annotation(
      Placement(transformation(extent = {{24, -10}, {44, 10}})));
    AixLib.Fluid.Actuators.Valves.SimpleValve simpleValve(Kvs = 2, redeclare package Medium = Medium, m_flow_small = 1e-4) annotation(
      Placement(transformation(extent = {{-10, 9}, {10, -9}}, rotation = 90, origin = {69, 42})));
    AixLib.Fluid.Sensors.TemperatureTwoPort temperatureSensor(redeclare package Medium = Medium, m_flow_nominal = 0.01) annotation(
      Placement(transformation(extent = {{48, -10}, {68, 10}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort temperatureSensorIn(redeclare package Medium = Medium, m_flow_nominal = 0.01) annotation(
      Placement(visible = true, transformation(extent = {{-36, -16}, {-16, 14}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PI(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.05, Ti = 60, yMax = 0.999, yMin = 0) annotation(
      Placement(transformation(extent = {{-6, 6}, {6, -6}}, rotation = 90, origin = {90, 14})));
    Modelica.Blocks.Sources.Constant const(k = 273.15 + 70) annotation(
      Placement(transformation(extent = {{74, -10}, {80, -4}})));
    Modelica.Blocks.Math.Add add(k2 = -1) annotation(
      Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 90, origin = {88, 30})));
    Modelica.Blocks.Sources.Constant const1(k = 1) annotation(
      Placement(transformation(extent = {{70, 20}, {78, 28}})));
    Modelica.Blocks.Sources.CombiTimeTable hotSummerDay(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 21, 0; 3600, 20.6, 0; 7200, 20.5, 0; 10800, 20.4, 0; 14400, 20, 6; 18000, 20.5, 106; 21600, 22.4, 251; 25200, 24.1, 402; 28800, 26.3, 540; 32400, 28.4, 657; 36000, 30, 739; 39600, 31.5, 777; 43200, 31.5, 778; 46800, 32.5, 737; 50400, 32.5, 657; 54000, 32.5, 544; 57600, 32.5, 407; 61200, 32.5, 257; 64800, 31.6, 60; 68400, 30.8, 5; 72000, 22.9, 0; 75600, 21.2, 0; 79200, 20.6, 0; 82800, 20.3, 0], offset = {273.15, 0.01}) annotation(
      Placement(transformation(extent = {{10, 32}, {30, 52}})));
  equation
    connect(booleanExpression.y, pump.IsNight) annotation(
      Line(points = {{25, 70}, {-30, 70}}, color = {255, 0, 255}));
    connect(hotSummerDay.y[2], solarThermal.Irradiation) annotation(
      Line(points = {{31, 42}, {31, 10}, {34, 10}}, color = {0, 0, 127}));
    connect(hotSummerDay.y[1], solarThermal.T_air) annotation(
      Line(points = {{31, 42}, {31, 22}, {28, 22}, {28, 10}}, color = {0, 0, 127}));
    connect(simpleValve.port_b, pump.port_a) annotation(
      Line(points = {{69, 52}, {68, 52}, {68, 80}, {-40, 80}}, color = {0, 127, 255}));
    connect(solarThermal.port_b, temperatureSensor.port_a) annotation(
      Line(points = {{44, 0}, {48, 0}}, color = {0, 127, 255}));
    connect(temperatureSensor.port_b, simpleValve.port_a) annotation(
      Line(points = {{68, 0}, {68, 32}, {69, 32}}, color = {0, 127, 255}));
    connect(const.y, PI.u_s) annotation(
      Line(points = {{80.3, -7}, {90, -7}, {90, 6.8}}, color = {0, 0, 127}));
    connect(PI.y, add.u2) annotation(
      Line(points = {{90, 20.6}, {90, 25.2}, {90.4, 25.2}}, color = {0, 0, 127}));
    connect(add.y, simpleValve.opening) annotation(
      Line(points = {{88, 34.4}, {88, 42}, {76.2, 42}}, color = {0, 0, 127}));
    connect(boundary_p.ports[1], pump.port_a) annotation(
      Line(points = {{-66, 80}, {-40, 80}}, color = {0, 127, 255}));
    connect(temperatureSensor.T, PI.u_m) annotation(
      Line(points = {{58, 11}, {58, 14}, {82.8, 14}}, color = {0, 0, 127}));
    connect(const1.y, add.u1) annotation(
      Line(points = {{78.4, 24}, {85.6, 24}, {85.6, 25.2}}, color = {0, 0, 127}));
    connect(pipe.port_b, solarThermal.port_a) annotation(
      Line(points = {{14, 0}, {24, 0}, {24, 0}, {24, 0}}, color = {0, 127, 255}));
    connect(temperatureSensorIn.port_b, pipe.port_a) annotation(
      Line(points = {{-16, 0}, {-6, 0}, {-6, 0}, {-6, 0}}, color = {0, 127, 255}));
    connect(temperatureSensorIn.port_a, pump.port_b) annotation(
      Line(points = {{-36, 0}, {-40, 0}, {-40, 60}, {-40, 60}}, color = {0, 127, 255}));
    annotation(
      experiment(StopTime = 172800, Interval = 60),
      Documentation(info = "<html>
     <h4><font color=\"#008000\">Overview</font></h4>
     <p>This is a simple example of a storage and a solar collector.</p>
     </html>", revisions = "<html>
     <ul>
     <li><i>October 11, 2016</i> by Marcus Fuchs:<br/>Replace pipe</li>
     <li><i>April 2016&nbsp;</i>
        by Peter Remmen:<br/>
        Replace TempAndRad model</li>
     <li><i>November 2014&nbsp;</i>
        by Marcus Fuchs:<br/>
        Changed model to use Annex 60 base class</li>
     <li><i>13.12.2013</i>
           by Sebastian Stinner:<br/>
          implemented</li>
     </ul>
     </html>"));
  end StorageSolarCollector;

  model Producer_SolarThermalCollector_Dummy "Dummy for a solar thermal collector"
    extends Modelica.Icons.Package;
    Modelica.Blocks.Interfaces.RealInput u_Irradiation annotation(
      Placement(visible = true, transformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180), iconTransformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput u_T_air annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {0, -70}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {0, 70}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
      Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_dotQ = abs1.y * 4178 * (TemperatureOutput.T - TemperatureInput.T) annotation(
      Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate annotation(
      Placement(visible = true, transformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource annotation(
      Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel annotation(
      Placement(visible = true, transformation(origin = {-34, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const1(k = 5) annotation(
      Placement(visible = true, transformation(origin = {66, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Sine sine(amplitude = 0.0001, freqHz = 1 / (3600 * 48)) annotation(
      Placement(visible = true, transformation(origin = {-82, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Abs abs1 annotation(
      Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add annotation(
      Placement(visible = true, transformation(origin = {38, -28}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
  equation
    connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
      Line(points = {{0, 79}, {0, 110}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_a, enthalpyPort_a) annotation(
      Line(points = {{0, -79}, {0, -110}}, color = {176, 0, 0}));
    connect(vessel.enthalpyPort_a, massFlowRate.enthalpyPort_b) annotation(
      Line(points = {{-26, -10}, {0, -10}, {0, -20}, {0, -20}}, color = {176, 0, 0}));
    connect(massFlowRate.enthalpyPort_a, TemperatureInput.enthalpyPort_b) annotation(
      Line(points = {{0, -38}, {0, -38}, {0, -60}, {0, -60}}, color = {176, 0, 0}));
    connect(TemperatureOutput.enthalpyPort_a, fluidSource.enthalpyPort_b) annotation(
      Line(points = {{0, 62}, {0, 62}, {0, 50}, {2, 50}}, color = {176, 0, 0}));
    connect(sine.y, abs1.u) annotation(
      Line(points = {{-70, 20}, {-58, 20}, {-58, 20}, {-58, 20}}, color = {0, 0, 127}));
    connect(abs1.y, fluidSource.dotm) annotation(
      Line(points = {{-34, 20}, {-2, 20}, {-2, 32}, {-2, 32}}, color = {0, 0, 127}));
    connect(TemperatureInput.T, add.u2) annotation(
      Line(points = {{12, -68}, {32, -68}, {32, -40}, {32, -40}}, color = {0, 0, 127}));
    connect(const1.y, add.u1) annotation(
      Line(points = {{56, -60}, {44, -60}, {44, -40}, {44, -40}}, color = {0, 0, 127}));
    connect(add.y, fluidSource.T_fluid) annotation(
      Line(points = {{38, -16}, {38, -16}, {38, 20}, {4, 20}, {4, 32}, {4, 32}}, color = {0, 0, 127}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
  end Producer_SolarThermalCollector_Dummy;

  model Producer_Boiler_opt2 "Gasboiler with simple and optimized control and with pump"
    extends Modelica.Icons.Package;
    parameter Modelica.SIunits.Temperature T_start = 353.15 "Inital temperature" annotation(
      Dialog(tab = "General"));
    parameter Modelica.SIunits.Temperature T_Out = 353.15 "Output temperature" annotation(
      Dialog(tab = "General"));
    parameter Modelica.SIunits.Temperature uLow = 341.15 "Value of deltaT for switching on" annotation(
      Dialog(tab = "General"));
    parameter Modelica.SIunits.Temperature uHigh = 343.15 "Value of deltaT for switching off" annotation(
      Dialog(tab = "General"));
    parameter Real Q_nom = 200000 "Nominal power of gasboiler" annotation(
      Dialog(tab = "General"));
    parameter Real Q_min = 200000 * 0.0 "Minimal power of gasboiler" annotation(
      Dialog(tab = "General"));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
      Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
    Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.HeatGenerators.Boiler.Boiler Boiler(T_start = T_start, paramBoiler = AixLib.FastHVAC.Data.Boiler.General.Boiler_Vitocrossal200_311kW(Q_nom = Q_nom, Q_min = Q_min)) annotation(
      Placement(visible = true, transformation(origin = {22, 0}, extent = {{-20, -22}, {20, 22}}, rotation = 0)));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
      Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation(
      Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
      Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
      Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotE = Boiler.dotE_gas annotation(
      Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput y_dotQ = Boiler.heater.Q_flow annotation(
      Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.LimPID pid(Ti = 1, controllerType = .Modelica.Blocks.Types.SimpleController.PID, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.0001, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0) annotation(
      Placement(visible = true, transformation(origin = {-80, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Logical.Switch switch1 annotation(
      Placement(visible = true, transformation(origin = {-40, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-95, 43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uHigh = uHigh, uLow = uLow) annotation(
      Placement(visible = true, transformation(origin = {-40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0.000000000001, y_start = 0.000000000001) annotation(
      Placement(visible = true, transformation(origin = {30, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump annotation(
      Placement(visible = true, transformation(origin = {0, -70}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    Modelica.Blocks.Sources.Constant const1(k = T_Out) annotation(
      Placement(visible = true, transformation(origin = {70, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  equation
    connect(Boiler.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation(
      Line(points = {{32, 0}, {40, 0}, {40, 42}}, color = {176, 0, 0}));
    connect(TemperatureInput.enthalpyPort_b, Boiler.enthalpyPort_a1) annotation(
      Line(points = {{-60, -20}, {-60, 0}, {12, 0}}, color = {176, 0, 0}));
    connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
      Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
    connect(control_opt_SI_BooleanSI.y_control_boolean, Boiler.onOff_boiler) annotation(
      Line(points = {{1, 26}, {28, 26}, {28, 15}}, color = {255, 0, 255}));
    connect(control_opt_SI_BooleanSI.y_control, Boiler.dotQ_rel) annotation(
      Line(points = {{1, 20}, {18, 20}, {18, 15}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation(
      Line(points = {{-10, 32}, {-10, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
    connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation(
      Line(points = {{-4, 32}, {-4, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
    connect(pid.u_s, u_T_setpoint_specification) annotation(
      Line(points = {{-92, 12}, {-92, -60}, {-120, -60}}, color = {0, 0, 127}));
    connect(pid.u_m, u_T_setpoint) annotation(
      Line(points = {{-80, 24}, {-80, 70}, {80, 70}, {80, -60}, {120, -60}}, color = {0, 0, 127}));
    connect(const.y, switch1.u3) annotation(
      Line(points = {{-90, 44}, {-60, 44}, {-60, 28}, {-52, 28}, {-52, 28}}, color = {0, 0, 127}));
    connect(hysteresis.y, switch1.u2) annotation(
      Line(points = {{-52, 50}, {-66, 50}, {-66, 20}, {-52, 20}, {-52, 20}}, color = {255, 0, 255}));
    connect(u_T_setpoint, hysteresis.u) annotation(
      Line(points = {{120, -60}, {80, -60}, {80, 70}, {-20, 70}, {-20, 50}, {-28, 50}, {-28, 50}}, color = {0, 0, 127}));
    connect(pump.enthalpyPort_a, enthalpyPort_a) annotation(
      Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
    connect(pump.dotm_setValue, PID_Pump.y) annotation(
      Line(points = {{8, -70}, {19, -70}}, color = {0, 0, 127}));
    connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation(
      Line(points = {{-60, -38}, {-60, -38}, {-60, -50}, {0, -50}, {0, -60}, {0, -60}}, color = {176, 0, 0}));
    connect(const1.y, PID_Pump.u_m) annotation(
      Line(points = {{60, -90}, {30, -90}, {30, -82}, {30, -82}}, color = {0, 0, 127}));
    connect(TemperatureOutput.T, PID_Pump.u_s) annotation(
      Line(points = {{52, 52}, {60, 52}, {60, -70}, {42, -70}, {42, -70}}, color = {0, 0, 127}));
    connect(pid.y, control_opt_SI_BooleanSI.u_control_standard) annotation(
      Line(points = {{-68, 12}, {-60, 12}, {-60, 4}, {-22, 4}, {-22, 20}, {-22, 20}}, color = {0, 0, 127}));
    connect(switch1.u1, pid.y) annotation(
      Line(points = {{-52, 12}, {-68, 12}, {-68, 12}, {-68, 12}}, color = {0, 0, 127}));
    annotation(
      Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
  end Producer_Boiler_opt2;
  annotation(
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
    Documentation(info = "<html>
      <p>Im package Components werden alle selbst erstellten Komponenten der unterschiedlichen Modelle abgelegt.</p>
      <p>Erstellt wurden die Komponenten durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Rectangle(origin = {0.0, 35.1488}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Rectangle(origin = {0.0, -34.8512}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Line(origin = {-51.25, 0.0}, points = {{21.25, -35.0}, {-13.75, -35.0}, {-13.75, 35.0}, {6.25, 35.0}}), Polygon(origin = {-40.0, 35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10.0, 0.0}, {-5.0, 5.0}, {-5.0, -5.0}}), Line(origin = {51.25, 0.0}, points = {{-21.25, 35.0}, {13.75, 35.0}, {13.75, -35.0}, {-6.25, -35.0}}), Polygon(origin = {40.0, -35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10.0, 0.0}, {5.0, 5.0}, {5.0, -5.0}})}));
end Components;
