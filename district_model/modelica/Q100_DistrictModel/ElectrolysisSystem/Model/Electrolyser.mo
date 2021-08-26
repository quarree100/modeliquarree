within Q100_DistrictModel.ElectrolysisSystem.Model;
model Electrolyser "temperature-controlled electrolysis system"

  replaceable model CellModel = PartialModels.PartialCell constrainedby PartialModels.PartialCell
                              "choose whether to use simple or detailed model for electrolysis"
      annotation(choices(
        choice(redeclare model CellModel =
            DetailedModel.Cell                                        "detailed model"),
        choice(redeclare model CellModel =
            SimpleModel.Cell                                        "simple model")));

  parameter SI.Temperature param_T_container(displayUnit="K") = 30+273.15 "temperature inside electrolyser container" annotation(Dialog(group="general parameter"));

  // operating parameter for stack
  parameter Units.VolumetricEnergy param_stack_kWh_per_m3 = 4.4 "simple model: constant specific energy demand for H2 production of stack in kWh per normcubicmeter (0 °C, 1,01325 bar)" annotation(Dialog(group="electrolysis parameter"));
  parameter Units.VolumetricEnergy param_stack_HHV_h2 = 3.5403 "higher heating value of H2 at norm conditions (0 °C, 1,01325 bar)"
                                                                                                                                   annotation(Dialog(group="electrolysis parameter"));
  parameter SI.Power param_stack_P_el_min = 10e3 "minimal power of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
  parameter SI.Power param_stack_P_el_max = 100e3 "nominal power of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
  parameter SI.CurrentDensity param_stack_i_min = 0.2e4 "minimum current density in electrolysis cell" annotation(Dialog(group="electrolysis parameter"));
  parameter SI.CurrentDensity param_stack_i_max = 2.5e4 "maximum current density in electrolysis cell" annotation(Dialog(group="electrolysis parameter"));
  parameter SI.Temperature param_stack_T_init(displayUnit="K") = 50+273.15 "initial temperature of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
  parameter SI.Temperature param_stack_T_op(displayUnit="K")= 65+273.15 "desired operating temperature of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
  parameter SI.Temperature param_stack_T_crit(displayUnit="K") = 75+273.15 "critical temperature at which electrolyser turns off" annotation(Dialog(group="electrolysis parameter"));
  parameter SI.Temperature param_stack_T_in(displayUnit="K")= 55+273.15 "desired inlet temperature of electrolyser stack" annotation(Dialog(group="electrolysis parameter"));
  SI.Pressure param_stack_p_op_cathode "operating pressure at cathode"
                                                                      annotation(Dialog(group="electrolysis parameter"));
  SI.Pressure param_stack_p_op_anode "operating pressure at anode"
                                                                  annotation(Dialog(group="electrolysis parameter"));

    // general parameter of stack
  parameter Integer param_stack_cell_n=100 "number of cells in electrolyser"
                                                                            annotation(Dialog(group="stack parameter"));
  parameter SI.Area param_stack_cell_area=600e-4 "membrane area of one cell [m²]"   annotation (Dialog(group="stack parameter"));
  parameter SI.Distance param_stack_cell_d=200e-6 "thickness of cell membrane [m]"   annotation (Dialog(group="stack parameter"));
  parameter SI.Distance param_stack_cell_length=0.35 "length of one cell including frame thickness [m]"    annotation (Dialog(group="stack parameter"));
  parameter SI.Distance param_stack_cell_depth=0.02 "depth of one cell including frame [m]"    annotation (Dialog(group="stack parameter"));
  parameter SI.Mass param_stack_mass = 2000 "mass of electrolyser (without cooling liquid)" annotation(Dialog(group="stack parameter"));
  parameter SI.SpecificHeatCapacity param_stack_cp = 420 "mean specific heat capacity of electrolyser" annotation(Dialog(group="stack parameter"));
  parameter SI.Mass param_stack_mass_h2o = 100 "mass of electrolyser cooling liquid" annotation(Dialog(group="stack parameter"));

  // operating parameter for peripheral components
  parameter Real param_ppm_h2o_h2=5 "desired water fraction of hydrogen after gas dryer in ppm" annotation(Dialog(group="peripheral parameter"));
  parameter SI.Pressure param_p_comp_h2=200e5   "pressure of compressed hydrogen for storage purposes"    annotation (Dialog(group="peripheral parameter"));
  parameter Integer param_n_comp_h2=5  "number of compressor stages"    annotation (Dialog(group="peripheral parameter"));

  // cooling pump parameter
  parameter SI.VolumeFlowRate param_pump_Qmax=5e-3  "maximal volume flow rate of pump at 25°C [m³/s]" annotation (Dialog(group="cooling pump parameter"));
  parameter SI.Pressure param_pump_dp=2e5    "system pressure loss at maximum volume flow rate [Pa]"    annotation (Dialog(group="cooling pump parameter"));
  parameter SI.Efficiency param_pump_eta=0.6    "cooling pump efficiency at operating condition"    annotation (Dialog(group="cooling pump parameter"));

  // variables
  SI.Power var_P_ex(start=0, fixed=false)  "excess power which is not used";
  SI.Power var_P_av_elec(start=0, fixed=false)  "available power for the electrolyser stack";
  SI.Energy var_P_cons(start=0.0, fixed=true) "integrated power consumption";
  Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons) "integrated power consumption in kWh";

  // components of system
  Stack comp_stack(
    redeclare CellModel comp_cell(
        redeclare package H2 = H2,
        redeclare package O2 = O2,
        param_p_op_cathode=param_stack_p_op_cathode,
        param_p_op_anode=param_stack_p_op_anode,
        param_kWh_per_m3=param_stack_kWh_per_m3,
        param_HHV_h2=param_stack_HHV_h2,
        param_membrane_area=param_stack_cell_area,
        param_membrane_d=param_stack_cell_d),
    comp_heater(param_T_op_min=param_stack_T_op - 5),
    redeclare package O2 = O2,
    redeclare package H2 = H2,
    param_stack_kWh_per_m3=param_stack_kWh_per_m3,
    param_stack_HHV_h2=param_stack_HHV_h2,
    param_stack_P_el_min=param_stack_P_el_min,
    param_stack_P_el_max=param_stack_P_el_max,
    param_stack_i_min=0.2e4,
    param_stack_i_max=param_stack_i_max,
    param_stack_T_init=param_stack_T_init,
    param_stack_T_op=param_stack_T_op,
    param_stack_T_crit=param_stack_T_crit,
    param_stack_T_in=param_stack_T_in,
    param_stack_p_op_cathode=param_stack_p_op_cathode,
    param_stack_p_op_anode=param_stack_p_op_anode,
    param_stack_cell_n=param_stack_cell_n,
    param_stack_cell_area=param_stack_cell_area,
    param_stack_cell_d=param_stack_cell_d,
    param_stack_cell_length=param_stack_cell_length,
    param_stack_cell_depth=param_stack_cell_depth,
    param_stack_mass=param_stack_mass,
    param_stack_cp=param_stack_cp,
    param_stack_mass_h2o=param_stack_mass_h2o) annotation (Placement(transformation(extent={{-40,-2},{40,78}})));
  Pump.Pump comp_pump(param_Q_max=param_pump_Qmax) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,-42})));
  Cooler.AirCooler comp_airCooler(param_T_Set=param_stack_T_in, param_T_init=param_stack_T_init) "cools fluid against ambient" annotation (Placement(transformation(extent={{-120,-100},{-100,-80}})));
  GasDryer.GasDryer comp_gasDryerH2(param_ppm_h2o=param_ppm_h2o_h2, param_use_water_outlet=false) annotation (Placement(transformation(extent={{60,130},{80,150}})));
  GasCompressor.H2Compressor comp_gasCompressorH2(param_p_end=param_p_comp_h2,
      param_n_compStage=param_n_comp_h2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={100,140})));

  // sensors
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor meas_T_stack_in "Inlet temperature of stack"  annotation (Placement(transformation(extent={{-60,
            -110},{-40,-90}})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor meas_T_stack "temperature of stack" annotation (Placement(transformation(extent={{40,-110},
            {60,-90}})));

  // connectors
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_inlet_cooling(m_flow(start=comp_pump.param_Q_min/1000, fixed=false))    annotation (Placement(transformation(extent={{-120,-160},{-80,-120}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet_cooling    annotation (Placement(transformation(extent={{80,-160},{120,-120}})));
  Tools.Connectors.GasConnector port_outlet_h2(redeclare package Gas = H2)
    annotation (Placement(transformation(extent={{120,120},{160,160}})));
  Tools.Connectors.GasConnector port_outlet_o2(redeclare package Gas = O2)
    annotation (Placement(transformation(extent={{120,80},{160,120}})));
  Tools.Connectors.PowerConnector port_P_el
    annotation (Placement(transformation(extent={{-160,120},{-120,160}})));

  // controllers
  AixLib.Controls.Continuous.LimPID contr_pump_mflow(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-4,
    Td=0.25,
    Ti=100,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    xi_start=param_stack_T_init,
    reverseAction=true,
    strict=true,
    yMax=comp_pump.param_Q_max,
    yMin=comp_pump.param_Q_min,
    y_start=comp_pump.param_Q_min)
                  annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-66,-42})));

  // external input blocks
  Modelica.Blocks.Interfaces.RealInput inp_P_av
    "power available for electrolyser system" annotation (Placement(
        transformation(extent={{-200,10},{-160,50}}),  iconTransformation(
          extent={{-180,30},{-160,50}})));
  Modelica.Blocks.Interfaces.RealInput inp_T_air "outside air temperature" annotation (Placement(
        transformation(extent={{-198,-102},{-158,-62}}),
                                                       iconTransformation(
          extent={{-180,-50},{-160,-30}})));

  // internal input blocks
  Modelica.Blocks.Sources.RealExpression exp_P_stack_av(y=var_P_av_elec)
    "available power for electrolyser stack" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-94,34})));
  Modelica.Blocks.Sources.RealExpression exp_set_T_stack(y=param_stack_T_op)
    "setpoint temperature for stack" annotation (Placement(visible=true,
        transformation(extent={{-118,-52},{-98,-32}},rotation=0)));
  Modelica.Blocks.Sources.RealExpression exp_is_T_stack(y=meas_T_stack.T)
    "current temperature of stack" annotation (Placement(visible=true,
        transformation(extent={{-118,-70},{-98,-50}},rotation=0)));

  // media packages
  Modelica.Blocks.Logical.Hysteresis block_hyst_cooling_on(uLow=
        param_stack_T_op - 1, uHigh=param_stack_T_op)
    "turns cooling system on if T_op is exceeded by one degree"
    annotation (Placement(transformation(extent={{-164,-56},{-152,-44}})));
  Modelica.Blocks.Interfaces.BooleanOutput out_cooling_system_on
    "true if cooling system is needed"
    annotation (Placement(transformation(extent={{-160,-150},{-180,-130}})));
  Modelica.Blocks.Continuous.FirstOrder block_firstOrder(
    T=6,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0)
    annotation (Placement(transformation(extent={{-44,-48},{-32,-36}})));
  Modelica.Blocks.Sources.BooleanExpression exp_true(y=comp_stack.port_P_el.P
         > 1)                                                "cooling cycle on"
    annotation (Placement(visible=true, transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-146,-92})));
