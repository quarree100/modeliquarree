within Q100_DistrictModel.Components;
model Calc_Dynamic_Heatload_Scalefactor_TEST "Scales the heat load depending on the heating grid and ambient temperature"
  Modelica.Blocks.Interfaces.RealOutput Qdot_heatload_scalefactor annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput T_amb annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={50,-120})));
  Modelica.Blocks.Interfaces.RealInput T_heatgrid_FF annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-120})));
  parameter Real T_high=60;
  parameter Real T_low_limit=10;
  parameter Real T_low(start=10);
  parameter Real scalefactor;

equation
  T_low = if T_amb > T_low_limit then T_amb else T_low_limit;
  scalefactor=if T_heatgrid_FF> T_high then 1 else (T_heatgrid_FF - T_low)/(T_high - T_low);
algorithm
   when {T_heatgrid_FF>T_low, T_heatgrid_FF<T_high} then
     Qdot_heatload_scalefactor :=scalefactor;
   elsewhen T_heatgrid_FF<T_low then
     Qdot_heatload_scalefactor :=0;
   end when;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Calc_Dynamic_Heatload_Scalefactor_TEST;
