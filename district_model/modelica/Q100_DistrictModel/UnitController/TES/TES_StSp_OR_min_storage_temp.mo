within Q100_DistrictModel.UnitController.TES;
model TES_StSp_OR_min_storage_temp
  Modelica.Blocks.Interfaces.RealInput T_TES_unload annotation (Placement(
        transformation(extent={{-128,60},{-100,88}}),iconTransformation(extent={{-128,60},
            {-100,88}})));
  Modelica.Blocks.Interfaces.RealInput T_DH_RF annotation (Placement(
        transformation(extent={{-128,10},{-100,38}}),iconTransformation(extent={{-128,10},
            {-100,38}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_load annotation (Placement(
        transformation(extent={{-128,-44},{-100,-16}}),iconTransformation(
          extent={{-128,-44},{-100,-16}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_max_set annotation (Placement(
        transformation(extent={{-132,-90},{-100,-58}}),iconTransformation(
          extent={{-132,-90},{-100,-58}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Interfaces.BooleanOutput TES_OS_load
    "True wenn load (OS1) erfüllt"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.BooleanOutput TES_OS_unload
    "True wenn unload (OS2) erfüllt"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-34,22},{-22,34}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-60,42},{-48,54}})));
  Components.Hysteresis_var hysteresis_var annotation (Placement(transformation(extent={{42,40},{62,60}})));
equation
  connect(T_TES_load, less.u1) annotation (Line(points={{-114,-30},{-28,-30},{
          -28,-50},{-22,-50}}, color={0,0,127}));
  connect(T_TES_max_set, less.u2) annotation (Line(points={{-116,-74},{-28,-74},
          {-28,-58},{-22,-58}}, color={0,0,127}));
  connect(less.y, TES_OS_load)
    annotation (Line(points={{1,-50},{110,-50}}, color={255,0,255}));
  connect(const.y, add.u1) annotation (Line(points={{-47.4,48},{-40,48},{-40,32},
          {-36,32},{-36,31.6},{-35.2,31.6}}, color={0,0,127}));
  connect(T_DH_RF, add.u2) annotation (Line(points={{-114,24},{-34,24},{-34,
          24.4},{-35.2,24.4}}, color={0,0,127}));
  connect(T_TES_unload, hysteresis_var.u) annotation (Line(points={{-114,74},{
          34,74},{34,50},{40,50}}, color={0,0,127}));
  connect(T_DH_RF, hysteresis_var.uLow) annotation (Line(points={{-114,24},{-40,
          24},{-40,18},{34,18},{34,42},{40,42}}, color={0,0,127}));
  connect(add.y, hysteresis_var.uHigh) annotation (Line(points={{-21.4,28},{0,
          28},{0,58},{40,58}}, color={0,0,127}));
  connect(TES_OS_unload, TES_OS_unload)
    annotation (Line(points={{110,50},{110,50}}, color={255,0,255}));
  connect(hysteresis_var.y, TES_OS_unload)
    annotation (Line(points={{63,50},{110,50}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TES_StSp_OR_min_storage_temp;
