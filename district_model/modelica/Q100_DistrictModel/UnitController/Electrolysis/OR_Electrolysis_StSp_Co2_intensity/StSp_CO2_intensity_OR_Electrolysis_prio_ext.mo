within Q100_DistrictModel.UnitController.Electrolysis.OR_Electrolysis_StSp_Co2_intensity;
model StSp_CO2_intensity_OR_Electrolysis_prio_ext
  Modelica.Blocks.Interfaces.BooleanOutput OS_Electrolysis_prio_ext
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_Electrolysis_prio_ext
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Logical.LessThreshold         lessThreshold(threshold=-0.01)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation
  connect(lessThreshold.u, signal_Electrolysis_prio_ext)
    annotation (Line(points={{-10,0},{-120,0}}, color={0,0,127}));
  connect(lessThreshold.y, OS_Electrolysis_prio_ext)
    annotation (Line(points={{13,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_CO2_intensity_OR_Electrolysis_prio_ext;
