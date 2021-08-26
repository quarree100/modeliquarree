within Q100_DistrictModel.ElectrolysisSystem;
package Units "custom units not covered by Modelica.SIunits"
extends Modelica.Icons.Package;

  type MolarFlowRateDensity = Real (final quantity="Molar Flow Rate Density",
        final unit="mol.s-1.m-2") "moles per second and square meter";

  type ResistanceArea = Real (final quantity="Resistance Times Area", final
        unit="Ohm.m2") "resistance times area, ohm*m²";

  type PermeabilityCoefficient = Real (final quantity="Molar Flow Rate Density",
        final unit="mol.m-1.s-1.Pa-1")
    "moles per meter, second, and Pascal [mol/(m.s.Pa)]";

  type CombinedDiffHydrThickFactor = Real (final quantity="Factor", final unit="Pa.m2.A-1")
    "factor combining diffusion coefficient, hydraulic conductivity and membrane thickness [Pa.m2.A-1]";

  type MembraneHumidity = Real (
      final quantity="Membrane Humidity",
      final unit="1",
      min=7,
      max=25) "humidity of membrane 7-25";

  type Fraction = Real (
      final quantity="Fraction",
      final unit="1",
      min=0,
      max=1) "Type For Fraction";

  type UniversalGasConstant = Real (final quantity="Universal Gas Constant",
        final unit="J.mol-1.K-1") "universal gas constant";

  type MolarFraction = Real (
      final quantity="MolarFraction",
      final unit="1",
      min=0,
      max=1);

  type VolumetricEnergy =Real (
      final quantity="VolumetricEnergy",
      final unit="kW.h.m-3",
      min=0);

  type MolePerJoule =Real (
      final quantity="MolePerJoule",
      final unit="mol.J-1",
      min=0);
end Units;
