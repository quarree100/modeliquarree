within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Functions.O2;
function cp "specific heat capacity based on shomate equation"

  //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782447&Mask=1
  input SI.Temperature T;
  output SI.SpecificHeatCapacityAtConstantPressure shc;

  // coefficient for range 100-700K
protected
  Real A= 31.32234;
  Real B= -20.23531;
  Real C= 57.86644;
  Real D= -36.50624;
  Real E= -0.007374;

  Real t= T/1000;

algorithm

  shc:= A + B*t + C*t^2 + D*t^3 + E/t^2;

end cp;
