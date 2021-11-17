within Q100_DistrictModel.Components;
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
    Line(points = {{-80, 120}, {-80, 80}, {-0.12, 80}, {-0.12, 10.68}}, color = {0, 0, 127}));
  connect(add1.y, y_deltaT) annotation (
    Line(points = {{44, 71}, {44, 80}, {108, 80}}, color = {0, 0, 127}));
  connect(TemperatureOutput.T, add1.u1) annotation (
    Line(points = {{51, 11}, {50, 11}, {50, 48}}, color = {0, 0, 127}));
  connect(enthalpyPort_a, TemperatureInput.enthalpyPort_a) annotation (
    Line(points = {{-110, 0}, {-84, 0}, {-84, -0.1}, {-58.8, -0.1}}, color = {176, 0, 0}));
  connect(TemperatureInput.enthalpyPort_b, sink.enthalpyPort_a1) annotation (
    Line(points = {{-41, -0.1}, {-25.8, -0.1}, {-25.8, 0}, {-10.8, 0}}, color = {176, 0, 0}));
  connect(sink.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation (
    Line(points = {{10.8, 0}, {26, 0}, {26, -0.1}, {41.2, -0.1}}));
  connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation (
    Line(points = {{59, -0.1}, {104, -0.1}, {104, 0}, {110, 0}}, color = {176, 0, 0}));
  connect(y_Tin, TemperatureInput.T) annotation (
    Line(points = {{110, 40}, {-50, 40}, {-50, 11}, {-49, 11}}, color = {0, 0, 127}));
  connect(add1.u2, TemperatureInput.T) annotation (
    Line(points = {{38, 48}, {38, 48}, {38, 40}, {-50, 40}, {-50, 11}, {-49, 11}}, color = {0, 0, 127}));
  annotation (
    Diagram,
    Icon(graphics={  Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
end Consumer_simple;
