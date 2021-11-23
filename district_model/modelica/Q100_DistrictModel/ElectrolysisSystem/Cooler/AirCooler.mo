within Q100_DistrictModel.ElectrolysisSystem.Cooler;
model AirCooler
  "cools fluid down to given setpoint temperature, new alpha model, with Power Connector"

 // medium to use
  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple water=
      AixLib.FastHVAC.Media.WaterSimple() "water inside heat exchanger";

  //parameters
  parameter SI.Temperature param_T_Set=298.15
    "setpoint temperature to which fluid is cooled"
    annotation (Dialog(group="operating parameters"));
  parameter SI.Temperature param_T_init=298.15
    "initial temperature of fluid inside heat exchanger"
    annotation (Dialog(group="operating parameters"));

  // for example: https://www.thermokey.de/uploads/media/Power_line_Power_J.pdf
  // WR1180.B (delta circuit)
  parameter SI.Power param_P_el=310
    "power consumption at design point (ENV 1048)"
    annotation (Dialog(group="design parameters"));
  parameter SI.Power param_P_cool=33.7e3
    "cooling power at design point (ENV 1048)"
    annotation (Dialog(group="design parameters"));
  parameter SI.VolumeFlowRate param_airflowrate=9000/3600
    "air flow rate at design point (ENV 1048)"
    annotation (Dialog(group="design parameters"));
  parameter SI.Distance param_d_radiator=0.8
    "diameter of radiator" annotation (Dialog(group="design parameters"));
  parameter Integer param_n_radiator=1 "number of radiators" annotation(Dialog(group="design parameters"));
  parameter SI.Area param_surfaceArea=113
    "surface area for heat transfer"
    annotation (Dialog(group="design parameters"));
  parameter SI.Volume param_V=0.022
    "inner volume of heat exchanger"
    annotation (Dialog(group="design parameters"));
  parameter SI.CoefficientOfHeatTransfer param_alpha_ambient=2.5
    "heat transfer coefficient to ambient without radiator"
    annotation (Dialog(group="design parameters"));

  // variables
  SI.Energy var_P_therm_rem(start=0.0, fixed=true) "intergrated removed heat";
  Real var_P_therm_rem_kWh = SI.Conversions.to_kWh(var_P_therm_rem) "intergrated removed heat in kWh";
  SI.Energy var_P_cons(start=0.0, fixed=true)
    "integrated power consumption";
  Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
    "integrated power consumption in kWh";
  SI.CoefficientOfHeatTransfer var_alpha_eff(start=
        param_alpha_ambient);
  Real var_delta_T(start=10, fixed=false) "mean temperature difference";

  // components
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_inlet(T(start=303.15, fixed=false))
    annotation (Placement(transformation(extent={{-100,-110},{-80,-90}}),
        iconTransformation(extent={{-100,-110},{-80,-90}})));
  Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-10,-114},
            {10,-94}}), iconTransformation(extent={{80,80},{120,120}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet(T(start=param_T_init,
        fixed=false))
    annotation (Placement(transformation(extent={{80,-110},{100,-90}}),
        iconTransformation(extent={{80,-110},{100,-90}})));
  Modelica.Blocks.Interfaces.RealInput inp_T_Amb(unit="K")
    "ambient temperature"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
  AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid comp_workingFluid(
    medium=water,
    m_fluid=param_V*water.rho,
    T0=param_T_init)
    annotation (Placement(transformation(extent={{-12,-62},{12,-38}})));
  Tools.Components.ThreeWayConnector threeWayConnector
    annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor meas_T_out
    annotation (Placement(transformation(extent={{72,-56},{84,-44}})));
  AixLib.Controls.Continuous.LimPID contr_valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.001,
    Ti=0.25,
    Td=0.25,
    yMax=1,
    reverseAction=true,
    reset=AixLib.Types.Reset.Parameter,
    y_reset=0) annotation (Placement(transformation(extent={{60,-6},{48,6}})));
  Modelica.Blocks.Sources.RealExpression exp_set_T_valve(y=param_T_Set)
    annotation (Placement(transformation(extent={{92,-10},{72,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_Q_res(T_ref=
        273.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-24})));

  AixLib.Controls.Continuous.LimPID contr_air_speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=10,
    Ti=1,
    Td=0.25,
    yMax=1,
    reverseAction=true,
    reset=AixLib.Types.Reset.Parameter,
    y_reset=0)
    annotation (Placement(transformation(extent={{38,36},{26,48}})));
  Modelica.Blocks.Sources.RealExpression exp_set_T_airspeed(y=param_T_Set)
    annotation (Placement(transformation(extent={{86,32},{66,52}})));
  Modelica.Blocks.Sources.RealExpression exp_meas_T_modified(y=if
        greaterEqualThreshold.y then meas_T_out.T else 0)
    "modifies measured temperature so that valve opens first, then ventilator"
    annotation (Placement(transformation(extent={{68,12},{48,32}})));
  Modelica.Blocks.Interfaces.BooleanInput inp_offSwitch
    "if true the cooler turns on"      annotation (Placement(transformation(
          extent={{-140,0},{-100,40}}), iconTransformation(extent={{-120,10},{
            -100,30}})));
  Tools.Components.Switch switch annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={-50,-16})));
  Modelica.Blocks.Math.Gain block_gain(k=param_air_speed)
    "multiply by max airspeed"
    annotation (Placement(transformation(extent={{10,36},{-2,48}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       0.99, y(start=false, fixed=false))
          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={20,14})));
  Modelica.Blocks.Sources.RealExpression exp_meas_T_modified1(y=if
        inp_offSwitch then meas_T_out.T else 0)
    "modifies measured temperature so that valve opens first, then ventilator"
    annotation (Placement(transformation(extent={{98,-26},{78,-6}})));
