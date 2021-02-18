within ;
package HP_testbench "Evaluate heat pump performance with weather data"

  model HeatPump_weather "Heat Pump properties from weather data"

    extends Modelica.Icons.Example;

    Modelica.Blocks.Sources.BooleanConstant booleanConstant1
      annotation (Placement(transformation(extent={{-26,68},{-6,88}})));
    Modelica.Blocks.Sources.Constant dotm_ev2(k=191310/3600)
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
    Modelica.Blocks.Sources.Constant dotm_co2(k=76000/3600)
                                                     annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={70,0})));
    Modelica.Blocks.Sources.Constant T_cond_in(k=75 + 273.15)
      annotation (Placement(transformation(extent={{80,30},{60,50}})));
    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
    "C:/Users/Nettelstroth/code_projects/quarree100/modeliquarree/HP_testbench/modelica/TRY2015_541957091051_Jahr.mos")
      annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
    AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
          transformation(extent={{-74,10},{-34,50}}),  iconTransformation(
            extent={{-110,-10},{-90,10}})));

    HeatPump_IO heatPump_IO
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(weaDat.weaBus, weaBus) annotation (Line(
        points={{-70,60},{-50,60},{-50,30},{-54,30}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(weaBus.TDryBul, heatPump_IO.T_evap_in) annotation (Line(
        points={{-54,30},{-32,30},{-32,8},{-11.6,8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(booleanConstant1.y, heatPump_IO.Bool_on_off)
      annotation (Line(points={{-5,78},{0,78},{0,11.6}}, color={255,0,255}));
    connect(dotm_co2.y, heatPump_IO.dotM_cond_in) annotation (Line(points={{59,
            8.88178e-16},{44,8.88178e-16},{44,2},{11.6,2}}, color={0,0,127}));
    connect(T_cond_in.y, heatPump_IO.T_cond_in) annotation (Line(points={{59,40},
            {46,40},{46,8},{11.6,8}}, color={0,0,127}));
    connect(dotm_ev2.y, heatPump_IO.dotM_evap_in) annotation (Line(points={{-69,
            0},{-42,0},{-42,2},{-11.6,2}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),
      experiment(StopTime=31536000, Interval=900),
      __Dymola_experimentSetupOutput,
      Documentation(revisions="<html>
<ul>
<li><i>Februar 17, 2021</i> Joris Zimmermann:<br>Update to AixLib 0.10.7</li>
<li><i>Dezember 3, 2019</i> Joris Zimmermann:<br>Add weather data input</li>
<li><i>November 28, 2016&nbsp;</i> Tobias Blacha:<br>Moved into AixLib </li>
</ul>
</html>",   info="<html>
<p>This model is based on &quot;AixLib.FastHVAC.Examples.HeatGenerators.HeatPump.ValidationHeatPump&quot;.</p>
<p>Its purpose is to evaluate the annual performance of an air/water heat pump for a given weather data set.</p>
</html>"),
      __Dymola_Commands(file="plotting.mos" "plotting"));
  end HeatPump_weather;

  model HeatPump_IO "Input-Output model for heatpump"
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_cond
      annotation (Placement(transformation(extent={{32,-40},{50,-22}})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource_evap(medium=
          AixLib.FastHVAC.Media.WaterSimple())
      annotation (Placement(transformation(extent={{-48,-32},{-28,-12}})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource_cond annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={42,18})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel_ev annotation (Placement(
          transformation(
          extent={{-11,-9},{11,9}},
          rotation=180,
          origin={-51,55})));
    AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump(
      CCon=100,
      CEva=100,
      GCon=5,
      GConIns=0,
      GEva=5,
      GEvaIns=0,
      Medium_con=AixLib.FastHVAC.Media.WaterSimple(),
      Medium_eva=AixLib.FastHVAC.Media.WaterSimple(),
      redeclare model PerDataChi =
          AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D
          (dataTable=
              AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
      redeclare model PerDataHea =
          AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D
          (dataTable=
              AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
      Q_useNominal=0,
      TAmbCon_nominal=288.15,
      TCon_start(displayUnit="K"),
      TEva_start(displayUnit="K"),
      VCon=0.4,
      VEva=0.04,
      allowFlowReversalEva=true,
      deltaM_con=0.1,
      deltaM_eva=0.1,
      mFlow_conNominal=0.5,
      mFlow_evaNominal=0.5,
      refIneFre_constant=1,
      transferHeat=true,
      use_ConCap=false,
      use_EvaCap=false,
      use_autoCalc=false,
      use_refIne=true,
      use_revHP=true) annotation (Placement(transformation(
          extent={{-10,-13},{10,13}},
          rotation=270,
          origin={0,1})));
    Modelica.Blocks.Sources.Constant iceFac(final k=1)
      "Fixed value for icing factor"                   annotation (Placement(
          transformation(
          extent={{5,5},{-5,-5}},
          rotation=180,
          origin={-45,1})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal "on off control "
      annotation (Placement(transformation(extent={{4,4},{-4,-4}},
          rotation=180,
          origin={0,28})));
    Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
      "Constant internal ambient temeprature"
      annotation (Placement(transformation(extent={{7,-7},{-7,7}},
          rotation=-90,
          origin={1,-35})));
    Modelica.Blocks.Interfaces.RealInput T_evap_in(unit="K")
      "Input temperature for evaporator in [K]"
      annotation (Placement(transformation(extent={{-132,64},{-100,96}})));
    Modelica.Blocks.Interfaces.RealInput dotM_evap_in(unit="kg/s")
      "Input mass flow for evaporator in [kg/s]"
      annotation (Placement(transformation(extent={{-132,4},{-100,36}})));
    Modelica.Blocks.Interfaces.RealInput T_cond_in(unit="K")
      "Input temperature for condenser in [K]"
      annotation (Placement(transformation(extent={{132,64},{100,96}})));
    Modelica.Blocks.Interfaces.RealInput dotM_cond_in(unit="kg/s")
      "Input mass flow for condenser in [kg/s]"
      annotation (Placement(transformation(extent={{132,4},{100,36}})));
    Modelica.Blocks.Interfaces.BooleanInput Bool_on_off "Boolean input signal"
      annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          rotation=-90,
          origin={0,116})));
    Modelica.Blocks.Interfaces.RealOutput T_cond_out(unit="K")
      "Outlet temperature of condenser in [K]"
      annotation (Placement(transformation(extent={{100,-36},{132,-4}})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel_co
      annotation (Placement(transformation(extent={{68,-40},{90,-22}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor_evap
      annotation (Placement(transformation(extent={{-54,22},{-36,40}})));
    Modelica.Blocks.Interfaces.RealOutput T_evap_out(unit="K")
      "Outlet temperature of condenser in [K]"
      annotation (Placement(transformation(extent={{-100,-36},{-132,-4}})));
    Modelica.Blocks.Interfaces.RealOutput P_th_cond(unit="W")
      "Thermal power (heat flow) from condenser [W]" annotation (Placement(
          transformation(
          extent={{16,-16},{-16,16}},
          rotation=90,
          origin={-40,-116})));
    Modelica.Blocks.Interfaces.RealOutput P_th_evap(unit="W")
      "Thermal power (heat flow) to evaporator [W]" annotation (Placement(
          transformation(
          extent={{16,-16},{-16,16}},
          rotation=90,
          origin={0,-116})));
    Modelica.Blocks.Interfaces.RealOutput P_el(unit="W")
      "Electrical power consumed by compressor [W]" annotation (Placement(
          transformation(
          extent={{16,-16},{-16,16}},
          rotation=90,
          origin={40,-116})));
    AixLib.Controls.Interfaces.ThermalMachineControlBus
      thermalMachineControlBus
      annotation (Placement(transformation(extent={{-120,-120},{-80,-80}})));
    Modelica.Blocks.Interfaces.RealOutput COP "Coefficient of performance [-]"
      annotation (Placement(transformation(
          extent={{16,-16},{-16,16}},
          rotation=90,
          origin={80,-116})));
  equation
    connect(fluidSource_evap.enthalpyPort_b, heatPump.enthalpyPort_a1)
      annotation (Line(points={{-28,-21},{-20,-21},{-20,-9},{-6.5,-9}}, color={
            176,0,0}));
    connect(fluidSource_cond.enthalpyPort_b, heatPump.enthalpyPort_a)
      annotation (Line(points={{32,17},{18,17},{18,11},{6.5,11}}, color={176,0,
            0}));
    connect(heatPump.enthalpyPort_b, temperatureSensor_cond.enthalpyPort_a)
      annotation (Line(points={{6.5,-9},{23.25,-9},{23.25,-31.09},{33.08,-31.09}},
          color={176,0,0}));
    connect(iceFac.y,heatPump. iceFac_in) annotation (Line(points={{-39.5,1},{
            -32.75,1},{-32.75,8.6},{-14.7333,8.6}},color={0,0,127}));
    connect(booleanToReal.y,heatPump. nSet) annotation (Line(points={{4.4,28},{
            8,28},{8,12.6},{2.16667,12.6}},   color={0,0,127}));
    connect(T_amb_internal.y,heatPump. T_amb_eva) annotation (Line(points={{1,-27.3},
            {1,-19.65},{-10.8333,-19.65},{-10.8333,-10}},  color={0,0,127}));
    connect(T_amb_internal.y,heatPump. T_amb_con) annotation (Line(points={{1,-27.3},
            {1,-18.65},{10.8333,-18.65},{10.8333,-10}},  color={0,0,127}));
    connect(T_evap_in, fluidSource_evap.T_fluid) annotation (Line(points={{-116,
            80},{-82,80},{-82,-17.8},{-46,-17.8}}, color={0,0,127}));
    connect(dotM_evap_in, fluidSource_evap.dotm) annotation (Line(points={{-116,
            20},{-82,20},{-82,-24.6},{-46,-24.6}}, color={0,0,127}));
    connect(dotM_cond_in, fluidSource_cond.dotm) annotation (Line(points={{116,
            20},{84,20},{84,20.6},{50,20.6}}, color={0,0,127}));
    connect(T_cond_in, fluidSource_cond.T_fluid) annotation (Line(points={{116,
            80},{84,80},{84,13.8},{50,13.8}}, color={0,0,127}));
    connect(Bool_on_off, booleanToReal.u) annotation (Line(points={{0,116},{-10,
            116},{-10,28},{-4.8,28}}, color={255,0,255}));
    connect(Bool_on_off, heatPump.modeSet) annotation (Line(points={{0,116},{
            -14,116},{-14,16},{-8,16},{-8,12.6},{-1.95,12.6}}, color={255,0,255}));
    connect(temperatureSensor_cond.enthalpyPort_b, vessel_co.enthalpyPort_a)
      annotation (Line(points={{49.1,-31.09},{59.55,-31.09},{59.55,-31},{71.3,
            -31}}, color={176,0,0}));
    connect(temperatureSensor_cond.T, T_cond_out) annotation (Line(points={{
            41.9,-21.1},{72.95,-21.1},{72.95,-20},{116,-20}}, color={0,0,127}));
    connect(heatPump.enthalpyPort_b1, temperatureSensor_evap.enthalpyPort_a)
      annotation (Line(points={{-6.5,11},{-6.5,12},{-52.92,12},{-52.92,30.91}},
          color={176,0,0}));
    connect(temperatureSensor_evap.enthalpyPort_b, vessel_ev.enthalpyPort_a)
      annotation (Line(points={{-36.9,30.91},{-24,30.91},{-24,55},{-43.3,55}},
          color={176,0,0}));
    connect(temperatureSensor_evap.T, T_evap_out) annotation (Line(points={{
            -44.1,40.9},{-70.05,40.9},{-70.05,-20},{-116,-20}}, color={0,0,127}));
    connect(thermalMachineControlBus.Pel,P_el)  annotation (Line(
        points={{-99.9,-99.9},{-80,-99.9},{-80,-100},{-60,-100},{-60,-66},{40,-66},
            {40,-116}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(heatPump.sigBusHP,thermalMachineControlBus)  annotation (Line(
        points={{-4.225,10.9},{-4.225,-27.55},{-100,-27.55},{-100,-100}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));

        P_th_cond = heatPump.innerCycle.QCon;
        P_th_evap = heatPump.innerCycle.QEva;
        COP = P_th_cond / P_el
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
    annotation (Documentation(info="<html>
<p>This model is just a wrapper around the AixLib 0.10.7 HeatPump (AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump), offering a simplified interface with real values for temperature and mass flow into evaporator and condensor, instead of the enthalpy ports used in AixLib.</p>
</html>"));
  end HeatPump_IO;
  annotation (uses(Modelica(version="3.2.3"), AixLib(version="0.10.7")), version=
     "0.2.0");
end HP_testbench;
