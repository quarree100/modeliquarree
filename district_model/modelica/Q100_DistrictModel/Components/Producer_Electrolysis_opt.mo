within Q100_DistrictModel.Components;
model Producer_Electrolysis_opt "Electrolysis with pump and simple and optimized control"
  extends Modelica.Icons.Package;
  AixLib.FastHVAC.Components.HeatGenerators.CHP.CHP_PT1 Elektrolyseur(capP_el = 300000, eta_el = 1.67, eta_th = 0.28, selectable = false)  annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation (
    Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -106}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation (
    Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput u_control_signal annotation (
    Placement(visible = true, transformation(origin = {-60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-46, 112}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.Blocks.Math.RealToBoolean realToBoolean annotation (
    Placement(visible = true, transformation(origin = {-20, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(Elektrolyseur.enthalpyPort_b, enthalpyPort_b) annotation (
    Line(points = {{10, 0}, {40, 0}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
connect(Elektrolyseur.enthalpyPort_a, enthalpyPort_a) annotation (
    Line(points = {{-10, 0}, {-40, 0}, {-40, -80}, {0, -80}, {0, -110}}, color = {176, 0, 0}));
connect(u_control_signal, Elektrolyseur.P_elRel) annotation (
    Line(points = {{-60, 120}, {-60, 68}, {4, 68}, {4, 10}, {6, 10}}, color = {0, 0, 127}));
connect(realToBoolean.y, Elektrolyseur.onOff) annotation (
    Line(points = {{-20, 40}, {-20, 30}, {-4, 30}, {-4, 10}}, color = {255, 0, 255}));
connect(realToBoolean.u, u_control_signal) annotation (
    Line(points = {{-20, 62}, {-20, 68}, {-60, 68}, {-60, 120}}, color = {0, 0, 127}));
  annotation (
    Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system.
  
    <p>
    Parameter:
    <p>
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump
  
  
    </html>"),
    Diagram,
    Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
end Producer_Electrolysis_opt;
