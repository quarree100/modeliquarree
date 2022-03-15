within Q100_DistrictModel.UnitController.Electrolysis.OR_Electrolysis_StSp_priority_ext;
model StSp_priority_ext_OR_Electrolysis_prio_int
  Modelica.Blocks.Interfaces.BooleanOutput OS_Electrolysis_prio_int
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_Electrolysis_prio_int
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Logical.GreaterThreshold      greaterThreshold(
                                                              threshold=-0.01)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(greaterThreshold.u, signal_Electrolysis_prio_int)
    annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
  connect(greaterThreshold.y, OS_Electrolysis_prio_int)
    annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_priority_ext_OR_Electrolysis_prio_int;
