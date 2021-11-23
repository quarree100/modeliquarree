within Q100_DistrictModel.Components;
model calc_valve "Callculation of massflow according to power and temperature"
  extends Modelica.Icons.Package;
  Modelica.Blocks.Interfaces.RealInput u_T_consumer_output annotation (
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_T_source_input annotation (
    Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_T_consumer_input annotation (
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_valve(start = 0.8) annotation (
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation (
    Placement(visible = true, transformation(extent = {{-72, 56}, {-52, 76}}, rotation = 0)));
  Modelica.Blocks.Math.Division division annotation (
    Placement(visible = true, transformation(extent = {{-20, 0}, {0, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Max max annotation (
    Placement(visible = true, transformation(extent = {{72, -10}, {92, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation (
    Placement(visible = true, transformation(extent = {{20, -60}, {40, -40}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1) annotation (
    Placement(visible = true, transformation(extent = {{-72, -64}, {-52, -44}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k1 = -1) annotation (
    Placement(visible = true, transformation(extent = {{10, -6}, {30, 14}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 1) annotation (
    Placement(visible = true, transformation(extent = {{-20, -38}, {0, -18}}, rotation = 0)));
  Modelica.Blocks.Math.Min min annotation (
    Placement(visible = true, transformation(origin = {50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 1) annotation (
    Placement(visible = true, transformation(extent = {{0, 60}, {20, 80}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation (
    Placement(visible = true, transformation(extent = {{-60, -6}, {-40, 14}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = 0.00001) annotation (
    Placement(visible = true, transformation(extent = {{-40, 30}, {-60, 50}}, rotation = 0)));
equation
  connect(const.y, max.u2) annotation (
    Line(points = {{41, -50}, {60, -50}, {60, -6}, {70, -6}}, color = {0, 0, 127}));
  connect(max.y, y_valve) annotation (
    Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(add.u1, u_T_source_input) annotation (
    Line(points = {{-74, 72}, {-80, 72}, {-80, 120}}, color = {0, 0, 127}));
  connect(u_T_consumer_input, add.u2) annotation (
    Line(points = {{-120, 60}, {-74, 60}}, color = {0, 0, 127}));
  connect(u_T_consumer_output, add1.u2) annotation (
    Line(points = {{-120, -60}, {-74, -60}}, color = {0, 0, 127}));
  connect(add1.u1, u_T_source_input) annotation (
    Line(points = {{-74, -48}, {-80, -48}, {-80, 120}}, color = {0, 0, 127}));
  connect(division.y, add2.u1) annotation (
    Line(points = {{1, 10}, {8, 10}, {8, 10}, {8, 10}}, color = {0, 0, 127}));
  connect(const1.y, add2.u2) annotation (
    Line(points = {{1, -28}, {4, -28}, {4, -2}, {8, -2}, {8, -2}}, color = {0, 0, 127}));
  connect(add2.y, min.u2) annotation (
    Line(points = {{31, 4}, {32, 4}, {32, 12}, {38, 12}, {38, 14}}, color = {0, 0, 127}));
  connect(min.y, max.u1) annotation (
    Line(points = {{61, 20}, {64, 20}, {64, 6}, {70, 6}, {70, 6}}, color = {0, 0, 127}));
  connect(const2.y, min.u1) annotation (
    Line(points = {{21, 70}, {28, 70}, {28, 26}, {38, 26}, {38, 26}}, color = {0, 0, 127}));
  connect(add.y, division.u1) annotation (
    Line(points = {{-51, 66}, {-36, 66}, {-36, 16}, {-22, 16}}, color = {0, 0, 127}));
  connect(max1.y, division.u2) annotation (
    Line(points = {{-39, 4}, {-22, 4}}, color = {0, 0, 127}));
  connect(add1.y, max1.u2) annotation (
    Line(points = {{-51, -54}, {-40, -54}, {-40, -20}, {-72, -20}, {-72, -2}, {-62, -2}}, color = {0, 0, 127}));
  connect(const3.y, max1.u1) annotation (
    Line(points = {{-61, 40}, {-72, 40}, {-72, 10}, {-62, 10}}, color = {0, 0, 127}));
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
end calc_valve;
