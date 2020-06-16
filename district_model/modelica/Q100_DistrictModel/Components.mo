within Q100_DistrictModel;
package Components
    extends Modelica.Icons.Package;

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
      Q100_DistrictModel.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation (
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
        Line(points = {{32, 0}, {40, 0}, {40, 42}}, color = {176, 0, 0}));
      connect(TemperatureInput.enthalpyPort_b, Boiler.enthalpyPort_a1) annotation (
        Line(points = {{-60, -20}, {-60, 0}, {12, 0}}, color = {176, 0, 0}));
      connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation (
        Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
      connect(control_opt_SI_BooleanSI.y_control_boolean, Boiler.onOff_boiler) annotation (
        Line(points = {{1, 26}, {28, 26}, {28, 15}}, color = {255, 0, 255}));
      connect(control_opt_SI_BooleanSI.y_control, Boiler.dotQ_rel) annotation (
        Line(points = {{1, 20}, {18, 20}, {18, 15}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation (
        Line(points = {{-10, 32}, {-10, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation (
        Line(points = {{-4, 32}, {-4, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
      connect(pid.u_s, u_T_setpoint_specification) annotation (
        Line(points = {{-92, 12}, {-92, -60}, {-120, -60}}, color = {0, 0, 127}));
      connect(pid.u_m, u_T_setpoint) annotation (
        Line(points = {{-80, 24}, {-80, 70}, {80, 70}, {80, -60}, {120, -60}}, color = {0, 0, 127}));
      connect(const.y, switch1.u3) annotation (
        Line(points = {{-90, 44}, {-60, 44}, {-60, 28}, {-52, 28}, {-52, 28}}, color = {0, 0, 127}));
      connect(hysteresis.y, switch1.u2) annotation (
        Line(points = {{-52, 50}, {-66, 50}, {-66, 20}, {-52, 20}, {-52, 20}}, color = {255, 0, 255}));
      connect(u_T_setpoint, hysteresis.u) annotation (
        Line(points = {{120, -60}, {80, -60}, {80, 70}, {-20, 70}, {-20, 50}, {-28, 50}, {-28, 50}}, color = {0, 0, 127}));
      connect(pump.enthalpyPort_a, enthalpyPort_a) annotation (
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
      connect(pump.dotm_setValue, PID_Pump.y) annotation (
        Line(points = {{8, -70}, {19, -70}}, color = {0, 0, 127}));
      connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation (
        Line(points = {{-60, -38}, {-60, -38}, {-60, -50}, {0, -50}, {0, -60}, {0, -60}}, color = {176, 0, 0}));
      connect(const1.y, PID_Pump.u_m) annotation (
        Line(points = {{60, -90}, {30, -90}, {30, -82}, {30, -82}}, color = {0, 0, 127}));
      connect(TemperatureOutput.T, PID_Pump.u_s) annotation (
        Line(points = {{52, 52}, {60, 52}, {60, -70}, {42, -70}, {42, -70}}, color = {0, 0, 127}));
      connect(pid.y, control_opt_SI_BooleanSI.u_control_standard) annotation (
        Line(points = {{-68, 12}, {-60, 12}, {-60, 4}, {-22, 4}, {-22, 20}, {-22, 20}}, color = {0, 0, 127}));
      connect(switch1.u1, pid.y) annotation (
        Line(points = {{-52, 12}, {-68, 12}, {-68, 12}, {-68, 12}}, color = {0, 0, 127}));
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
      Q100_DistrictModel.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation (
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
        Line(points = {{60, -80}, {20, -80}, {20, -72}, {20, -72}}, color = {0, 0, 127}));
      connect(PID_pump.y, pump.dotm_setValue) annotation (
        Line(points = {{10, -60}, {-50, -60}, {-50, -60}, {-52, -60}}, color = {0, 0, 127}));
      connect(pump.enthalpyPort_a, enthalpyPort_a) annotation (
        Line(points = {{-60, -70}, {-60, -70}, {-60, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
      connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation (
        Line(points = {{-60, -38}, {-60, -38}, {-60, -50}, {-60, -50}}, color = {176, 0, 0}));
      connect(TemperatureOutput.T, PID_pump.u_s) annotation (
        Line(points = {{52, 52}, {60, 52}, {60, -60}, {32, -60}, {32, -60}}, color = {0, 0, 127}));
      connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation (
        Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
      connect(u_T_setpoint_specification, add.u2) annotation (
        Line(points = {{-120, -60}, {-90, -60}, {-90, 54}, {-82, 54}}, color = {0, 0, 127}));
      connect(add.y, hysteresis.u) annotation (
        Line(points = {{-59, 60}, {-52, 60}}, color = {0, 0, 127}));
      connect(add.u1, u_T_setpoint) annotation (
        Line(points = {{-82, 66}, {-90, 66}, {-90, 90}, {90, 90}, {90, -60}, {120, -60}}, color = {0, 0, 127}));
      connect(booleanToReal.y, control_opt_SI_BooleanSI.u_control_standard) annotation (
        Line(points = {{-48, 20}, {-26, 20}}, color = {0, 0, 127}));
      connect(booleanToReal.u, hysteresis.y) annotation (
        Line(points = {{-72, 20}, {-80, 20}, {-80, 40}, {-20, 40}, {-20, 60}, {-29, 60}}, color = {255, 0, 255}));
      connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation (
        Line(points = {{-14, 32}, {-14, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation (
        Line(points = {{-8, 32}, {-8, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
      connect(control_opt_SI_BooleanSI.y_control, chp.P_elRel) annotation (
        Line(points = {{-2, 20}, {16, 20}, {16, 0}, {16, 0}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.y_control_boolean, chp.onOff) annotation (
        Line(points = {{-2, 26}, {6, 26}, {6, 0}, {6, 0}}, color = {255, 0, 255}));
      connect(chp.enthalpyPort_a, TemperatureInput.enthalpyPort_b) annotation (
        Line(points = {{0, -10}, {-60, -10}, {-60, -20}, {-60, -20}}, color = {176, 0, 0}));
      connect(chp.enthalpyPort_b, TemperatureOutput.enthalpyPort_a) annotation (
        Line(points = {{20, -10}, {40, -10}, {40, 42}, {40, 42}}, color = {176, 0, 0}));
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
      Q100_DistrictModel.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation (
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
        model                                                                              PerDataHea =
          AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D
          (                                                                                                                                                                    dataTable = AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(tableQdot_con = [0, -15, -7, 2, 7, 10, 20, 30; 35, 3020 * Scale_Factor, 3810 * Scale_Factor, 2610 * Scale_Factor, 3960 * Scale_Factor, 4340 * Scale_Factor, 5350 * Scale_Factor, 6610 * Scale_Factor; 45, 3020 * Scale_Factor, 3780 * Scale_Factor, 2220 * Scale_Factor, 3870 * Scale_Factor, 4120 * Scale_Factor, 5110 * Scale_Factor, 6310 * Scale_Factor; 55, 3120 * Scale_Factor, 3790 * Scale_Factor, 2430 * Scale_Factor, 3610 * Scale_Factor, 3910 * Scale_Factor, 4850 * Scale_Factor, 6000 * Scale_Factor], tableP_ele = [0, -15, -7, 2, 7, 10, 20, 30; 35, 1290 * Scale_Factor, 1310 * Scale_Factor, 730 * Scale_Factor, 870 * Scale_Factor, 850 * Scale_Factor, 830 * Scale_Factor, 780 * Scale_Factor; 45, 1550 * Scale_Factor, 1600 * Scale_Factor, 870 * Scale_Factor, 1110 * Scale_Factor, 1090 * Scale_Factor, 1080 * Scale_Factor, 1040 * Scale_Factor; 55, 1870 * Scale_Factor, 1940 * Scale_Factor, 1170 * Scale_Factor, 1370 * Scale_Factor, 1370 * Scale_Factor, 1370 * Scale_Factor, 1350 * Scale_Factor], mFlow_conNom = 3960 / 4180 / 5 * Scale_Factor, mFlow_evaNom = 2250 * 1.2 / 3600 * Scale_Factor, tableUppBou = [-20, 50; -10, 60; 30, 60; 35, 55], tableLowBou = [-20, 25; 25, 25; 35, 35])), redeclare
        model                                                                                                                                                                                                         PerDataChi =
          AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D
          (                                                                                                                                                                                                        dataTable = AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(tableQdot_con = [0, 20, 25, 27, 30, 35; 7, 2540 * Scale_Factor, 2440 * Scale_Factor, 2370 * Scale_Factor, 2230 * Scale_Factor, 2170 * Scale_Factor; 18, 5270 * Scale_Factor, 5060 * Scale_Factor, 4920 * Scale_Factor, 4610 * Scale_Factor, 4500 * Scale_Factor], tableP_ele = [0, 20, 25, 27, 30, 35; 7, 1380 * Scale_Factor, 1590 * Scale_Factor, 1680 * Scale_Factor, 1800 * Scale_Factor, 1970 * Scale_Factor; 18, 950 * Scale_Factor, 1060 * Scale_Factor, 1130 * Scale_Factor, 1200 * Scale_Factor, 1350 * Scale_Factor], mFlow_conNom = 3960 / 4180 / 5 * Scale_Factor, mFlow_evaNom = 2250 * 1.2 / 3600 * Scale_Factor, tableUppBou = [20, 20; 35, 20], tableLowBou = [20, 5; 35, 5])), CCon = 100, CEva = 100, GCon = 5, GEva = 5, Q_useNominal = 0, TAmbCon_nominal = 288.15, TCon_start(displayUnit = "K"), TEva_start(displayUnit = "K"), VCon = 0.4, VEva = 0.04, allowFlowReversalEva = true, deltaM_con = 0.1, deltaM_eva = 0.1, mFlow_conNominal = 0.5, mFlow_evaNominal = 0.5, refIneFre_constant = 1, transferHeat = true, use_ConCap = false, use_EvaCap = false, use_autoCalc = false, use_refIne = true, use_revHP = true) annotation (
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
      connect(booleanToReal.y, control_opt_SI_BooleanSI.u_control_standard) annotation (
        Line(points = {{-81, -20}, {-58, -20}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation (
        Line(points = {{-46, -8}, {-46, 110}, {-80, 110}, {-80, 160}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation (
        Line(points = {{-40, -8}, {-40, 160}}, color = {255, 0, 255}));
      connect(heatPump.enthalpyPort_a, TemperatureInput.enthalpyPort_b) annotation (
        Line(points = {{0, 15.3334}, {0, 15.3334}, {0, -49}, {-0.1, -49}}, color = {176, 0, 0}));
      connect(TemperatureOutput.enthalpyPort_a, heatPump.enthalpyPort_b) annotation (
        Line(points = {{-0.1, 89.2}, {-0.1, 89.2}, {-0.1, 42}, {0, 42}}, color = {176, 0, 0}));
      connect(hysteresis.y, booleanToReal.u) annotation (
        Line(points = {{-69, -54}, {-60, -54}, {-60, -36}, {-120, -36}, {-120, -20}, {-104, -20}, {-104, -20}}, color = {255, 0, 255}));
      connect(control_opt_SI_BooleanSI.y_control, heatPump.nSet) annotation (
        Line(points = {{-35, -20}, {-6, -20}, {-6, 13.2001}, {-5.33333, 13.2001}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.y_control_boolean, heatPump.modeSet) annotation (
        Line(points = {{-35, -14}, {-10, -14}, {-10, 13.2001}, {-10.4, 13.2001}}, color = {255, 0, 255}));
      connect(vessel.enthalpyPort_a, heatPump.enthalpyPort_b1) annotation (
        Line(points = {{-59, 6}, {-16, 6}, {-16, 15.3334}, {-16, 15.3334}}, color = {176, 0, 0}));
      connect(fluidSource.enthalpyPort_b, heatPump.enthalpyPort_a1) annotation (
        Line(points = {{-62, 63}, {-16, 63}, {-16, 42}}, color = {176, 0, 0}));
      connect(const.y, heatPump.iceFac_in) annotation (
        Line(points = {{-79, 20}, {-26, 20}, {-26, 18.5334}, {-26.1333, 18.5334}}, color = {0, 0, 127}));
      connect(u_T_fluid_source, fluidSource.T_fluid) annotation (
        Line(points = {{-160, 100}, {-100, 100}, {-100, 66.2}, {-80, 66.2}}, color = {0, 0, 127}));
      connect(u_dotm_source, fluidSource.dotm) annotation (
        Line(points = {{-160, 60}, {-82, 60}, {-82, 59.4}, {-80, 59.4}}, color = {0, 0, 127}));
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

    model control_opt_SI_BooleanSI "Control unit for optimization"
      extends Modelica.Icons.Package;
      Modelica.Blocks.Interfaces.RealInput u_control_standard annotation (
        Placement(visible = true, transformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180), iconTransformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180)));
      Modelica.Blocks.Interfaces.RealOutput y_control annotation (
        Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold = 0.0001) annotation (
        Placement(visible = true, transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch1 annotation (
        Placement(visible = true, transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.LogicalSwitch logicalSwitch annotation (
        Placement(visible = true, transformation(origin = {70, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanOutput y_control_boolean annotation (
        Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_control_value annotation (
        Placement(visible = true, transformation(origin = {0, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90), iconTransformation(origin = {0, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation (
        Placement(visible = true, transformation(origin = {40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    equation
      connect(realToBoolean.y, switch1.u2) annotation (
        Line(points = {{-18, 20}, {-10, 20}, {-10, 0}, {58, 0}}, color = {255, 0, 255}));
      connect(u_control_standard, realToBoolean.u) annotation (
        Line(points = {{-120, 0}, {-60, 0}, {-60, 20}, {-42, 20}, {-42, 20}}, color = {0, 0, 127}));
      connect(u_control_standard, switch1.u1) annotation (
        Line(points = {{-120, 0}, {-60, 0}, {-60, -8}, {58, -8}}, color = {0, 0, 127}));
      connect(switch1.y, y_control) annotation (
        Line(points = {{81, 0}, {110, 0}}, color = {0, 0, 127}));
      connect(logicalSwitch.u1, realToBoolean.y) annotation (
        Line(points = {{58, 52}, {-10, 52}, {-10, 20}, {-18, 20}}, color = {255, 0, 255}));
      connect(logicalSwitch.u2, realToBoolean.y) annotation (
        Line(points = {{58, 60}, {-10, 60}, {-10, 20}, {-18, 20}}, color = {255, 0, 255}));
      connect(logicalSwitch.y, y_control_boolean) annotation (
        Line(points = {{81, 60}, {110, 60}}, color = {255, 0, 255}));
      connect(switch1.u3, u_control_value) annotation (
        Line(points = {{58, 8}, {0, 8}, {0, 120}, {0, 120}}, color = {0, 0, 127}));
      connect(logicalSwitch.u3, u_control_boolean) annotation (
        Line(points = {{58, 68}, {40, 68}, {40, 120}, {40, 120}}, color = {255, 0, 255}));
      annotation (
        Documentation(info = "<html>
    <p>
    This component represents the control unit for optimized control.

    <p>



    </html>"),
        Diagram,
        Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(origin = {2, -246}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
        experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
    end control_opt_SI_BooleanSI;

    model bus2SOBoolean_SO
      extends Modelica.Icons.Package;
      AixLib.BoundaryConditions.WeatherData.Bus controlBus annotation (
        Placement(visible = true, transformation(origin = {-99, -1}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_control_value annotation (
        Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanOutput y_control_boolean annotation (
        Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(y_control_boolean, controlBus.control_boolean) annotation (
        Line(points = {{110, 40}, {0, 40}, {0, 0}, {-98, 0}, {-98, 0}}, color = {255, 0, 255}));
      connect(y_control_value, controlBus.control_value) annotation (
        Line(points = {{110, -40}, {0, -40}, {0, 0}, {-98, 0}, {-98, 0}}, color = {0, 0, 127}));
      annotation (
        Documentation(info = "<html>
    <p>
    This cmoponent simiulate a basboiler with a simple control system.

    <p>
    Parameter:
    <p>
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump


    </html>"),
        Diagram,
        Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
        experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
    end bus2SOBoolean_SO;

    model Consumer_simple
      extends Modelica.Icons.Package;
      parameter Modelica.SIunits.Temperature T0 = 343.15 "Inital temperature" annotation (
        Dialog(tab = "General"));
      AixLib.FastHVAC.Components.Sinks.Sink sink(fluid(T0 = T0)) annotation (
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation (
        Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation (
        Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add1(k1 = -1) annotation (
        Placement(visible = true, transformation(origin = {44, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation (
        Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation (
        Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_sink annotation (
        Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput y_deltaT annotation (
        Placement(visible = true, transformation(origin = {108, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_Tin annotation (
        Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(u_sink, sink.Load) annotation (
        Line(points = {{-80, 120}, {-80, 80}, {0, 80}, {0, 11}}, color = {0, 0, 127}));
      connect(add1.y, y_deltaT) annotation (
        Line(points = {{44, 71}, {44, 80}, {108, 80}}, color = {0, 0, 127}));
      connect(TemperatureOutput.T, add1.u1) annotation (
        Line(points = {{52, 12}, {50, 12}, {50, 48}}, color = {0, 0, 127}));
      connect(enthalpyPort_a, TemperatureInput.enthalpyPort_a) annotation (
        Line(points = {{-110, 0}, {-59, 0}}, color = {176, 0, 0}));
      connect(TemperatureInput.enthalpyPort_b, sink.enthalpyPort_a1) annotation (
        Line(points = {{-41, 0}, {-11, 0}}, color = {176, 0, 0}));
      connect(sink.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation (
        Line(points = {{11, 0}, {42, 0}}));
      connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation (
        Line(points = {{60, 0}, {104, 0}, {104, 0}, {110, 0}}, color = {176, 0, 0}));
      connect(y_Tin, TemperatureInput.T) annotation (
        Line(points = {{110, 40}, {-50, 40}, {-50, 12}, {-48, 12}}, color = {0, 0, 127}));
      connect(add1.u2, TemperatureInput.T) annotation (
        Line(points = {{38, 48}, {38, 48}, {38, 40}, {-50, 40}, {-50, 12}, {-48, 12}}, color = {0, 0, 127}));
      annotation (
        Diagram,
        Icon(graphics={  Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
    end Consumer_simple;

    model busbar_4consumer
      extends Modelica.Icons.Package;
      Modelica.Blocks.Interfaces.RealOutput y_DirectConsumptionCHP annotation (
        Placement(visible = true, transformation(origin = {210, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_ProductionCHP annotation (
        Placement(visible = true, transformation(origin = {-80, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput uProductionPV annotation (
        Placement(visible = true, transformation(origin = {-20, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput u_DemandHeatPump annotation (
        Placement(visible = true, transformation(origin = {-220, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_DemandHouses annotation (
        Placement(visible = true, transformation(origin = {-220, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_FeedInCHP annotation (
        Placement(visible = true, transformation(origin = {210, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_DirectConsumptionPV annotation (
        Placement(visible = true, transformation(origin = {210, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_LoadToBattery annotation (
        Placement(visible = true, transformation(origin = {210, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_PVProductionToBattery annotation (
        Placement(visible = true, transformation(origin = {210, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Q100_DistrictModel.Components.busbar_1consumer Busbar_CHP annotation (
        Placement(visible = true, transformation(origin = {-71, 153}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
      Q100_DistrictModel.Components.busbar_1consumer Busbar_PV annotation (
        Placement(visible = true, transformation(origin = {-27, 91}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput u_EMob annotation (
        Placement(visible = true, transformation(origin = {-220, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Math.Add3 add3_1 annotation (
        Placement(transformation(extent = {{-178, 30}, {-158, 50}})));
      Modelica.Blocks.Math.Add add annotation (
        Placement(transformation(extent = {{-140, 100}, {-120, 120}})));
      Modelica.Blocks.Interfaces.RealInput u_DemandElectrolyser annotation (
        Placement(visible = true, transformation(origin = {-220, 180}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      connect(Busbar_PV.y_GridLoad, y_LoadToBattery) annotation (
        Line(points = {{-27, 78.625}, {-27, -20}, {210, -20}}, color = {0, 0, 127}));
      connect(Busbar_PV.y_FeedIn, y_PVProductionToBattery) annotation (
        Line(points = {{-33.75, 78.625}, {-33.75, -40}, {210, -40}}, color = {0, 0, 127}));
      connect(uProductionPV, Busbar_PV.u_Production) annotation (
        Line(points = {{-20, 220}, {-20, 104.5}, {-20.25, 104.5}}, color = {0, 0, 127}));
      connect(Busbar_CHP.y_GridLoad, Busbar_PV.u_Demand) annotation (
        Line(points = {{-71, 140.625}, {-71, 128}, {-33.75, 128}, {-33.75, 104.5}}, color = {0, 0, 127}));
      connect(Busbar_PV.y_DirectConsumption, y_DirectConsumptionPV) annotation (
        Line(points = {{-20.25, 78.625}, {-20.25, 60}, {210, 60}}, color = {0, 0, 127}));
      connect(Busbar_CHP.y_FeedIn, y_FeedInCHP) annotation (
        Line(points = {{-77.75, 140.625}, {-77.75, 120}, {210, 120}}, color = {0, 0, 127}));
      connect(Busbar_CHP.y_DirectConsumption, y_DirectConsumptionCHP) annotation (
        Line(points = {{-64.25, 140.625}, {210, 140.625}, {210, 140}}, color = {0, 0, 127}));
      connect(u_ProductionCHP, Busbar_CHP.u_Production) annotation (
        Line(points = {{-80, 220}, {-80, 188}, {-64.25, 188}, {-64.25, 166.5}}, color = {0, 0, 127}));
      connect(u_DemandHeatPump, add3_1.u1) annotation (
        Line(points = {{-220, 120}, {-190, 120}, {-190, 48}, {-180, 48}}, color = {0, 0, 127}));
      connect(u_DemandHouses, add3_1.u2) annotation (
        Line(points = {{-220, 20}, {-200, 20}, {-200, 40}, {-180, 40}}, color = {0, 0, 127}));
      connect(u_EMob, add3_1.u3) annotation (
        Line(points = {{-220, -40}, {-190, -40}, {-190, 32}, {-180, 32}}, color = {0, 0, 127}));
      connect(add.y, Busbar_CHP.u_Demand) annotation (
        Line(points = {{-119, 110}, {-108, 110}, {-108, 180}, {-77.75, 180}, {-77.75, 166.5}}, color = {0, 0, 127}));
      connect(u_DemandElectrolyser, add.u1) annotation (
        Line(points = {{-220, 180}, {-142, 180}, {-142, 116}}, color = {0, 0, 127}));
      connect(add3_1.y, add.u2) annotation (
        Line(points = {{-157, 40}, {-150, 40}, {-150, 104}, {-142, 104}}, color = {0, 0, 127}));
      annotation (
        experiment(StartTime = 0, StopTime = 345600, Tolerance = 1e-06, Interval = 900),
        __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
        Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
        Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
        __OpenModelica_commandLineOptions = "");
    end busbar_4consumer;

    model busbar_1consumer
      extends Modelica.Icons.Package;
      Modelica.Blocks.Interfaces.RealInput u_Production annotation (
        Placement(visible = true, transformation(origin = {-220, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_Demand annotation (
        Placement(visible = true, transformation(origin = {-220, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_FeedIn annotation (
        Placement(visible = true, transformation(origin = {210, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption annotation (
        Placement(visible = true, transformation(origin = {210, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add1(k1 = -1, k2 = +1) annotation (
        Placement(visible = true, transformation(origin = {-110, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1 annotation (
        Placement(visible = true, transformation(origin = {-70, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch1 annotation (
        Placement(visible = true, transformation(origin = {-10, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const(k = 0) annotation (
        Placement(visible = true, transformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch11 annotation (
        Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_GridLoad annotation (
        Placement(visible = true, transformation(origin = {210, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add3(k1 = +1, k2 = -1) annotation (
        Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Gain gain1(k = -1) annotation (
        Placement(visible = true, transformation(origin = {30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(gain1.y, y_GridLoad) annotation (
        Line(points = {{42, 20}, {72, 20}, {72, 0}, {210, 0}, {210, 0}}, color = {0, 0, 127}));
      connect(gain1.y, add3.u2) annotation (
        Line(points = {{42, 20}, {72, 20}, {72, 34}, {98, 34}}, color = {0, 0, 127}));
      connect(switch11.y, gain1.u) annotation (
        Line(points = {{2, 20}, {18, 20}, {18, 22}, {18, 22}, {18, 20}}, color = {0, 0, 127}));
      connect(add3.y, y_DirectConsumption) annotation (
        Line(points = {{121, 40}, {210, 40}}, color = {0, 0, 127}));
      connect(u_Demand, add3.u1) annotation (
        Line(points = {{-220, -40}, {-140, -40}, {-140, 46}, {98, 46}}, color = {0, 0, 127}));
      connect(add1.u1, u_Demand) annotation (
        Line(points = {{-122, -26}, {-140, -26}, {-140, -40}, {-220, -40}, {-220, -40}}, color = {0, 0, 127}));
      connect(u_Production, add1.u2) annotation (
        Line(points = {{-220, 40}, {-180, 40}, {-180, -14}, {-122, -14}, {-122, -14}}, color = {0, 0, 127}));
      connect(add1.y, switch1.u1) annotation (
        Line(points = {{-99, -20}, {-92, -20}, {-92, -48}, {-22, -48}}, color = {0, 0, 127}));
      connect(add1.y, switch11.u3) annotation (
        Line(points = {{-99, -20}, {-92, -20}, {-92, 12}, {-22, 12}}, color = {0, 0, 127}));
      connect(add1.y, greaterThreshold1.u) annotation (
        Line(points = {{-99, -20}, {-83, -20}, {-83, -18}, {-84, -18}, {-84, -20}, {-83, -20}}, color = {0, 0, 127}));
      connect(const.y, switch1.u3) annotation (
        Line(points = {{-98, 80}, {-32, 80}, {-32, -32}, {-22, -32}, {-22, -32}}, color = {0, 0, 127}));
      connect(const.y, switch11.u1) annotation (
        Line(points = {{-98, 80}, {-32, 80}, {-32, 28}, {-22, 28}, {-22, 28}}, color = {0, 0, 127}));
      connect(greaterThreshold1.y, switch11.u2) annotation (
        Line(points = {{-59, -20}, {-39, -20}, {-39, 20}, {-21, 20}, {-21, 20}, {-23, 20}, {-23, 20}}, color = {255, 0, 255}));
      connect(switch1.y, y_FeedIn) annotation (
        Line(points = {{1, -40}, {210, -40}}, color = {0, 0, 127}));
      connect(greaterThreshold1.y, switch1.u2) annotation (
        Line(points = {{-59, -20}, {-39, -20}, {-39, -40}, {-21, -40}, {-21, -39}, {-23, -39}, {-23, -40}}, color = {255, 0, 255}));
      annotation (
        experiment(StartTime = 0, StopTime = 345600, Tolerance = 1e-06, Interval = 900),
        __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        Icon(coordinateSystem(extent = {{-80, -80}, {80, 80}}, initialScale = 0.1), graphics={  Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name"), Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
        __OpenModelica_commandLineOptions = "");
    end busbar_1consumer;
    annotation (
      uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
      Documentation(info = "<html>
      <p>Im package Components werden alle selbst erstellten Komponenten der unterschiedlichen Modelle abgelegt.</p>
      <p>Erstellt wurden die Komponenten durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics={  Rectangle(origin = {0.0, 35.1488}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Rectangle(origin = {0.0, -34.8512}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Line(origin = {-51.25, 0.0}, points = {{21.25, -35.0}, {-13.75, -35.0}, {-13.75, 35.0}, {6.25, 35.0}}), Polygon(origin = {-40.0, 35.0}, pattern = LinePattern.None,
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{10.0, 0.0}, {-5.0, 5.0}, {-5.0, -5.0}}), Line(origin = {51.25, 0.0}, points = {{-21.25, 35.0}, {13.75, 35.0}, {13.75, -35.0}, {-6.25, -35.0}}), Polygon(origin = {40.0, -35.0}, pattern = LinePattern.None,
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{-10.0, 0.0}, {5.0, 5.0}, {5.0, -5.0}})}));
end Components;
