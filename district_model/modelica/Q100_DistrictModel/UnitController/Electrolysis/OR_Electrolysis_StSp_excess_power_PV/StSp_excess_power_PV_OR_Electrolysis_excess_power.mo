within Q100_DistrictModel.UnitController.Electrolysis.OR_Electrolysis_StSp_excess_power_PV;
model StSp_excess_power_PV_OR_Electrolysis_excess_power
  Modelica.Blocks.Interfaces.BooleanOutput OS_excess_power
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput P_el_renergy annotation (
      Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput Electrolysis_Constants_P_el_HP_min
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation
  connect(greaterEqual.y, OS_excess_power)
    annotation (Line(points={{13,0},{110,0}}, color={255,0,255}));
  connect(greaterEqual.u1, P_el_renergy) annotation (Line(points={{-10,
          0},{-50,0},{-50,50},{-120,50}}, color={0,0,127}));
  connect(greaterEqual.u2, Electrolysis_Constants_P_el_HP_min) annotation (Line(
        points={{-10,-8},{-50,-8},{-50,-50},{-120,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end StSp_excess_power_PV_OR_Electrolysis_excess_power;
