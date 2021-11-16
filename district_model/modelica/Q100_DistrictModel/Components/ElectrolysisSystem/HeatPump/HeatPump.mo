within Q100_DistrictModel.Components.ElectrolysisSystem.HeatPump;
model HeatPump
  "simple inverter heat pump model with constant COP"

    // medium to use
    parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple param_medium_evap=
        AixLib.FastHVAC.Media.WaterSimple() "medium type on evaporator side";
    parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple param_medium_cond=
        AixLib.FastHVAC.Media.WaterSimple() "medium type on condenser side";

    // heat pump parameter
    parameter Real param_COP = 3.00 "constant COP" annotation(Dialog(group="heat pump parameters"));
    parameter SI.Power param_P_el=10e3 "maximum power consumption" annotation(Dialog(group="heat pump parameters"));
    parameter SI.Temperature param_T_set_evap=55+273.15
    "desired outlet temperature of evaporator"
                                              annotation(Dialog(group="heat pump parameters"));
    parameter SI.Temperature param_T_init=35+273.15
    "initial temperature of heat pump"
                                      annotation(Dialog(group="heat pump parameters"));

    // other parameters
    parameter SI.Temperature param_T_init_evap=param_T_init
    "Initial evaporator temperatur"                                                    annotation(Dialog(group="initial parameters"));
    parameter SI.Volume param_V_evap = 0.1 "Volume of evaporator"
                                                                 annotation(Dialog(group="initial parameters"));
    parameter SI.Temperature param_T_init_cond=param_T_init
    "Initial condenser temperature"                                                    annotation(Dialog(group="initial parameters"));
    parameter SI.Volume param_V_cond = param_V_evap "Volume of condenser"
                                                                         annotation(Dialog(group="initial parameters"));

    // variables
    SI.Power var_P_therm "current thermal power output";
    SI.Energy var_P_therm_rem(start=0.0, fixed=true) "intergrated removed heat";
    Real var_P_therm_rem_kWh = SI.Conversions.to_kWh(var_P_therm_rem) "intergrated removed heat in kWh";
    SI.Power var_P_el "current electrical power consumption";
    SI.Energy var_P_cons(start=0.0, fixed=true) "integrated power consumption";
    Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons) "integrated power consumption in kWh";

    // components
    AixLib.FastHVAC.BaseClasses.WorkingFluid comp_evapFluid(
    medium=param_medium_evap,
    m_fluid=param_V_evap*param_medium_evap.rho,
    T0=param_T_init_evap) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,90})));
    AixLib.FastHVAC.BaseClasses.WorkingFluid comp_condFluid(
    medium=param_medium_cond,
    m_fluid=param_V_cond*param_medium_cond.rho,
    T0=param_T_init_cond) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-90})));

    // in- and output enthalpy ports
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_evap_out annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,90}), iconTransformation(extent={{-100,80},{-80,100}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_cond_in annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,-90}), iconTransformation(extent={{-100,-100},{-80,-80}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_cond_out annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-90}), iconTransformation(extent={{80,-100},{100,-80}})));
    AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_evap_in annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,90}), iconTransformation(extent={{80,80},{100,100}})));

    // sensors
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor meas_T_evap
    "outlet temperature of evaporator" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,90})));

    // heat flows
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_dotQCond
    annotation (Placement(transformation(
        origin={0,-64},
        extent={{10,-10},{-10,10}},
        rotation=90)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_dotQEvap
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,62})));

    // inputs / connectors
    Modelica.Blocks.Interfaces.RealInput inp_P_av
    "power available for heat pump" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,20}), iconTransformation(extent={{-10,-10},{10,10}},
          origin={-110,30})));
  Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-120,-20},
            {-100,0}}), iconTransformation(extent={{-140,-80},{-100,-40}})));

    // power controlling components
    Modelica.Blocks.Sources.RealExpression exp_set_T_evap(y=param_T_set_evap)
    "setpoint temperature evaporator outlet" annotation (Placement(visible=true,
        transformation(extent={{-36,-12},{-16,8}},  rotation=0)));
  AixLib.Controls.Continuous.LimPID contr_hp_temp(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.5,
    Td=0.2,
    Ti=30,
    reverseAction=true,
    strict=true,
    yMax=1,
    yMin=0,
    y_start=0.01,
    reset=AixLib.Types.Reset.Parameter,
    y_reset=0,
    addPID(y(start=0, fixed=false))) "controls hp power consumption due to setpoint temperature" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={26,0})));
  Modelica.Blocks.Sources.RealExpression exp_is_T_evap(y=if block_and.y then
        block_firstOrder.y else param_T_set_evap)
    "temperature after heatpump evaporator" annotation (Placement(visible=true,
        transformation(extent={{-36,-32},{-16,-12}}, rotation=0)));
  Modelica.Blocks.Math.Min
                 block_min
    annotation (Placement(transformation(extent={{-26,22},{-14,34}})));
  Modelica.Blocks.Math.Product block_limit_power
    "actual electrical power for heatpump"
    annotation (Placement(transformation(extent={{48,4},{60,16}})));

  Tools.Components.Switch block_switch_hp "on/off switch for heatpump"
    annotation (Placement(transformation(extent={{18,22},{30,34}})));
    Modelica.Blocks.Sources.RealExpression exp_P_max(y=param_P_el)
    "maximum power consumption" annotation (Placement(visible=true,
        transformation(extent={{-68,-2},{-48,18}},  rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput inp_offSwitch
    "if false the heatpump is not used"
                                       annotation (Placement(transformation(
          extent={{-140,40},{-100,80}}),iconTransformation(extent={{-120,60},{-100,
            80}})));
  Modelica.Blocks.Continuous.FirstOrder block_firstOrder(T=2, initType=Modelica.Blocks.Types.Init.InitialOutput)
    "temperature sensor response time" annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={-51,73})));
    Modelica.Blocks.Sources.RealExpression exp_zero(y=0) "zero" annotation (
      Placement(visible=true, transformation(extent={{-80,34},{-68,44}},
          rotation=0)));
  Modelica.Blocks.Math.Max block_max
    annotation (Placement(transformation(extent={{-56,26},{-44,38}})));
  Modelica.Blocks.Sources.BooleanExpression block_greaterThreshold(y=block_min.y
         > 5) annotation (Placement(transformation(extent={{-8,34},{-2,40}})));
  Modelica.Blocks.Logical.And block_and
    annotation (Placement(transformation(extent={{4,36},{12,44}})));
