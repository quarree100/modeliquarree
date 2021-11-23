within Q100_DistrictModel.Components.ElectrolysisSystem.Pump;
model Check
extends Modelica.Icons.Example;
  Pump pump
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(T0=323.15, m_fluid=10)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  Modelica.Blocks.Sources.Ramp           ramp1(height=pump.param_Q_max, duration=10e10)
    annotation (Placement(transformation(extent={{-28,72},{-8,92}})));
equation
  connect(pump.port_outlet, workingFluid.enthalpyPort_b) annotation (Line(
        points={{10,0},{32,0},{32,-80},{9,-80}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_a, pump.port_inlet) annotation (Line(points=
         {{-9,-80},{-40,-80},{-40,0},{-10,0}}, color={176,0,0}));
  connect(ramp1.y, pump.inp_Q)
    annotation (Line(points={{-7,82},{-7,47},{0,47},{0,11}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100000000000, __Dymola_NumberOfIntervals=10000));
end Check;
