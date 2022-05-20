within Q100_DistrictModel.Components;
model InputSignalCheck "Checks if a input signal is greater than 0 and otherwise puts out an default value"
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-100,-20},{-60,20}}),
        iconTransformation(extent={{-100,-20},{-60,20}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{60,-20},{100,20}}),  iconTransformation(extent={{60,-20},{
            100,20}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.00001)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  parameter Real d = 0 "Default Value";
  Modelica.Blocks.Sources.Constant const(k=d)
    annotation (Placement(transformation(extent={{-40,-48},{-20,-28}})));
equation
  connect(u, greaterThreshold.u)
    annotation (Line(points={{-80,0},{-42,0}},  color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{-19,0},{18,0}}, color={255,0,255}));
  connect(u, switch1.u1) annotation (Line(points={{-80,0},{-48,0},{-48,40},{
          10,40},{10,8},{18,8}},
                              color={0,0,127}));
  connect(switch1.y, y)
    annotation (Line(points={{41,0},{80,0}},  color={0,0,127}));
  connect(const.y, switch1.u3) annotation (Line(points={{-19,-38},{12,-38},{
          12,-8},{18,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-60,
            -60},{60,60}})),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-60,-60},{60,60}})));
end InputSignalCheck;
