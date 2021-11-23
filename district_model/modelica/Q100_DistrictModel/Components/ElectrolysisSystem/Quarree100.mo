within Q100_DistrictModel.Components.ElectrolysisSystem;
model Quarree100 "Electrolyser in heat grid with quaree100 boundary conditions"
  extends Modelica.Icons.Example;
  Model.ElectrolysisSystem comp_electrolysisSystem(
    redeclare model CellModel = DetailedModel.Cell,
    param_outputPumpMassFlow=true,
    param_stack_i_max=3e4,
    param_stack_T_init=60 + 273.15,
    param_stack_T_op=70 + 273.15,
    param_stack_T_crit=85 + 273.15,
    param_stack_T_in=60 + 273.15,
    param_stack_cell_area=600e-4,
    param_stack_cell_d=150e-6,
    param_stack_cell_length=0.3,
    param_stack_cell_depth=0.02,
    param_p_comp_h2=35000000,
    param_stack_P_el_max=300e3,
    param_stack_P_el_min=20e3,
    param_stack_p_op_anode=1400000,
    param_stack_p_op_cathode=3000000,
    param_pump_Qmax=12/3600) "electrolyser with integrated heat pump"
    annotation (Placement(transformation(extent={{-16,2},{18,36}})));
  AixLib.FastHVAC.Components.Pumps.FluidSource comp_fluidSource annotation (
      Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-13,-35})));
  AixLib.FastHVAC.Components.Sinks.Vessel comp_vessel
    annotation (Placement(transformation(extent={{46,-30},{66,-10}})));
  Modelica.Blocks.Sources.CombiTimeTable table_lowerStorageTemp(
    tableOnFile=true,
    tableName="lowerStorageTemp",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Q100_DistrictModel/Components/ElectrolysisSystem/Resources/loadprofiles/inputDataCombined.txt"),
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    timeScale=15*60)
    annotation (Placement(transformation(extent={{-68,-80},{-54,-66}})));

  Modelica.Blocks.Sources.CombiTimeTable table_upperStorageTemp(
    tableOnFile=true,
    tableName="upperStorageTemp",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Q100_DistrictModel/Components/ElectrolysisSystem/Resources/loadprofiles/inputDataCombined.txt"),
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    timeScale=15*60)
    annotation (Placement(transformation(extent={{10,-66},{24,-52}})));

  Modelica.Blocks.Sources.CombiTimeTable table_inputPower(
    tableOnFile=true,
    tableName="power",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Q100_DistrictModel/Components/ElectrolysisSystem/Resources/loadprofiles/inputDataCombined.txt"),
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    timeScale=15*60)
    annotation (Placement(transformation(extent={{-64,30},{-50,44}})));
  Modelica.Blocks.Math.Add block_add
    annotation (Placement(transformation(extent={{-34,-76},{-26,-68}})));
  Modelica.Blocks.Sources.RealExpression exp_T_offset(y=273.15) "offset for conversion to Kelvin"
    annotation (Placement(transformation(extent={{-74,-58},{-54,-38}})));
  Modelica.Blocks.Math.Gain block_gain(k=5) "multiply signal with max mass flow rate"
    annotation (Placement(transformation(extent={{0,-60},{-8,-52}})));
  Modelica.Blocks.Logical.LessEqualThreshold block_load_storage(threshold=90 +
        273.15) "storage temperature at which heat pump has to turn off"
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=90,
        origin={11,-31})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 comp_weather(
    computeWetBulbTemperature=false,
    pAtmSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    ceiHeiSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    totSkyCovSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    opaSkyCovSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    TDewPoiSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    TBlaSkySou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    relHumSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    winSpeSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    winDirSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    HInfHorSou=AixLib.BoundaryConditions.Types.DataSource.Parameter,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Q100_DistrictModel/Components/ElectrolysisSystem/Resources/weather/TRY2015_541957091051_Jahr.mos"))
    "weather data of Heide"
    annotation (Placement(transformation(extent={{-80,4},{-66,18}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-42,6},{-32,18}}), iconTransformation(extent={{
            -118,96},{-98,116}})));
equation

  connect(comp_fluidSource.enthalpyPort_b, comp_electrolysisSystem.port_inlet_cooling)
    annotation (Line(points={{-13.9,-26},{-14,-26},{-14,-14},{-11.75,-14},{-11.75,
          4.125}}, color={176,0,0}));
  connect(comp_electrolysisSystem.port_outlet_cooling, comp_vessel.enthalpyPort_a)
    annotation (Line(points={{13.75,4.125},{13.75,-20},{49,-20}}, color={176,0,
          0}));
  connect(table_lowerStorageTemp.y[1], block_add.u2) annotation (Line(points={{-53.3,-73},{-44.65,-73},
          {-44.65,-74.4},{-34.8,-74.4}}, color={0,0,127}));
  connect(block_add.y, comp_fluidSource.T_fluid)
    annotation (Line(points={{-25.6,-72},{-18,-72},{-18,-42.2},{-16.78,-42.2}}, color={0,0,127}));
  connect(exp_T_offset.y, block_add.u1)
    annotation (Line(points={{-53,-48},{-44,-48},{-44,-69.6},{-34.8,-69.6}}, color={0,0,127}));
  connect(comp_electrolysisSystem.out_hp_cond_mflow, block_gain.u) annotation (Line(points={{-4.3125,
          0.9375},{-4.3125,-24},{2,-24},{2,-56},{0.8,-56}}, color={0,0,127}));
  connect(block_gain.y, comp_fluidSource.dotm)
    annotation (Line(points={{-8.4,-56},{-10,-56},{-10,-42.2},{-10.66,-42.2}}, color={0,0,127}));
  connect(table_inputPower.y[1], comp_electrolysisSystem.inp_P_av) annotation (
      Line(points={{-49.3,37},{-30.65,37},{-30.65,28.5625},{-14.9375,28.5625}},
        color={0,0,127}));
  connect(table_upperStorageTemp.y[1], block_load_storage.u) annotation (Line(
        points={{24.7,-59},{34,-59},{34,-40},{11,-40},{11,-34.6}}, color={0,0,
          127}));
  connect(comp_electrolysisSystem.inp_hp_on, block_load_storage.y) annotation (
      Line(points={{6.3125,0.9375},{6.3125,-22},{11,-22},{11,-27.7}}, color={
          255,0,255}));
  connect(comp_weather.weaBus, weaBus) annotation (Line(
      points={{-66,11},{-66,12},{-37,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, comp_electrolysisSystem.inp_T_air)
    annotation (Line(
      points={{-37,12},{-26.5,12},{-26.5,24.3125},{-14.9375,24.3125}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-92,94},{-42,70}},
          lineColor={0,0,127},
          pattern=LinePattern.Dot,
          horizontalAlignment=TextAlignment.Left,
          textString="Due to a 2.5MW heat pump in quarree100 the heat produced
by the electrolyser has nearly no effect on the storage
temperature. That is why both, lower and upper storage
temperature, are inputs from a table. Input power is the
avaiable excess power for the electrolyser")}),
    experiment(
      StopTime=31536000,
      Interval=180,
      __Dymola_Algorithm="Dassl"));
end Quarree100;
