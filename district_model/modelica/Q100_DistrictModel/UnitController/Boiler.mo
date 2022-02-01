within Q100_DistrictModel.UnitController;
package Boiler
  model Boiler_Controller
    Modelica.Blocks.Interfaces.RealInput T_DH_FF annotation (Placement(
          transformation(extent={{-116,40},{-100,56}}), iconTransformation(
            extent={{-116,40},{-100,56}})));
    Modelica.Blocks.Interfaces.RealInput T_DH_FF_set annotation (Placement(
          transformation(extent={{-116,26},{-100,42}}), iconTransformation(
            extent={{-116,26},{-100,42}})));
    Modelica.Blocks.Logical.Less less
      annotation (Placement(transformation(extent={{-56,34},{-36,54}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{14,-10},{34,10}})));
    Modelica.Blocks.Interfaces.RealInput u_chp_oa annotation (Placement(
          transformation(extent={{-116,-44},{-100,-28}}), iconTransformation(
            extent={{-116,-44},{-100,-28}})));
    Modelica.Blocks.Interfaces.RealInput staus_chp annotation (Placement(
          transformation(extent={{-116,-8},{-100,8}}), iconTransformation(
            extent={{-116,-8},{-100,8}})));
    Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=-0.001)
      annotation (Placement(transformation(extent={{-88,-46},{-68,-26}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
      annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{-40,-24},{-20,-4}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{68,-4},{76,4}})));
    Modelica.Blocks.Interfaces.RealOutput status_boiler
      "1 wenn in Betrieb, 0 wenn nicht" annotation (Placement(transformation(
            extent={{100,-6},{112,6}}), iconTransformation(extent={{100,-6},{
              112,6}})));
    Modelica.Blocks.Sources.Constant const(k=1)
      annotation (Placement(transformation(extent={{48,4},{56,12}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{48,-14},{56,-6}})));
  equation
    connect(T_DH_FF, less.u1) annotation (Line(points={{-108,48},{-66,48},{-66,
            44},{-58,44}}, color={0,0,127}));
    connect(T_DH_FF_set, less.u2) annotation (Line(points={{-108,34},{-64,34},{
            -64,36},{-58,36}}, color={0,0,127}));
    connect(less.y, and1.u1) annotation (Line(points={{-35,44},{6,44},{6,0},{12,
            0}}, color={255,0,255}));
    connect(u_chp_oa, lessThreshold.u)
      annotation (Line(points={{-108,-36},{-90,-36}}, color={0,0,127}));
    connect(staus_chp, greaterThreshold.u)
      annotation (Line(points={{-108,0},{-90,0}}, color={0,0,127}));
    connect(greaterThreshold.y, or1.u1) annotation (Line(points={{-67,0},{-50,0},
            {-50,-14},{-42,-14}}, color={255,0,255}));
    connect(lessThreshold.y, or1.u2) annotation (Line(points={{-67,-36},{-50,
            -36},{-50,-22},{-42,-22}}, color={255,0,255}));
    connect(or1.y, and1.u2) annotation (Line(points={{-19,-14},{12,-14},{12,-8}},
          color={255,0,255}));
    connect(and1.y, switch1.u2)
      annotation (Line(points={{35,0},{67.2,0}}, color={255,0,255}));
    connect(switch1.y, status_boiler)
      annotation (Line(points={{76.4,0},{106,0}}, color={0,0,127}));
    connect(const.y, switch1.u1) annotation (Line(points={{56.4,8},{60,8},{60,4},
            {67.2,4},{67.2,3.2}}, color={0,0,127}));
    connect(const1.y, switch1.u3) annotation (Line(points={{56.4,-10},{60,-10},
            {60,-4},{67.2,-4},{67.2,-3.2}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Boiler_Controller;
end Boiler;
