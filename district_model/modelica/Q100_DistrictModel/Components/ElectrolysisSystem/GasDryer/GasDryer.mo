within Q100_DistrictModel.Components.ElectrolysisSystem.GasDryer;
model GasDryer "model of continuous gas dryer with MSL Media"

  // media model
  package H2O = Modelica.Media.Water.WaterIF97_R1pT;
  package Gas = Media.Gases.H2andWaterVapor;
  Gas.ThermodynamicState state_cold;
  Gas.ThermodynamicState state_hot;
  H2O.ThermodynamicState state_h2o;
  SI.SpecificHeatCapacity var_cp;

  // parameters
  parameter SI.Temperature param_T_ac=40 + 273.15
    "temperature after cooling against ambient";
  parameter Real param_ppm_h2o=5 "ppm of water vapor in hydrogen after dryer";
  parameter SI.Efficiency param_eta_h=0.98
    "efficiency of electrical heating units";
  parameter Boolean param_use_water_outlet=true "if true then there is a enthalpy port out for the condensed water";
  parameter SI.MolarEnthalpy param_adsorp_enth=48.6e3
    "constant adsorption enthalpy";
  parameter Units.Fraction param_feedbackFlow=0.2
    "fraction of gas mass flow in feedback loop";

  // variables
  SI.Energy var_P_cons(start=0.0, fixed=true)
    "integrated power consumption";
  Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
    "integrated power consumption in kWh";
  SI.HeatFlowRate var_Q_heat "power demand for heater";
  SI.HeatFlowRate var_Q_des "heating power demand for desorption";
  SI.Mass var_total_water_removed(start=0.0, fixed=true) "total mass of adsorbed water";
  SI.Temperature var_T_heater(start=param_T_ac, fixed=false) "gas temperature after heater in feedback loop";

  // actual in and output flow rates of gas dryer
  SI.MolarFlowRate var_n_gas_in;
  SI.MolarFlowRate var_n_h2o_in;
  SI.MolarFlowRate var_n_gas_out;
  SI.MolarFlowRate var_n_h2o_out;

  // temporary molar flow rates
  SI.MolarFlowRate var_n_condenser_in(start=0.0, fixed=false);
  SI.MolarFlowRate var_n_gas_condenser_in;
  SI.MolarFlowRate var_n_h2o_condenser_in;
  SI.MolarFlowRate var_n_condenser_out;
  SI.MolarFlowRate var_n_gas_condenser_out;
  SI.MolarFlowRate var_n_h2o_condenser_out;

  SI.MolarFlowRate var_n_drybed_in;
  SI.MolarFlowRate var_n_gas_drybed_in;
  SI.MolarFlowRate var_n_h2o_drybed_in;
  SI.MolarFlowRate var_n_drybed_out;
  SI.MolarFlowRate var_n_gas_drybed_out;
  SI.MolarFlowRate var_n_h2o_drybed_out;

  SI.MolarFlowRate var_n_feedback_in;
  SI.MolarFlowRate var_n_gas_feedback_in(start=0.0, fixed=false);
  SI.MolarFlowRate var_n_h2o_feedback_in;
  SI.MolarFlowRate var_n_feedback_out;
  SI.MolarFlowRate var_n_gas_feedback_out;
  SI.MolarFlowRate var_n_h2o_feedback_out(start=0.0, fixed=false);

  // temporary molar fractions
  SI.MoleFraction var_x_h2o_condenser_in;
  // SI.MoleFraction var_x_gas_condenser_in;
  SI.MoleFraction var_x_h2o_condenser_out;
  SI.MoleFraction var_x_gas_condenser_out;
  SI.MoleFraction var_x_h2o_drybed_in;
  SI.MoleFraction var_x_h2o_drybed_out;
  SI.MoleFraction var_x_gas_drybed_out;

  /*
  Real var_x_h2o_condenser_in;
  Real var_x_gas_condenser_in; 
  Real var_x_h2o_condenser_out;

  Real var_x_h2o_drybed_in;
  Real var_x_h2o_drybed_out;
  Real var_x_gas_drybed_out;
  */

  // absorbed water
  SI.MolarFlowRate var_delta_h2o;

  // connectors and components
  Tools.Connectors.GasConnector port_inlet_gas(redeclare package Gas = Gas) annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-120,-20},
            {-80,20}})));
  Tools.Connectors.GasConnector port_outlet_gas(redeclare package Gas = Gas) annotation (
      Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{80,-20},
            {120,20}})));
  Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-100,-100},
            {-80,-80}}), iconTransformation(extent={{-20,-120},{20,-80}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet_water if param_use_water_outlet  annotation (Placement(transformation(extent={{80,-100},{100,-80}}),
        iconTransformation(extent={{80,-100},{100,-80}})));
  AixLib.FastHVAC.Components.Sinks.Vessel comp_waterSink if not param_use_water_outlet;

  Modelica.Blocks.Tables.CombiTable2D table_humidity_condenser(
    tableOnFile=true,
    tableName="humidity",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/H2_humidity.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    verboseExtrapolation=true)
    "calculation of hydrogen water content after condenser"
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));

  Modelica.Blocks.Tables.CombiTable2D table_temperature_heater(
    u2(start=param_T_ac),
    tableOnFile=true,
    tableName="humidity",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/H2_humidity_backward.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    verboseExtrapolation=true) "table to determine temperature after heater"
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));

