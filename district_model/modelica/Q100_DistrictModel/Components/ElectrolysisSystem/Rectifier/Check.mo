within Q100_DistrictModel.Components.ElectrolysisSystem.Rectifier;
model Check
  extends Modelica.Icons.Example;
  Rectifier rectifier
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Tools.Boundaries.PowerSource powerBoundary1(P=10e3)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
equation
  connect(rectifier.port_P_el_out, powerBoundary1.powerConnector)
    annotation (Line(points={{8,0},{40,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Check;
