within Q100_DistrictModel.UnitController.HeatPump;
model HeatPump_StSp_HP_hysteresis
  Modelica.Blocks.Interfaces.RealInput T_DH_FF_actual "Temperature heat storage " annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput T_DH_FF_set "Temperature heating grid" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Hysteresis_var hysteresis_var
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Constant const1(k=-5)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput Heatpump_Specification_StSp_HP_hysteresis_SI annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  OR_Heatpump_StSp_excess_power_PV.StSp_excess_power_PV_OR_HP_prio_int
    stSp_excess_power_PV_OR_HP_prio_int
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  OR_Heatpump_StSp_excess_power_PV.StSp_excess_power_PV_OR_HP_prio_ext
    stSp_excess_power_PV_OR_HP_prio_ext
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_ext annotation (
      Placement(transformation(extent={{-140,-110},{-100,-70}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_int
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(extent={{10,40},{30,60}})));
equation
  connect(T_DH_FF_set, add1.u2) annotation (Line(points={{-120,0},{-68,0},{-68,14},{-62,14}}, color={0,0,127}));
  connect(const1.y, add1.u1) annotation (Line(points={{-79,20},{-70,20},{-70,26},{-62,26}},
                           color={0,0,127}));
  connect(const.y, add.u1) annotation (Line(points={{-79,60},{-68,60},{-68,66},{-62,66}},
                     color={0,0,127}));
  connect(T_DH_FF_set, add.u2) annotation (Line(points={{-120,0},{-68,0},{-68,54},{-62,54}}, color={0,0,127}));
  connect(T_DH_FF_actual, hysteresis_var.u) annotation (Line(points={{-120,80},{-30,80},{-30,50},{-22,50}}, color={0,0,127}));
  connect(add.y, hysteresis_var.uHigh)
    annotation (Line(points={{-39,60},{-22,60},{-22,58}},color={0,0,127}));
  connect(add1.y, hysteresis_var.uLow) annotation (Line(points={{-39,20},{-30,20},{-30,42},{-22,42}},
                                   color={0,0,127}));
  connect(and2.y,and1. u2) annotation (Line(points={{-19,-70},{32,-70},{32,-8},{38,-8}},
                           color={255,0,255}));
  connect(signal_HP_prio_int,stSp_excess_power_PV_OR_HP_prio_int. signal_HP_prio_int)
    annotation (Line(points={{-120,-60},{-82,-60}}, color={0,0,127}));
  connect(stSp_excess_power_PV_OR_HP_prio_ext.signal_HP_prio_ext,signal_HP_prio_ext)
    annotation (Line(points={{-82,-90},{-120,-90}}, color={0,0,127}));
  connect(stSp_excess_power_PV_OR_HP_prio_ext.OS_HP_prio_ext,and2. u2)
    annotation (Line(points={{-59,-90},{-48,-90},{-48,-78},{-42,-78}},
        color={255,0,255}));
  connect(stSp_excess_power_PV_OR_HP_prio_int.OS_HP_prio_int,and2. u1)
    annotation (Line(points={{-59,-60},{-48,-60},{-48,-70},{-42,-70}},
        color={255,0,255}));
  connect(and1.y, Heatpump_Specification_StSp_HP_hysteresis_SI) annotation (Line(points={{61,0},{110,0}}, color={255,0,255}));
  connect(hysteresis_var.y, not1.u) annotation (Line(points={{1,50},{8,50}}, color={255,0,255}));
  connect(not1.y, and1.u1) annotation (Line(points={{31,50},{40,50},{40,14},{32,14},{32,0},{38,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end HeatPump_StSp_HP_hysteresis;
