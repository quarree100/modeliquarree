within Q100_DistrictModel.Components;
model calc_mdot_consumer "Callculation of massflow according to power and temperature"
  extends Modelica.Icons.Package;
  Modelica.Blocks.Interfaces.RealInput u_TemperatureInput annotation (
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_dotQ annotation (
    Placement(visible = true, transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_TemperatureOutput annotation (
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_mdot annotation (
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Math.Gain gain(k = 4187) annotation (
    Placement(transformation(extent = {{-50, -4}, {-30, 16}})));
  Modelica.Blocks.Math.Add add(k1 = -1) annotation (
    Placement(transformation(extent = {{-80, -4}, {-60, 16}})));
  Modelica.Blocks.Math.Division division annotation (
    Placement(transformation(extent = {{20, -4}, {40, 16}})));
  Modelica.Blocks.Math.Max max annotation (
    Placement(transformation(extent = {{60, -10}, {80, 10}})));
  Modelica.Blocks.Sources.Constant const(k = 0.00001) annotation (
    Placement(transformation(extent = {{-60, -60}, {-40, -40}})));
  Modelica.Blocks.Math.Max max1 annotation (
    Placement(transformation(extent = {{-20, -10}, {0, 10}})));
  Modelica.Blocks.Sources.Constant const1(k = 0) annotation (
    Placement(transformation(extent = {{26, -60}, {46, -40}})));
equation
  connect(division.u1, u_dotQ) annotation (
    Line(points = {{18, 12}, {10, 12}, {10, 66}, {0, 66}, {0, 120}}, color = {0, 0, 127}));
  connect(add.y, gain.u) annotation (
    Line(points = {{-59, 6}, {-52, 6}}, color = {0, 0, 127}));
  connect(add.u2, u_TemperatureInput) annotation (
    Line(points = {{-82, 0}, {-92, 0}, {-92, -60}, {-120, -60}}, color = {0, 0, 127}));
  connect(add.u1, u_TemperatureOutput) annotation (
    Line(points = {{-82, 12}, {-92, 12}, {-92, 60}, {-120, 60}}, color = {0, 0, 127}));
  connect(division.y, max.u1) annotation (
    Line(points = {{41, 6}, {58, 6}}, color = {0, 0, 127}));
  connect(max.y, y_mdot) annotation (
    Line(points = {{81, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(max1.y, division.u2) annotation (
    Line(points = {{1, 0}, {18, 0}}, color = {0, 0, 127}));
  connect(gain.y, max1.u1) annotation (
    Line(points = {{-29, 6}, {-22, 6}}, color = {0, 0, 127}));
  connect(const.y, max1.u2) annotation (
    Line(points = {{-39, -50}, {-30, -50}, {-30, -6}, {-22, -6}}, color = {0, 0, 127}));
  connect(const1.y, max.u2) annotation (
    Line(points = {{47, -50}, {52, -50}, {52, -6}, {58, -6}}, color = {0, 0, 127}));
  annotation (
    Documentation(info = "<html>
<p>
This component simiulate a basboiler with a simple control system. 

<p>
Parameter:  
<p> 
<strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 


</html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(origin = {-6, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
    experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
end calc_mdot_consumer;
