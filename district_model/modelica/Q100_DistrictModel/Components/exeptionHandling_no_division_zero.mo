within Q100_DistrictModel.Components;
model exeptionHandling_no_division_zero "Callculation of massflow according to power and temperature"
  extends Modelica.Icons.Package;
  Modelica.Blocks.Interfaces.RealInput u annotation (
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation (
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Sources.Constant const1(k = 0.0000001) annotation (
    Placement(visible = true, transformation(extent = {{-20, 30}, {-40, 50}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation (
    Placement(transformation(extent = {{-40, -4}, {-20, 16}})));
equation
  connect(u, max1.u2) annotation (
    Line(points = {{-120, 0}, {-42, 0}}, color = {0, 0, 127}));
  connect(const1.y, max1.u1) annotation (
    Line(points = {{-41, 40}, {-60, 40}, {-60, 12}, {-42, 12}}, color = {0, 0, 127}));
  connect(max1.y, y) annotation (
    Line(points = {{-19, 6}, {42, 6}, {42, 0}, {110, 0}}, color = {0, 0, 127}));
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
end exeptionHandling_no_division_zero;
