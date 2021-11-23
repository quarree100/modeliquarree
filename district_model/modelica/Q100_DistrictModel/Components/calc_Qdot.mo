within Q100_DistrictModel.Components;
model calc_Qdot "Callculation of massflow according to power and temperature"
  extends Modelica.Icons.Package;
  Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation (
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_T_measurement annotation (
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_Qdot annotation (
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Math.Add add(k1 = -1) annotation (
    Placement(visible = true, transformation(extent = {{-80, 44}, {-60, 64}}, rotation = 0)));
  Modelica.Blocks.Math.Division division annotation (
    Placement(visible = true, transformation(extent = {{-20, 0}, {0, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Min min annotation (
    Placement(visible = true, transformation(origin = {72, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 0.99) annotation (
    Placement(visible = true, transformation(extent = {{20, -40}, {40, -20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_deltaT_setpoint annotation (
    Placement(visible = true, transformation(origin = {-28, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
  Modelica.Blocks.Math.Max max1 annotation (
    Placement(visible = true, transformation(extent = {{-60, 6}, {-40, 26}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = 0) annotation (
    Placement(visible = true, transformation(extent = {{-40, -30}, {-60, -10}}, rotation = 0)));
equation
  connect(u_T_measurement, add.u1) annotation (
    Line(points = {{-120, 60}, {-82, 60}}, color = {0, 0, 127}));
  connect(add.u2, u_T_setpoint) annotation (
    Line(points = {{-82, 48}, {-90, 48}, {-90, -60}, {-120, -60}}, color = {0, 0, 127}));
  connect(max1.y, division.u1) annotation (
    Line(points = {{-39, 16}, {-22, 16}}, color = {0, 0, 127}));
  connect(add.y, max1.u1) annotation (
    Line(points = {{-59, 54}, {-50, 54}, {-50, 36}, {-70, 36}, {-70, 22}, {-62, 22}}, color = {0, 0, 127}));
  connect(const3.y, max1.u2) annotation (
    Line(points = {{-61, -20}, {-70, -20}, {-70, 10}, {-62, 10}}, color = {0, 0, 127}));
  connect(min.y, y_Qdot) annotation (
    Line(points = {{83, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(division.y, min.u1) annotation (
    Line(points = {{1, 10}, {28, 10}, {28, 6}, {60, 6}}, color = {0, 0, 127}));
  connect(const2.y, min.u2) annotation (
    Line(points = {{41, -30}, {50, -30}, {50, -6}, {60, -6}}, color = {0, 0, 127}));
  connect(division.u2, u_deltaT_setpoint) annotation (
    Line(points = {{-22, 4}, {-28, 4}, {-28, 120}}, color = {0, 0, 127}));
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
end calc_Qdot;
