within Q100_DistrictModel.Components.ElectrolysisSystem.Model;
model Stack "stack model for electrolyser"

  replaceable model CellModel = PartialModels.PartialCell constrainedby
    PartialModels.PartialCell "choose whether to use simple or detailed model for electrolysis"
      annotation(choices(
        choice(redeclare model CellModel =
            DetailedModel.Cell                                        "detailed model"),
        choice(redeclare model CellModel =
            SimpleModel.Cell                                        "simple model")));

  // media models for H2 and O2
  replaceable package H2 = Media.Gases.H2andWaterVapor;
  replaceable package O2 = Media.Gases.O2andWaterVapor;

  // ambient temperature
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

  // other parameter of stack
  parameter SI.Distance param_frame_thickness=0.03    "width of frame around cell [m]"    annotation (Dialog(group="detailed stack parameter"));
  parameter SI.ThermalConductivity param_frame_lambda=0.23    "thermal conducivity of frame [W/(m.K)]"    annotation (Dialog(group="detailed stack parameter"));
  parameter SI.Distance param_endplate_thickness=0.12    "width of endplates of stack"    annotation (Dialog(group="detailed stack parameter"));
  parameter SI.ThermalConductivity param_endplate_lambda=15    "thermal conducivity of frame [W/(m.K)]"    annotation (Dialog(group="detailed stack parameter"));
  parameter SI.CoefficientOfHeatTransfer param_alpha_inside=210    "heat transfer coefficient from cell to frame/endplate [W/(m2.K)]"    annotation (Dialog(group="detailed stack parameter"));
  parameter SI.CoefficientOfHeatTransfer param_alpha_ambient=3.8    "heat transfer coefficient from frame/endplate to ambient [W/(m2.K)]"    annotation (Dialog(group="detailed stack parameter"));

  // variables
  SI.Temperature var_T_stack=comp_heatCapacity.T
    "current stack temperature";

  // production of gas, power consumption, efficiency
  SI.Mass var_h2_prod(start=0, fixed=true)  "mass of produced hydrogen [kg]";
  SI.Mass var_o2_prod(start=0, fixed=true)    "mass of produced oxygen [kg]";
  SI.Energy var_P_cons(start=0.0, fixed=true) "integrated power consumption";
  Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons) "integrated power consumption [kWh]";
  SI.Energy var_Q_cool(start=0.0, fixed=true) "integrated extra cooling need";
  SI.Energy var_Q_tot(start=0.0, fixed=true) "integrated heat production";
  Real var_Q_cool_kWh = SI.Conversions.to_kWh(var_Q_cool) "integrated extra cooling need [kWh]";
  Real var_Q_tot_kWh = SI.Conversions.to_kWh(var_Q_tot) "integrated heat production in kWh";
  SI.Volume var_h2_prod_Nm3=var_h2_prod/param_dens_h2 "produced hydrogen as norm-cubicmeter (0 °C, 1,01325 bar)";
  SI.Volume var_o2_prod_Nm3=var_o2_prod/param_dens_o2 "produced oxygen as norm-cubicmeter (0 °C, 1,01325 bar)";
  Real var_h2_prod_kWh=param_stack_HHV_h2 * var_h2_prod_Nm3 "produced hydrogen as kWh (higher heating value)";

  // variables for heat flow calculation
  SI.HeatFlowRate var_Q_amb_cell  "Heat flow to ambient of one cell [W]";
  SI.HeatFlowRate var_Q_amb_endplate   "Heat flow to ambient at endplate [W]";
  SI.HeatFlowRate var_Q_amb  "Heat flow to ambient of whole electrolyser [W]";
  SI.HeatFlowRate var_Q_coolingSystem   "heat flow from/to cooling system";

  //components
  replaceable CellModel comp_cell(
    redeclare package H2 = H2,
    redeclare package O2 = O2,
    param_p_op_cathode=param_stack_p_op_cathode,
    param_p_op_anode=param_stack_p_op_anode,
    param_kWh_per_m3=param_stack_kWh_per_m3,
    param_HHV_h2=param_stack_HHV_h2,
    param_membrane_area=param_stack_cell_area,
    param_membrane_d=param_stack_cell_d) constrainedby
    PartialModels.PartialCell
    "model of one cell, can be scaled due to assumed uniform temperature throughout stack"
    annotation (Placement(visible=true, transformation(extent={{78,-14},{98,6}}, rotation=0)));
  AixLib.FastHVAC.BaseClasses.EnergyBalance comp_energyBalance    annotation (Placement(transformation(extent={{-12,-102},{12,-80}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor comp_heatCapacity(C=
        param_hc + param_hc_h2o, T(fixed=true, start=param_stack_T_init))
    "heat capacity of electrolyser and water inside electrolyser"    annotation (Placement(transformation(extent={{-30,-62},{-10,-42}})));
  Rectifier.Rectifier comp_rectifier(param_P_rated=param_stack_P_el_max)
    annotation (Placement(transformation(extent={{-88,-80},{-68,-60}})));

  // connectors
  Tools.Connectors.PowerConnector port_P_el "power input for electrolyser" annotation (
      Placement(transformation(extent={{-120,-80},{-100,-60}}), iconTransformation(extent={{-140,
            -100},{-100,-60}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_inlet_cooling "cooling inlet"
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}}),
        iconTransformation(extent={{-60,-100},{-40,-80}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet_cooling
    "cooling outlet" annotation (Placement(transformation(extent={{40,-100},{60,
            -80}}), iconTransformation(extent={{40,-100},{60,-80}})));
  Tools.Connectors.GasConnector port_outlet_o2(redeclare package Gas = O2)
    "outlet port of produced oxygen" annotation (Placement(transformation(extent={{-100,60},{-80,
            80}}), iconTransformation(extent={{100,20},{140,60}})));
  Tools.Connectors.GasConnector port_outlet_h2(redeclare package Gas = H2)
    "outlet port of produced hydrogen" annotation (Placement(transformation(extent={{80,60},{100,
            80}}), iconTransformation(extent={{100,60},{140,100}})));

  // controller, inputs and tools
  AixLib.Controls.Continuous.LimPID contr_stack_temperature(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.05,
    Ti=0.5,
    yMax=1,
    reverseAction=false)
    "controls stack power consumption due to stack temperature"
    annotation (Placement(transformation(extent={{-60,46},{-52,54}})));
  Modelica.Blocks.Interfaces.RealInput inp_P_av "avaiable power" annotation (
      Placement(transformation(extent={{-140,-40},{-100,0}}),
        iconTransformation(extent={{-120,-20},{-100,0}})));
  Tools.Components.Switch block_switch_greater_i_min
    "limits power due to minimal power consumption"
    annotation (Placement(transformation(extent={{0,18},{12,30}})));

  Modelica.Blocks.Math.Product block_limiter_P
    "limits power of cell due to boundary conditions"
    annotation (Placement(transformation(extent={{-22,18},{-10,30}})));
  Modelica.Blocks.Continuous.FirstOrder block_PT1_stack_temperature(T=1,
                                        y(start=param_stack_T_init, fixed=true))
    annotation (Placement(transformation(extent={{-74,30},{-66,38}})));
  Modelica.Blocks.Math.Division block_divisor
    "divides available power through number of cells"
    annotation (Placement(transformation(extent={{44,16},{54,26}})));
  Modelica.Blocks.Sources.RealExpression exp_n_cells(y=param_stack_cell_n)
    "number of cells in stack"
    annotation (Placement(transformation(extent={{-4,-8},{10,4}})));
  Modelica.Blocks.Math.Min block_min
    annotation (Placement(transformation(extent={{-54,-14},{-46,-6}})));
  Modelica.Blocks.Sources.RealExpression exp_P_max(y=param_stack_P_el_max)
    "max power consumption of stack"
    annotation (Placement(transformation(extent={{-100,-6},{-86,6}})));
  Modelica.Blocks.Math.Product block_powerLimiter_imax1
    "limits power of cell due to maximum current density"
    annotation (Placement(transformation(extent={{-72,-28},{-62,-18}})));
  Modelica.Blocks.Sources.RealExpression exp_rectifier_eta(y=comp_rectifier.var_eta)
    annotation (Placement(transformation(extent={{-100,-46},{-86,-34}})));
  Heater.Heater comp_heater(
    param_P_el_max=0.3*param_stack_P_el_max,
    param_T_op=param_stack_T_op)
    annotation (Placement(transformation(extent={{-32,-36},{-20,-24}})));
  Modelica.Blocks.Sources.RealExpression exp_T_stack(y=var_T_stack)
    "stack temperature"
    annotation (Placement(transformation(extent={{-60,-48},{-46,-36}})));
  Modelica.Blocks.Sources.RealExpression exp_P_av_stack(y=max(block_min.y -
        comp_heater.port_P_el.P, 0)) "available power for stack"
    annotation (Placement(transformation(extent={{-50,14},{-36,26}})));
  AixLib.Controls.Continuous.LimPID contr_cell_i(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2,
    Ti=0.5,
    yMax=param_stack_i_max,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    xi_start=0,
    y_start=0,
    reverseAction=false) "controls cell current density"
    annotation (Placement(transformation(extent={{48,-12},{58,-2}})));
  Modelica.Blocks.Sources.RealExpression exp_P_cell(y=comp_cell.port_P_el.P)
    "power consumption of one cell"
    annotation (Placement(transformation(extent={{30,-28},{46,-16}})));
  Tools.Components.DynHysteresis block_hyst_greater_i_min(uLow=param_U_rev*param_stack_i_min*
        param_stack_cell_n*comp_cell.param_membrane_area, uHigh=(param_U_rev*param_stack_i_min*
        param_stack_cell_n*comp_cell.param_membrane_area)*1.05)
    annotation (Placement(transformation(extent={{-4,40},{4,48}})));
  Modelica.Blocks.Sources.RealExpression exp_T_cell(y=var_T_stack)
    "temperature of cell (equals stack temperature)"
    annotation (Placement(transformation(extent={{46,-36},{62,-24}})));
  Modelica.Blocks.Sources.RealExpression exp_T_crit(y=param_stack_T_crit)
    "critical stack temperature"
    annotation (Placement(transformation(extent={{-96,44},{-82,56}})));
  Modelica.Blocks.Sources.RealExpression exp_T_stack1(y=var_T_stack)
    "stack temperature"
    annotation (Placement(transformation(extent={{-96,28},{-82,40}})));
  Tools.Components.Switch block_filter_small_values
    "blocks very small controller outputs (<1e-12)"
    annotation (Placement(transformation(extent={{66,0},{72,6}})));
  Modelica.Blocks.Interfaces.RealInput inp_P_av_tot "avaiable power for total system" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-30,100}), iconTransformation(extent={{-120,20},{-100,40}})));
protected
  Modelica.Blocks.Interfaces.RealOutput inp_wasteHeatFlow
    "heat flow from/to cooling system" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={14,-46})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_wasteHeat(alpha=0)
    "waste heat" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={22,-56})));

