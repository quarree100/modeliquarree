within Q100_DistrictModel.Components.ElectrolysisSystem.Heater;
model Heater

  parameter SI.Power param_P_el_max = 10e3 "maximum power consumption" annotation (Dialog(group="heater parameters"));
  parameter SI.Efficiency param_eta = 0.99 "electrical efficiency of heater" annotation (Dialog(group="heater parameters"));

  parameter SI.Temperature param_T_op = 65+273.15 "temperature up to which heater is active" annotation (Dialog(group="stack parameters"));
  parameter SI.Temperature param_T_op_min = 60+273.15 "temperature at which heating is started again" annotation (Dialog(group="stack parameters"));

  SI.Energy var_P_cons(start=0.0, fixed=true)
    "integrated power consumption";
  Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
    "integrated power consumption in kWh";

  // connector
  Tools.Connectors.PowerConnector port_P_el "actual power consumption" annotation (Placement(
        transformation(extent={{-100,-100},{-80,-80}}), iconTransformation(extent={{-140,-100},{
            -100,-60}})));

  // in- and output
  Modelica.Blocks.Interfaces.RealInput inp_T_is "current temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput inp_P_av "power avaiable"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealOutput out_P_heat annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={
            {100,-10},{120,10}})));
  Modelica.Blocks.Math.Min block_min
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Modelica.Blocks.Math.Gain block_gain(k=param_eta)
    annotation (Placement(transformation(extent={{82,-6},{94,6}})));
  Modelica.Blocks.Sources.RealExpression exp_P_av(y=max(inp_P_av, 0))
    annotation (Placement(transformation(extent={{-38,-16},{-18,4}})));
  Modelica.Blocks.Logical.Hysteresis block_hysteresis(uLow=param_T_op_min,
      uHigh=param_T_op)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Tools.Components.Switch block_switch
    annotation (Placement(transformation(extent={{22,10},{42,-10}})));
  Modelica.Blocks.Logical.Not block_inv
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Modelica.Blocks.Sources.RealExpression exp_P_max(y=param_P_el_max)
    annotation (Placement(transformation(extent={{-38,-4},{-18,16}})));
  Modelica.Blocks.Continuous.FirstOrder block_firstOrder(T=6,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
equation

  // power consumption
  port_P_el.P = max(block_firstOrder.y,0);
  der(var_P_cons) = port_P_el.P;

  connect(exp_P_av.y, block_min.u2)
    annotation (Line(points={{-17,-6},{-8,-6}},
                                              color={0,0,127}));
  connect(block_hysteresis.y, block_inv.u)
    annotation (Line(points={{-59,-40},{-52,-40}}, color={255,0,255}));
  connect(block_min.y, block_switch.u)
    annotation (Line(points={{15,0},{20,0}}, color={0,0,127}));
  connect(block_gain.y, out_P_heat)
    annotation (Line(points={{94.6,0},{110,0}}, color={0,0,127}));
  connect(block_min.u1, exp_P_max.y)
    annotation (Line(points={{-8,6},{-17,6}}, color={0,0,127}));
  connect(block_inv.y, block_switch.onOffSignal)
    annotation (Line(points={{-29,-40},{32,-40},{32,-12}}, color={255,0,255}));
  connect(inp_T_is, block_hysteresis.u) annotation (Line(points={{-120,0},{-90,0},
          {-90,-40},{-82,-40}}, color={0,0,127}));
  connect(block_firstOrder.y, block_gain.u)
    annotation (Line(points={{75,0},{80.8,0}}, color={0,0,127}));
  connect(block_firstOrder.u, block_switch.y)
    annotation (Line(points={{52,0},{44,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-26,90},{30,-66}},
          lineColor={0,0,0},
          textString="q"),
        Text(
          extent={{-28,166},{28,10}},
          lineColor={0,0,0},
          textString="."),              Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Heater;
