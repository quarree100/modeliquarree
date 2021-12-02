within Q100_DistrictModel.UnitController.HeatPump.OR_Heatpump_StSp_excess_power_PV;
model StSp_excess_power_PV_OR_tp_TES_max
  Modelica.Blocks.Interfaces.BooleanOutput OS_tp_TES_max
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput tp_TES_load annotation (
      Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput Heatpump_Constants_tp_TES_max_set
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(less.y, OS_tp_TES_max)
    annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  connect(less.u1, tp_TES_load) annotation (Line(points={{-12,0},{-50,0},
          {-50,50},{-120,50}}, color={0,0,127}));
  connect(less.u2, Heatpump_Constants_tp_TES_max_set) annotation (Line(
        points={{-12,-8},{-50,-8},{-50,-50},{-120,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_excess_power_PV_OR_tp_TES_max;
