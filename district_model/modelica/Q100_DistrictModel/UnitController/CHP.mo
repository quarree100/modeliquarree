within Q100_DistrictModel.UnitController;
package CHP
  model CHP_controller
    Modelica.Blocks.Interfaces.RealInput T_DH_FF_set annotation (Placement(
          transformation(extent={{-112,-26},{-100,-14}}),iconTransformation(
            extent={{-112,-26},{-100,-14}})));
    Modelica.Blocks.Interfaces.RealInput T_TES_FF annotation (Placement(
          transformation(extent={{-112,-66},{-100,-54}}),iconTransformation(
            extent={{-112,-66},{-100,-54}})));
    CHP_StSp_auto cHP_StSp_auto
      "True wenn Betrieb vom StSp_Auto gefordert wird"
      annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
    CHP_StSp_prio_ext cHP_StSp_prio_ext
      "True wenn Betrieb vom StSp_prio_ext gefordert wird"
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    CHP_StSp_prio_int cHP_StSp_prio_int
      "True wenn Betrieb vom StSp_prio_int gefordert wird"
      annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_ext annotation (
        Placement(transformation(extent={{-112,14},{-100,26}}),
          iconTransformation(extent={{-112,14},{-100,26}})));
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_int annotation (
        Placement(transformation(extent={{-112,54},{-100,66}}),
          iconTransformation(extent={{-112,54},{-100,66}})));
    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{-20,24},{0,44}})));
    Modelica.Blocks.Logical.Or or2
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    Modelica.Blocks.Interfaces.RealOutput CHP_Specification_Value
      "1 wenn in Betrieb, 0 wenn nicht" annotation (Placement(transformation(
            extent={{100,-6},{112,6}}), iconTransformation(extent={{100,-6},{
              112,6}})));
    Modelica.Blocks.Interfaces.BooleanOutput CHP_Specification_SI annotation (
        Placement(transformation(extent={{100,-46},{112,-34}}),
          iconTransformation(extent={{100,-46},{112,-34}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  equation
    connect(T_DH_FF_set, cHP_StSp_auto.T_DH_FF_set) annotation (Line(points={{-106,
            -20},{-80,-20},{-80,47.4},{-60.6,47.4}},    color={0,0,127}));
    connect(T_TES_FF, cHP_StSp_auto.T_TES_FF) annotation (Line(points={{-106,
            -60},{-76,-60},{-76,45},{-60.6,45}},
                                               color={0,0,127}));
    connect(signal_CHP_prio_ext, cHP_StSp_auto.signal_CHP_prio_ext) annotation (
       Line(points={{-106,20},{-66,20},{-66,57},{-60,57}}, color={0,0,127}));
    connect(signal_CHP_prio_int, cHP_StSp_auto.signal_CHP_prio_int) annotation (
       Line(points={{-106,60},{-72,60},{-72,53.8},{-60,53.8}}, color={0,0,127}));
    connect(signal_CHP_prio_ext, cHP_StSp_prio_ext.signal_CHP_prio_ext)
      annotation (Line(points={{-106,20},{-66,20},{-66,17},{-60,17}}, color={0,
            0,127}));
    connect(signal_CHP_prio_int, cHP_StSp_prio_int.signal_CHP_prio_int)
      annotation (Line(points={{-106,60},{-72,60},{-72,-46.2},{-60,-46.2}},
          color={0,0,127}));
    connect(cHP_StSp_prio_int.StSp_prio_int_SI, or2.u2) annotation (Line(points={{-39,-50},
            {12,-50},{12,-8},{18,-8}},             color={255,0,255}));
    connect(cHP_StSp_prio_ext.StSp_prio_ext_SI, or1.u2) annotation (Line(points={{-39,10},
            {-28,10},{-28,26},{-22,26}},        color={255,0,255}));
    connect(cHP_StSp_auto.StSp_Auto_SI, or1.u1) annotation (Line(points={{-39,50},
            {-28,50},{-28,34},{-22,34}},     color={255,0,255}));
    connect(or1.y, or2.u1) annotation (Line(points={{1,34},{12,34},{12,0},{18,0}},
                                 color={255,0,255}));
    connect(or2.y, CHP_Specification_SI) annotation (Line(points={{41,0},{44,0},
            {44,-40},{106,-40}}, color={255,0,255}));
    connect(booleanToReal.y, CHP_Specification_Value)
      annotation (Line(points={{81,0},{106,0}}, color={0,0,127}));
    connect(or2.y, booleanToReal.u)
      annotation (Line(points={{41,0},{58,0}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CHP_controller;

  model CHP_StSp_auto
    Modelica.Blocks.Logical.Less less
      annotation (Placement(transformation(extent={{-60,-52},{-40,-32}})));
    Modelica.Blocks.Interfaces.RealInput T_DH_FF_set annotation (Placement(
          transformation(extent={{-112,-32},{-100,-20}}),iconTransformation(
            extent={{-112,-32},{-100,-20}})));
    Modelica.Blocks.Interfaces.RealInput T_TES_FF annotation (Placement(
          transformation(extent={{-112,-56},{-100,-44}}),iconTransformation(
            extent={{-112,-56},{-100,-44}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-20,42},{0,62}})));
    Modelica.Blocks.Logical.And and2
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput StSp_Auto_SI
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_ext annotation (
        Placement(transformation(extent={{-112,56},{-100,68}}),
          iconTransformation(extent={{-106,64},{-94,76}})));
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_int annotation (
        Placement(transformation(extent={{-112,24},{-100,36}}),
          iconTransformation(extent={{-106,32},{-94,44}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
         -0.001)
      annotation (Placement(transformation(extent={{-68,52},{-48,72}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(threshold=
         -0.001)
      annotation (Placement(transformation(extent={{-68,20},{-48,40}})));
  equation
    connect(T_DH_FF_set, less.u2) annotation (Line(points={{-106,-26},{-32,-26},
            {-32,-56},{-72,-56},{-72,-50},{-62,-50}},
                                            color={0,0,127}));
    connect(T_TES_FF, less.u1) annotation (Line(points={{-106,-50},{-80,-50},{
            -80,-42},{-62,-42}}, color={0,0,127}));
    connect(and1.y, and2.u1) annotation (Line(points={{1,52},{32,52},{32,0},{38,
            0}}, color={255,0,255}));
    connect(less.y, and2.u2) annotation (Line(points={{-39,-42},{32,-42},{32,-8},
            {38,-8}}, color={255,0,255}));
    connect(and2.y, StSp_Auto_SI)
      annotation (Line(points={{61,0},{110,0}}, color={255,0,255}));
    connect(signal_CHP_prio_int, greaterEqualThreshold1.u)
      annotation (Line(points={{-106,30},{-70,30}}, color={0,0,127}));
    connect(signal_CHP_prio_ext, greaterEqualThreshold.u)
      annotation (Line(points={{-106,62},{-70,62}}, color={0,0,127}));
    connect(greaterEqualThreshold.y, and1.u1) annotation (Line(points={{-47,62},
            {-30,62},{-30,52},{-22,52}}, color={255,0,255}));
    connect(greaterEqualThreshold1.y, and1.u2) annotation (Line(points={{-47,30},
            {-28,30},{-28,44},{-22,44}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CHP_StSp_auto;

  model CHP_StSp_prio_ext
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_ext annotation (
        Placement(transformation(extent={{-112,-6},{-100,6}}),
          iconTransformation(extent={{-106,64},{-94,76}})));
    Modelica.Blocks.Interfaces.BooleanOutput StSp_prio_ext_SI
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=-0.001)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(signal_CHP_prio_ext, greaterThreshold.u)
      annotation (Line(points={{-106,0},{-12,0}}, color={0,0,127}));
    connect(greaterThreshold.y, StSp_prio_ext_SI)
      annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
    connect(StSp_prio_ext_SI, StSp_prio_ext_SI)
      annotation (Line(points={{110,0},{110,0}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CHP_StSp_prio_ext;

  model CHP_StSp_prio_int
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_int annotation (
        Placement(transformation(extent={{-112,-6},{-100,6}}),
          iconTransformation(extent={{-106,32},{-94,44}})));
    Modelica.Blocks.Interfaces.BooleanOutput StSp_prio_int_SI
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=-0.001)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(signal_CHP_prio_int, greaterThreshold.u)
      annotation (Line(points={{-106,0},{-12,0}}, color={0,0,127}));
    connect(greaterThreshold.y, StSp_prio_int_SI)
      annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CHP_StSp_prio_int;

end CHP;
