within Q100_DistrictModel.Components;
model Calc_Dynamic_Heatload_Scalefactor "Calculates the scale factor of the heat load depending on the heating grid and ambient temperature"
  Modelica.Blocks.Interfaces.RealOutput Qdot_heatload_scalefactor annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput T_amb annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={50,-120})));
  Modelica.Blocks.Interfaces.RealInput T_heatgrid_FF annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-120})));

  Modelica.Blocks.Sources.Constant const1(k=60)   annotation (
    Placement(visible = true, transformation(origin={-90,-50},       extent={{-10,-10},{10,10}},      rotation = 0)));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Math.Add add1(k2=-1) annotation (Placement(transformation(extent={{22,-60},{42,-40}})));
equation
  connect(const1.y, add.u1) annotation (Line(points={{-79,-50},{-70,-50},{-70,-44},{-62,-44}}, color={0,0,127}));
  connect(T_amb, add.u2) annotation (Line(points={{50,-120},{50,-94},{-68,-94},{-68,-56},{-62,-56}}, color={0,0,127}));
  connect(add.y, division.u2) annotation (Line(points={{-39,-50},{-20,-50},{-20,-6},{56,-6}}, color={0,0,127}));
  connect(T_heatgrid_FF, add1.u1) annotation (Line(points={{-50,-120},{-50,-70},{0,-70},{0,-44},{20,-44}}, color={0,0,127}));
  connect(add1.u2, T_amb) annotation (Line(points={{20,-56},{10,-56},{10,-94},{50,-94},{50,-120}}, color={0,0,127}));
  connect(add1.y, division.u1) annotation (Line(points={{43,-50},{50,-50},{50,6},{56,6}}, color={0,0,127}));
  connect(division.y, Qdot_heatload_scalefactor) annotation (Line(points={{79,0},{110,0}}, color={0,0,127}));
end Calc_Dynamic_Heatload_Scalefactor;
