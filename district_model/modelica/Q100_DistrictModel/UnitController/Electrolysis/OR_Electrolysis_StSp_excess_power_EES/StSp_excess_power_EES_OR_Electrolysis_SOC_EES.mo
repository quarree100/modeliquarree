within Q100_DistrictModel.UnitController.Electrolysis.OR_Electrolysis_StSp_excess_power_EES;
model StSp_excess_power_EES_OR_Electrolysis_SOC_EES
  Modelica.Blocks.Interfaces.BooleanOutput OS_SOC_EES
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput SOC_EES
    "state of charge - electrical storage" annotation (Placement(
        transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput Electrolysis_Constants_storage_el_SOC_threshold
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Components.Hysteresis_var hysteresis_var annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Math.Gain gain(k=1.01)
      annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
equation
    connect(OS_SOC_EES, hysteresis_var.y)
      annotation (Line(points={{110,0},{11,0}}, color={255,0,255}));
    connect(SOC_EES, hysteresis_var.u) annotation (Line(points={{-120,50},{
            -18,50},{-18,0},{-12,0}}, color={0,0,127}));
  connect(Electrolysis_Constants_storage_el_SOC_threshold, hysteresis_var.uLow)
    annotation (Line(points={{-120,-50},{-18,-50},{-18,-8},{-12,-8}}, color={0,
          0,127}));
  connect(Electrolysis_Constants_storage_el_SOC_threshold, gain.u) annotation (
      Line(points={{-120,-50},{-68,-50},{-68,20},{-62,20}}, color={0,0,127}));
    connect(gain.y, hysteresis_var.uHigh) annotation (Line(points={{-39,20},
            {-30,20},{-30,8},{-12,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_excess_power_EES_OR_Electrolysis_SOC_EES;
