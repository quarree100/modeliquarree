within Q100_DistrictModel.Components.ElectrolysisSystem.Model;
model CheckStack
  extends Modelica.Icons.Example;
  Stack                                  stack(
  redeclare model CellModel = SimpleModel.Cell,
  param_stack_p_op_cathode=100000,
  param_stack_p_op_anode=100000)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(T0=323.15, m_fluid=1000) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-32,-68})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0.005) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,-42})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=500e3,
    duration=1e7,
    startTime=0)   annotation (Placement(transformation(extent={{-88,-12},{-68,
            8}})));
  Pump.Pump pump annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-38})));
equation

  connect(stack.port_inlet_cooling, pump.port_outlet)
    annotation (Line(points={{-10,-18},{-10,-28}}, color={176,0,0}));
  connect(pump.port_inlet, workingFluid.enthalpyPort_b) annotation (Line(
        points={{-10,-48},{-10,-68},{-23,-68}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_a, stack.port_outlet_cooling) annotation (
      Line(points={{-41,-68},{-54,-68},{-54,-90},{10,-90},{10,-18}}, color={176,
          0,0}));
  connect(realExpression2.y, pump.inp_Q)
    annotation (Line(points={{-77,-42},{-64,-42},{-64,-38},{-21,-38}},
                                                   color={0,0,127}));
  connect(ramp.y, stack.inp_P_av)
    annotation (Line(points={{-67,-2},{-22,-2}}, color={0,0,127}));
  connect(stack.inp_P_av_tot, stack.inp_P_av)
    annotation (Line(points={{-22,6},{-54,6},{-54,-2},{-22,-2}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000000, __Dymola_NumberOfIntervals=10000));
end CheckStack;
