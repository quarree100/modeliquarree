within Q100_DistrictModel.UnitController.HeatPump;
model HeatPump_StSp_excess_power_PV
  Modelica.Blocks.Interfaces.BooleanOutput Heatpump_Specification_StSp_excess_power_PV_SI
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_int
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_ext annotation (
      Placement(transformation(extent={{-140,-110},{-100,-70}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  OR_Heatpump_StSp_excess_power_PV.StSp_excess_power_PV_OR_HP_prio_ext
    stSp_excess_power_PV_OR_HP_prio_ext
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  OR_Heatpump_StSp_excess_power_PV.StSp_excess_power_PV_OR_HP_prio_int
    stSp_excess_power_PV_OR_HP_prio_int
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Logical.And and3
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Interfaces.RealInput P_el_renergy
    "electrical power - renewable energy (PV, BHKW)"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput Heatpump_Constants_P_el_HP_min
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_load
      annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput Heatpump_Constants_tp_TES_max_set
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  OR_Heatpump_StSp_excess_power_PV.StSp_excess_power_PV_OR_excess_power
    stSp_excess_power_PV_OR_excess_power
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  OR_Heatpump_StSp_excess_power_PV.StSp_excess_power_PV_OR_tp_TES_max
    stSp_excess_power_PV_OR_tp_TES_max
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(and1.y, Heatpump_Specification_StSp_excess_power_PV_SI)
    annotation (Line(points={{61,0},{110,0}}, color={255,0,255}));
  connect(stSp_excess_power_PV_OR_HP_prio_ext.signal_HP_prio_ext,
    signal_HP_prio_ext)
    annotation (Line(points={{-82,-90},{-120,-90}}, color={0,0,127}));
  connect(signal_HP_prio_int, stSp_excess_power_PV_OR_HP_prio_int.signal_HP_prio_int)
    annotation (Line(points={{-120,-60},{-82,-60}}, color={0,0,127}));
  connect(stSp_excess_power_PV_OR_HP_prio_int.OS_HP_prio_int, and2.u1)
    annotation (Line(points={{-59,-60},{-48,-60},{-48,-70},{-42,-70}},
        color={255,0,255}));
  connect(stSp_excess_power_PV_OR_HP_prio_ext.OS_HP_prio_ext, and2.u2)
    annotation (Line(points={{-59,-90},{-48,-90},{-48,-78},{-42,-78}},
        color={255,0,255}));
  connect(and2.y, and1.u2) annotation (Line(points={{-19,-70},{32,-70},{
          32,-8},{38,-8}}, color={255,0,255}));
  connect(and3.y, and1.u1) annotation (Line(points={{-19,40},{32,40},{32,
          0},{38,0}}, color={255,0,255}));
  connect(stSp_excess_power_PV_OR_excess_power.P_el_renergy, P_el_renergy)
    annotation (Line(points={{-82,85},{-90,85},{-90,90},{-120,90}}, color=
         {0,0,127}));
  connect(stSp_excess_power_PV_OR_excess_power.Heatpump_Constants_P_el_HP_min,
    Heatpump_Constants_P_el_HP_min) annotation (Line(points={{-82,75},{
          -90,75},{-90,60},{-120,60}}, color={0,0,127}));
  connect(stSp_excess_power_PV_OR_tp_TES_max.Heatpump_Constants_tp_TES_max_set,
    Heatpump_Constants_tp_TES_max_set) annotation (Line(points={{-82,-5},
          {-90,-5},{-90,-20},{-120,-20}}, color={0,0,127}));
    connect(stSp_excess_power_PV_OR_tp_TES_max.tp_TES_load, T_TES_load)
      annotation (Line(points={{-82,5},{-90,5},{-90,20},{-120,20}}, color={0,
            0,127}));
  connect(stSp_excess_power_PV_OR_tp_TES_max.OS_tp_TES_max, and3.u2)
    annotation (Line(points={{-59,0},{-50,0},{-50,32},{-42,32}}, color={
          255,0,255}));
  connect(stSp_excess_power_PV_OR_excess_power.OS_excess_power, and3.u1)
    annotation (Line(points={{-59,80},{-50,80},{-50,40},{-42,40}}, color=
          {255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPump_StSp_excess_power_PV;
