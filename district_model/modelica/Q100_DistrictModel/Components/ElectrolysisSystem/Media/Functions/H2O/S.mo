within Q100_DistrictModel.Components.ElectrolysisSystem.Media.Functions.H2O;
function S "temperature dependent molar entropy of water"

  //https://webbook.nist.gov/cgi/cbook.cgi?ID=C7732185&Type=JANAFL&Plot=on
  input SI.Temperature T;
  output SI.MolarEntropy ent;

  // coefficient for range 298-500K
protected
  Real A= -203.6060;
  Real B= 1523.290;
  Real C= -3196.413;
  Real D= 2474.455;
  Real E= 3.855326;
  Real G= -488.7163;

  Real t= min(max(T,298),500)/1000;
algorithm
  ent :=A*log(t)+B*t+C*t^2/2+D*t^3/3-E/(2*t^2)+G;
end S;
