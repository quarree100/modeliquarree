within Q100_DistrictModel.UnitController.TES;
model TES_StSp
  Modelica.Blocks.Interfaces.RealInput P_th_DH_supply annotation (Placement(
        transformation(extent={{-116,74},{-100,90}}),iconTransformation(extent={{-116,74},
            {-100,90}})));
  Modelica.Blocks.Interfaces.RealInput P_th_DH_demand annotation (Placement(
        transformation(extent={{-116,50},{-100,66}}),iconTransformation(extent={{-116,50},
            {-100,66}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_unload annotation (Placement(
        transformation(extent={{-116,24},{-100,40}}),iconTransformation(extent={{-116,24},
            {-100,40}})));
  Modelica.Blocks.Interfaces.RealInput T_DH_RF annotation (Placement(
        transformation(extent={{-116,0},{-100,16}}),iconTransformation(extent={{-116,0},
            {-100,16}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_load annotation (Placement(
        transformation(extent={{-116,-28},{-100,-12}}),iconTransformation(
          extent={{-116,-28},{-100,-12}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_max_set annotation (Placement(
        transformation(extent={{-116,-44},{-100,-28}}),iconTransformation(
          extent={{-116,-44},{-100,-28}})));
  TES_StSp_OR_heat_demand tES_StSp_OR_heat_demand "True wenn supply < demand"
    annotation (Placement(transformation(extent={{-62,48},{-42,68}})));
  TES_StSp_OR_min_storage_temp tES_StSp_OR_min_storage_temp
    "True wenn Anforderungen für load/unload erfüllt sind, siehe Variablenbeschreibung"
    annotation (Placement(transformation(extent={{-62,-38},{-42,-18}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{6,26},{26,46}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{6,-10},{26,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{46,26},{66,46}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-12,32},{-2,42}})));
  Modelica.Blocks.Interfaces.RealOutput P_th_TES
    ">0 für load, <0 für unload, 0 undefined"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{28,24},{36,32}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{28,40},{36,48}})));
  Modelica.Blocks.Sources.Constant const2(k=-1)
    annotation (Placement(transformation(extent={{28,4},{36,12}})));
  Modelica.Blocks.Interfaces.RealInput P_th_TES_load annotation (Placement(
        transformation(extent={{-116,-76},{-100,-60}}),iconTransformation(
          extent={{-106,-54},{-94,-42}})));
  Modelica.Blocks.Interfaces.RealInput P_th_TES_unload annotation (Placement(
        transformation(extent={{-116,-92},{-100,-76}}),iconTransformation(
          extent={{-106,-68},{-94,-56}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-84,-86},{-64,-66}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-74,80},{-64,90}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-58,80},{-48,90}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-42,-86},{-22,-66}})));
  Modelica.Blocks.Math.Min min1
    annotation (Placement(transformation(extent={{-2,-86},{18,-66}})));
  Modelica.Blocks.Sources.Constant const3(k=1)
    annotation (Placement(transformation(extent={{-20,-88},{-12,-80}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{54,-86},{74,-66}})));
equation
  connect(P_th_DH_supply, tES_StSp_OR_heat_demand.P_th_DH_supply) annotation (
      Line(points={{-108,82},{-82,82},{-82,64},{-64,64},{-64,62.8}}, color={0,0,
          127}));
  connect(P_th_DH_demand, tES_StSp_OR_heat_demand.P_th_DH_demand) annotation (
      Line(points={{-108,58},{-70,58},{-70,53.2},{-64,53.2}}, color={0,0,127}));
  connect(T_TES_unload, tES_StSp_OR_min_storage_temp.T_TES_unload) annotation (
      Line(points={{-108,32},{-68,32},{-68,-20.6},{-63.4,-20.6}},
                                                                color={0,0,127}));
  connect(T_DH_RF, tES_StSp_OR_min_storage_temp.T_DH_RF) annotation (Line(
        points={{-108,8},{-72,8},{-72,-25.6},{-63.4,-25.6}},
                                                           color={0,0,127}));
  connect(T_TES_load, tES_StSp_OR_min_storage_temp.T_TES_load) annotation (Line(
        points={{-108,-20},{-82,-20},{-82,-31},{-63.4,-31}},
                                                           color={0,0,127}));
  connect(T_TES_max_set, tES_StSp_OR_min_storage_temp.T_TES_max_set)
    annotation (Line(points={{-108,-36},{-66,-36},{-66,-35.4},{-63.6,-35.4}},
        color={0,0,127}));
  connect(tES_StSp_OR_min_storage_temp.TES_OS_load, and1.u2) annotation (Line(
        points={{-41,-33},{-26,-33},{-26,-34},{-10,-34},{-10,28},{4,28}}, color=
         {255,0,255}));
  connect(and1.y, switch1.u2)
    annotation (Line(points={{27,36},{44,36}}, color={255,0,255}));
  connect(and2.y, switch2.u2)
    annotation (Line(points={{27,0},{44,0}}, color={255,0,255}));
  connect(tES_StSp_OR_heat_demand.TES_StSp_OR_heat_demand_SI, not1.u)
    annotation (Line(points={{-41,58},{-18,58},{-18,37},{-13,37}}, color={255,0,
          255}));
  connect(not1.y, and1.u1)
    annotation (Line(points={{-1.5,37},{-1.5,36},{4,36}}, color={255,0,255}));
  connect(const.y, switch1.u3)
    annotation (Line(points={{36.4,28},{44,28}}, color={0,0,127}));
  connect(const1.y, switch1.u1)
    annotation (Line(points={{36.4,44},{44,44}}, color={0,0,127}));
  connect(switch1.y, switch2.u3) annotation (Line(points={{67,36},{72,36},{72,
          -14},{44,-14},{44,-8}}, color={0,0,127}));
  connect(const2.y, switch2.u1)
    annotation (Line(points={{36.4,8},{44,8}}, color={0,0,127}));
  connect(tES_StSp_OR_min_storage_temp.TES_OS_unload, and2.u2) annotation (Line(
        points={{-41,-23},{-24,-23},{-24,-8},{4,-8}}, color={255,0,255}));
  connect(tES_StSp_OR_heat_demand.TES_StSp_OR_heat_demand_SI, and2.u1)
    annotation (Line(points={{-41,58},{-18,58},{-18,0},{4,0}}, color={255,0,255}));
  connect(and1.y, switch3.u2) annotation (Line(points={{27,36},{38,36},{38,-14},
          {32,-14},{32,-60},{-86,-60},{-86,-76}}, color={255,0,255}));
  connect(P_th_TES_load, switch3.u1) annotation (Line(points={{-108,-68},{-86,
          -68}},                     color={0,0,127}));
  connect(P_th_TES_unload, switch3.u3)
    annotation (Line(points={{-108,-84},{-86,-84}}, color={0,0,127}));
  connect(P_th_DH_supply, add.u1) annotation (Line(points={{-108,82},{-82,82},{
          -82,88},{-75,88}}, color={0,0,127}));
  connect(P_th_DH_demand, add.u2)
    annotation (Line(points={{-108,58},{-75,58},{-75,82}}, color={0,0,127}));
  connect(add.y, abs1.u)
    annotation (Line(points={{-63.5,85},{-59,85}}, color={0,0,127}));
  connect(switch3.y, division.u2) annotation (Line(points={{-63,-76},{-50,-76},
          {-50,-82},{-44,-82}}, color={0,0,127}));
  connect(abs1.y, division.u1) annotation (Line(points={{-47.5,85},{-38,85},{
          -38,-54},{-50,-54},{-50,-70},{-44,-70}}, color={0,0,127}));
  connect(division.y, min1.u1) annotation (Line(points={{-21,-76},{-12,-76},{
          -12,-70},{-4,-70}}, color={0,0,127}));
  connect(const3.y, min1.u2) annotation (Line(points={{-11.6,-84},{-8,-84},{-8,
          -82},{-4,-82}}, color={0,0,127}));
  connect(min1.y, product1.u2) annotation (Line(points={{19,-76},{44,-76},{44,
          -82},{52,-82}}, color={0,0,127}));
  connect(switch2.y, product1.u1) annotation (Line(points={{67,0},{74,0},{74,
          -58},{42,-58},{42,-70},{52,-70}}, color={0,0,127}));
  connect(product1.y, P_th_TES) annotation (Line(points={{75,-76},{94,-76},{94,
          0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TES_StSp;
