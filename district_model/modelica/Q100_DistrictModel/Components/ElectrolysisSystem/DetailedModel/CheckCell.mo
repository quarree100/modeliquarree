within Q100_DistrictModel.Components.ElectrolysisSystem.DetailedModel;
model CheckCell
extends Modelica.Icons.Example;

  ElectrolysisSystem.DetailedModel.Cell singleCell(
    param_p_op_cathode=3000000,
    param_p_op_anode=1400000,
    param_membrane_area=600e-4,
    param_membrane_d=150e-6)
    annotation (Placement(transformation(extent={{10,-12},{30,8}})));
  Modelica.Blocks.Sources.Ramp currentDensity(
    height=3e4,
    duration=10e10,
    offset=0) annotation (Placement(transformation(extent={{-58,12},{-38,32}})));
  Modelica.Blocks.Sources.RealExpression T_cell(y=80 + 273.15)
    annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
equation

  connect(currentDensity.y, singleCell.inp_i) annotation (Line(points={{-37,22},
          {-16,22},{-16,5},{9,5}}, color={0,0,127}));
  connect(T_cell.y, singleCell.inp_T) annotation (Line(points={{-39,-8},{-16,-8},
          {-16,1},{9,1}},      color={0,0,127}));
    annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100000000000, __Dymola_NumberOfIntervals=5000));
end CheckCell;
