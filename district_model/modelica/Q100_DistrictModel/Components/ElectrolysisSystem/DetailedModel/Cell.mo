within Q100_DistrictModel.Components.ElectrolysisSystem.DetailedModel;
model Cell "detailed model of electrolysis cell"
  extends PartialModels.PartialCell(table_hydrogen(verboseExtrapolation=false),
      table_oxygen(extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
        verboseExtrapolation=false));

  // membrane parameters
  parameter Units.MembraneHumidity param_lambda=25
    "constant humidity of membrane"    annotation (Dialog(group="membrane parameters"));
  parameter Units.ResistanceArea param_r_ele=0.096/1e4
    "electric resistivity of membrane [Ohm*m²]"    annotation (Dialog(group="membrane parameters"));

  // coefficients for calculation
  parameter Units.CombinedDiffHydrThickFactor param_A_cs=2.4*1e5/1e4
    "constant cathode current collector thickness / (2*F(diffusion coefficient * hydraulic conductivity))"  annotation (Dialog(group="coefficients for calculation"));
  parameter Units.CombinedDiffHydrThickFactor param_A_as=2.8*1e5/1e4
    "constant anode current collector thickness / (2*F(diffusion coefficient * hydraulic conductivity))" annotation (Dialog(group="coefficients for calculation"));
  parameter Units.PermeabilityCoefficient param_perm_coeff_h2=4e-14
    "permeability coefficient of hydrogen (80°C)"  annotation (Dialog(group="coefficients for calculation"));
  parameter Units.PermeabilityCoefficient param_perm_coeff_o2=2e-14
    "permeability coefficient of oxygen (80°C)"  annotation (Dialog(group="coefficients for calculation"));
  parameter SI.MoleFraction param_epsilon_d=0.27
    "coefficient for electroosmotic drag of water through membrane [mol H2O / mol H2]"  annotation (Dialog(group="coefficients for calculation"));

  // variables: pressure at cathode
  SI.Pressure var_p_h2_ca
    "partial pressure of hydrogen at cathode";
  SI.Pressure var_p_h2_cc
    "partial pressure of hydrogen in channel on cathode side";
  SI.Pressure var_p_h2o_cc
    "partial pressure of water vapor in channel on cathode side";

  // variables: pressure at anode
  SI.Pressure var_p_o2_an
    "partial pressure of oxygen at anode";
  SI.Pressure var_p_o2_ac
    "partial pressure of oxygen in channel on anode side";
  SI.Pressure var_p_h2o_ac
    "partial pressure of water vapor in channel on anode side";

  // variables: currents
  SI.CurrentDensity var_i_loss "mass losses";

  // variables: efficiencies
  SI.Efficiency var_eta_cell "cell efficiency";
  SI.Efficiency var_eta_volt "voltage efficiency";
  SI.Efficiency var_eta_curr "current efficiency";

  // variables: molar flows in channels
  Units.MolarFlowRateDensity var_n_h2_ac
    "hydrogen flow in anode channel [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_h2o_ac
    "water flow in anode channel [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_o2_ac
    "oxygen flow in anode channel [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_h2_cc
    "hydrogen flow in cathode channel [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_h2o_cc
    "water flow in cathode channel [mol/(s*m²)]";

  // variables: molar flows produced / consumed
  Units.MolarFlowRateDensity var_n_h2o_cons
    "consumed water flow at anode [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_o2_prod
    "produced oxygen flow at anode [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_h2_prod
    "produced hydrogen flow at cathode [mol/(s*m²)]";

  // variables: molar permeation flows
  Units.MolarFlowRateDensity var_n_h2_per
    "permeation hydrogen flow to anode [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_h2o_per
    "permeation water flow to cathode [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_o2_per
    "permeation oxygen flow to cathode [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_h2o_dis
    "water flow from recombination of permeated oxygen and produced hydrogen at cathode [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_h2o_h2
    "water vapor in saturated hydrogen [mol/(s*m²)]";
  Units.MolarFlowRateDensity var_n_h2o_o2
    "water vapor in saturated oxygen [mol/(s*m²)]";

  // cell voltage variables
  SI.Voltage var_U_nernst "nernst voltage";
  SI.Voltage var_U_act "activation overvoltage";
  SI.Voltage var_U_ohm "ohmic overvoltage";
  SI.Voltage var_U_conc=0 "concentration overvoltage";

  // variable membrane parameter
  SI.Voltage var_alpha
    "combined Durchtrittsfaktor (from curve fitting 80°C) [V]";
  SI.CurrentDensity inp_i_0
    "combined exchange current density (from curve fitting 80°C) [A/m²]";
  Units.ResistanceArea var_r_ion
    "ionic resistivity of membrane [Ohm*m²]";
  SI.Conductivity var_sigma_mem "conductivity of membran";

  // heat balance variables
  SI.HeatFlux var_q_cell "total heat flow of one cell";
  SI.HeatFlux var_q_vap "evaporation heat flow of one cell";
  SI.HeatFlux var_q_rea "reaction heat flow of one cell";

  // temperature dependent input data from table
  Modelica.Blocks.Tables.CombiTable1Ds table_parameter(
    tableOnFile=true,
    tableName="elecData",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/parameter/cell.txt"),
    columns=2:3,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    verboseExtrapolation=false) "temperature dependent parameter data for cell"
    annotation (Placement(transformation(extent={{-60,18},{-40,38}})));

