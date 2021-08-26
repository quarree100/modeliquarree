within Q100_DistrictModel.ElectrolysisSystem.Tools.Connectors;
connector GasConnector
  "Connector without flow/stream variables, so decoupled pressure/nflow"

  replaceable package Gas = Modelica.Media.Interfaces.PartialMedium
      "gas model" annotation (choicesAllMatching=true);

  Gas.AbsolutePressure p "pressure of gas";
  SI.MolarFlowRate n_flow "molar flow rate of gas";
  Gas.SpecificEnthalpy h "specific enthalpy flow rate of gas";
  Units.MolarFraction X[Gas.nXi]
    "mass fractions of gas";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,46},{22,-54}},
          lineColor={0,0,0},
          textString="n"),
        Text(
          extent={{-22,102},{22,2}},
          lineColor={0,0,0},
          textString=".")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GasConnector;
