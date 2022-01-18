within Q100_DistrictModel.UnitController.Electrolysis.OR_Electrolysis_StSp_priority_ext;
model StSp_priority_ext_OR_Electrolysis_prio_ext
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation (
    Placement(visible = true, transformation(origin={2,0},          extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput OS_Electrolysis_prio_ext
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_Electrolysis_prio_ext
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  connect(signal_Electrolysis_prio_ext, greaterThreshold.u)
    annotation (Line(points={{-120,0},{-10,0}}, color={0,0,127}));
  connect(greaterThreshold.y, OS_Electrolysis_prio_ext)
    annotation (Line(points={{13,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_priority_ext_OR_Electrolysis_prio_ext;
