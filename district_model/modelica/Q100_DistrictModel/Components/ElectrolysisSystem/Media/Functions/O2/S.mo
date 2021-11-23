within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Functions.O2;
function S "temperature dependent molar entropy of oxygen"

  //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782447&Mask=1
  input SI.Temperature T;
  output SI.MolarEntropy ent;

  // coefficient for range 100-700K
protected
  Real A= 31.32234;
  Real B= -20.23531;
  Real C= 57.86644;
  Real D= -36.50624;
  Real E= -0.007374;
  Real G= 246.7945;

  Real t= min(max(T,100),700)/1000;
algorithm
  ent :=A*log(t)+B*t+C*t^2/2+D*t^3/3-E/(2*t^2)+G;
end S;
