within Q100_DistrictModel.Components;
model SignalConverter_Tri2Bi
  "Converts a signal from tridimensional (1;0;-1) to bidimensional (1;0)"
  extends Modelica.Icons.Package;
  Modelica.Blocks.Interfaces.RealInput u annotation (
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y annotation (
    Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=-0.0001)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
equation
  connect(u, greaterThreshold.u)
    annotation (Line(points={{-120,0},{-42,0}}, color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{-19,0},{18,0}}, color={255,0,255}));
  connect(switch1.y, y)
    annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{1,-50},{12,-50},{12,
          -8},{18,-8}}, color={0,0,127}));
  connect(const.y, switch1.u1)
    annotation (Line(points={{1,50},{12,50},{12,8},{18,8}}, color={0,0,127}));
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
end SignalConverter_Tri2Bi;
