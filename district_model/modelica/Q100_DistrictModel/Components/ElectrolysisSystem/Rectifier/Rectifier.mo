within Q100_DistrictModel.Components.ElectrolysisSystem.Rectifier;
model Rectifier "rectifier for input power"
  //parameter SI.Power ratedPower = 1e6 "rated power of electrolyser [W]";

  parameter SI.Power param_P_rated=100e3
    "rated power output of rectifier [W]";

  SI.Energy var_P_cons(start=0.0, fixed=true)
    "integrated power consumption";
  Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
    "integrated power consumption in kWh";

  SI.Power var_P_loss "power loss of rectifier [W]";
  SI.Efficiency var_eta "current efficiency of rectifier";
  Tools.Connectors.PowerConnector port_P_el_in "power input connector" annotation (Placement(
        transformation(extent={{-120,-20},{-100,0}}), iconTransformation(extent={{-120,-20},{-80,
            20}})));
  Tools.Connectors.PowerConnector port_P_el_out(P(start=0, fixed=false))
    "power output connector" annotation (Placement(transformation(extent={{80,-20},{100,0}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds table_efficiency(
    tableOnFile=true,
    tableName="recEff",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Q100_DistrictModel/Components/ElectrolysisSystem/Resources/parameter/rectifierEfficiency.txt"),
    columns=2:2,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
                 "table wirth rectifier efficiency depending on load"
    annotation (Placement(transformation(extent={{-86,60},{-66,80}})));

equation

  //interpolation data
  table_efficiency.u = port_P_el_out.P/param_P_rated;
  var_eta=table_efficiency.y[1];

  port_P_el_in.P*var_eta = port_P_el_out.P;
  var_P_loss =port_P_el_in.P - port_P_el_out.P;

  assert(
    port_P_el_out.P >= -Const.eps,
    "power output of rectifier is <0",
    AssertionLevel.warning);
  assert(
    port_P_el_in.P >= -Const.eps,
    "power input of rectifier is <0",
    AssertionLevel.warning);

  der(var_P_cons) = port_P_el_in.P;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,30},{30,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None),
        Line(points={{-26,-28}}, color={0,0,0}),
        Line(points={{-90,0},{-82,0}}, color={0,0,0}),
        Line(points={{30,0},{90,0}}, color={0,0,0}),
        Line(points={{-30,-30},{30,30}},color={0,0,0}),
        Text(
          extent={{-22,38},{0,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="~"),
        Text(
          extent={{0,12},{24,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="="),
        Line(points={{-90,0},{-30,0}},color={0,0,0}),
                                        Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Rectifier;
