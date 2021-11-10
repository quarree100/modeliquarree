within Q100_DistrictModel.Components.ElectrolysisSystem.GasCompressor;
model H2Compressor "partial model for gas compressor"

  // media model
  package Gas = Media.Gases.H2andWaterVapor;

  // parameters for compressor
  parameter SI.Pressure param_p_end=50e5
    "pressure at the end of compression";
//  parameter SI.Pressure
  parameter SI.Temperature param_T_start=40 + 273.15
    "temperature after intercooler";
  parameter SI.Temperature param_T_end=135 + 273.15
    "maximum temperatue allowed during compression";
  parameter Real param_kappa=1.50 "constant isentropix exponent of hydrogen for calculation of number of stages";
  parameter SI.Efficiency param_eta_mech=0.8
    "mechanical efficiency of compressor";

  /*
  // Modelica doesn't allow component array with 'variable' size 
  // -> ThermodynamicState-Arrays are the problem, without them this approach would work
  parameter Integer param_n_compStage=
    integer(ceil(log(param_p_end/port_inlet_gas.p)/log((param_T_end/param_T_start)^(param_kappa/(param_kappa-1)))))
      "number of compressor stages (calculated with constant kappa)";
  */
  parameter Integer param_n_compStage=5 "number of compressor stages";

  // variables
  SI.Energy var_P_cons(start=0.0, fixed=true)
    "integrated power consumption";
  Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
    "integrated power consumption in kWh";

  SI.Pressure var_p_in[param_n_compStage];
  SI.Pressure var_p_out[param_n_compStage];
  Real var_Z_in[param_n_compStage];
//  Real var_Z_out[param_n_compStage];
//  Real var_Z_stage[param_n_compStage];
  Real var_k_in[param_n_compStage];
  Real var_k_out[param_n_compStage];
  Real var_k_stage[param_n_compStage];
  SI.SpecificEnthalpy var_h_in[param_n_compStage];
  SI.SpecificEnthalpy var_h_out[param_n_compStage];
  Real var_ratio;
  SI.MolarEnergy var_w_t_stage[param_n_compStage];
  SI.MolarEnergy var_w_t;
  SI.Power var_P_comp "power for compression";
  SI.Power var_P_el "electrical power consumption";
  SI.Power var_P_cool[param_n_compStage + 1] "cooling power";
  Gas.ThermodynamicState state_in[param_n_compStage];
  Gas.ThermodynamicState state_out[param_n_compStage];

  // Connectors
  Tools.Connectors.GasConnector port_inlet_gas(redeclare package Gas = Gas) annotation (
      Placement(transformation(extent={{-68,-10},{-48,10}}), iconTransformation(extent={{-120,-20},
            {-80,20}})));
  Tools.Connectors.GasConnector port_outlet_gas(redeclare package Gas = Gas) annotation (
      Placement(transformation(extent={{52,-12},{72,8}}), iconTransformation(extent={{80,-20},{120,
            20}})));
  Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-10,-108},
            {10,-88}}), iconTransformation(extent={{-20,-120},{20,-80}})));

  Modelica.Blocks.Tables.CombiTable2D table_kappa[2*param_n_compStage](each
    tableOnFile=true,
    each tableName="kappa",
    each fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/Components/ElectrolysisSystem/Resources/gas_data/H2_kappa.txt"),
    each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    each extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
    each verboseExtrapolation=true) "real gas isentropic exponent of hydrogen"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));

  Modelica.Blocks.Tables.CombiTable2D table_z[param_n_compStage](
    each tableOnFile=true,
    each tableName="z",
    each fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/Components/ElectrolysisSystem/Resources/gas_data/H2_z.txt"),
    each smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    each extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints,
    each verboseExtrapolation=true) "compressibility factor of real gas hydrogen"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));

protected
  Real var_m_gas "constant molar mass of gas";
  Gas.ThermodynamicState state_init;
  Gas.ThermodynamicState state_end;

  Real var_X[2];
  parameter Real var_ratio_tmp(fixed=false);
  parameter Integer param_n_compStage_min(fixed=false) "minimal number of compressor
  stages to fit boundary condition max temperature";

initial algorithm
  //compression ratio due to boundary condition max temperature
  var_ratio_tmp := min((param_T_end/param_T_start)^(param_kappa/(param_kappa-1)), max(param_p_end/port_inlet_gas.p,1));
  // calculate the needed # of stages once
  param_n_compStage_min := if var_ratio>1 then
    integer(ceil(log(param_p_end/port_inlet_gas.p)/log(var_ratio_tmp)))
      else 1;
