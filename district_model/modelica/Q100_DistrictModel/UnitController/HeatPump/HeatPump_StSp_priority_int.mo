within Q100_DistrictModel.UnitController.HeatPump;
model HeatPump_StSp_priority_int
  Modelica.Blocks.Interfaces.BooleanOutput Heatpump_Specification_StSp_priority_int_SI
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_int
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  OR_Heatpump_StSp_priority_int.StSp_priority_int_OR_HP_prio_int
    stSp_priority_int_OR_HP_prio_int
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(stSp_priority_int_OR_HP_prio_int.signal_HP_prio_int,
    signal_HP_prio_int)
    annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
  connect(stSp_priority_int_OR_HP_prio_int.OS_HP_prio_int,
    Heatpump_Specification_StSp_priority_int_SI)
    annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPump_StSp_priority_int;
