within Q100_DistrictModel.UnitController.HeatPump.OR_Heatpump_StSp_Co2_intensity;
model StSp_CO2_intensity_OR_HP_hysteresis
  Modelica.Blocks.Interfaces.BooleanOutput OS_HP_hysteresis
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput tp_TES_unload
    "Temperature heat storage " annotation (Placement(transformation(
          extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput tp_DH_FF_set
    "Temperature heating grid" annotation (Placement(transformation(
          extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(less.y, OS_HP_hysteresis)
    annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  connect(less.u1, tp_TES_unload) annotation (Line(points={{-12,0},{-50,
          0},{-50,50},{-120,50}}, color={0,0,127}));
  connect(less.u2, tp_DH_FF_set) annotation (Line(points={{-12,-8},{-50,
          -8},{-50,-50},{-120,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_CO2_intensity_OR_HP_hysteresis;
