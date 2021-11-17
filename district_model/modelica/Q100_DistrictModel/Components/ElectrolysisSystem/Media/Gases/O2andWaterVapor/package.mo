within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Gases;
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
