within Q100_DistrictModel.UnitController.TES;
model TES_StSp_OR_heat_demand
  Modelica.Blocks.Interfaces.RealInput P_th_DH_supply
    annotation (Placement(transformation(extent={{-140,28},{-100,68}})));
  Modelica.Blocks.Interfaces.RealInput P_th_DH_demand
    annotation (Placement(transformation(extent={{-140,-68},{-100,-28}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput TES_StSp_OR_heat_demand_SI
    "True, wenn demand supply übersteigt, sonst False"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(P_th_DH_supply, less.u1) annotation (Line(points={{-120,48},{-16,48},
          {-16,0},{-10,0}}, color={0,0,127}));
  connect(P_th_DH_demand, less.u2) annotation (Line(points={{-120,-48},{-16,-48},
          {-16,-8},{-10,-8}}, color={0,0,127}));
  connect(less.y, TES_StSp_OR_heat_demand_SI)
    annotation (Line(points={{13,0},{110,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TES_StSp_OR_heat_demand;
