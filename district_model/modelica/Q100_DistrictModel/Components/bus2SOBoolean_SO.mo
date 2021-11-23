within Q100_DistrictModel.Components;
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
