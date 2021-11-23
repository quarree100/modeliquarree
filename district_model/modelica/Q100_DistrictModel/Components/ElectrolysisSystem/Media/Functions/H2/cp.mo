within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Functions.H2;
function cp "specific heat capacity based on shomate equation"

  //https://webbook.nist.gov/cgi/cbook.cgi?ID=C1333740&Mask=1&Type=JANAFG&Plot=on
  input SI.Temperature T;
  output SI.SpecificHeatCapacityAtConstantPressure shc;

  // coefficient for range 298-1000K
protected
  Real A= 33.066178;
  Real B= -11.363417;
  Real C= 11.432816;
  Real D= -2.772874;
  Real E= -0.158558;

  Real t= T/1000;

algorithm

  shc:= A + B*t + C*t^2 + D*t^3 + E/t^2;

end cp;
