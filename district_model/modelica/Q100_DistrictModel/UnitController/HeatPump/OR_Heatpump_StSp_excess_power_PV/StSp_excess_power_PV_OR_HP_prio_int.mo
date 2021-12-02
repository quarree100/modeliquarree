within Q100_DistrictModel.UnitController.HeatPump.OR_Heatpump_StSp_excess_power_PV;
model StSp_excess_power_PV_OR_HP_prio_int
  Modelica.Blocks.Interfaces.BooleanOutput OS_HP_prio_int
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_int annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Logical.LessThreshold         lessThreshold(threshold=-0.01)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
    connect(lessThreshold.u, signal_HP_prio_int)
      annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
    connect(lessThreshold.y, OS_HP_prio_int)
      annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_excess_power_PV_OR_HP_prio_int;
