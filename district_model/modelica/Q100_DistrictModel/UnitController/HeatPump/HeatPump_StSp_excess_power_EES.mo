within Q100_DistrictModel.UnitController.HeatPump;
model HeatPump_StSp_excess_power_EES
  Modelica.Blocks.Interfaces.BooleanOutput Heatpump_Specification_StSp_excess_power_EES_SI
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_int
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_ext annotation (
      Placement(transformation(extent={{-140,-110},{-100,-70}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Logical.And and3
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Interfaces.RealInput SOC_EES
    "state of charge - electrical storage"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput Heatpump_Constants_storage_el_SOC_threshold
    "Electrical storage charge status threshold"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_unload
      "Temperature heat storage "
      annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput T_DH_FF_set "Temperature heating grid"
      annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  OR_Heatpump_StSp_excess_power_EES.StSp_excess_power_EES_OR_HP_prio_ext
    stSp_excess_power_EES_OR_HP_prio_ext
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  OR_Heatpump_StSp_excess_power_EES.StSp_excess_power_EES_OR_HP_prio_int
    stSp_excess_power_EES_OR_HP_prio_int
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  OR_Heatpump_StSp_excess_power_EES.StSp_excess_power_EES_OR_SOC_EES
    stSp_excess_power_EES_OR_SOC_EES
    "Battery discharge hysteresis: Only start discharging if the charge level is above 20% "
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  OR_Heatpump_StSp_excess_power_EES.StSp_excess_power_EES_OR_HP_hysteresis
    stSp_excess_power_EES_OR_HP_hysteresis
    "Only allow operation if the heat storage temprature falls below the heating grid temperature "
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(and1.y, Heatpump_Specification_StSp_excess_power_EES_SI)
    annotation (Line(points={{61,0},{110,0}}, color={255,0,255}));
  connect(and2.y, and1.u2) annotation (Line(points={{-19,-70},{32,-70},{
          32,-8},{38,-8}}, color={255,0,255}));
  connect(and3.y, and1.u1) annotation (Line(points={{-19,40},{32,40},{32,
          0},{38,0}}, color={255,0,255}));
  connect(stSp_excess_power_EES_OR_HP_prio_int.signal_HP_prio_int,
    signal_HP_prio_int)
    annotation (Line(points={{-82,-60},{-120,-60}}, color={0,0,127}));
  connect(stSp_excess_power_EES_OR_HP_prio_ext.signal_HP_prio_ext,
    signal_HP_prio_ext)
    annotation (Line(points={{-82,-90},{-120,-90}}, color={0,0,127}));
  connect(and2.u1, stSp_excess_power_EES_OR_HP_prio_int.OS_HP_prio_int)
    annotation (Line(points={{-42,-70},{-50,-70},{-50,-60},{-59,-60}},
        color={255,0,255}));
  connect(and2.u2, stSp_excess_power_EES_OR_HP_prio_ext.OS_HP_prio_ext)
    annotation (Line(points={{-42,-78},{-50,-78},{-50,-90},{-59,-90}},
        color={255,0,255}));
  connect(stSp_excess_power_EES_OR_SOC_EES.SOC_EES, SOC_EES) annotation (
      Line(points={{-82,85},{-90,85},{-90,90},{-120,90}}, color={0,0,127}));
  connect(stSp_excess_power_EES_OR_SOC_EES.Heatpump_Constants_storage_el_SOC_threshold,
    Heatpump_Constants_storage_el_SOC_threshold) annotation (Line(points=
          {{-82,75},{-90,75},{-90,60},{-120,60}}, color={0,0,127}));
  connect(stSp_excess_power_EES_OR_SOC_EES.OS_SOC_EES, and3.u1)
    annotation (Line(points={{-59,80},{-50,80},{-50,40},{-42,40}}, color=
          {255,0,255}));
    connect(stSp_excess_power_EES_OR_HP_hysteresis.tp_TES_unload,
      T_TES_unload) annotation (Line(points={{-82,5},{-90,5},{-90,20},{-120,
            20}}, color={0,0,127}));
    connect(stSp_excess_power_EES_OR_HP_hysteresis.tp_DH_FF_set, T_DH_FF_set)
      annotation (Line(points={{-82,-5},{-90,-5},{-90,-20},{-120,-20}}, color=
           {0,0,127}));
  connect(stSp_excess_power_EES_OR_HP_hysteresis.OS_HP_hysteresis, and3.u2)
    annotation (Line(points={{-59,0},{-50,0},{-50,32},{-42,32}}, color={
          255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPump_StSp_excess_power_EES;
