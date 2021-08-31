within Q100_DistrictModel.ElectrolysisSystem.Tools.Components;
model GasConverter "Convert gas properties to individual outputs"
  replaceable package Gas = Modelica.Media.Interfaces.PartialMedium
      "gas model, e.g. Media.Gases.H2andWaterVapor" annotation (choicesAllMatching=true);
  Connectors.GasConnector gasConnector(redeclare package Gas = Gas) annotation (Placement(transformation(
          extent={{-100,-20},{-80,0}}),  iconTransformation(extent={{-100,-20},{
            -60,20}})));
  Modelica.Blocks.Interfaces.RealOutput Mdot(final quantity = "Massflow", final unit = "kg/h", displayUnit = "kg/h", min = 0) "Massflow of gas [kg/h]" annotation (
    Placement(transformation(extent={{80,70},{100,90}}),      iconTransformation(extent={{80,70},
            {100,90}})));
  Modelica.Blocks.Interfaces.RealOutput Vdot(final quantity = "Volume flow", final unit = "m3/h", displayUnit = "m3/h", min = 0) "Volume flow of gas [m³/h]" annotation (Placement(transformation(
          extent={{80,30},{100,50}}), iconTransformation(extent={{80,30},{100,50}})));
  Modelica.Blocks.Interfaces.RealOutput Vdot_norm(final quantity="Volume flow", final unit="m3/h", displayUnit="m3/h", min=0) "'Normal' volume flow of gas [Nm³/h]" annotation (Placement(transformation(
          extent={{80,-10},{100,10}}),iconTransformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Interfaces.RealOutput p(final quantity = "Pressure", final unit = "Pa", displayUnit = "Pa", min = 0) "Pressure of gas [Pa]" annotation (Placement(transformation(
          extent={{80,-50},{100,-30}}),
                                      iconTransformation(extent={{80,-50},{100,-30}})));
  Modelica.Blocks.Interfaces.RealOutput T(final quantity = "Temperature", final unit = "K", displayUnit = "K", min = 0) "Temperature of gas [K]" annotation (Placement(transformation(
          extent={{80,-90},{100,-70}}), iconTransformation(extent={{80,-90},{100,
            -70}})));
  Modelica.SIunits.AbsolutePressure p_norm = 101325 "Normal pressure [Pa]";
  Modelica.SIunits.TemperatureDifference T_norm = 273.15 "Normal temperature [K]";
  Modelica.SIunits.MolarMass M_molar;
  Modelica.SIunits.TemperatureDifference T_calc;
  Gas.ThermodynamicState state;
equation
  state = gasConnector.Gas.setState_phX(gasConnector.p, gasConnector.h, gasConnector.X);
  M_molar = gasConnector.Gas.molarMass(state);
  Mdot = M_molar * gasConnector.n_flow * 3600; // Convert from kg/s to kg/h
  T_calc = gasConnector.Gas.temperature_phX(gasConnector.p, gasConnector.h, gasConnector.X);
  // R = 8.3144598 J/(mol.K) in p*V=n*R*T, with [p] = Pa, [V] = m3, T] = K, [n] = mol
  Vdot = (gasConnector.n_flow * Modelica.Constants.R * T_calc / gasConnector.p) * 3600;  // Convert from m3/s to m3/h
  Vdot_norm = Vdot * (p/p_norm) * (T_norm/T);
  p = gasConnector.p;
  T = T_calc;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-80,0},{80,-40}}, color={0,0,0}),
        Line(points={{-80,0},{80,80}}, color={0,0,0}),
        Line(points={{-80,0},{80,40}}, color={0,0,0}),
        Line(points={{-80,0},{80,-80}}, color={0,0,0}),
        Line(points={{-80,0},{80,0}}, color={0,0,0})}),          Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GasConverter;
