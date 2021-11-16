within Q100_DistrictModel.Components;
model calc_valve_ratio
  extends Modelica.Icons.Package;
  Modelica.Blocks.Interfaces.RealInput u_dotm_in annotation (
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput u_dotm_out annotation (
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealOutput y_valve annotation (
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Math.Division division annotation (
    Placement(visible = true, transformation(extent = {{-20, -10}, {0, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Max max annotation (
    Placement(visible = true, transformation(extent = {{-60, -26}, {-40, -6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.0000001) annotation (
    Placement(visible = true, transformation(extent = {{-100, -20}, {-80, 0}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation (
    Placement(visible = true, transformation(extent = {{20, 10}, {40, 30}}, rotation = 0)));
  Modelica.Blocks.Math.Min min annotation (
    Placement(transformation(extent = {{62, 4}, {82, 24}})));
  Modelica.Blocks.Sources.Constant const1(k=0.00001)
                                                 annotation (
    Placement(visible = true, transformation(extent = {{-20, 30}, {0, 50}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k=0.99999)
                                                 annotation (
    Placement(visible = true, transformation(extent = {{20, -30}, {40, -10}}, rotation = 0)));
equation
  connect(const.y, max.u1) annotation (
    Line(points = {{-79, -10}, {-62, -10}}, color = {0, 0, 127}));
  connect(u_dotm_in, max.u2) annotation (
    Line(points = {{-120, -60}, {-70, -60}, {-70, -22}, {-62, -22}}, color = {0, 0, 127}));
  connect(max.y, division.u2) annotation (
    Line(points = {{-39, -16}, {-30, -16}, {-30, -6}, {-22, -6}}, color = {0, 0, 127}));
  connect(u_dotm_out, division.u1) annotation (
    Line(points = {{-120, 60}, {-30, 60}, {-30, 6}, {-22, 6}}, color = {0, 0, 127}));
  connect(max1.u2, division.y) annotation (
    Line(points = {{18, 14}, {10, 14}, {10, 0}, {1, 0}}, color = {0, 0, 127}));
  connect(max1.y, min.u1) annotation (
    Line(points = {{41, 20}, {60, 20}}, color = {0, 0, 127}));
  connect(const1.y, max1.u1) annotation (
    Line(points = {{1, 40}, {8, 40}, {8, 26}, {18, 26}}, color = {0, 0, 127}));
  connect(const2.y, min.u2) annotation (
    Line(points = {{41, -20}, {50, -20}, {50, 8}, {60, 8}}, color = {0, 0, 127}));
  connect(min.y, y_valve) annotation (
    Line(points = {{83, 14}, {94, 14}, {94, 0}, {110, 0}}, color = {0, 0, 127}));
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
end calc_valve_ratio;
