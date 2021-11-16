within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Functions.H2O;
function cp "specific heat capacity based on shomate equation"

  //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Type=JANAFL&Plot=on
  input SI.Temperature T;
  output SI.SpecificHeatCapacityAtConstantPressure shc;

  // coefficient for range 298-500K
protected
  Real A= -203.6060;
  Real B= 1523.290;
  Real C= -3196.413;
  Real D= 2474.455;
  Real E= 3.855326;

  Real t= T/1000;

algorithm

  shc:= A + B*t + C*t^2 + D*t^3 + E/t^2;

end cp;
