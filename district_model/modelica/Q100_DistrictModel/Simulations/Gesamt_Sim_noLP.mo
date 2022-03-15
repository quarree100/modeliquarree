within Q100_DistrictModel.Simulations;
model Gesamt_Sim_noLP
  extends Modelica.Icons.Example;
  Q100_DistrictModel.FMUs.FMU_PhyModel fMU_PhyModel annotation (Placement(
        visible=true, transformation(extent={{-128,66},{132,266}}, rotation=0)));
  Modelica.Blocks.Sources.Constant E_th_RH_Houses(k = 1374690.5) annotation (
    Placement(transformation(extent={{-680,580},{-660,600}})));
  Modelica.Blocks.Sources.Constant E_th_TWW_Houses(k = 162898.75) annotation (
    Placement(transformation(extent={{-680,550},{-660,570}})));
  Modelica.Blocks.Sources.Constant E_th_RH_GHD(k = 2203638.5) annotation (
    Placement(transformation(extent={{-680,640},{-660,660}})));
  Modelica.Blocks.Sources.Constant E_th_TWW_GHD(k = 12448) annotation (
    Placement(transformation(extent={{-680,610},{-660,630}})));
  Modelica.Blocks.Math.Add add2 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-470,420})));
  Modelica.Blocks.Math.Product product1 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-510,460})));
  Modelica.Blocks.Math.Product product2 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-430,460})));
  Modelica.Blocks.Math.Add add3 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-330,420})));
  Modelica.Blocks.Math.Product product3 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-370,460})));
  Modelica.Blocks.Math.Product product4 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-290,460})));
  Modelica.Blocks.Math.Add add4 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-380,380})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=0.0001,
    freqHz=1/31536000,
    phase=1.5707963267949,
    offset=0.0001)                                                                                                       annotation (
    Placement(transformation(extent={{-474,530},{-454,550}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=0.0001,
    width=50,
    period=86400,
    startTime=21600)                                                                                     annotation (
    Placement(transformation(extent={{-470,490},{-490,510}})));
  Modelica.Blocks.Sources.Pulse pulse1(
    amplitude=0.0001,
    width=50,
    period=86400,
    startTime=21600)                                                                                      annotation (
    Placement(transformation(extent={{-332,490},{-352,510}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=0.0001,
    freqHz=1/31536000,
    phase=1.5707963267949,
    offset=0.0001)                                                                                                        annotation (
    Placement(transformation(extent={{-330,530},{-310,550}})));
  Modelica.Blocks.Math.Gain gain1(k=1)   annotation (
    Placement(visible = true, transformation(origin={-630,560},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain6(k=1)   annotation (
    Placement(visible = true, transformation(origin={-630,590},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain7(k=1)   annotation (
    Placement(visible = true, transformation(origin={-630,620},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain8(k=1)   annotation (
    Placement(visible = true, transformation(origin={-630,650},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Lastprofile(k=0)
    annotation (Placement(transformation(extent={{-440,302},{-420,322}})));
  Modelica.Blocks.Sources.Constant HeatStorage_loading(k=1)
    annotation (Placement(transformation(extent={{-720,194},{-700,214}})));
  Modelica.Blocks.Sources.Constant HeatStorage_unloading(k=1)
    annotation (Placement(transformation(extent={{-720,160},{-700,180}})));
  Modelica.Blocks.Sources.Constant HeatPump_inputsignal(k=0.1)
    annotation (Placement(transformation(extent={{-520,230},{-500,250}})));
  Modelica.Blocks.Sources.Constant HeatPump1_disturb(k=1)
    annotation (Placement(transformation(extent={{-520,200},{-500,220}})));
  Modelica.Blocks.Sources.Constant HeatPump2_disturb(k=1)
    annotation (Placement(transformation(extent={{-520,260},{-500,280}})));
  Modelica.Blocks.Sources.Constant CHP_inputsignal(k=0.5)
    annotation (Placement(transformation(extent={{-420,70},{-400,90}})));
  Modelica.Blocks.Sources.Constant CHP_disturb(k=1)
    annotation (Placement(transformation(extent={{-420,100},{-400,120}})));
  Modelica.Blocks.Sources.Constant Boiler_inputsignal(k=0)
    annotation (Placement(transformation(extent={{-300,70},{-280,90}})));
  Modelica.Blocks.Sources.Constant Boiler_disturb(k=1)
    annotation (Placement(transformation(extent={{-300,100},{-280,120}})));
Modelica.Blocks.Sources.Constant const1(k=70)   annotation (
    Placement(visible = true, transformation(extent={{-180,18},{-160,38}},      rotation = 0)));
Modelica.Blocks.Sources.Constant Electrolysis_inputsignal(k=0.1) annotation (
      Placement(visible=true, transformation(extent={{-320,196},{-300,216}},
          rotation=0)));
Modelica.Blocks.Sources.Constant Electrolysis_disturb(k=1) annotation (
      Placement(visible=true, transformation(extent={{-320,224},{-300,244}},
          rotation=0)));
equation
  connect(product2.y,add2. u1) annotation (
    Line(points={{-430,449},{-430,440},{-464,440},{-464,432}},      color = {0, 0, 127}));
  connect(product1.y,add2. u2) annotation (
    Line(points={{-510,449},{-510,440},{-476,440},{-476,432}},      color = {0, 0, 127}));
  connect(product4.y,add3. u1) annotation (
    Line(points={{-290,449},{-290,440},{-324,440},{-324,432}},      color = {0, 0, 127}));
  connect(product3.y,add3. u2) annotation (
    Line(points={{-370,449},{-370,440},{-336,440},{-336,432}},      color = {0, 0, 127}));
  connect(add2.y,add4. u2) annotation (
    Line(points={{-470,409},{-470,398},{-386,398},{-386,392}},      color = {0, 0, 127}));
  connect(add3.y,add4. u1) annotation (
    Line(points={{-330,409},{-330,400},{-374,400},{-374,392}},      color = {0, 0, 127}));
  connect(pulse.y,product1. u1) annotation (
    Line(points={{-491,500},{-504,500},{-504,472}},     color = {0, 0, 127}));
  connect(pulse1.y,product3. u1) annotation (
    Line(points={{-353,500},{-364,500},{-364,472}},     color = {0, 0, 127}));
  connect(sine.y,product2. u2) annotation (
    Line(points={{-453,540},{-436,540},{-436,472}},     color = {0, 0, 127}));
  connect(sine1.y,product4. u2) annotation (
    Line(points={{-309,540},{-296,540},{-296,472}},     color = {0, 0, 127}));
  connect(E_th_TWW_Houses.y, gain1.u)
    annotation (Line(points={{-659,560},{-642,560}}, color={0,0,127}));
  connect(E_th_RH_Houses.y, gain6.u)
    annotation (Line(points={{-659,590},{-642,590}}, color={0,0,127}));
  connect(E_th_TWW_GHD.y, gain7.u)
    annotation (Line(points={{-659,620},{-642,620}}, color={0,0,127}));
  connect(E_th_RH_GHD.y, gain8.u)
    annotation (Line(points={{-659,650},{-642,650}}, color={0,0,127}));
  connect(gain1.y, product1.u2) annotation (Line(points={{-619,560},{-516,560},
          {-516,472}}, color={0,0,127}));
  connect(gain6.y, product2.u1) annotation (Line(points={{-619,590},{-424,590},
          {-424,472}}, color={0,0,127}));
  connect(gain7.y, product3.u2) annotation (Line(points={{-619,620},{-376,620},
          {-376,472}}, color={0,0,127}));
  connect(gain8.y, product4.u1) annotation (Line(points={{-619,650},{-284,650},
          {-284,472}}, color={0,0,127}));
connect(add4.y, fMU_PhyModel.u_loadProfile_kW) annotation (
    Line(points={{-380,369},{-380,262.667},{-129.625,262.667}},
                                                           color = {0, 0, 127}));
  connect(Lastprofile.y,fMU_PhyModel.u_loadProfile_ProductionPV_kW)
    annotation (Line(points={{-419,312},{-406,312},{-406,259.333},{-129.625,
          259.333}}, color={0,0,127}));
  connect(Lastprofile.y, fMU_PhyModel.u_loadProfile_DemandPower_kW)
    annotation (Line(points={{-419,312},{-406,312},{-406,256},{-129.625,256}},
        color={0,0,127}));
  connect(Lastprofile.y, fMU_PhyModel.u_loadProfile_DemandEMob_kW)
    annotation (Line(points={{-419,312},{-406,312},{-406,252.667},{-129.625,
          252.667}}, color={0,0,127}));
  connect(Electrolysis_inputsignal.y, fMU_PhyModel.u_electrolysis_0_1)
    annotation (Line(points={{-299,206},{-280,206},{-280,230.167},{-129.625,
          230.167}}, color={0,0,127}));
  connect(Electrolysis_disturb.y, fMU_PhyModel.u_disturb_electrolysis)
    annotation (Line(points={{-299,234},{-278,234},{-278,236},{-129.625,236}},
        color={0,0,127}));
  connect(fMU_PhyModel.u_disturb_heatpump1, HeatPump2_disturb.y) annotation (
      Line(points={{-129.625,191.833},{-460,191.833},{-460,270},{-499,270}},
        color={0,0,127}));
  connect(fMU_PhyModel.u_heatpump_0_1, HeatPump_inputsignal.y) annotation (Line(
        points={{-129.625,188.167},{-464,188.167},{-464,240},{-499,240}}, color=
         {0,0,127}));
  connect(fMU_PhyModel.u_disturb_heatpump2, HeatPump1_disturb.y) annotation (
      Line(points={{-129.625,184.333},{-468,184.333},{-468,210},{-499,210}},
        color={0,0,127}));
  connect(fMU_PhyModel.u_7102_NS, HeatStorage_loading.y) annotation (Line(
        points={{-129.625,181.833},{-129.625,182},{-680,182},{-680,204},{-699,
          204}}, color={0,0,127}));
  connect(fMU_PhyModel.u_7202_NS, HeatStorage_unloading.y) annotation (Line(
        points={{-129.625,179.333},{-680,179.333},{-680,170},{-699,170}}, color=
         {0,0,127}));
  connect(fMU_PhyModel.u_disturb_CHP, CHP_disturb.y) annotation (Line(points={{
          -129.625,176.833},{-390,176.833},{-390,110},{-399,110}}, color={0,0,
          127}));
  connect(CHP_inputsignal.y, fMU_PhyModel.u_CHP_0_1) annotation (Line(points={{
          -399,80},{-386,80},{-386,173.5},{-129.625,173.5}}, color={0,0,127}));
  connect(fMU_PhyModel.u_disturb_boiler, Boiler_disturb.y) annotation (Line(
        points={{-129.625,152.667},{-270,152.667},{-270,110},{-279,110}}, color=
         {0,0,127}));
  connect(fMU_PhyModel.u_boiler_0_1, Boiler_inputsignal.y) annotation (Line(
        points={{-129.625,149.333},{-260,149.333},{-260,80},{-279,80}}, color={
          0,0,127}));
  connect(const1.y, fMU_PhyModel.u_temperature_heatingGrid_set) annotation (
      Line(points={{-159,28},{-154,28},{-154,126},{-129.625,126}}, color={0,0,
          127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}}), graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
    Icon(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}})),
    experiment(StopTime = 31536000, Interval = 900, Tolerance = 0.01, __Dymola_Algorithm = "Dassl"));
end Gesamt_Sim_noLP;
