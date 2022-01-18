within Q100_DistrictModel.UnitController.Electrolysis;
model Electrolysis_StSp_priority_ext
  Modelica.Blocks.Interfaces.BooleanOutput Electrolysis_Specification_StSp_priority_ext_SI
    "Q100_Funktionsbeschreibung.Heatpump.Specification.SS_priority_ext._SI_virtual"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_Electrolysis_prio_int
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput signal_Electrolysis_prio_ext
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  OR_Electrolysis_StSp_priority_ext.StSp_priority_ext_OR_Electrolysis_prio_ext
    stSp_priority_ext_OR_Electrolysis_prio_ext
    annotation (Placement(transformation(extent={{-58,-60},{-38,-40}})));
  OR_Electrolysis_StSp_priority_ext.StSp_priority_ext_OR_Electrolysis_prio_int
    stSp_priority_ext_OR_Electrolysis_prio_int
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(stSp_priority_ext_OR_Electrolysis_prio_ext.signal_Electrolysis_prio_ext,
    signal_Electrolysis_prio_ext)
    annotation (Line(points={{-60,-50},{-120,-50}}, color={0,0,127}));
  connect(stSp_priority_ext_OR_Electrolysis_prio_int.signal_Electrolysis_prio_int,
    signal_Electrolysis_prio_int)
    annotation (Line(points={{-62,50},{-120,50}}, color={0,0,127}));
  connect(stSp_priority_ext_OR_Electrolysis_prio_int.OS_Electrolysis_prio_int,
    and1.u1) annotation (Line(points={{-39,50},{32,50},{32,0},{38,0}}, color={
          255,0,255}));
  connect(stSp_priority_ext_OR_Electrolysis_prio_ext.OS_Electrolysis_prio_ext,
    and1.u2) annotation (Line(points={{-37,-50},{32,-50},{32,-8},{38,-8}},
        color={255,0,255}));
  connect(and1.y, Electrolysis_Specification_StSp_priority_ext_SI)
    annotation (Line(points={{61,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Electrolysis_StSp_priority_ext;
