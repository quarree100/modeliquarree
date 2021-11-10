within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Gases;
model H2WithWater "gas mixture model for H2 with water vapor fraction"
  extends GasWithWater(redeclare package Gas = H2andWaterVapor, X=
        H2andWaterVapor.reference_X) annotation (Icon(coordinateSystem(
          preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end H2WithWater;
