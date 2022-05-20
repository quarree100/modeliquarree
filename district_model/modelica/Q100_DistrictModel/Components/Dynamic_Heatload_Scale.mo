within Q100_DistrictModel.Components;
model Dynamic_Heatload_Scale "Scales the heat load depending on the heating grid and ambient temperature"
  replaceable Modelica.Blocks.Interfaces.RealInput Qdot_heatload annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Qdot_heatload_scaled annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  replaceable Modelica.Blocks.Interfaces.RealInput T_amb annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={50,-120})));
  replaceable Modelica.Blocks.Interfaces.RealInput T_heatgrid_FF annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-120})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(extent={{60,20},{70,30}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=60 + 5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-55,-65})));
  Modelica.Blocks.Math.Max max1 annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={45,-65})));
  Modelica.Blocks.Sources.Constant T_low_limit(k=15) annotation (Placement(visible=true, transformation(
        origin={95,-95},
        extent={{5,-5},{-5,5}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant const1(k=1)    annotation (
    Placement(visible = true, transformation(origin={-95,-45},       extent={{-5,-5},{5,5}},          rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-45,-25})));
  Modelica.Blocks.Logical.GreaterEqual greaterEqual annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={5,-45})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={15,5})));
  Modelica.Blocks.Sources.Constant const2(k=0)    annotation (
    Placement(visible = true, transformation(origin={95,-25},        extent={{5,-5},{-5,5}},          rotation = 0)));
  Calc_Dynamic_Heatload_Scalefactor calc_Dynamic_Heatload_Scalefactor annotation (Placement(transformation(extent={{-10,-60},{-30,-40}})));
  Modelica.Blocks.Sources.Constant T_difference_HeatExchanger(k=5) annotation (Placement(visible=true, transformation(
        origin={5,-85},
        extent={{-5,-5},{5,5}},
        rotation=0)));
  Modelica.Blocks.Math.Add add(k2=+1) annotation (Placement(transformation(extent={{22,-90},{32,-80}})));
equation
  connect(realToBoolean.u, T_heatgrid_FF) annotation (Line(points={{-55,-71},{-55,-96},{-50,-96},{-50,-120}}, color={0,0,127}));
  connect(T_low_limit.y, max1.u2) annotation (Line(points={{89.5,-95},{56,-95},{56,-71},{48,-71}}, color={0,0,127}));
  connect(const1.y, switch1.u1) annotation (Line(points={{-89.5,-45},{-56,-45},{-56,-31},{-49,-31}}, color={0,0,127}));
  connect(realToBoolean.y, switch1.u2) annotation (Line(points={{-55,-59.5},{-55,-46},{-45,-46},{-45,-31}}, color={255,0,255}));
  connect(max1.y, greaterEqual.u2) annotation (Line(points={{45,-59.5},{44,-59.5},{44,-54},{16,-54},{16,-51},{9,-51}}, color={0,0,127}));
  connect(T_heatgrid_FF, greaterEqual.u1) annotation (Line(points={{-50,-120},{-50,-88},{-14,-88},{-14,-66},{4,-66},{4,-54},{5,-54},{5,-51}}, color={0,0,127}));
  connect(greaterEqual.y, switch2.u2) annotation (Line(points={{5,-39.5},{4,-39.5},{4,-4},{15,-4},{15,-1}}, color={255,0,255}));
  connect(switch1.y, switch2.u1) annotation (Line(points={{-45,-19.5},{-45,-1},{11,-1}}, color={0,0,127}));
  connect(const2.y, switch2.u3) annotation (Line(points={{89.5,-25},{24,-25},{24,-1},{19,-1}}, color={0,0,127}));
  connect(switch2.y, product1.u2) annotation (Line(points={{15,10.5},{14,10.5},{14,22},{59,22}}, color={0,0,127}));
  connect(Qdot_heatload, product1.u1) annotation (Line(points={{-120,0},{-46,0},{-46,28},{59,28}}, color={0,0,127}));
  connect(product1.y, Qdot_heatload_scaled) annotation (Line(points={{70.5,25},{96,25},{96,0},{110,0}}, color={0,0,127}));
  connect(T_heatgrid_FF, calc_Dynamic_Heatload_Scalefactor.T_heatgrid_FF) annotation (Line(points={{-50,-120},{-50,-88},{-15,-88},{-15,-62}}, color={0,0,127}));
  connect(max1.y, calc_Dynamic_Heatload_Scalefactor.T_amb) annotation (Line(points={{45,-59.5},{44,-59.5},{44,-54},{26,-54},{26,-68},{-25,-68},{-25,-62}}, color={0,0,127}));
  connect(calc_Dynamic_Heatload_Scalefactor.Qdot_heatload_scalefactor, switch1.u3) annotation (Line(points={{-31,-50},{-36,-50},{-36,-31},{-41,-31}}, color={0,0,127}));
  connect(T_difference_HeatExchanger.y, add.u1) annotation (Line(points={{10.5,-85},{16,-85},{16,-82},{21,-82}}, color={0,0,127}));
  connect(add.u2, T_amb) annotation (Line(points={{21,-88},{16,-88},{16,-94},{50,-94},{50,-120}}, color={0,0,127}));
  connect(add.y, max1.u1) annotation (Line(points={{32.5,-85},{36,-85},{36,-71},{42,-71}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Dynamic_Heatload_Scale;
