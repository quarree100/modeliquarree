within Q100_DistrictModel.ElectrolysisSystem.PartialModels;
partial model PartialCell

  // media models
  replaceable package H2O = Modelica.Media.Water.WaterIF97_R1pT; //R1 is liquid, R2 is vapor
  replaceable package H2 = Media.Gases.H2andWaterVapor;
  replaceable package O2 = Media.Gases.O2andWaterVapor;

  // operating parameter
  parameter Units.VolumetricEnergy param_kWh_per_m3 = 4.4 "simple model: constant specific energy demand for H2 production of stack in kWh per normcubicmeter (0 °C, 1,01325 bar)" annotation(Dialog(group="electrolysis parameter"));
  parameter Units.VolumetricEnergy param_HHV_h2 = 3.5403 "higher heating value of H2 at norm conditions (0 °C, 1,01325 bar)"
                                                                                                                             annotation(Dialog(group="electrolysis parameter"));
   SI.Pressure param_p_op_cathode
    "total pressure in channel on cathode side"  annotation (Dialog(group="operating parameter"));
   SI.Pressure param_p_op_anode
    "total pressure in channel on anode side"   annotation (Dialog(group="operating parameter"));
  parameter SI.Area param_membrane_area=600e-4  "active area of cell [m²]"   annotation (Dialog(group="membrane parameter"));
  parameter SI.Distance param_membrane_d=200e-6 "membrane thickness [m]"   annotation (Dialog(group="membrane parameter"));

  // variable evaporation enthalpy
  SI.MolarEnthalpy var_delta_Hr=-Media.Functions.H2O.deltaH(inp_T)
      "temperature dependent evaporation enthalpy of electrolyssis";

  // results
  SI.MoleFraction var_X_cc[2] "mole fractions hydrogen/vapor in cathode channel";
  SI.MoleFraction  var_X_ac[2] "mole fractions oxygen/vapor in anode channel";

  SI.Voltage var_U_rev "reversible cell voltage";
  SI.Voltage var_U_therm "thermoneutral cell voltage";
  SI.Voltage var_U_cell "current voltage of cell";
  SI.Power var_Q_prod "heat production of single cell";

  SI.Temperature var_T_cc=inp_T
    "temperature of cell cathode channel (no differentiation as of now)";
  SI.Temperature var_T_ac=inp_T
    "temperature of cell cathode channel (no differentiation as of now)";

  // variables: molar fraction of water in hydrogen and oxygen
  Units.MolarFraction var_x_h2o_h2
    "water vapor in saturated hydrogen [mol/mol]";
  Units.MolarFraction var_x_h2o_o2
    "water vapor in saturated oxygen [mol/mol]";

  // connectors
  Tools.Connectors.GasConnector port_outlet_h2(redeclare package Gas = H2) annotation (
      Placement(transformation(extent={{60,60},{80,80}}), iconTransformation(extent={{60,60},{100,
            100}})));
  Tools.Connectors.GasConnector port_outlet_o2(redeclare package Gas = O2) annotation (
      Placement(transformation(extent={{60,-100},{80,-80}}), iconTransformation(extent={{60,-100},
            {100,-60}})));
  Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-100,-100},
            {-80,-80}}), iconTransformation(extent={{-100,-100},{-60,-60}})));

  Modelica.Blocks.Interfaces.RealInput inp_i "input for current density"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput inp_T "cell temperature"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
        iconTransformation(extent={{-120,20},{-100,40}})));
  Modelica.Blocks.Tables.CombiTable2D table_hydrogen(
    tableOnFile=true,
    tableName="humidity",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/H2_humidity.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
    verboseExtrapolation=false)
                               "water vapor content of hydrogen"
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));

  Modelica.Blocks.Tables.CombiTable2D table_oxygen(
    tableOnFile=true,
    tableName="humidity",
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/ElectrolysisSystem/Resources/gas_data/O2_humidity.txt"),
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    verboseExtrapolation=false)
                               "water vapor content of oxygen"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

protected
  H2.ThermodynamicState state_h2;
  O2.ThermodynamicState state_o2;
  parameter SI.Density param_dens_h2 = H2.density(H2.setState_pTX(101325,273.15,{1,0})) "density of H2 at norm conditions (0 °C, 1,01325 bar)";
  parameter SI.Density param_dens_o2 = O2.density(H2.setState_pTX(101325,273.15,{1,0})) "density of O2 at norm conditions (0 °C, 1,01325 bar)";
  parameter SI.MolarMass param_M_h2 = H2.molarMass(H2.setState_pTX(101325,273.15,{1,0})) "molar mass of H2";
equation

  assert(var_T_cc>274, "temperature too low (=" + String(var_T_cc) + " K)",  AssertionLevel.error);
  assert(param_p_op_cathode>=1e5, "pressure too low (=" + String(param_p_op_cathode) + " Pa)",  AssertionLevel.error);
  assert(param_p_op_anode<=27e5, "data for water content of oxygen is only valid up to 27 bar", AssertionLevel.error);

  // gas data
  table_hydrogen.u1 = SI.Conversions.to_bar(param_p_op_cathode);
  table_hydrogen.u2 = inp_T;
  table_oxygen.u1 = SI.Conversions.to_bar(param_p_op_anode);
  table_oxygen.u2 = inp_T;

  // reversible cell voltage
  var_U_rev =
    (-Media.Functions.H2O.deltaH(inp_T)
    -inp_T*(Media.Functions.H2.S(inp_T) +0.5*Media.Functions.O2.S(inp_T)-Media.Functions.H2O.S(inp_T)))
    /(2*Const.F);
  var_U_therm = var_delta_Hr/(2*Const.F);

  // water vapor in gases [mole H2O per mole gas] (assumption: saturated gas)
  // Huang (2007): Humidity Standard of Compressed Hydrogen for Fuel Cell Technology
  // Huang (2008): Humidity Standard of Compressed Oxygen for Future Generation PEM Fuel Cells
  var_x_h2o_h2 = table_hydrogen.y;
  var_x_h2o_o2 = table_oxygen.y;

  // thermodynamic states to calculate h for port
  state_h2 = H2.setState_pTX(param_p_op_cathode,var_T_cc,var_X_cc);
  state_o2 = O2.setState_pTX(param_p_op_anode,var_T_ac,var_X_ac);

  // port variables except n_flow
  var_X_cc = {(1-var_x_h2o_h2), var_x_h2o_h2};
  port_outlet_h2.p = param_p_op_cathode;
  port_outlet_h2.h = H2.specificEnthalpy(state_h2);
  port_outlet_h2.X = var_X_cc;

  var_X_ac = {(1-var_x_h2o_o2), var_x_h2o_o2};
  port_outlet_o2.p = param_p_op_anode;
  port_outlet_o2.h = O2.specificEnthalpy(state_o2);
  port_outlet_o2.X = var_X_ac;

  port_P_el.P = max(var_U_cell * inp_i * param_membrane_area,0);
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
end PartialCell;
