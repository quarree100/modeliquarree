within Q100_DistrictModel.ElectrolysisSystem.HeatPump;
model Check
  extends Modelica.Icons.Example;
  HeatPump heatPump(param_P_el=100e3, param_T_init=50 + 273.15)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=333.15)
    annotation (Placement(transformation(extent={{-106,-66},{-86,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-106,-80},{-86,-60}})));
  AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-58,-72},{-38,-52}})));
  AixLib.FastHVAC.Components.Sinks.Vessel vessel_cond
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Modelica.Blocks.Sources.Step           step(
    height=20,
    offset=323.15,
    startTime=100)
    annotation (Placement(transformation(extent={{94,62},{74,82}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=0.5)
    annotation (Placement(transformation(extent={{94,44},{74,64}})));
  AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource1
    annotation (Placement(transformation(extent={{42,50},{22,70}})));
  AixLib.FastHVAC.Components.Sinks.Vessel vessel_evap
    annotation (Placement(transformation(extent={{-22,50},{-42,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=50e3)
    annotation (Placement(transformation(extent={{-76,-16},{-56,4}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=20,
    freqHz=1/1200,
    offset=323.15)
    annotation (Placement(transformation(extent={{68,80},{48,100}})));
  Modelica.Blocks.Sources.BooleanExpression
                                         booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-78,4},{-58,24}})));
equation
  connect(realExpression.y,fluidSource. dotm) annotation (Line(points={{-85,-70},{-82,-70},{-82,-64.6},{-56,-64.6}}, color={0,0,127}));
  connect(realExpression1.y,fluidSource. T_fluid) annotation (Line(points={{-85,-56},{-80,-56},{-80,-57.8},{-56,
          -57.8}},                                                                                                       color={0,0,127}));
  connect(fluidSource.enthalpyPort_b, heatPump.port_cond_in) annotation (Line(
        points={{-38,-61},{-38,-60},{-18,-60},{-18,-18}}, color={176,0,0}));
  connect(vessel_cond.enthalpyPort_a, heatPump.port_cond_out)
    annotation (Line(points={{43,-60},{18,-60},{18,-18}}, color={176,0,0}));
  connect(fluidSource1.dotm, realExpression3.y)
    annotation (Line(points={{40,57.4},{57,57.4},{57,54},{73,54}}, color={0,0,127}));
  connect(fluidSource1.enthalpyPort_b, heatPump.port_evap_in) annotation (Line(
        points={{22,61},{22,39.5},{18,39.5},{18,18}}, color={176,0,0}));
  connect(heatPump.port_evap_out, vessel_evap.enthalpyPort_a)
    annotation (Line(points={{-18,18},{-18,60},{-25,60}}, color={176,0,0}));
  connect(realExpression4.y, heatPump.inp_P_av)
    annotation (Line(points={{-55,-6},{-44,-6},{-44,6},{-22,6}},
                                               color={0,0,127}));
  connect(booleanExpression.y, heatPump.inp_offSwitch)
    annotation (Line(points={{-57,14},{-22,14}}, color={255,0,255}));
  connect(step.y, fluidSource1.T_fluid) annotation (Line(points={{73,72},{58,72},
          {58,64.2},{40,64.2}}, color={0,0,127}));
  annotation (experiment(StopTime=10000, __Dymola_NumberOfIntervals=1000));
end Check;
