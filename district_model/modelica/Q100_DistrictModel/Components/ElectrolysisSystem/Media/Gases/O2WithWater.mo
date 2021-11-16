within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Gases;
model O2WithWater "gas mixture model for O2 with water vapor fraction"
  extends GasWithWater(redeclare package Gas = O2andWaterVapor, X=
        O2andWaterVapor.reference_X) annotation (Icon(coordinateSystem(
          preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end O2WithWater;
