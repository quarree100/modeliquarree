within Q100_DistrictModel.Components;
block TES_Switch "Splits the single TES signal into a load and unload signal"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput u
    "Connector of Real input signals" annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y1
    "Connector of Real output signals 1" annotation (Placement(transformation(
          extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput y2
    "Connector of Real output signals 2" annotation (Placement(transformation(
          extent={{100,-70},{120,-50}})));

equation
  y1 = if u>0.001 then u else 0;
  y2 = if u<-0.001 then -u else 0;
  annotation (
    Documentation(info="<html>
<p>
The input connector is <strong>split</strong> up into two output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1 and n2.
</p>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{100,60},{60,60},{0,0}}, color={0,0,127}),
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127}),
        Line(points={{100,-60},{60,-60},{0,0}}, color={0,0,127}),
        Line(points={{-100,0},{-6,0}}, color={0,0,127})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{100,60},{60,60},{0,0}}, color={0,0,127}),
        Line(points={{100,-60},{60,-60},{0,0}}, color={0,0,127}),
        Line(points={{-100,0},{-6,0}}, color={0,0,127}),
        Ellipse(
          extent={{-15,15},{15,-15}},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127})}));
end TES_Switch;