protected
  parameter SI.MolarMass param_M_h2=H2.molarMass(H2.setState_pTX(101325,273.15,{1,0})) "molar mass of hydrogen";
  parameter SI.MolarMass param_M_o2 = O2.molarMass(O2.setState_pTX(101325,288.15,{1,0})) "molar mass of oxygen";
  parameter SI.Density param_dens_o2 = O2.density(H2.setState_pTX(101325,273.15,{1,0})) "density of O2 at norm conditions (0 °C, 1,01325 bar)";
  parameter SI.Density param_dens_h2 = H2.density(H2.setState_pTX(101325,273.15,{1,0})) "density of H2 at norm conditions (0 °C, 1,01325 bar)";
  parameter SI.HeatCapacity param_hc=param_stack_mass*param_stack_cp "heat capacity of electrolyser without water";
  parameter SI.HeatCapacity param_hc_h2o=4182*param_stack_mass_h2o  "heat capacity of water inside electrolyser";

  parameter SI.Voltage param_U_rev=
    (-Media.Functions.H2O.deltaH(param_stack_T_op)
      -param_stack_T_op*(Media.Functions.H2.S(param_stack_T_op)
      +0.5*Media.Functions.O2.S(param_stack_T_op)-Media.Functions.H2O.S(param_stack_T_op)))
      /(2*Const.F) "reversibel cell voltage for hysteresis power controller";

  parameter SI.CoefficientOfHeatTransfer param_alpha_res_frame=
      (1/param_alpha_inside + param_frame_thickness/param_frame_lambda + 1/param_alpha_ambient)^(-1)
    "resulting heat transfer coefficient frame to ambient";
  parameter SI.CoefficientOfHeatTransfer param_alpha_res_endplate=
      (1/param_alpha_inside + param_endplate_thickness/param_endplate_lambda + 1/param_alpha_ambient)^(-1)
    "resulting heat transfer coefficient endplate to ambient";

