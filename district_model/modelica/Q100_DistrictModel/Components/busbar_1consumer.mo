within Q100_DistrictModel.Components;
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
    Line(points={{41,20},{72,20},{72,0},{210,0},{210,0}},            color = {0, 0, 127}));
  connect(gain1.y, add3.u2) annotation (
    Line(points={{41,20},{72,20},{72,34},{98,34}},          color = {0, 0, 127}));
  connect(switch11.y, gain1.u) annotation (
    Line(points={{1,20},{18,20},{18,22},{18,22},{18,20}},            color = {0, 0, 127}));
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
    Line(points={{-99,-20},{-83,-20},{-83,-18},{-84,-18},{-84,-20},{-82,-20}},              color = {0, 0, 127}));
  connect(const.y, switch1.u3) annotation (
    Line(points={{-99,80},{-32,80},{-32,-32},{-22,-32},{-22,-32}},            color = {0, 0, 127}));
  connect(const.y, switch11.u1) annotation (
    Line(points={{-99,80},{-32,80},{-32,28},{-22,28},{-22,28}},            color = {0, 0, 127}));
  connect(greaterThreshold1.y, switch11.u2) annotation (
    Line(points={{-59,-20},{-39,-20},{-39,20},{-21,20},{-21,20},{-22,20},{-22,
          20}},                                                                                    color = {255, 0, 255}));
  connect(switch1.y, y_FeedIn) annotation (
    Line(points = {{1, -40}, {210, -40}}, color = {0, 0, 127}));
  connect(greaterThreshold1.y, switch1.u2) annotation (
    Line(points={{-59,-20},{-39,-20},{-39,-40},{-21,-40},{-21,-39},{-22,-39},{
          -22,-40}},                                                                                    color = {255, 0, 255}));
  annotation (
    experiment(StartTime = 0, StopTime = 345600, Tolerance = 1e-06, Interval = 900),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(coordinateSystem(extent = {{-80, -80}, {80, 80}}, initialScale = 0.1), graphics={  Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name"), Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
    __OpenModelica_commandLineOptions = "");
end busbar_1consumer;
