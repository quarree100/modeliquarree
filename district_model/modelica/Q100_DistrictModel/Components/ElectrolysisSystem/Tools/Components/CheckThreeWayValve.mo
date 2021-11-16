within Q100_DistrictModel.Components.ElectrolysisSystem.Tools.Components;
model CheckThreeWayValve "check for three way valve"
  extends Modelica.Icons.Example;
  AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-68,-10},{-50,8}})));
  AixLib.FastHVAC.Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Modelica.Blocks.Sources.RealExpression mflow1(y=5)
    annotation (Placement(transformation(extent={{-118,-14},{-98,6}})));
  Modelica.Blocks.Sources.RealExpression T1(y=25 + 273.15)
    annotation (Placement(transformation(extent={{-118,6},{-98,26}})));
  AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve
    annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));
  Modelica.Blocks.Sources.RealExpression T2(y=0.2)
    annotation (Placement(transformation(extent={{-20,22},{0,42}})));
  Components.ThreeWayConnector threeWayConnector
    annotation (Placement(transformation(extent={{28,-10},{8,10}})));
equation
  connect(mflow1.y, fluidSource.dotm) annotation (Line(points={{-97,-4},{-82,-4},
          {-82,-3.34},{-66.2,-3.34}}, color={0,0,127}));
  connect(T1.y, fluidSource.T_fluid) annotation (Line(points={{-97,16},{-82,16},
          {-82,2.78},{-66.2,2.78}}, color={0,0,127}));
  connect(fluidSource.enthalpyPort_b, threeWayValve.enthalpyPort_ab)
    annotation (Line(points={{-50,-0.1},{-30,-0.1},{-30,0},{-25.8,0}}, color={
          176,0,0}));
  connect(T2.y, threeWayValve.opening) annotation (Line(points={{1,32},{16,32},
          {16,18},{-16,18},{-16,9}}, color={0,0,127}));
  connect(threeWayValve.enthalpyPort_a, threeWayConnector.inlet1)
    annotation (Line(points={{-6,0},{8,0}}, color={176,0,0}));
  connect(threeWayValve.enthalpyPort_b, threeWayConnector.inlet2) annotation (
      Line(points={{-16,-10},{-16,-20},{18,-20},{18,-10}}, color={176,0,0}));
  connect(threeWayConnector.outlet, vessel.enthalpyPort_a)
    annotation (Line(points={{27.8,0},{49,0}}, color={176,0,0}));
  annotation (experiment(StopTime=30));
end CheckThreeWayValve;
