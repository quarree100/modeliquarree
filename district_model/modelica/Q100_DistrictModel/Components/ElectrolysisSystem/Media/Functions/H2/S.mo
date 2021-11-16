within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Functions.H2;
function S "temperature dependent molar entropy of hydrogen"

  //https://webbook.nist.gov/cgi/cbook.cgi?ID=C1333740&Mask=1&Type=JANAFG&Plot=on
  input SI.Temperature T;
  output SI.MolarEntropy ent;

  // coefficient for range 298-1000K
protected
   Real A= 33.066178;
  Real B= -11.363417;
  Real C= 11.432816;
  Real D= -2.772874;
  Real E= -0.158558;
  Real G= 172.707974;

  Real t= min(max(T,298),1000)/1000;
algorithm
  ent :=A*log(t)+B*t+C*t^2/2+D*t^3/3-E/(2*t^2)+G;
end S;
