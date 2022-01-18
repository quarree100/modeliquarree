within Q100_DistrictModel.UnitController.Electrolysis.OR_Electrolysis_StSp_excess_power_PV;
model StSp_excess_power_PV_OR_Electrolysis_tp_TES_max
  Modelica.Blocks.Interfaces.BooleanOutput OS_tp_TES_max
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput tp_TES_load annotation (
      Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput Electrolysis_Constants_tp_TES_max_set
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Hysteresis_var hysteresis_var
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const(k=3)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-60,-36},{-40,-16}})));
equation
  connect(hysteresis_var.y, OS_tp_TES_max)
    annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  connect(hysteresis_var.u, tp_TES_load) annotation (Line(points={{-12,0},{-20,
          0},{-20,50},{-120,50}}, color={0,0,127}));
  connect(const.y, feedback.u2)
    annotation (Line(points={{-79,-70},{-50,-70},{-50,-34}}, color={0,0,127}));
  connect(feedback.y, hysteresis_var.uLow) annotation (Line(points={{-41,-26},{
          -20,-26},{-20,-8},{-12,-8}}, color={0,0,127}));
  connect(hysteresis_var.uHigh, Electrolysis_Constants_tp_TES_max_set)
    annotation (Line(points={{-12,8},{-70,8},{-70,-50},{-120,-50}}, color={0,0,
          127}));
  connect(Electrolysis_Constants_tp_TES_max_set, feedback.u1) annotation (Line(
        points={{-120,-50},{-70,-50},{-70,-26},{-58,-26}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_excess_power_PV_OR_Electrolysis_tp_TES_max;