protected
  parameter SI.MoleFraction param_x_h2o_dry=param_ppm_h2o*1e-6;
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_tmpOut "temporary port";
  SI.Pressure var_p=port_inlet_gas.p "pressure inside dryer";

equation

  assert(var_p<=60e5, "reverse data for water content of hydrogen was only calculated up to 60 bar", AssertionLevel.error);

  // table
  table_humidity_condenser.u1 = SI.Conversions.to_bar(var_p);
  table_humidity_condenser.u2 = param_T_ac;

  // input
  var_n_gas_in =max(port_inlet_gas.X[1]*port_inlet_gas.n_flow,0);
  var_n_h2o_in =max(port_inlet_gas.X[2]*port_inlet_gas.n_flow,0);

  // condenser (always cooling to 40°C)
  var_n_gas_condenser_in = max(var_n_gas_in + var_n_gas_feedback_out,0);
  var_n_h2o_condenser_in = max(var_n_h2o_in + var_n_h2o_feedback_out,0);
  var_n_condenser_in = var_n_gas_condenser_in+var_n_h2o_condenser_in;

  var_x_h2o_condenser_in = if noEvent(var_n_condenser_in>Const.eps)
    then var_n_h2o_condenser_in/var_n_condenser_in else 0;

  var_x_h2o_condenser_out =min(table_humidity_condenser.y,
    var_x_h2o_condenser_in);
  var_x_gas_condenser_out = 1-var_x_h2o_condenser_out;

  assert(var_x_gas_condenser_out>0.1, "mole fraction of gas is zero, table_humidity_condenser.y: "
   + String(table_humidity_condenser.y), AssertionLevel.error);

  var_n_gas_condenser_out = var_n_gas_condenser_in;
  var_n_condenser_out = if noEvent(var_x_gas_condenser_out>0) then
    var_n_gas_condenser_out/var_x_gas_condenser_out else 0;
  var_n_h2o_condenser_out = var_n_condenser_out*var_x_h2o_condenser_out;

  // dry bed absorber
  var_n_gas_drybed_in = var_n_gas_condenser_out;
  var_n_h2o_drybed_in = var_n_h2o_condenser_out;
  var_n_drybed_in = var_n_gas_drybed_in+var_n_h2o_drybed_in;
  var_x_h2o_drybed_in = var_x_h2o_condenser_out;

  var_n_gas_drybed_out = var_n_gas_drybed_in;
  var_n_h2o_drybed_out = var_n_drybed_out*var_x_h2o_drybed_out;
  var_n_drybed_out = var_n_gas_drybed_out/var_x_gas_drybed_out;
  var_x_h2o_drybed_out = max(min(param_x_h2o_dry, var_x_h2o_drybed_in),0);
  var_x_gas_drybed_out = 1-var_x_h2o_drybed_out;

  // absorbed water
  var_delta_h2o =  var_n_drybed_in - var_n_drybed_out;
  var_n_gas_out = var_n_gas_drybed_out * (1-param_feedbackFlow);

  // actual output of gas dryer
  var_n_h2o_out = var_n_h2o_drybed_out * (1-param_feedbackFlow);

  // feedback loop with heater and desorption
  var_n_gas_feedback_in = var_n_gas_drybed_out * param_feedbackFlow;
  var_n_h2o_feedback_in = var_n_h2o_drybed_out * param_feedbackFlow;
  var_n_feedback_in = var_n_gas_feedback_in+var_n_h2o_feedback_in;

  // determine temperature of hydrogen so that saturation pressure is high enough to
  // desorp water from dry bed
  table_temperature_heater.u1 = SI.Conversions.to_bar(var_p);

  if noEvent(var_delta_h2o>0) then
    // input is mole fraction of water vapor
    table_temperature_heater.u2 = max((var_delta_h2o+var_n_h2o_feedback_in)/(var_n_feedback_in+var_delta_h2o),0);
  else
    table_temperature_heater.u2 = 0;
  end if;
  var_T_heater = max(table_temperature_heater.y, param_T_ac);

  // power consumption of heating of gas and desorptin
  state_cold = Gas.setState_pTX(var_p, param_T_ac, {var_x_gas_drybed_out, var_x_h2o_drybed_out});
  state_hot = Gas.setState_pTX(var_p, var_T_heater, {var_x_gas_drybed_out, var_x_h2o_drybed_out});
  var_cp = (Gas.specificHeatCapacityCp(state_cold)+Gas.specificHeatCapacityCp(state_hot))/2;
  var_Q_heat = max(var_cp*Gas.molarMass(state_cold)*var_n_feedback_in*(var_T_heater-param_T_ac),0);
  var_Q_des = param_adsorp_enth * var_delta_h2o;

  // states after desorption
  var_n_feedback_out = var_n_gas_feedback_out+var_n_h2o_feedback_out;
  var_n_gas_feedback_out = var_n_gas_feedback_in;
  var_n_h2o_feedback_out = var_n_h2o_feedback_in+var_delta_h2o;

  // outlet port
  port_outlet_gas.n_flow = var_n_gas_out+var_n_h2o_out;
  port_outlet_gas.p = var_p;
  port_outlet_gas.X = {var_x_gas_drybed_out, var_x_h2o_drybed_out};
  port_outlet_gas.h = Gas.specificEnthalpy(Gas.setState_pTX(
    var_p, param_T_ac, port_outlet_gas.X));

  // total water removed from gas stream
  der(var_total_water_removed) = port_tmpOut.m_flow;

  // power consumption for heating
  port_P_el.P = max((var_Q_des + var_Q_heat)/param_eta_h,0);
  der(var_P_cons) = port_P_el.P;

  // water outlet
  state_h2o = H2O.setState_pT(var_p, param_T_ac);
  port_tmpOut.m_flow= var_delta_h2o * H2O.molarMass(state_h2o);
  port_tmpOut.T = param_T_ac;
  port_tmpOut.c = H2O.specificHeatCapacityCp(state_h2o);
  port_tmpOut.h = H2O.specificEnthalpy(state_h2o);

  if param_use_water_outlet then
    connect(port_outlet_water, port_tmpOut);
  else
    connect(comp_waterSink.enthalpyPort_a, port_tmpOut);
  end if;

annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-70,30},{-10,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None),
        Rectangle(
          extent={{16,30},{50,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None),
        Line(points={{-26,-28}}, color={0,0,0}),
        Line(points={{-52,-46},{-52,10},{-40,-10},{-28,10},{-28,-46}}, color={0,
              0,0}),
        Line(points={{16,-14},{50,-14}},
                                       color={0,0,0}),
        Polygon(
          points={{40,-10},{48,-10},{44,-14},{40,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None),
        Line(points={{-90,0},{-70,0}}, color={0,0,0}),
        Line(points={{-10,0},{16,0}}, color={0,0,0}),
        Line(points={{50,0},{90,0}}, color={0,0,0}),
                                        Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GasDryer;