protected
  parameter SI.Velocity param_air_speed=param_airflowrate/
      param_n_radiator/(param_d_radiator^2/4*Const.pi)
    "velocity of air at design point";
  parameter SI.CoefficientOfHeatTransfer param_alpha_design=
      param_P_cool/param_surfaceArea/12.3316 "12.3316 is mean temperature difference ENV 1048";
  parameter Real param_corrector=param_alpha_design/(7.14*param_air_speed^(0.78))  "corrector for alpha";

//  SI.Temperature var_T_mod "modified temperature for air speed controller";

equation

  // simplified equation by Kuchling: Taschenbuch der Physik
  var_alpha_eff =max(7.14*block_gain.y^(0.78)/param_corrector, param_alpha_ambient);

  // only use cooler if outside is cool enough
  var_delta_T =max(comp_workingFluid.heatCapacitor.T - inp_T_Amb, 0);

  heatflow_Q_res.Q_flow = -var_alpha_eff*param_surfaceArea*var_delta_T;
  der(var_P_therm_rem) =port_inlet.m_flow*port_inlet.c*(port_inlet.T-port_outlet.T);

  // law of correlation P ~ (Q/Qref)^3
  port_P_el.P = param_P_el*((block_gain.y)/param_air_speed)^3;

  // integrator
  der(var_P_cons) = port_P_el.P;

  connect(threeWayValve.enthalpyPort_a, comp_workingFluid.enthalpyPort_a)
    annotation (Line(points={{-40,-50},{-10.8,-50}}, color={176,0,0}));
  connect(comp_workingFluid.enthalpyPort_b, threeWayConnector.inlet1)
    annotation (Line(points={{10.8,-50},{40,-50}}, color={176,0,0}));
  connect(threeWayValve.enthalpyPort_b, threeWayConnector.inlet2) annotation (
      Line(points={{-50,-60},{-50,-74},{50,-74},{50,-60}}, color={176,0,0}));
  connect(threeWayConnector.outlet, meas_T_out.enthalpyPort_a) annotation (Line(
        points={{59.8,-50},{66,-50},{66,-50.06},{72.72,-50.06}}, color={176,0,0}));
  connect(meas_T_out.enthalpyPort_b, port_outlet) annotation (Line(points={{83.4,
          -50.06},{90,-50.06},{90,-100}}, color={176,0,0}));
  connect(threeWayValve.enthalpyPort_ab, port_inlet) annotation (Line(points={{-59.8,
          -50},{-90,-50},{-90,-100}}, color={176,0,0}));
  connect(exp_set_T_valve.y, contr_valve.u_s)
    annotation (Line(points={{71,0},{61.2,0}}, color={0,0,127}));
  connect(comp_workingFluid.heatPort, heatflow_Q_res.port)
    annotation (Line(points={{0,-38.72},{0,-34}}, color={191,0,0}));
  connect(exp_set_T_airspeed.y, contr_air_speed.u_s)
    annotation (Line(points={{65,42},{39.2,42}}, color={0,0,127}));
  connect(threeWayValve.opening, switch.y)
    annotation (Line(points={{-50,-41},{-50,-23.2}}, color={0,0,127}));
  connect(switch.u, contr_valve.y)
    annotation (Line(points={{-50,-8.8},{-50,0},{47.4,0}}, color={0,0,127}));
  connect(inp_offSwitch, switch.onOffSignal) annotation (Line(points={{-120,20},
          {-78,20},{-78,-16},{-57.2,-16}}, color={255,0,255}));
  connect(contr_valve.trigger, switch.onOffSignal) annotation (Line(points={{58.8,
          -7.2},{58.8,-28},{-78,-28},{-78,-16},{-57.2,-16}}, color={255,0,255}));
  connect(greaterEqualThreshold.u, contr_valve.y)
    annotation (Line(points={{20,6.8},{20,0},{47.4,0}},
                                                      color={0,0,127}));
  connect(exp_meas_T_modified1.y, contr_valve.u_m)
    annotation (Line(points={{77,-16},{54,-16},{54,-7.2}}, color={0,0,127}));
  connect(exp_meas_T_modified.y, contr_air_speed.u_m)
    annotation (Line(points={{47,22},{32,22},{32,34.8}}, color={0,0,127}));
  connect(contr_air_speed.trigger, greaterEqualThreshold.y) annotation (Line(
        points={{36.8,34.8},{36.8,26},{20,26},{20,20.6}}, color={255,0,255}));
  connect(contr_air_speed.y, block_gain.u)
    annotation (Line(points={{25.4,42},{11.2,42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-90,0},{-86,0},{-86,80},{80,80},{80,70},{-80,70},{-80,60},
              {80,60},{80,50},{-80,50},{-80,40},{80,40},{80,30},{-80,30},{-80,20},
              {80,20},{80,10},{-80,10},{-80,0},{80,0},{80,-10},{-80,-10},{-80,-20},
              {80,-20},{80,-30},{-80,-30},{-80,-40},{80,-40},{80,-50},{-80,-50},
              {-80,-60},{80,-60},{80,-70},{-80,-70},{-80,-80},{86,-80},{86,0},{92,
              0}}, color={0,0,0}),
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-78,78},{78,-78}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-8,6},{-18,22},{-28,44},{-30,64},{-24,74},{-2,78},{4,44},{2,20},
              {2,20},{0,10},{-8,6}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{5,-37},{-5,-21},{-15,1},{-17,21},{-11,31},{11,35},{17,1},{15,
              -23},{15,-23},{13,-33},{5,-37}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          origin={-43,-13},
          rotation=90),
        Polygon(
          points={{5,-37},{-5,-21},{-15,1},{-17,21},{-11,31},{11,35},{17,1},{15,
              -23},{15,-23},{13,-33},{5,-37}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          origin={13,-43},
          rotation=180),
        Polygon(
          points={{5,-37},{-5,-21},{-15,1},{-17,21},{-11,31},{11,35},{17,1},{15,
              -23},{15,-23},{13,-33},{5,-37}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          origin={43,13},
          rotation=270),
        Ellipse(
          extent={{-10,10},{10,-10}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-56,88},{96,66}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="cools fluid down to setpoint temperature
1.partially redirecting flow through cooler, cooling to ambient
2. turn on radiator if that isn't enough

")}));
end AirCooler;
