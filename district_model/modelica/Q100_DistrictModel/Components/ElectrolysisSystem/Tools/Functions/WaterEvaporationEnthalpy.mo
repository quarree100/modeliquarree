within Q100_DistrictModel.Components.ElectrolysisSystem.Tools.Functions;
function WaterEvaporationEnthalpy
  "calculates the evaporation enthalpy based on VDI-Waermeatlas Eq. 46b in J/mol"
  input SI.Temperature T "temperature in K";
  output SI.MolarEnthalpy delta_hv
    "evaporation enthalpy of water";

protected
  final parameter Real A=6.85307;
  final parameter Real B=7.43804;
  final parameter Real C=-2.937595;
  final parameter Real D=-3.282093;
  final parameter Real E=8.397378;
  final parameter SI.Temperature T_c=647;
  final parameter Real R =  Const.R;
  Real tao=max(1-T/T_c,0);

algorithm
 // assert(T<T_c, "setting delta_hv=0 because temperature is higher than triple point temperature: " + String(T) + " K", AssertionLevel.warning);

  if T>=T_c then
      delta_hv := 0;
  else
      delta_hv :=Const.R*T_c*(A*tao^(1/3)+B*tao^(2/3)+C*tao+D*tao^2+E*tao^6);
  end if;

end WaterEvaporationEnthalpy;
