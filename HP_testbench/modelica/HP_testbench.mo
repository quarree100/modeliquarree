within ;
package HP_testbench "Evaluate heat pump performance with weather data"

  model HeatPump_weather "Heat Pump properties from weather data"

    extends Modelica.Icons.Example;
    AixLib.FastHVAC.Components.Sinks.Vessel vessel_co
      annotation (Placement(transformation(extent={{64,-40},{86,-22}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{32,-40},{50,-22}})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource(medium=
          AixLib.FastHVAC.Media.WaterSimple())
      annotation (Placement(transformation(extent={{-56,-70},{-36,-50}})));
    AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump1(
      
      CoP_output=true,
      Pel_ouput=true,
      T_maxCo=355.15,
      cap_calcType=2,
      corrFlowCo=true,
      corrFlowEv=true,
      cycle(P_eleTable(fileName="false",
                       tableName="false"),
            Qdot_ConTable(fileName="false",
                          tableName="false")),
      medium_co=AixLib.FastHVAC.Media.WaterSimple(),
      medium_ev=AixLib.FastHVAC.Media.WaterSimple(),
      volume_co=1,volume_ev=1)
      annotation (Placement(transformation(extent={{-10,-78},{20,-58}})));

    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource1 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,-78})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel_ev annotation (Placement(
          transformation(
          extent={{-11,-9},{11,9}},
          rotation=180,
          origin={-43,-93})));

    Modelica.Blocks.Sources.BooleanConstant booleanConstant1
      annotation (Placement(transformation(extent={{-98,-34},{-78,-14}})));
    Modelica.Blocks.Sources.Constant dotm_ev2(k=191310/3600)
      annotation (Placement(transformation(extent={{-98,-96},{-78,-76}})));
    Modelica.Blocks.Sources.Constant dotm_co2(k=76000/3600)
                                                     annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={86,-54})));
    Modelica.Blocks.Sources.Constant T_cond_in(k=75 + 273.15)
      annotation (Placement(transformation(extent={{96,-94},{76,-74}})));
    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
          "C:/Users/nettelstroth/code_projects/quarree100/modeliquarree/HP_test/Result/TRY2015_541957091051_Jahr.mos")
      annotation (Placement(transformation(extent={{-96,56},{-76,76}})));
    AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-76,0},{-36,40}}),   iconTransformation(
            extent={{-110,-10},{-90,10}})));
  equation
    connect(temperatureSensor.enthalpyPort_b,vessel_co. enthalpyPort_a)
      annotation (Line(
        points={{49.1,-31.09},{67.55,-31.09},{67.55,-31},{67.3,-31}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(vessel_ev.enthalpyPort_a,heatPump1. enthalpyPort_outEv)
      annotation (Line(
        points={{-35.3,-93},{-7.4,-93},{-7.4,-76.2}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(fluidSource.enthalpyPort_b,heatPump1. enthalpyPort_inEv)
      annotation (Line(
        points={{-36,-59},{-7,-59},{-7,-59.8},{-7.4,-59.8}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(heatPump1.enthalpyPort_outCo,temperatureSensor. enthalpyPort_a)
      annotation (Line(
        points={{17.2,-59.6},{17.2,-31.09},{33.08,-31.09}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(heatPump1.enthalpyPort_inCo,fluidSource1. enthalpyPort_b)
      annotation (Line(
        points={{17.6,-76.2},{17.6,-79},{30,-79}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(dotm_ev2.y, fluidSource.dotm) annotation (Line(
        points={{-77,-86},{-66,-86},{-66,-62.6},{-54,-62.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(booleanConstant1.y,heatPump1. onOff_in) annotation (Line(
        points={{-77,-24},{0,-24},{0,-59}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(dotm_co2.y, fluidSource1.dotm) annotation (Line(
        points={{75,-54},{66,-54},{66,-75.4},{48,-75.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(T_cond_in.y, fluidSource1.T_fluid) annotation (Line(points={{75,-84},
            {74,-84},{74,-82.2},{48,-82.2}}, color={0,0,127}));
    connect(weaDat.weaBus, weaBus) annotation (Line(
        points={{-76,66},{-50,66},{-50,20},{-56,20}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(weaBus.TDryBul, fluidSource.T_fluid) annotation (Line(
        points={{-56,20},{-62,20},{-62,-56},{-58,-56},{-58,-55.8},{-54,-55.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics={
          Rectangle(
            extent={{-100,-2},{100,-100}},
            lineColor={215,215,215},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-24,-2},{24,-16}},
            lineColor={0,0,255},
            fillColor={213,170,255},
            fillPattern=FillPattern.Solid,
            textString="FastHVAC")}),
      experiment(StopTime=72000, Interval=60),
      __Dymola_experimentSetupOutput,
      Documentation(revisions="<html>
<ul>
<li><i>Dezember 3, 2019</i> Joris Nettelstroth:<br>Add weather data input</li>
<li><i>November 28, 2016&nbsp;</i> Tobias Blacha:<br>Moved into AixLib </li>
</ul>
</html>",   info="<html>
<p>This model is based on &quot;AixLib.FastHVAC.Examples.HeatGenerators.HeatPump.ValidationHeatPump&quot;.</p>
<p>Its purpose is to evaluate the annual performance of an air/water heat pump for a given weather data set.</p>
</html>"),
      __Dymola_Commands(file="plotting.mos" "plotting"));
  end HeatPump_weather;
  annotation (uses(Modelica(version="3.2.3"), AixLib(version="0.7.3")), version=
     "0.1.0");
end HP_testbench;