protected
  package H2 = Media.Gases.H2andWaterVapor;
  package O2 = Media.Gases.O2andWaterVapor;
equation

  // assert statements in case something doesn't check out
  assert(
    port_P_el.P >= -Const.eps,
    "power consumption <0",
    AssertionLevel.warning);

  // actual power consumption
  port_P_el.P = inp_P_av - var_P_ex;
  der(var_P_cons) =port_P_el.P;

  // specific assert statement
  assert(
    comp_stack.port_P_el.P >= -Const.eps and comp_gasCompressorH2.port_P_el.P >= -Const.eps and
       comp_gasDryerH2.port_P_el.P >= -Const.eps and comp_pump.port_P_el.P >= -Const.eps,
    "at least one value <0"
       + ", stack: " + String(comp_stack.port_P_el.P) + ", h2comp: " + String(
      comp_gasCompressorH2.port_P_el.P) + ", h2dryer: " + String(comp_gasDryerH2.port_P_el.P)
       + ", pump: " +
      String(comp_pump.port_P_el.P),
    AssertionLevel.warning);

  // remaining power for stack
  var_P_av_elec=inp_P_av - abs(comp_gasCompressorH2.port_P_el.P)
     -  abs(comp_gasDryerH2.port_P_el.P) -
     abs(comp_pump.port_P_el.P) - abs(
    comp_airCooler.port_P_el.P);

  // balance power consumption
  0 =port_P_el.P - (abs(comp_stack.port_P_el.P) + abs(
    comp_gasCompressorH2.port_P_el.P) +
    abs(comp_gasDryerH2.port_P_el.P) + abs(
    comp_pump.port_P_el.P));

  connect(comp_airCooler.port_outlet, meas_T_stack_in.enthalpyPort_a)    annotation (Line(points={{-101,-100},{-78,-100},{-78,-100.1},{-58.8,-100.1}},
        color={176,0,0}));
  connect(meas_T_stack_in.enthalpyPort_b, comp_pump.port_inlet) annotation (Line(
        points={{-41,-100.1},{-6,-100.1},{-6,-52}},   color={176,0,0}));
  connect(meas_T_stack.enthalpyPort_b, port_outlet_cooling) annotation (Line(
        points={{59,-100.1},{140,-100.1},{140,-140},{100,-140}}, color={176,0,0}));
  connect(comp_airCooler.port_inlet, port_inlet_cooling) annotation (Line(points=
         {{-119,-100},{-140,-100},{-140,-140},{-100,-140}}, color={176,0,0}));
  connect(exp_set_T_stack.y, contr_pump_mflow.u_s)    annotation (Line(points={{-97,-42},
          {-73.2,-42}},                                                                                color={0,0,127}));

  connect(inp_T_air, comp_airCooler.inp_T_Amb) annotation (Line(points={{-178,
          -82},{-121,-82}},                  color={0,0,127}));
  connect(exp_P_stack_av.y, comp_stack.inp_P_av)
    annotation (Line(points={{-83,34},{-44,34}}, color={0,0,127}));
  connect(block_hyst_cooling_on.u, contr_pump_mflow.u_m) annotation (Line(
        points={{-165.2,-50},{-170,-50},{-170,-72},{-66,-72},{-66,-49.2}},
        color={0,0,127}));
  connect(exp_is_T_stack.y, contr_pump_mflow.u_m) annotation (Line(points={{-97,
          -60},{-66,-60},{-66,-49.2}}, color={0,0,127}));
  connect(comp_pump.inp_Q, block_firstOrder.y)
    annotation (Line(points={{-17,-42},{-31.4,-42}}, color={0,0,127}));
  connect(contr_pump_mflow.y, block_firstOrder.u)
    annotation (Line(points={{-59.4,-42},{-45.2,-42}}, color={0,0,127}));
  connect(exp_true.y, comp_airCooler.inp_offSwitch) annotation (Line(points={{-135,
          -92},{-126,-92},{-126,-88},{-121,-88}}, color={255,0,255}));
  connect(block_hyst_cooling_on.y, out_cooling_system_on) annotation (Line(
        points={{-151.4,-50},{-144,-50},{-144,-28},{-196,-28},{-196,-120},{-150,
          -120},{-150,-140},{-170,-140}}, color={255,0,255}));
  connect(inp_P_av, comp_stack.inp_P_av_tot)
    annotation (Line(points={{-180,30},{-132,30},{-132,50},{-44,50}}, color={0,0,127}));
  connect(comp_stack.port_outlet_h2, comp_gasDryerH2.port_inlet_gas)
    annotation (Line(points={{48,70},{50,70},{50,140},{60,140}}, color={0,0,0}));
  connect(comp_gasDryerH2.port_outlet_gas, comp_gasCompressorH2.port_inlet_gas)
    annotation (Line(points={{80,140},{90,140}}, color={0,0,0}));
  connect(comp_gasCompressorH2.port_outlet_gas, port_outlet_h2)
    annotation (Line(points={{110,140},{140,140}}, color={0,0,0}));
  connect(comp_stack.port_outlet_o2, port_outlet_o2)
    annotation (Line(points={{48,54},{94,54},{94,100},{140,100}}, color={0,0,0}));
  connect(comp_pump.port_outlet, comp_stack.port_inlet_cooling)
    annotation (Line(points={{-6,-32},{-6,-16},{-20,-16},{-20,2}}, color={176,0,0}));
  connect(comp_stack.port_outlet_cooling, meas_T_stack.enthalpyPort_a)
    annotation (Line(points={{20,2},{20,-100.1},{41.2,-100.1}}, color={176,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}}), graphics={                                                                                                                                                                                                        Ellipse(origin={
              28.03,-11.2},                                                                                                                                                                                               extent={{
              -186.03,171.2},{131.97,-148.8}},                                                                                                                                                                                                        endAngle = 360),
                     Text(origin={-44.38,-30.8},
                                               extent={{-61.62,116.8},{16.38,-43.2}},
                                                                                textString = "P"), Text(origin={-74.7272,-11.714},
                                                                                                                             extent={{
              -7.2728,11.7142},{32.7272,-70.286}},                                                                                                          textString = "el"), Text(origin={
              86.46,-34.26},                                                                                                                                                                             extent={{
              -58.46,118.26},{15.54,-43.74}},                                                                                                                                                                                             textString = "H"), Text(origin={
              108,-14.6664},                                                                                                                                                                                                        extent={{
              -7.99999,12.6664},{30,-63.3336}},                                                                                                                                                                                                        textString = "2"),
                                                                                                                                                                                                    Polygon(fillColor = {76, 76, 76},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{-20, 20}, {20, 0}, {-20, -20}, {-20, -20}, {-20, 20}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
    experiment(StopTime=10800, __Dymola_Algorithm="Rkfix4"));
end Electrolyser;