equation

  // limit power
  var_P_el = block_limit_power.y;
  var_P_therm = var_P_el*(param_COP-1);

  // heat extraction evaporator
  heatflow_dotQCond.Q_flow = var_P_therm+var_P_el;
  heatflow_dotQEvap.Q_flow = -var_P_therm;
  der(var_P_therm_rem) = var_P_therm;

  // actual electricity demand
  port_P_el.P = var_P_el;
  der(var_P_cons) = port_P_el.P;

  // connect statements

  connect(comp_evapFluid.enthalpyPort_b, meas_T_evap.enthalpyPort_a)
    annotation (Line(points={{-9,90},{-23.75,90},{-23.75,90.1},{-41.2,90.1}},
        color={176,0,0}));
  connect(meas_T_evap.enthalpyPort_b, port_evap_out) annotation (Line(points={{-59,
          90.1},{-72.5,90.1},{-72.5,90},{-90,90}}, color={176,0,0}));
  connect(comp_evapFluid.heatPort, heatflow_dotQEvap.port) annotation (Line(
        points={{-1.16573e-15,80.6},{0,80.6},{0,72},{1.77636e-15,72}}, color={
          191,0,0}));
  connect(comp_condFluid.heatPort, heatflow_dotQCond.port)
    annotation (Line(points={{0,-80.6},{0,-74}}, color={191,0,0}));
  connect(comp_evapFluid.enthalpyPort_a, port_evap_in)
    annotation (Line(points={{9,90},{90,90}}, color={176,0,0}));
  connect(comp_condFluid.enthalpyPort_b, port_cond_out)
    annotation (Line(points={{9,-90},{90,-90}}, color={176,0,0}));
  connect(port_cond_in, comp_condFluid.enthalpyPort_a)
    annotation (Line(points={{-90,-90},{-9,-90}}, color={176,0,0}));
  connect(block_switch_hp.y, block_limit_power.u1) annotation (Line(points={{31.2,28},
          {42,28},{42,13.6},{46.8,13.6}},     color={0,0,127}));
  connect(block_min.y, block_switch_hp.u)
    annotation (Line(points={{-13.4,28},{16.8,28}},  color={0,0,127}));
  connect(exp_set_T_evap.y, contr_hp_temp.u_s)
    annotation (Line(points={{-15,-2},{-6,-2},{-6,0},{18.8,0}},
                                                 color={0,0,127}));
  connect(contr_hp_temp.y, block_limit_power.u2) annotation (Line(points={{32.6,0},
          {38,0},{38,6.4},{46.8,6.4}},  color={0,0,127}));
  connect(meas_T_evap.T, block_firstOrder.u)
    annotation (Line(points={{-51,79},{-51,76.6}}, color={0,0,127}));
  connect(exp_is_T_evap.y, contr_hp_temp.u_m) annotation (Line(points={{-15,-22},
          {26,-22},{26,-7.2}},   color={0,0,127}));
  connect(exp_P_max.y, block_min.u2) annotation (Line(points={{-47,8},{-38,8},{
          -38,24.4},{-27.2,24.4}}, color={0,0,127}));
  connect(exp_zero.y, block_max.u1) annotation (Line(points={{-67.4,39},{-62,39},
          {-62,35.6},{-57.2,35.6}}, color={0,0,127}));
  connect(inp_P_av, block_max.u2) annotation (Line(points={{-120,20},{-88,20},{
          -88,28.4},{-57.2,28.4}}, color={0,0,127}));
  connect(block_max.y, block_min.u1) annotation (Line(points={{-43.4,32},{-38,
          32},{-38,31.6},{-27.2,31.6}}, color={0,0,127}));
  connect(contr_hp_temp.trigger, block_switch_hp.onOffSignal) annotation (Line(
        points={{21.2,-7.2},{21.2,-12},{14,-12},{14,40},{24,40},{24,35.2}},
        color={255,0,255}));
  connect(block_and.y, block_switch_hp.onOffSignal)
    annotation (Line(points={{12.4,40},{24,40},{24,35.2}}, color={255,0,255}));
  connect(block_greaterThreshold.y, block_and.u2) annotation (Line(points={{
          -1.7,37},{1.15,37},{1.15,36.8},{3.2,36.8}}, color={255,0,255}));
  connect(inp_offSwitch, block_and.u1) annotation (Line(points={{-120,60},{-64,
          60},{-64,46},{0,46},{0,40},{3.2,40}}, color={255,0,255}));
  annotation (Icon(graphics={
          Line(points={{0,80},{0,70},{-20,70},{20,60},{-20,50},{20,40},{-20,30},{20,20},{-20,10},{20,0},{-20,-10},
              {20,-20},{-20,-30},{20,-40},{-20,-50},{20,-60},{-19.9609,-69.9902},{0,-70},{0,-80}},  color={0,0,127},
          origin={0,60},
          rotation=90),
          Line(points={{0,80},{0,70},{-20,70},{20,60},{-20,50},{20,40},{-20,30},{20,20},{-20,10},{20,0},{-20,-10},
              {20,-20},{-20,-30},{20,-40},{-20,-50},{20,-60},{-19.9609,-69.99},{0,-70},{0,-80}},
                                                                                  color={238,46,47},
          origin={0,-60},
          rotation=90),
          Text(
            extent={{-64,33},{64,-33}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString=DynamicSelect("COP", "COP="+String(COP,  format="1.2f")),
            origin={-1,0},
            rotation=180),
          Polygon(
            points={{0,-14},{10,14},{-10,14},{0,-14}},
            lineColor={28,108,200},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
          origin={-54,90},
          rotation=270),
          Polygon(
            points={{0,14},{10,-14},{-10,-14},{0,14}},
            lineColor={238,46,47},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
          origin={54,-90},
          rotation=270),
          Line(points={{-60,0},{60,0}},   color={28,108,200},
          origin={-80,0},
          rotation=90),
          Line(points={{0,69},{-2.20424e-15,-51}},
                                          color={238,46,47},
          origin={80,9},
          rotation=180),
        Line(points={{40,-90},{-68,-90}}, color={238,46,47}),
        Line(points={{-40,90},{70,90}}, color={28,108,200})}), experiment(
        StopTime=10800, __Dymola_NumberOfIntervals=10000));
end HeatPump;
