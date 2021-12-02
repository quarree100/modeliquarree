within Q100_DistrictModel.UnitController.HeatPump;
model HeatPump_StSp_CO2_intensity
  Modelica.Blocks.Interfaces.BooleanOutput Heatpump_Specification_StSp_CO2_intensity_SI
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_int
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_ext annotation (
      Placement(transformation(extent={{-140,-110},{-100,-70}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Blocks.Logical.And and3
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Interfaces.RealInput carbon_intensity
    "carbon intensity of electrical power"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput Heatpump_Constants_carbon_intensity_threshold
    "carbon intensity threshold"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_unload
      "Temperature heat storage "
      annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput T_DH_FF_set "Temperature heating grid"
      annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  OR_Heatpump_StSp_Co2_intensity.StSp_CO2_intensity_OR_HP_prio_ext
    stSp_CO2_intensity_OR_HP_prio_ext
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  OR_Heatpump_StSp_Co2_intensity.StSp_CO2_intensity_OR_HP_prio_int
    stSp_CO2_intensity_OR_HP_prio_int
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  OR_Heatpump_StSp_Co2_intensity.StSp_CO2_intensity_OR_HP_hysteresis
    stSp_CO2_intensity_OR_HP_hysteresis
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  OR_Heatpump_StSp_Co2_intensity.StSp_CO2_intensity_OR_CO2_intensity
    stSp_CO2_intensity_OR_CO2_intensity
    "CO2 intensity must be below threshold carbon_intensity"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
equation
  connect(and1.y, Heatpump_Specification_StSp_CO2_intensity_SI)
    annotation (Line(points={{61,0},{110,0}}, color={255,0,255}));
  connect(and2.y, and1.u2) annotation (Line(points={{11,-70},{20,-70},{20,
          -8},{38,-8}}, color={255,0,255}));
  connect(and3.y, and1.u1) annotation (Line(points={{11,40},{20,40},{20,0},
          {38,0}}, color={255,0,255}));
  connect(signal_HP_prio_int, stSp_CO2_intensity_OR_HP_prio_int.signal_HP_prio_int)
    annotation (Line(points={{-120,-60},{-62,-60}}, color={0,0,127}));
  connect(signal_HP_prio_ext, stSp_CO2_intensity_OR_HP_prio_ext.signal_HP_prio_ext)
    annotation (Line(points={{-120,-90},{-62,-90}}, color={0,0,127}));
  connect(stSp_CO2_intensity_OR_HP_prio_int.OS_HP_prio_int, and2.u1)
    annotation (Line(points={{-39,-60},{-20,-60},{-20,-70},{-12,-70}},
        color={255,0,255}));
  connect(stSp_CO2_intensity_OR_HP_prio_ext.OS_HP_prio_ext, and2.u2)
    annotation (Line(points={{-39,-90},{-20,-90},{-20,-78},{-12,-78}},
        color={255,0,255}));
  connect(stSp_CO2_intensity_OR_HP_hysteresis.OS_HP_hysteresis, and3.u2)
    annotation (Line(points={{-39,0},{-20,0},{-20,32},{-12,32}}, color={
          255,0,255}));
    connect(stSp_CO2_intensity_OR_HP_hysteresis.tp_DH_FF_set, T_DH_FF_set)
      annotation (Line(points={{-62,-5},{-80,-5},{-80,-20},{-120,-20}}, color=
           {0,0,127}));
    connect(stSp_CO2_intensity_OR_HP_hysteresis.tp_TES_unload, T_TES_unload)
      annotation (Line(points={{-62,5},{-80,5},{-80,20},{-120,20}}, color={0,
            0,127}));
  connect(and3.u1, stSp_CO2_intensity_OR_CO2_intensity.OS_CO2_intensity)
    annotation (Line(points={{-12,40},{-20,40},{-20,80},{-39,80}}, color=
          {255,0,255}));
  connect(stSp_CO2_intensity_OR_CO2_intensity.carbon_intensity,
    carbon_intensity) annotation (Line(points={{-62,85},{-80,85},{-80,90},
          {-120,90}}, color={0,0,127}));
  connect(stSp_CO2_intensity_OR_CO2_intensity.Heatpump_Constants_carbon_intensity_threshold,
    Heatpump_Constants_carbon_intensity_threshold) annotation (Line(
        points={{-62,75},{-80,75},{-80,60},{-120,60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPump_StSp_CO2_intensity;
