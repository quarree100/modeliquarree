within Q100_DistrictModel.UnitController.Electrolysis;
model Electrolysis_StSp_priority_int
  Modelica.Blocks.Interfaces.BooleanOutput Electrolysis_Specification_StSp_priority_int_SI
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_Electrolysis_prio_int
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  OR_Electrolysis_StSp_priority_int.StSp_priority_int_OR_Electrolysis_prio_int
    stSp_priority_int_OR_Electrolysis_prio_int
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(stSp_priority_int_OR_Electrolysis_prio_int.signal_Electrolysis_prio_int,
    signal_Electrolysis_prio_int)
    annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
  connect(stSp_priority_int_OR_Electrolysis_prio_int.OS_Electrolysis_prio_int,
    Electrolysis_Specification_StSp_priority_int_SI)
    annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Electrolysis_StSp_priority_int;
