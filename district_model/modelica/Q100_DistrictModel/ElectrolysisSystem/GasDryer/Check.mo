within Q100_DistrictModel.ElectrolysisSystem.GasDryer;
model Check
extends Modelica.Icons.Example;
  GasDryer gasDryer(param_use_water_outlet=false)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  SI.MolarFlowRate n_dot = 1;
  Modelica.Blocks.Sources.Sine sine_signal(freqHz = 0.1, offset = 0.8)  annotation (
    Placement(visible = true, transformation(origin = {-84, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ElectrolysisSystem.Tools.Boundaries.GasSource gasSource(T=338.15) annotation (Placement(
        visible=true, transformation(
        origin={-80,-36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  gasDryer.port_inlet_gas.n_flow = sine_signal.y;
  gasDryer.port_inlet_gas.p = 1e5;
  gasDryer.port_inlet_gas.h = gasSource.gasConnector.h;
  gasDryer.port_inlet_gas.X = {0.9,0.1};
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=120, __Dymola_NumberOfIntervals=5000));
end Check;
