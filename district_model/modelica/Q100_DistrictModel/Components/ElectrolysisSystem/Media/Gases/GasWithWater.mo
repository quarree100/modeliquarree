within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Gases;
partial model GasWithWater "base class for gas with water"

  replaceable package Gas =
      Modelica.Media.Interfaces.PartialMixtureMedium;

  parameter Gas.MassFraction X[Gas.nX];
  Gas.ThermodynamicState state;
  Gas.SpecificEnthalpy h;
  Gas.Density d;
  Gas.SpecificHeatCapacity cp;

  SI.AbsolutePressure p=1e5;
  SI.Temperature T=298.15;

equation
  state = Gas.setState_pTX(p, T, X);
  h = Gas.specificEnthalpy(state);
  d = Gas.density(state);
  cp = Gas.specificHeatCapacityCp(state)
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end GasWithWater;
