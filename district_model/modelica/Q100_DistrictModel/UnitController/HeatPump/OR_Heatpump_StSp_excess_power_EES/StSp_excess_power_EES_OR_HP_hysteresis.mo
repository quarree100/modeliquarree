within Q100_DistrictModel.UnitController.HeatPump.OR_Heatpump_StSp_excess_power_EES;
model StSp_excess_power_EES_OR_HP_hysteresis
  Modelica.Blocks.Interfaces.BooleanOutput OS_HP_hysteresis
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput tp_TES_unload
    "Temperature heat storage " annotation (Placement(transformation(
          extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput tp_DH_FF_set
    "Temperature heating grid" annotation (Placement(transformation(
          extent={{-140,-70},{-100,-30}})));
  Hysteresis_var hysteresis_var
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Constant const(k=10)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
equation
  connect(tp_TES_unload, hysteresis_var.u) annotation (Line(points={{-120,50},{
          -20,50},{-20,0},{-12,0}}, color={0,0,127}));
  connect(hysteresis_var.y, OS_HP_hysteresis)
    annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  connect(tp_DH_FF_set, add.u2) annotation (Line(points={{-120,-50},{-70,-50},{
          -70,4},{-62,4}}, color={0,0,127}));
  connect(tp_DH_FF_set, add1.u2) annotation (Line(points={{-120,-50},{-70,-50},
          {-70,-36},{-62,-36}}, color={0,0,127}));
  connect(add1.y, hysteresis_var.uLow) annotation (Line(points={{-39,-30},{-18,
          -30},{-18,-8},{-12,-8}}, color={0,0,127}));
  connect(add.y, hysteresis_var.uHigh) annotation (Line(points={{-39,10},{-18,
          10},{-18,8},{-12,8}}, color={0,0,127}));
  connect(const.y, add.u1) annotation (Line(points={{-79,10},{-68,10},{-68,16},
          {-62,16}}, color={0,0,127}));
  connect(const1.y, add1.u1) annotation (Line(points={{-79,-30},{-68,-30},{-68,
          -24},{-62,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_excess_power_EES_OR_HP_hysteresis;