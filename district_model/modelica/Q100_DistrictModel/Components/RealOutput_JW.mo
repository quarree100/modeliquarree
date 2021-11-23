within Q100_DistrictModel.Components;
connector RealOutput_JW = output Real "'output Real' as connector" annotation (
  defaultComponentName = "y",
  Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics={  Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255},
          fillPattern =                                                                                                                                                                   FillPattern.Solid, points = {{-100.0, 100.0}, {100.0, 0.0}, {-100.0, -100.0}})}),
  Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics={  Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255},
          fillPattern =                                                                                                                                                                      FillPattern.Solid, points = {{-100.0, 50.0}, {0.0, 0.0}, {-100.0, -50.0}}), Text(lineColor = {0, 0, 127}, extent = {{30.0, 60.0}, {30.0, 110.0}}, fontSize = 1, textString = "%name")}),
  Documentation(info = "<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));
