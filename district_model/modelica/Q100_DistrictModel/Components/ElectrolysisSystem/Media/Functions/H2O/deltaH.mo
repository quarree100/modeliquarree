within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Functions.H2O;
function deltaH "temperature dependent molar enthalpy of water"

  //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Type=JANAFL&Plot=on
  input SI.Temperature T;
  output SI.MolarEnthalpy ent;

  // coefficient for range 298-500K
protected
  Real A= -203.6060;
  Real B= 1523.290;
  Real C= -3196.413;
  Real D= 2474.455;
  Real E= 3.855326;
  Real F= -256.5478;
  Real G= -488.7163;
  Real H= -285.8304;

  Real t= T/1000;
  Real H0 = -285.830;
algorithm

  ent := (H0 + A*t + B*t^2/2 + C*t^3/3 + D*t^4/4 - E/t + F - H)*1000;

end deltaH;
