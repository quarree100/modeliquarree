within Q100_DistrictModel.Components.ElectrolysisSystem.Tools.Components;
model Switch "Input signal if on, zero if off"
  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},
            {-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-20},{
            140,20}})));
  Modelica.Blocks.Interfaces.BooleanInput onOffSignal(start=false, fixed = false) "boolean on-off-signal"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
        iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
equation
  y = if onOffSignal then u else 0.0;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {0, 0, 0}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                            FillPattern.Solid), Line(points={{
              -100,0},{-34,0}},                                                                                                                                                                                                        color = {0, 0, 0}, thickness = 0.5),                                                                                                                                                                                                        Line(points={{
              30,-2},{100,-2}},                                                                                                                                                                                                        color = {0, 0, 0}, thickness = 0.5),
                                                                                                                                                                                                  Line(points={{
              -32,0},{24,26}},                                                                                                                                                                                                        color={255,
              0,255},                                                                                                                                                                                                        thickness=
              0.5),
        Ellipse(
          extent={{-36,4},{-28,-4}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end Switch;
