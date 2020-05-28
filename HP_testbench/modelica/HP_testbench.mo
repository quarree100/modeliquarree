within ;
package HP_testbench "Evaluate heat pump performance with weather data"

  model HeatPump_weather "Heat Pump properties from weather data"

    extends Modelica.Icons.Example;
    AixLib.FastHVAC.Components.Sinks.Vessel vessel_co
      annotation (Placement(transformation(extent={{72,-92},{94,-74}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{30,-92},{48,-74}})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource(medium=
          AixLib.FastHVAC.Media.WaterSimple())
      annotation (Placement(transformation(extent={{-50,-84},{-30,-64}})));

    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource1 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={40,-34})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel_ev annotation (Placement(
          transformation(
          extent={{-11,-9},{11,9}},
          rotation=180,
          origin={-47,-35})));

    Modelica.Blocks.Sources.BooleanConstant booleanConstant1
      annotation (Placement(transformation(extent={{-94,-34},{-74,-14}})));
    Modelica.Blocks.Sources.Constant dotm_ev2(k=191310/3600)
      annotation (Placement(transformation(extent={{-96,-92},{-76,-72}})));
    Modelica.Blocks.Sources.Constant dotm_co2(k=76000/3600)
                                                     annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={86,-22})));
    Modelica.Blocks.Sources.Constant T_cond_in(k=75 + 273.15)
      annotation (Placement(transformation(extent={{96,-62},{76,-42}})));
    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
    "C:/Users/Nettelstroth/code_projects/quarree100/modeliquarree/HP_testbench/modelica/TRY2015_541957091051_Jahr.mos")
      annotation (Placement(transformation(extent={{-96,56},{-76,76}})));
    AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-74,-2},{-34,38}}),  iconTransformation(
            extent={{-110,-10},{-90,10}})));
    AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump(
      refIneFre_constant=1,
      Medium_con=AixLib.FastHVAC.Media.WaterSimple(),
      Medium_eva=AixLib.FastHVAC.Media.WaterSimple(),
      mFlow_conNominal=0.5,
      VCon=0.4,
      deltaM_con=0.1,
      use_ConCap=false,
      CCon=100,
      GCon=5,
      GConIns=0,
      mFlow_evaNominal=0.5,
      VEva=0.04,
      deltaM_eva=0.1,
      use_EvaCap=false,
      CEva=100,
      GEva=5,
      GEvaIns=0,
      allowFlowReversalEva=true,
      use_revHP=true,
      TCon_start(displayUnit="K"),
      TEva_start(displayUnit="K"),
      redeclare model PerDataHea =
          AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D
          (dataTable=AixLib.DataBase.ThermalMachines.HeatPump.EN14511.Vitocal200AWO201()),
      redeclare model PerDataChi =
          AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D
          (dataTable=AixLib.DataBase.ThermalMachines.HeatPump.EN14511.Vitocal200AWO201()),
      Q_useNominal=0,
      use_autoCalc=false,
      TAmbCon_nominal=288.15) annotation (Placement(transformation(
          extent={{-10,-13},{10,13}},
          rotation=270,
          origin={-2,-51})));
    Modelica.Blocks.Sources.Constant iceFac(final k=1)
      "Fixed value for icing factor"                   annotation (Placement(
          transformation(
          extent={{5,5},{-5,-5}},
          rotation=180,
          origin={-47,-51})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal "on off control "
      annotation (Placement(transformation(extent={{4,4},{-4,-4}},
          rotation=180,
          origin={-2,-24})));
    Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
      "Constant internal ambient temeprature"
      annotation (Placement(transformation(extent={{7,-7},{-7,7}},
          rotation=-90,
          origin={-1,-87})));
  equation
    connect(temperatureSensor.enthalpyPort_b,vessel_co. enthalpyPort_a)
      annotation (Line(
        points={{47.1,-83.09},{67.55,-83.09},{67.55,-83},{75.3,-83}},
        color={176,0,0},
        smooth=Smooth.None));
    connect(dotm_ev2.y, fluidSource.dotm) annotation (Line(
        points={{-75,-82},{-66,-82},{-66,-76.6},{-48,-76.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(dotm_co2.y, fluidSource1.dotm) annotation (Line(
        points={{75,-22},{66,-22},{66,-31.4},{48,-31.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(T_cond_in.y, fluidSource1.T_fluid) annotation (Line(points={{75,-52},{
            74,-52},{74,-38.2},{48,-38.2}},  color={0,0,127}));
    connect(weaDat.weaBus, weaBus) annotation (Line(
        points={{-76,66},{-50,66},{-50,18},{-54,18}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(weaBus.TDryBul, fluidSource.T_fluid) annotation (Line(
        points={{-54,18},{-66,18},{-66,-56},{-58,-56},{-58,-69.8},{-48,-69.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(fluidSource.enthalpyPort_b, heatPump.enthalpyPort_a1) annotation (
        Line(points={{-30,-73},{-22,-73},{-22,-61},{-8.5,-61}}, color={176,0,0}));
    connect(fluidSource1.enthalpyPort_b, heatPump.enthalpyPort_a) annotation (
        Line(points={{30,-35},{16,-35},{16,-41},{4.5,-41}}, color={176,0,0}));
    connect(heatPump.enthalpyPort_b1, vessel_ev.enthalpyPort_a) annotation (Line(
          points={{-8.5,-41},{-23.25,-41},{-23.25,-35},{-39.3,-35}}, color={176,0,
            0}));
    connect(heatPump.enthalpyPort_b, temperatureSensor.enthalpyPort_a)
      annotation (Line(points={{4.5,-61},{21.25,-61},{21.25,-83.09},{31.08,-83.09}},
          color={176,0,0}));
    connect(booleanConstant1.y, heatPump.modeSet) annotation (Line(points={{-73,-24},
            {-12,-24},{-12,-39.4},{-3.95,-39.4}}, color={255,0,255}));
    connect(iceFac.y, heatPump.iceFac_in) annotation (Line(points={{-41.5,-51},
            {-34.75,-51},{-34.75,-43.4},{-16.7333,-43.4}},
                                                   color={0,0,127}));
    connect(booleanToReal.y, heatPump.nSet) annotation (Line(points={{2.4,-24},{6,
            -24},{6,-39.4},{0.166667,-39.4}}, color={0,0,127}));
    connect(booleanConstant1.y, booleanToReal.u)
      annotation (Line(points={{-73,-24},{-6.8,-24}}, color={255,0,255}));
    connect(T_amb_internal.y, heatPump.T_amb_eva) annotation (Line(points={{-1,
            -79.3},{-1,-71.65},{-12.8333,-71.65},{-12.8333,-62}},
                                                           color={0,0,127}));
    connect(T_amb_internal.y, heatPump.T_amb_con) annotation (Line(points={{-1,-79.3},
            {-1,-70.65},{8.83333,-70.65},{8.83333,-62}}, color={0,0,127}));
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
      experiment(StopTime=31536000, Interval=900),
      __Dymola_experimentSetupOutput,
      Documentation(revisions="<html>
<ul>
<li><i>May 27, 2020</i> Joris Zimmermann:<br>Update to AixLib 0.9.1</li>
<li><i>Dezember 3, 2019</i> Joris Zimmermann:<br>Add weather data input</li>
<li><i>November 28, 2016&nbsp;</i> Tobias Blacha:<br>Moved into AixLib </li>
</ul>
</html>",   info="<html>
<p>This model is based on &quot;AixLib.FastHVAC.Examples.HeatGenerators.HeatPump.ValidationHeatPump&quot;.</p>
<p>Its purpose is to evaluate the annual performance of an air/water heat pump for a given weather data set.</p>
</html>"),
      __Dymola_Commands(file="plotting.mos" "plotting"));
  end HeatPump_weather;
  annotation (uses(Modelica(version="3.2.3"), AixLib(version="0.9.1")), version=
     "0.2.0");
end HP_testbench;