equation

  assert(
    port_P_el.P >= -Const.eps,
    "power input is below zero",
    AssertionLevel.warning);

  // output warning if # of compression stags is too low
  // to fit boundary condition max temperature
  assert(
    param_n_compStage >= param_n_compStage_min,
    "the compressor needs to have more stages (at least "
      + String(param_n_compStage_min) + ")"
      + " if input pressure is " + String(port_inlet_gas.p/1e5) + " bar and "
      + "desired output pressure is " + String(param_p_end/1e5) + " bar. ",
    AssertionLevel.error);

  assert(port_inlet_gas.p*var_ratio_tmp^param_n_compStage>=param_p_end,
    "input pressure is too low to reach specified end pressure. Raise number of stages!"
    + ", reachable pressure: " + String(port_inlet_gas.p*var_ratio^param_n_compStage),
    AssertionLevel.error);

  for i in 1:size(port_inlet_gas.X, 1) loop
    var_X[i] =port_inlet_gas.X[i];
  end for;

  // formula if compStage is caculated
  //var_ratio=if param_p_end>var_p_in[1] then (param_T_end/param_T_start)^(param_kappa/(param_kappa-1)) else 1;
  // otherwise if n_compStage is constant then just
  var_ratio = max(min(
     (param_T_end/param_T_start)^(param_kappa/(param_kappa-1)),
     (param_p_end/port_inlet_gas.p)^(1/param_n_compStage)),1);

  for i in 1:param_n_compStage loop
    // input pressure of stage
    if i==1 then
      var_p_in[i] =port_inlet_gas.p;
    else
      var_p_in[i]=var_p_out[i-1];
    end if;

    // output pressure of stage
    if i==param_n_compStage then
      var_p_out[i] = param_p_end;
    else
      var_p_out[i]=var_p_in[i]*var_ratio;
    end if;

    // get density and kappa before compression
    state_in[i] = Gas.setState_pTX(var_p_in[i], param_T_start, var_X);
    state_out[i] = Gas.setState_pTX(var_p_out[i], param_T_end, var_X);

    table_kappa[2*(i-1)+1].u1 = SI.Conversions.to_bar(var_p_in[i]);
    table_kappa[2*(i-1)+1].u2 = param_T_start;
    var_k_in[i] = table_kappa[2*(i-1)+1].y;

    table_kappa[2*(i-1)+2].u1 = SI.Conversions.to_bar(var_p_out[i]);
    table_kappa[2*(i-1)+2].u2 = param_T_end;
    var_k_out[i] = table_kappa[2*(i-1)+2].y;

    var_k_stage[i] = (var_k_in[i]+var_k_out[i])/2;

    var_h_in[i] = Gas.specificEnthalpy(state_in[i]);
    var_h_out[i] = Gas.specificEnthalpy(state_out[i]);

    table_z[i].u1 = SI.Conversions.to_bar(var_p_in[i]);
    table_z[i].u2 = param_T_start;
    var_Z_in[i] = table_z[i].y;

    // specific work of stage
    var_w_t_stage[i] = var_k_stage[i]/(var_k_stage[i] - 1)*
      Const.R*param_T_start*var_Z_in[i]*(var_ratio^((
      var_k_stage[i] - 1)/var_k_stage[i]) - 1);
  end for;

  // cooling load
  state_init =Gas.setState_phX(
    port_inlet_gas.p,
    port_inlet_gas.h,
    port_inlet_gas.X);
  // gas gets cooled after last stage
  state_end = Gas.setState_pTX(var_p_out[param_n_compStage], param_T_start, var_X);
  var_m_gas = Gas.molarMass(state_init);

  //cooling before compression
  var_P_cool[1] =var_m_gas*port_inlet_gas.n_flow*(Gas.specificEnthalpy(state_init) -
    Gas.specificEnthalpy(state_in[1]));
  //cooling during compression
  for i in 1:param_n_compStage-1 loop
    var_P_cool[i+1] =var_m_gas*port_inlet_gas.n_flow*(var_h_out[i] - var_h_in[i + 1]);
  end for;
  //cooling after compression
  var_P_cool[param_n_compStage+1] =var_m_gas*port_inlet_gas.n_flow*(Gas.specificEnthalpy(
    state_out[param_n_compStage]) - Gas.specificEnthalpy(state_end));

  // mass balance
  port_inlet_gas.n_flow = port_outlet_gas.n_flow;
  port_inlet_gas.X = port_outlet_gas.X;
  port_outlet_gas.p = var_p_out[param_n_compStage];
  port_outlet_gas.h = Gas.specificEnthalpy(state_end);

  var_w_t = sum(var_w_t_stage);
  var_P_comp =var_w_t*abs(port_inlet_gas.n_flow);
  var_P_el = var_P_comp/param_eta_mech;
  port_P_el.P = var_P_el;
  der(var_P_cons) = port_P_el.P;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,80},{92,40}}, color={0,0,0}),
        Line(points={{-60,-80},{92,-40}}, color={0,0,0}),
                                        Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end H2Compressor;