protected
  final parameter SI.Pressure param_var_p_h2_ref=101325
    "reference pressure in Nernst equation";
  final parameter SI.Pressure param_var_p_o2_ref=101325
    "reference pressure in Nernst equation";

  Real tmp "tmp variable for permeation split";

equation

assert(
    inp_i >= -Const.eps,
    "current density negative: " + String(inp_i),
    AssertionLevel.warning);
assert(
    inp_i_0 >= -Const.eps,
    "i_0 negative: " + String(inp_i_0),
    AssertionLevel.warning);

  // table for interpolation data
  table_parameter.u = inp_T;
  var_alpha =table_parameter.y[1];
  inp_i_0 =table_parameter.y[2]*1e4;

  var_p_h2o_ac = var_x_h2o_o2*param_p_op_anode;
  var_p_h2o_cc = var_x_h2o_h2*param_p_op_cathode;

  // pressure in channels assuming there is no o2 at cathode and no h2 at anode
  param_p_op_anode = var_p_o2_ac + var_p_h2o_ac;
  param_p_op_cathode = var_p_h2_cc + var_p_h2o_cc;

  // partial pressure of hydrogen/oxygen at cathode / anode
  var_p_h2_ca = max(var_p_h2_cc + inp_i*param_A_cs,0);
  var_p_o2_an = max(var_p_o2_ac + inp_i*param_A_as,0);

  // cell efficiency
  var_eta_volt = var_U_nernst/var_U_cell;
  var_eta_curr = if noEvent(inp_i > var_i_loss) then max((inp_i - var_i_loss)/inp_i,0) else 0;
  var_eta_cell = var_eta_volt*var_eta_curr;

  // voltage losses
  var_U_cell = var_U_nernst + var_U_act + var_U_ohm + var_U_conc;
  var_U_act = if noEvent(inp_i>Const.eps) then max(var_alpha*log(inp_i/inp_i_0),0) else 0;

  if noEvent(var_p_o2_an>Const.eps) then
    var_U_nernst = var_U_rev + Const.R*inp_T/(2*Const.F)*log(sqrt(var_p_o2_an/1e5)*var_p_h2_ca/1e5);
  else
    var_U_nernst = var_U_rev;
  end if;

  // times 100 for conversion 1/(Ohm*cm) -> 1/(Ohm*m)
  var_sigma_mem = (0.005139*param_lambda - 0.00326)*Modelica.Math.exp(1268*(1/303 - 1/(min(max(inp_T,273.15),373.15))))*100;
  var_r_ion = param_membrane_d/var_sigma_mem;
  var_U_ohm = (var_r_ion + param_r_ele)*inp_i;

  // mass losses
  var_i_loss = 2*Const.F*(var_n_h2_per + 2*var_n_o2_per);

  // mass balance
  // anode
  var_n_h2_ac = var_n_h2_per;
  var_n_o2_ac = var_n_o2_prod - var_n_o2_per;
  // liquid water needed for electrolysis
  var_n_h2o_ac = var_n_h2o_cons + var_n_h2o_per + var_n_h2o_h2 + var_n_h2o_o2;
  // cathode
  var_n_h2_prod = var_n_h2_cc + var_n_h2_per + 2*var_n_o2_per;
  //permeated oxygen reacts to h2o, twice the amount of hydrogen needed
  var_n_h2o_cc = var_n_h2o_per + var_n_h2o_dis;
  var_n_h2o_dis = var_n_o2_per;
  // 1 mol oxygen reacts with 2 mol hydrogen to 1 mol water
  // production

  var_n_h2_prod = inp_i/(2*Const.F);
  var_n_o2_prod = 0.5*var_n_h2_prod;
  var_n_h2o_cons = var_n_h2_prod;

  tmp = 0.5;
  var_n_h2_per = min(param_perm_coeff_h2/param_membrane_d*var_p_h2_ca, tmp*var_n_h2_prod);
  var_n_o2_per = min(param_perm_coeff_o2/param_membrane_d*var_p_o2_an, (1-tmp)*var_n_h2_prod);

  // also simplified approach for electroosmotic water drag
  var_n_h2o_per = param_epsilon_d*var_n_h2_prod;

  // var_x_h2o is calculated in partial model
  var_n_h2o_h2 = var_n_h2_cc *var_x_h2o_h2/(1-var_x_h2o_h2);
  var_n_h2o_o2 = var_n_o2_ac * var_x_h2o_o2/(1-var_x_h2o_o2);

  //heat balance
  var_q_cell = var_q_vap + var_q_rea;
  var_q_rea = (var_U_cell - var_U_therm)*inp_i;
  var_q_vap =-Tools.Functions.WaterEvaporationEnthalpy(inp_T)*(var_n_h2o_h2 + var_n_h2o_o2);
                                                                                      //+var_n_h2o_cons);

  //cell heat production
  var_Q_prod = param_membrane_area*var_q_cell;

  // calculate molar flow rates in ports (rest in partial model)
  port_outlet_h2.n_flow = max(var_n_h2_cc/var_X_cc[1]*param_membrane_area, 0);
  port_outlet_o2.n_flow = max(var_n_o2_ac/var_X_ac[1]*param_membrane_area, 0);

  annotation (
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