equation

  assert(comp_heatCapacity.T>=283.15, "temperature lower than 10°C: " + String(comp_heatCapacity.T), AssertionLevel.error);

  // hydrogen port
  port_outlet_h2.n_flow = max(comp_cell.port_outlet_h2.n_flow*param_stack_cell_n,Const.eps);
  port_outlet_h2.h = comp_cell.port_outlet_h2.h;
  port_outlet_h2.p = comp_cell.port_outlet_h2.p;
  port_outlet_h2.X = comp_cell.port_outlet_h2.X;

  // oxygen port
  port_outlet_o2.n_flow = max(comp_cell.port_outlet_o2.n_flow*param_stack_cell_n,Const.eps);
  port_outlet_o2.h = comp_cell.port_outlet_o2.h;
  port_outlet_o2.p = comp_cell.port_outlet_o2.p;
  port_outlet_o2.X = comp_cell.port_outlet_o2.X;

  // integrators
  der(var_h2_prod) = max(port_outlet_h2.n_flow*port_outlet_h2.X[1]*param_M_h2,0);
  der(var_o2_prod) =max(port_outlet_o2.n_flow*port_outlet_o2.X[1]*param_M_o2,0);
  der(var_Q_tot) = max(comp_cell.var_Q_prod*param_stack_cell_n,0);
  der(var_Q_cool) = max(var_Q_coolingSystem,0);

  // heat loss to ambient
  var_Q_amb_cell =param_alpha_res_frame*4*(param_stack_cell_length)*param_stack_cell_depth*(var_T_stack
     - param_T_container);
  var_Q_amb_endplate =param_alpha_res_endplate*(param_stack_cell_length)^2*(var_T_stack
     - param_T_container);
  var_Q_amb = (param_stack_cell_n*var_Q_amb_cell + 2*var_Q_amb_endplate);

  //load for cooling system
  var_Q_coolingSystem =comp_cell.var_Q_prod*param_stack_cell_n - var_Q_amb;
  inp_wasteHeatFlow = var_Q_coolingSystem+comp_heater.out_P_heat;

  // power consumption
  comp_rectifier.port_P_el_out.P = max(comp_cell.port_P_el.P*param_stack_cell_n+comp_heater.port_P_el.P,0);
  der(var_P_cons) = comp_cell.port_P_el.P*param_stack_cell_n;

  // connect statements
  connect(comp_heatCapacity.port, comp_energyBalance.heatPort_a) annotation (
      Line(points={{-20,-62},{-20,-82.2},{0,-82.2}}, color={191,0,0}));
  connect(heatflow_wasteHeat.port, comp_energyBalance.heatPort_a)
    annotation (Line(points={{22,-66},{22,-82.2},{0,-82.2}}, color={191,0,0}));
  connect(port_inlet_cooling, comp_energyBalance.enthalpyPort_a) annotation (
      Line(points={{-50,-90},{-50,-91},{-9.6,-91}}, color={176,0,0}));
  connect(port_outlet_cooling, comp_energyBalance.enthalpyPort_b)
    annotation (Line(points={{50,-90},{50,-91},{9.6,-91}}, color={176,0,0}));
  connect(heatflow_wasteHeat.Q_flow, inp_wasteHeatFlow)
    annotation (Line(points={{22,-46},{14,-46}},color={0,0,127}));
  connect(block_limiter_P.y, block_switch_greater_i_min.u)
    annotation (Line(points={{-9.4,24},{-1.2,24}}, color={0,0,127}));
  connect(block_PT1_stack_temperature.y, contr_stack_temperature.u_m)
    annotation (Line(points={{-65.6,34},{-56,34},{-56,45.2}},
                                                            color={0,0,127}));
  connect(exp_n_cells.y, block_divisor.u2)
    annotation (Line(points={{10.7,-2},{16,-2},{16,18},{43,18}},
                                                               color={0,0,127}));
  connect(comp_rectifier.port_P_el_in, port_P_el) annotation (Line(points={{-88,
          -70},{-102,-70},{-102,-70},{-110,-70}}, color={0,0,0}));
  connect(inp_P_av, block_powerLimiter_imax1.u1)
    annotation (Line(points={{-120,-20},{-73,-20}}, color={0,0,127}));
  connect(exp_P_max.y, block_min.u1) annotation (Line(points={{-85.3,0},{-66,0},
          {-66,-7.6},{-54.8,-7.6}}, color={0,0,127}));
  connect(block_powerLimiter_imax1.y, block_min.u2) annotation (Line(points={{-61.5,
          -23},{-58,-23},{-58,-12},{-56,-12},{-56,-12.4},{-54.8,-12.4}}, color={
          0,0,127}));
  connect(exp_rectifier_eta.y, block_powerLimiter_imax1.u2) annotation (Line(
        points={{-85.3,-40},{-80,-40},{-80,-26},{-73,-26}}, color={0,0,127}));
  connect(block_min.y, comp_heater.inp_P_av) annotation (Line(points={{-45.6,-10},
          {-40,-10},{-40,-25.2},{-33.2,-25.2}}, color={0,0,127}));
  connect(exp_T_stack.y, comp_heater.inp_T_is) annotation (Line(points={{-45.3,-42},
          {-42,-42},{-42,-30},{-33.2,-30}}, color={0,0,127}));
  connect(exp_P_av_stack.y, block_limiter_P.u2) annotation (Line(points={{-35.3,
          20},{-28,20},{-28,20.4},{-23.2,20.4}}, color={0,0,127}));
  connect(block_divisor.y, contr_cell_i.u_s) annotation (Line(points={{54.5,21},
          {60,21},{60,6},{38,6},{38,-7},{47,-7}}, color={0,0,127}));
  connect(exp_P_cell.y, contr_cell_i.u_m)
    annotation (Line(points={{46.8,-22},{53,-22},{53,-13}}, color={0,0,127}));
  connect(contr_stack_temperature.y, block_limiter_P.u1) annotation (Line(
        points={{-51.6,50},{-38.75,50},{-38.75,27.6},{-23.2,27.6}}, color={0,0,127}));
  connect(block_hyst_greater_i_min.y, block_switch_greater_i_min.onOffSignal)
    annotation (Line(points={{4.4,44},{6,44},{6,31.2}}, color={255,0,255}));
  connect(exp_T_cell.y, comp_cell.inp_T) annotation (Line(points={{62.8,-30},{72,
          -30},{72,-1},{77,-1}}, color={0,0,127}));
  connect(exp_T_crit.y, contr_stack_temperature.u_s)
    annotation (Line(points={{-81.3,50},{-60.8,50}}, color={0,0,127}));
  connect(exp_T_stack1.y, block_PT1_stack_temperature.u)
    annotation (Line(points={{-81.3,34},{-74.8,34}}, color={0,0,127}));
  connect(contr_cell_i.y, block_filter_small_values.u) annotation (Line(points=
          {{58.5,-7},{60.25,-7},{60.25,3},{65.4,3}}, color={0,0,127}));
  connect(block_filter_small_values.y, comp_cell.inp_i)
    annotation (Line(points={{72.6,3},{77,3}}, color={0,0,127}));
  connect(block_filter_small_values.onOffSignal, block_switch_greater_i_min.onOffSignal)
    annotation (Line(points={{69,6.6},{69,40},{6,40},{6,31.2}}, color={255,0,
          255}));
  connect(block_switch_greater_i_min.y, block_divisor.u1)
    annotation (Line(points={{13.2,24},{43,24}}, color={0,0,127}));
  connect(block_hyst_greater_i_min.u, inp_P_av_tot)
    annotation (Line(points={{-4.8,44},{-30,44},{-30,100}}, color={0,0,127}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-60,18},{-50,-46}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{43,12},{46,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{39,12},{42,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{35,12},{38,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{31,12},{34,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{27,12},{30,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{23,12},{26,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{19,12},{22,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{15,12},{18,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{11,12},{14,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{7,12},{10,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{3,12},{6,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-1,12},{2,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-5,12},{-2,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-9,12},{-6,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-13,12},{-10,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-17,12},{-14,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-21,12},{-18,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-25,12},{-22,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-29,12},{-26,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-33,12},{-30,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-37,12},{-34,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-41,12},{-38,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-45,12},{-42,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-49,12},{-46,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,18},{60,-46}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-52,62},{-32,30}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.None,
          textString="H"),
        Text(
          extent={{26,62},{46,30}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.None,
          textString="H"),
        Text(
          extent={{-28,62},{-8,30}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.None,
          textString="O"),
        Text(
          extent={{-36,44},{-24,26}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.None,
          textString="2"),
        Text(
          extent={{42,44},{54,26}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.None,
          textString="2"),
        Polygon(
          points={{2,52},{2,40},{12,46},{2,52}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{47,12},{50,-38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
                                        Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}),                                Diagram(
      coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10000000,
      __Dymola_NumberOfIntervals=10000,
      __Dymola_Algorithm="Lsodar"));
end Stack;
