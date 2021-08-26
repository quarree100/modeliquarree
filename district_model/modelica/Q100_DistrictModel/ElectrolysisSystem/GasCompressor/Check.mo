within Q100_DistrictModel.ElectrolysisSystem.GasCompressor;
model Check
extends Modelica.Icons.Example;
  H2Compressor h2Compressor(param_n_compStage=5)
                            annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Sine sine_signal(freqHz=0.1, offset=0.8)      annotation (
    Placement(visible = true, transformation(origin = {-84, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Tools.Boundaries.GasSource gasSource(T=368.15, p=300000) annotation (Placement(visible=true,
        transformation(
        origin={-80,-36},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  h2Compressor.port_inlet_gas.n_flow = sine_signal.y;
  h2Compressor.port_inlet_gas.p = 1e5;
  h2Compressor.port_inlet_gas.h = gasSource.gasConnector.h;
  h2Compressor.port_inlet_gas.X = {0.9,0.1};

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=120));
end Check;
