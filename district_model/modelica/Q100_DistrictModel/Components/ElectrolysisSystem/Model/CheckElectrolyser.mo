within Q100_DistrictModel.Components.ElectrolysisSystem.Model;
model CheckElectrolyser "check of temperature-controlled electrolyser system"
  extends Modelica.Icons.Example;

  Electrolyser                                  detailedElectrolyser(
  redeclare model CellModel = SimpleModel.Cell,
  param_stack_p_op_cathode=100000,
  param_stack_p_op_anode=100000,
    param_n_comp_h2=7)
    annotation (Placement(transformation(extent={{-16,-16},{16,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=10 + 273.15)
                                                                     annotation (Placement(transformation(extent={{-84,-40},
            {-64,-20}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(T0=detailedElectrolyser.param_stack_T_init,
                                                                   m_fluid=1000)    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={0,-70})));
  Modelica.Blocks.Sources.Constant
                               const(k=100e3)
    annotation (Placement(transformation(extent={{-72,-6},{-52,14}})));
equation

  connect(detailedElectrolyser.port_outlet_cooling, workingFluid.enthalpyPort_a)
    annotation (Line(points={{10,-14},{10,-40},{40,-40},{40,-70},{9,-70}},
        color={176,0,0}));
  connect(detailedElectrolyser.port_inlet_cooling, workingFluid.enthalpyPort_b)
    annotation (Line(points={{-10,-14},{-10,-40},{-40,-40},{-40,-70},{-9,-70}},
        color={176,0,0}));
  connect(realExpression2.y, detailedElectrolyser.inp_T_air) annotation (Line(
        points={{-63,-30},{-40,-30},{-40,-4},{-17,-4}}, color={0,0,127}));
  connect(const.y, detailedElectrolyser.inp_P_av)
    annotation (Line(points={{-51,4},{-17,4}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=100000,
      __Dymola_NumberOfIntervals=10000,
      __Dymola_Algorithm="Cvode"));
end CheckElectrolyser;
