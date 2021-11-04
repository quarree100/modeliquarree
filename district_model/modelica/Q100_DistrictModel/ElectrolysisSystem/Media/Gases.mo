within Q100_DistrictModel.ElectrolysisSystem.Media;
package Gases
              extends Modelica.Icons.Package;

  package H2andWaterVapor "H2 with fraction of H2O vapor"
    extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
      mediumName="H2WithWaterFraction",
      data={Modelica.Media.IdealGases.Common.SingleGasesData.H2,
     Modelica.Media.IdealGases.Common.SingleGasesData.H2O},
      fluidConstants={Modelica.Media.IdealGases.Common.FluidData.H2,
        Modelica.Media.IdealGases.Common.FluidData.H2O},
      substanceNames = {"Hydrogen", "H2O"},
      reference_X={0.95,0.05});
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end H2andWaterVapor;

  package O2andWaterVapor "O2 with fraction of H2O vapor"
    extends Modelica.Media.IdealGases.Common.MixtureGasNasa(
      mediumName="O2WithWaterFraction",
      data={Modelica.Media.IdealGases.Common.SingleGasesData.O2,
     Modelica.Media.IdealGases.Common.SingleGasesData.H2O},
      fluidConstants={Modelica.Media.IdealGases.Common.FluidData.O2,
        Modelica.Media.IdealGases.Common.FluidData.H2O},
      substanceNames = {"Oxygen", "H2O"},
      reference_X={0.95,0.05});
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end O2andWaterVapor;

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

  model H2WithWater "gas mixture model for H2 with water vapor fraction"
    extends GasWithWater(redeclare package Gas = H2andWaterVapor, X=
          H2andWaterVapor.reference_X) annotation (Icon(coordinateSystem(
            preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end H2WithWater;

  model O2WithWater "gas mixture model for O2 with water vapor fraction"
    extends GasWithWater(redeclare package Gas = O2andWaterVapor, X=
          O2andWaterVapor.reference_X) annotation (Icon(coordinateSystem(
            preserveAspectRatio=false)), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end O2WithWater;
end Gases;
