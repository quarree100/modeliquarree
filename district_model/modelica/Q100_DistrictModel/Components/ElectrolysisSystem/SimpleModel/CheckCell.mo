within Q100_DistrictModel.Components.ElectrolysisSystem.SimpleModel;
model CheckCell
extends Modelica.Icons.Example;

  ElectrolysisSystem.SimpleModel.Cell singleCell(param_p_op_cathode=100000,
      param_p_op_anode=100000)
    annotation (Placement(transformation(extent={{10,-12},{30,8}})));
  Modelica.Blocks.Sources.Ramp inp_current(
    height=2.5e4,
    duration=10e8,
    offset=0) "current input"
    annotation (Placement(transformation(extent={{-60,8},{-40,28}})));
  Modelica.Blocks.Sources.RealExpression inp_temperature(y=80 + 273.15)
    "cel temperature"
    annotation (Placement(transformation(extent={{-58,-42},{-38,-22}})));
equation

  connect(inp_current.y, singleCell.inp_i)
    annotation (Line(points={{-39,18},{-20,18},{-20,5},{9,5}},
                                                             color={0,0,127}));
  connect(inp_temperature.y, singleCell.inp_T) annotation (Line(points={{-37,
          -32},{-14,-32},{-14,1},{9,1}}, color={0,0,127}));
    annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000000000, __Dymola_NumberOfIntervals=100000));
end CheckCell;
