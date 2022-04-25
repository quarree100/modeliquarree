within Q100_DistrictModel.UnitController;
package Boiler
  model Boiler_Controller
    Modelica.Blocks.Interfaces.RealInput T_DH_FF annotation (Placement(
          transformation(extent={{-116,12},{-100,28}}), iconTransformation(
            extent={{-116,12},{-100,28}})));
    Modelica.Blocks.Interfaces.RealInput T_DH_FF_set annotation (Placement(
          transformation(extent={{-116,-28},{-100,-12}}),
                                                        iconTransformation(
            extent={{-116,-28},{-100,-12}})));
    Modelica.Blocks.Logical.Less less
      annotation (Placement(transformation(extent={{-50,-22},{-30,-2}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Blocks.Interfaces.RealInput u_chp_oa annotation (Placement(
          transformation(extent={{-116,-108},{-100,-92}}),iconTransformation(
            extent={{-116,-108},{-100,-92}})));
    Modelica.Blocks.Interfaces.RealInput staus_chp annotation (Placement(
          transformation(extent={{-116,-68},{-100,-52}}),
                                                       iconTransformation(
            extent={{-116,-68},{-100,-52}})));
    Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=-0.001)
      annotation (Placement(transformation(extent={{-90,-100},{-70,-80}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
      annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
    Modelica.Blocks.Math.BooleanToReal
                                   booleanToReal
      annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
    Modelica.Blocks.Interfaces.RealOutput Boiler_Specification_Value
      "1 wenn in Betrieb, 0 wenn nicht" annotation (Placement(transformation(
            extent={{100,-6},{112,6}}), iconTransformation(extent={{100,-6},{
              112,6}})));
    Modelica.Blocks.Interfaces.BooleanOutput Boiler_Specification_SI
      annotation (Placement(transformation(extent={{100,-86},{112,-74}}),
          iconTransformation(extent={{100,-86},{112,-74}})));
    Modelica.Blocks.Interfaces.RealInput signal_Boiler_prio_int annotation (
        Placement(transformation(extent={{-114,90},{-100,104}}),
          iconTransformation(extent={{-116,88},{-100,104}})));
    Modelica.Blocks.Interfaces.RealInput signal_Boiler_prio_ext annotation (
        Placement(transformation(extent={{-116,52},{-100,68}}),
          iconTransformation(extent={{-116,52},{-100,68}})));
    Modelica.Blocks.Logical.And and2
      annotation (Placement(transformation(extent={{-10,60},{10,80}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
         -0.001)
      annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(threshold=
         -0.001)
      annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
    Modelica.Blocks.Logical.Or  and3
      annotation (Placement(transformation(extent={{32,-10},{52,10}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold2(threshold=
         0.001)
      annotation (Placement(transformation(extent={{20,80},{40,100}})));
    Modelica.Blocks.Logical.Or or2
      annotation (Placement(transformation(extent={{30,40},{50,60}})));
    Modelica.Blocks.Logical.And and4
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Blocks.Logical.LessThreshold         lessThreshold1(threshold=-0.001)
      annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
    Modelica.Blocks.Logical.And and5
      annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
    MultiMax multiMax(nu=3)
      annotation (Placement(transformation(extent={{74,34},{86,46}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{70,50},{90,70}})));
    Modelica.Blocks.Sources.Constant const1(k=0)   annotation (
      Placement(visible = true, transformation(origin={30,-70},       extent={{-10,-10},
              {10,10}},                                                                                rotation = 0)));
    Modelica.Blocks.Math.BooleanToReal
                                   booleanToReal1
      annotation (Placement(transformation(extent={{70,80},{90,100}})));
  equation
    connect(T_DH_FF, less.u1) annotation (Line(points={{-108,20},{-64,20},{-64,
            -12},{-52,-12}},
                           color={0,0,127}));
    connect(T_DH_FF_set, less.u2) annotation (Line(points={{-108,-20},{-52,-20}},
                               color={0,0,127}));
    connect(less.y, and1.u1) annotation (Line(points={{-29,-12},{-20,-12},{-20,
            -40},{-12,-40}},
                 color={255,0,255}));
    connect(u_chp_oa, lessThreshold.u)
      annotation (Line(points={{-108,-100},{-96,-100},{-96,-90},{-92,-90}},
                                                      color={0,0,127}));
    connect(staus_chp, greaterThreshold.u)
      annotation (Line(points={{-108,-60},{-92,-60}},
                                                  color={0,0,127}));
    connect(greaterThreshold.y, or1.u1) annotation (Line(points={{-69,-60},{-52,
            -60}},                color={255,0,255}));
    connect(lessThreshold.y, or1.u2) annotation (Line(points={{-69,-90},{-60,
            -90},{-60,-68},{-52,-68}}, color={255,0,255}));
    connect(or1.y, and1.u2) annotation (Line(points={{-29,-60},{-20,-60},{-20,
            -48},{-12,-48}},
          color={255,0,255}));
    connect(greaterEqualThreshold.u, signal_Boiler_prio_int) annotation (Line(
          points={{-62,80},{-84,80},{-84,97},{-107,97}}, color={0,0,127}));
    connect(greaterEqualThreshold1.u, signal_Boiler_prio_ext)
      annotation (Line(points={{-62,50},{-80,50},{-80,60},{-108,60}},
                                                    color={0,0,127}));
    connect(greaterEqualThreshold1.y, and2.u2) annotation (Line(points={{-39,50},
            {-20,50},{-20,62},{-12,62}}, color={255,0,255}));
    connect(greaterEqualThreshold.y, and2.u1) annotation (Line(points={{-39,80},
            {-20,80},{-20,70},{-12,70}}, color={255,0,255}));
    connect(and2.y, and3.u1) annotation (Line(points={{11,70},{24,70},{24,0},{
            30,0}}, color={255,0,255}));
    connect(greaterEqualThreshold2.u, signal_Boiler_prio_int) annotation (Line(
          points={{18,90},{-20,90},{-20,97},{-107,97}}, color={0,0,127}));
    connect(greaterEqualThreshold2.y, or2.u1) annotation (Line(points={{41,90},
            {48,90},{48,74},{28,74},{28,50}}, color={255,0,255}));
    connect(and3.y, or2.u2) annotation (Line(points={{53,0},{56,0},{56,20},{28,
            20},{28,42}}, color={255,0,255}));
    connect(or2.y, Boiler_Specification_SI) annotation (Line(points={{51,50},{
            62,50},{62,-80},{106,-80}}, color={255,0,255}));
    connect(greaterEqualThreshold.y, and4.u1) annotation (Line(points={{-39,80},
            {-20,80},{-20,62},{-18,62},{-18,30},{-12,30}}, color={255,0,255}));
    connect(lessThreshold1.u, signal_Boiler_prio_ext) annotation (Line(points={
            {-52,20},{-62,20},{-62,34},{-80,34},{-80,60},{-108,60}}, color={0,0,
            127}));
    connect(lessThreshold1.y, and4.u2) annotation (Line(points={{-29,20},{-18,
            20},{-18,22},{-12,22}}, color={255,0,255}));
    connect(and4.y, and5.u1) annotation (Line(points={{11,30},{16,30},{16,12},{
            -16,12},{-16,-2},{-12,-2}}, color={255,0,255}));
    connect(and1.y, and5.u2) annotation (Line(points={{11,-40},{16,-40},{16,-20},
            {-16,-20},{-16,-10},{-12,-10}}, color={255,0,255}));
    connect(and5.y, and3.u2) annotation (Line(points={{11,-2},{24,-2},{24,-8},{
            30,-8}}, color={255,0,255}));
    connect(booleanToReal.y, multiMax.u[1]) annotation (Line(points={{91,-30},{96,-30},{96,-2},{66,-2},{66,36},{74,36},{74,42.8}},
                                                              color={0,0,127}));
    connect(multiMax.y, Boiler_Specification_Value) annotation (Line(points={{
            87.02,40},{96,40},{96,0},{106,0}}, color={0,0,127}));
    connect(switch1.y, multiMax.u[2]) annotation (Line(points={{91,60},{94,60},
            {94,48},{66,48},{66,36},{74,36},{74,40}}, color={0,0,127}));
    connect(and2.y, switch1.u2) annotation (Line(points={{11,70},{50,70},{50,64},
            {62,64},{62,60},{68,60}}, color={255,0,255}));
    connect(signal_Boiler_prio_ext, switch1.u1) annotation (Line(points={{-108,
            60},{-80,60},{-80,34},{-16,34},{-16,56},{26,56},{26,70},{30,70},{30,
            72},{62,72},{62,74},{68,74},{68,68}}, color={0,0,127}));
    connect(const1.y, switch1.u3) annotation (Line(points={{41,-70},{48,-70},{
            48,-18},{66,-18},{66,-4},{64,-4},{64,46},{68,46},{68,52}}, color={0,
            0,127}));
    connect(and5.y, booleanToReal.u) annotation (Line(points={{11,-2},{24,-2},{
            24,-30},{68,-30}}, color={255,0,255}));
    connect(greaterEqualThreshold2.y, booleanToReal1.u)
      annotation (Line(points={{41,90},{68,90}}, color={255,0,255}));
    connect(booleanToReal1.y, multiMax.u[3]) annotation (Line(points={{91,90},{100,90},{100,48},{66,48},{66,36},{74,36},{74,37.2}},
                                                               color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Boiler_Controller;
end Boiler;
