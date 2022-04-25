within Q100_DistrictModel.UnitController;
package CHP
  model CHP_controller
    Modelica.Blocks.Interfaces.RealInput T_DH_FF_set annotation (Placement(
          transformation(extent={{-112,-66},{-100,-54}}),iconTransformation(
            extent={{-112,-66},{-100,-54}})));
    Modelica.Blocks.Interfaces.RealInput T_TES_FF annotation (Placement(
          transformation(extent={{-112,-106},{-100,-94}}),
                                                         iconTransformation(
            extent={{-112,-106},{-100,-94}})));
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
        Placement(transformation(extent={{-112,-26},{-100,-14}}),
          iconTransformation(extent={{-112,-26},{-100,-14}})));
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_int annotation (
        Placement(transformation(extent={{-112,14},{-100,26}}),
          iconTransformation(extent={{-112,14},{-100,26}})));
    Modelica.Blocks.Interfaces.RealOutput CHP_Specification_Value
      "1 wenn in Betrieb, 0 wenn nicht" annotation (Placement(transformation(
            extent={{100,-6},{112,6}}), iconTransformation(extent={{100,-6},{
              112,6}})));
    Modelica.Blocks.Interfaces.BooleanOutput CHP_Specification_SI annotation (
        Placement(transformation(extent={{100,-46},{112,-34}}),
          iconTransformation(extent={{100,-46},{112,-34}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal1
      annotation (Placement(transformation(extent={{-20,40},{0,60}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal2
      annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
    MultiMax multiMax(nu=3)
      annotation (Placement(transformation(extent={{44,-6},{56,6}})));
    Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=0.001)
      annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    Modelica.Blocks.Sources.Constant const1(k=0)   annotation (
      Placement(visible = true, transformation(origin={-50,-90},      extent={{-10,-10},
              {10,10}},                                                                                rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_status_Heatpump annotation (Placement(transformation(extent={{-112,94},{-100,106}}), iconTransformation(extent={{-112,94},{-100,106}})));
    Modelica.Blocks.Interfaces.RealInput u_Heatpump_oa annotation (Placement(transformation(extent={{-112,54},{-100,66}}), iconTransformation(extent={{-112,54},{-100,66}})));
  equation
    connect(T_DH_FF_set, cHP_StSp_auto.T_DH_FF_set) annotation (Line(points={{-106,-60},{-80,-60},{-80,40},{-60.6,40}},
                                                        color={0,0,127}));
    connect(T_TES_FF, cHP_StSp_auto.T_TES_FF) annotation (Line(points={{-106,-100},{-76,-100},{-76,44},{-60.6,44}},
                                               color={0,0,127}));
    connect(signal_CHP_prio_ext, cHP_StSp_auto.signal_CHP_prio_ext) annotation (
       Line(points={{-106,-20},{-66,-20},{-66,60},{-60.6,60}},
                                                           color={0,0,127}));
    connect(signal_CHP_prio_int, cHP_StSp_auto.signal_CHP_prio_int) annotation (
       Line(points={{-106,20},{-72,20},{-72,56},{-60.6,56}},   color={0,0,127}));
    connect(cHP_StSp_prio_ext.signal_CHP_prio_int, signal_CHP_prio_int)
      annotation (Line(points={{-60.6,4},{-72,4},{-72,20},{-106,20}}, color={0,
            0,127}));
    connect(signal_CHP_prio_ext, cHP_StSp_prio_ext.signal_CHP_prio_ext)
      annotation (Line(points={{-106,-20},{-66,-20},{-66,16},{-60.6,16}},
                                                                        color={
            0,0,127}));
    connect(cHP_StSp_prio_int.signal_CHP_prio_int, signal_CHP_prio_int)
      annotation (Line(points={{-60.6,-50},{-72,-50},{-72,20},{-106,20}}, color=
           {0,0,127}));
    connect(cHP_StSp_prio_int.StSp_prio_int_SI, booleanToReal2.u)
      annotation (Line(points={{-39,-50},{-22,-50}}, color={255,0,255}));
    connect(cHP_StSp_auto.StSp_Auto_SI, booleanToReal1.u)
      annotation (Line(points={{-39,50},{-22,50}}, color={255,0,255}));
    connect(booleanToReal1.y, multiMax.u[1]) annotation (Line(points={{1,50},{
            38,50},{38,2.8},{44,2.8}}, color={0,0,127}));
    connect(booleanToReal2.y, multiMax.u[2]) annotation (Line(points={{1,-50},{
            38,-50},{38,4.44089e-16},{44,4.44089e-16}}, color={0,0,127}));
    connect(realToBoolean.y, CHP_Specification_SI)
      annotation (Line(points={{81,-40},{106,-40}}, color={255,0,255}));
    connect(multiMax.y, realToBoolean.u) annotation (Line(points={{57.02,0},{62,
            0},{62,-20},{52,-20},{52,-40},{58,-40}}, color={0,0,127}));
    connect(multiMax.y, CHP_Specification_Value)
      annotation (Line(points={{57.02,0},{106,0}}, color={0,0,127}));
    connect(switch1.y, multiMax.u[3]) annotation (Line(points={{1,10},{38,10},{
            38,-2.8},{44,-2.8}}, color={0,0,127}));
    connect(cHP_StSp_prio_ext.StSp_prio_ext_SI, switch1.u2)
      annotation (Line(points={{-39,10},{-22,10}}, color={255,0,255}));
    connect(signal_CHP_prio_ext, switch1.u1) annotation (Line(points={{-106,-20},{-66,-20},{-66,-16},{-22,-16},{-22,18}},
                                                  color={0,0,127}));
    connect(const1.y, switch1.u3) annotation (Line(points={{-39,-90},{-32,-90},
            {-32,2},{-22,2}}, color={0,0,127}));
    connect(cHP_StSp_auto.u_Heatpump_oa, u_Heatpump_oa) annotation (Line(points={{-60.6,52},{-94,52},{-94,60},{-106,60}}, color={0,0,127}));
    connect(u_status_Heatpump, cHP_StSp_auto.u_status_Heatpump) annotation (Line(points={{-106,100},{-84,100},{-84,48},{-60.6,48}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CHP_controller;

  model CHP_StSp_auto
    Modelica.Blocks.Logical.Less less
      annotation (Placement(transformation(extent={{-60,-52},{-40,-32}})));
    Modelica.Blocks.Interfaces.RealInput T_DH_FF_set annotation (Placement(
          transformation(extent={{-112,-106},{-100,-94}}),
                                                         iconTransformation(
            extent={{-112,-106},{-100,-94}})));
    Modelica.Blocks.Interfaces.RealInput T_TES_FF annotation (Placement(
          transformation(extent={{-112,-66},{-100,-54}}),iconTransformation(
            extent={{-112,-66},{-100,-54}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-20,62},{0,82}})));
    Modelica.Blocks.Logical.And and2
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput StSp_Auto_SI
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_ext annotation (
        Placement(transformation(extent={{-112,94},{-100,106}}),
          iconTransformation(extent={{-112,94},{-100,106}})));
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_int annotation (
        Placement(transformation(extent={{-112,44},{-100,56}}),
          iconTransformation(extent={{-112,54},{-100,66}})));
    Modelica.Blocks.Logical.LessThreshold         lessThreshold(        threshold=
         -0.001)
      annotation (Placement(transformation(extent={{-68,70},{-48,90}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(threshold=
         -0.001)
      annotation (Placement(transformation(extent={{-68,40},{-48,60}})));
    Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold=-0.001)
      annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
      annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
    Modelica.Blocks.Interfaces.RealInput u_Heatpump_oa annotation (Placement(transformation(extent={{-116,-28},{-100,-12}}), iconTransformation(extent={{-112,14},{-100,26}})));
    Modelica.Blocks.Interfaces.RealInput u_status_Heatpump annotation (Placement(transformation(extent={{-116,12},{-100,28}}), iconTransformation(extent={{-112,-26},{-100,-14}})));
    Modelica.Blocks.Logical.And and3
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  equation
    connect(and1.y, and2.u1) annotation (Line(points={{1,72},{32,72},{32,0},{38,0}},
                 color={255,0,255}));
    connect(and2.y, StSp_Auto_SI)
      annotation (Line(points={{61,0},{110,0}}, color={255,0,255}));
    connect(lessThreshold.y, and1.u1) annotation (Line(points={{-47,80},{-30,80},{-30,72},{-22,72}},
                                color={255,0,255}));
    connect(greaterEqualThreshold1.y, and1.u2) annotation (Line(points={{-47,50},{-28,50},{-28,64},{-22,64}},
                                         color={255,0,255}));
    connect(T_TES_FF, less.u1) annotation (Line(points={{-106,-60},{-68,-60},{-68,-42},{-62,-42}},
                                 color={0,0,127}));
    connect(less.u2, T_DH_FF_set) annotation (Line(points={{-62,-50},{-62,-100},{-106,-100}},
                                   color={0,0,127}));
    connect(signal_CHP_prio_ext, lessThreshold.u)
      annotation (Line(points={{-106,100},{-88,100},{-88,80},{-70,80}},
                                                    color={0,0,127}));
    connect(signal_CHP_prio_int, greaterEqualThreshold1.u)
      annotation (Line(points={{-106,50},{-70,50}}, color={0,0,127}));
    connect(u_status_Heatpump, greaterThreshold.u) annotation (Line(points={{-108,20},{-92,20}}, color={0,0,127}));
    connect(greaterThreshold.y,or1. u1) annotation (Line(points={{-69,20},{-52,20}},
                                  color={255,0,255}));
    connect(lessThreshold1.y, or1.u2) annotation (Line(points={{-69,-10},{-60,-10},{-60,12},{-52,12}}, color={255,0,255}));
    connect(less.y, and3.u2) annotation (Line(points={{-39,-42},{-28,-42},{-28,-18},{-22,-18}}, color={255,0,255}));
    connect(or1.y, and3.u1) annotation (Line(points={{-29,20},{-24,20},{-24,-4},{-28,-4},{-28,-10},{-22,-10}}, color={255,0,255}));
    connect(and3.y, and2.u2) annotation (Line(points={{1,-10},{32,-10},{32,-8},{38,-8}}, color={255,0,255}));
    connect(lessThreshold1.u, u_Heatpump_oa) annotation (Line(points={{-92,-10},{-96,-10},{-96,-20},{-108,-20}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CHP_StSp_auto;

  model CHP_StSp_prio_ext
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_ext annotation (
        Placement(transformation(extent={{-112,-56},{-100,-44}}),
          iconTransformation(extent={{-112,54},{-100,66}})));
    Modelica.Blocks.Interfaces.BooleanOutput StSp_prio_ext_SI
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_int annotation (
        Placement(transformation(extent={{-112,44},{-100,56}}),
          iconTransformation(extent={{-112,-66},{-100,-54}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=-0.001)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  equation
    connect(signal_CHP_prio_ext, greaterThreshold.u)
      annotation (Line(points={{-106,-50},{-42,-50}},
                                                  color={0,0,127}));
    connect(StSp_prio_ext_SI, StSp_prio_ext_SI)
      annotation (Line(points={{110,0},{110,0}}, color={255,0,255}));
    connect(signal_CHP_prio_int, greaterThreshold1.u)
      annotation (Line(points={{-106,50},{-42,50}}, color={0,0,127}));
    connect(and1.y, StSp_prio_ext_SI)
      annotation (Line(points={{41,0},{110,0}}, color={255,0,255}));
    connect(greaterThreshold1.y, and1.u1) annotation (Line(points={{-19,50},{12,
            50},{12,0},{18,0}}, color={255,0,255}));
    connect(greaterThreshold.y, and1.u2) annotation (Line(points={{-19,-50},{12,
            -50},{12,-8},{18,-8}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CHP_StSp_prio_ext;

  model CHP_StSp_prio_int
    Modelica.Blocks.Interfaces.RealInput signal_CHP_prio_int annotation (
        Placement(transformation(extent={{-112,-6},{-100,6}}),
          iconTransformation(extent={{-112,-6},{-100,6}})));
    Modelica.Blocks.Interfaces.BooleanOutput StSp_prio_int_SI
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
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
