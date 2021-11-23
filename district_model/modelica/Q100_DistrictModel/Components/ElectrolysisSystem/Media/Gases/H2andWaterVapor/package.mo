within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Gases;
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
