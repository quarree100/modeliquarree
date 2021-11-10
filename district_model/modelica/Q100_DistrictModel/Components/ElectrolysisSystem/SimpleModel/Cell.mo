within Q100_DistrictModel.Components.ElectrolysisSystem.SimpleModel;
model Cell "simple model of electrolysis cell"
  extends PartialModels.PartialCell;

  parameter Units.VolumetricEnergy param_kWh_per_m3 = 4.4 "constant specific energy demand in kWh per normcubicmeter (0 °C, 1,01325 bar)";

  // resulting efficiency
  parameter SI.Efficiency param_eta=param_HHV_h2/param_kWh_per_m3 "resulting constant efficiency of electrolysis";

  // variables: molar fraction of water in hydrogen and oxygen
  SI.MolarFlowRate var_n_h2_port "molar flow rate of produced hydrogen";
  SI.MolarFlowRate var_n_o2_port "molar flow rate of produced hydrogen";

   // heat balance variables
  SI.HeatFlux var_q_cell "total heat flow of one cell";
  SI.HeatFlux var_q_vap "evaporation heat flow of one cell";
  SI.HeatFlux var_q_rea "reaction heat flow of one cell";

  Modelica.Blocks.Tables.CombiTable2D inp_volt_characteristic(
    tableOnFile=true,
    tableName="curr_volt_T_Q100",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/parameter/CurrentVoltageCharacteristicTemperature.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
    "current voltage characteristic curve"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

protected
  parameter Units.MolePerJoule param_mpj= 1/(param_HHV_h2*3600000)*param_dens_h2/param_M_h2 "mole per joule (HHV) for norm conditions (0 °C, 1,01325 bar)";
equation

  inp_volt_characteristic.u1 = inp_i/1e4; // expected input is in A/cm2
  inp_volt_characteristic.u2 = inp_T;
  var_U_cell = inp_volt_characteristic.y;

  // simplified constant efficiency approach
  // temperature and pressure dependency is neglected
  // var_n_h2_port = max(port_P_el.P*param_eta_electrolysis/var_delta_Hr,0);
  var_n_h2_port = max(param_eta*port_P_el.P*param_mpj, 0);
  var_n_o2_port = 0.5*var_n_h2_port;

  //heat balance
  var_q_cell = var_q_vap + var_q_rea;
  var_q_rea = (var_U_cell - var_U_therm)*inp_i;
  var_q_vap =-Tools.Functions.WaterEvaporationEnthalpy(inp_T)*(var_n_h2_port/
    param_membrane_area*var_x_h2o_h2 + var_n_o2_port/param_membrane_area*var_x_h2o_o2);

  //cell heat production
  var_Q_prod = param_membrane_area*var_q_cell;

  // calculate molar flow rates in ports
  port_outlet_h2.n_flow = max(var_n_h2_port/(1-var_x_h2o_h2), 0);
  port_outlet_o2.n_flow = max(var_n_o2_port/(1-var_x_h2o_o2), 0);

 annotation (
      Placement(transformation(extent={{-100,-100},{-80,-80}}),
        iconTransformation(extent={{-100,-100},{-60,-60}})),
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-74,50},{46,70},{46,-30},{-74,-50},{-74,50}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Polygon(
          points={{-62,40},{38,58},{38,-22},{-62,-40},{-62,40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-58,36},{42,54},{42,-26},{-58,-44},{-58,36}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-54,32},{46,50},{46,-30},{-54,-48},{-54,32}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-40,30},{-40,-72},{80,-50},{80,50},{-40,30}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          lineColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100000000000, __Dymola_NumberOfIntervals=1000000));
end Cell;
