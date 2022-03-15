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
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
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
      annotation (Placement(transformation(extent={{-88,-86},{-68,-66}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
      annotation (Placement(transformation(extent={{-88,-50},{-68,-30}})));
    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
    Modelica.Blocks.Math.BooleanToReal
                                   booleanToReal
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
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
      annotation (Placement(transformation(extent={{-10,70},{10,90}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
         -0.001)
      annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
    Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(threshold=
         -0.001)
      annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
    Modelica.Blocks.Logical.And and3
      annotation (Placement(transformation(extent={{24,-10},{44,10}})));
  equation
    connect(T_DH_FF, less.u1) annotation (Line(points={{-108,20},{-64,20},{-64,
            0},{-52,0}},   color={0,0,127}));
    connect(T_DH_FF_set, less.u2) annotation (Line(points={{-108,-20},{-64,-20},
            {-64,-8},{-52,-8}},color={0,0,127}));
    connect(less.y, and1.u1) annotation (Line(points={{-29,0},{-20,0},{-20,-40},
            {-12,-40}},
                 color={255,0,255}));
    connect(u_chp_oa, lessThreshold.u)
      annotation (Line(points={{-108,-100},{-96,-100},{-96,-76},{-90,-76}},
                                                      color={0,0,127}));
    connect(staus_chp, greaterThreshold.u)
      annotation (Line(points={{-108,-60},{-96,-60},{-96,-40},{-90,-40}},
                                                  color={0,0,127}));
    connect(greaterThreshold.y, or1.u1) annotation (Line(points={{-67,-40},{-60,
            -40},{-60,-60},{-52,-60}},
                                  color={255,0,255}));
    connect(lessThreshold.y, or1.u2) annotation (Line(points={{-67,-76},{-60,
            -76},{-60,-68},{-52,-68}}, color={255,0,255}));
    connect(or1.y, and1.u2) annotation (Line(points={{-29,-60},{-20,-60},{-20,
            -48},{-12,-48}},
          color={255,0,255}));
    connect(booleanToReal.y, Boiler_Specification_Value)
      annotation (Line(points={{81,0},{106,0}}, color={0,0,127}));
    connect(greaterEqualThreshold.u, signal_Boiler_prio_int) annotation (Line(
          points={{-62,90},{-84,90},{-84,97},{-107,97}}, color={0,0,127}));
    connect(greaterEqualThreshold1.u, signal_Boiler_prio_ext)
      annotation (Line(points={{-62,60},{-108,60}}, color={0,0,127}));
    connect(greaterEqualThreshold1.y, and2.u2) annotation (Line(points={{-39,60},
            {-20,60},{-20,72},{-12,72}}, color={255,0,255}));
    connect(greaterEqualThreshold.y, and2.u1) annotation (Line(points={{-39,90},
            {-20,90},{-20,80},{-12,80}}, color={255,0,255}));
    connect(and3.y, Boiler_Specification_SI) annotation (Line(points={{45,0},{
            50,0},{50,-80},{106,-80}}, color={255,0,255}));
    connect(and1.y, and3.u2) annotation (Line(points={{11,-40},{16,-40},{16,-8},
            {22,-8}}, color={255,0,255}));
    connect(and2.y, and3.u1) annotation (Line(points={{11,80},{16,80},{16,0},{
            22,0}}, color={255,0,255}));
    connect(and3.y, booleanToReal.u)
      annotation (Line(points={{45,0},{58,0}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Boiler_Controller;
end Boiler;
