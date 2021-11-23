within Q100_DistrictModel.Components;
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
