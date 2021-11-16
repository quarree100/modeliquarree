within Q100_DistrictModel.Components.ElectrolysisSystem.Cooler;
model Check "electrolyser system with all components"
extends Modelica.Icons.Example;

  // components

  AirCooler airCoolerNewNew(param_T_Set=318.15, param_T_init=328.15)
    annotation (Placement(transformation(extent={{18,-6},{38,14}})));
  Modelica.Blocks.Sources.RealExpression T_amb(y=15 + 273.15)
    annotation (Placement(transformation(extent={{-22,2},{-2,22}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=5)
    annotation (Placement(transformation(extent={{-78,-40},{-58,-20}})));
  Modelica.Blocks.Sources.Ramp           ramp(
    height=40,
    duration=10e6,
    offset=40 + 273.15,
    startTime=0)
    annotation (Placement(transformation(extent={{-74,-78},{-54,-58}})));
  AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-20,-40},{0,-60}})));
  AixLib.FastHVAC.Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{54,-46},{74,-26}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=10e3)
    annotation (Placement(transformation(extent={{-36,-20},{-16,0}})));
equation

  connect(T_amb.y, airCoolerNewNew.inp_T_Amb)
    annotation (Line(points={{-1,12},{17,12}}, color={0,0,127}));
  connect(airCoolerNewNew.port_outlet, vessel.enthalpyPort_a) annotation (Line(
        points={{37,-6},{37,-21},{57,-21},{57,-36}}, color={176,0,0}));
  connect(airCoolerNewNew.port_inlet, fluidSource.enthalpyPort_b) annotation (
      Line(points={{19,-6},{10,-6},{10,-51},{0,-51}}, color={176,0,0}));
  connect(realExpression.y, fluidSource.dotm) annotation (Line(points={{-57,-30},
          {-36,-30},{-36,-47.4},{-18,-47.4}}, color={0,0,127}));
  connect(ramp.y, fluidSource.T_fluid) annotation (Line(points={{-53,-68},{-36,
          -68},{-36,-54.2},{-18,-54.2}}, color={0,0,127}));
  connect(booleanStep.y, airCoolerNewNew.inp_offSwitch) annotation (Line(points=
         {{-15,-10},{0,-10},{0,6},{17,6}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000000, __Dymola_NumberOfIntervals=10000));
end Check;
