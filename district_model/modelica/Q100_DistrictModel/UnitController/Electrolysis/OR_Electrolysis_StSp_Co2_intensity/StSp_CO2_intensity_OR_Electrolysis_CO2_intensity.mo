within Q100_DistrictModel.UnitController.Electrolysis.OR_Electrolysis_StSp_Co2_intensity;
model StSp_CO2_intensity_OR_Electrolysis_CO2_intensity
  Modelica.Blocks.Interfaces.BooleanOutput OS_CO2_intensity
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput carbon_intensity annotation (
      Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput Electrolysis_Constants_carbon_intensity_threshold
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Logical.LessEqual lessEqual
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(lessEqual.u2, Electrolysis_Constants_carbon_intensity_threshold)
    annotation (Line(points={{-12,-8},{-50,-8},{-50,-50},{-120,-50}}, color={0,
          0,127}));
  connect(lessEqual.u1, carbon_intensity) annotation (Line(points={{-12,
          0},{-50,0},{-50,50},{-120,50}}, color={0,0,127}));
  connect(lessEqual.y, OS_CO2_intensity)
    annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_CO2_intensity_OR_Electrolysis_CO2_intensity;
