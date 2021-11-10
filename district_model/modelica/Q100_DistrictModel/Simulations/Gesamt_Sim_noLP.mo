within Q100_DistrictModel.Simulations;
model Gesamt_Sim_noLP
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Gaskessel(k = 0) annotation (
    Placement(transformation(extent={{-340,70},{-320,90}})));
  Modelica.Blocks.Sources.Constant WP(k=0.1) annotation (
    Placement(transformation(extent={{-502,260},{-482,280}})));
  Q100_DistrictModel.FMUs.FMU_PhyModel fMU_PhyModel annotation (
    Placement(visible = true, transformation(extent = {{-256, 66}, {4, 266}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Speicherbeladung(k = 1) annotation (
    Placement(transformation(extent={{-534,196},{-514,216}})));
  Modelica.Blocks.Sources.Constant Speicherentladung(k = 1) annotation (
    Placement(transformation(extent={{-500,180},{-480,200}})));
  Modelica.Blocks.Sources.BooleanConstant WP2_disturb(k=true)
    annotation (Placement(transformation(extent={{-502,230},{-482,250}})));
  Modelica.Blocks.Sources.BooleanConstant Heatpump_disturb(k=true)
    annotation (Placement(transformation(extent={{-340,100},{-320,120}})));
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
  Modelica.Blocks.Sources.BooleanConstant BHKW_disturb(k=true)
    annotation (Placement(transformation(extent={{-420,160},{-400,180}})));
  Modelica.Blocks.Sources.Constant BHKW(k=0.5)
    annotation (Placement(transformation(extent={{-420,130},{-400,150}})));
  Modelica.Blocks.Sources.BooleanConstant WP1_disturb(k=true)
    annotation (Placement(transformation(extent={{-376,216},{-356,236}})));
Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = true) annotation (
    Placement(visible = true, transformation(extent = {{-306, 286}, {-286, 306}}, rotation = 0)));
Modelica.Blocks.Sources.Constant const(k = 0.5) annotation (
    Placement(visible = true, transformation(extent = {{-300, 200}, {-280, 220}}, rotation = 0)));
Modelica.Blocks.Sources.Constant const1(k = 70) annotation (
    Placement(visible = true, transformation(extent = {{-300, 30}, {-280, 50}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Lastprofile(k=0)
    annotation (Placement(transformation(extent={{-444,302},{-424,322}})));
equation
connect(Gaskessel.y, fMU_PhyModel.u_boiler_0_1) annotation (
    Line(points={{-319,80},{-300,80},{-300,149.333},{-257.625,149.333}},
                                                                      color = {0, 0, 127}));
connect(WP.y, fMU_PhyModel.u_heatpump_0_1) annotation (
    Line(points={{-481,270},{-436,270},{-436,188.167},{-257.625,188.167}},
                                                                        color = {0, 0, 127}));
connect(Speicherentladung.y, fMU_PhyModel.u_7202_NS) annotation (
    Line(points={{-479,190},{-460,190},{-460,179.333},{-257.625,179.333}},
                                                                        color = {0, 0, 127}));
connect(Speicherbeladung.y, fMU_PhyModel.u_7102_NS) annotation (
    Line(points={{-513,206},{-348,206},{-348,181.833},{-257.625,181.833}},  color = {0, 0, 127}));
connect(Heatpump_disturb.y, fMU_PhyModel.u_disturb_boiler) annotation (
    Line(points={{-319,110},{-306,110},{-306,152.667},{-257.625,152.667}},
                                                                        color = {255, 0, 255}));
connect(WP2_disturb.y, fMU_PhyModel.u_disturb_heatpump2) annotation (
    Line(points={{-481,240},{-440,240},{-440,184.333},{-257.625,184.333}},
                                                                        color = {255, 0, 255}));
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
    Line(points={{-380,369},{-380,262.667},{-257.625,262.667}},
                                                           color = {0, 0, 127}));
connect(BHKW.y, fMU_PhyModel.u_CHP_0_1) annotation (
    Line(points={{-399,140},{-360,140},{-360,173.5},{-257.625,173.5}},  color = {0, 0, 127}));
connect(fMU_PhyModel.u_disturb_CHP, BHKW_disturb.y) annotation (
    Line(points={{-257.625,176.833},{-366,176.833},{-366,170},{-399,170}},  color = {255, 0, 255}));
connect(WP1_disturb.y, fMU_PhyModel.u_disturb_heatpump1) annotation (
    Line(points={{-355,226},{-314,226},{-314,191.833},{-257.625,191.833}},  color = {255, 0, 255}));
connect(const.y, fMU_PhyModel.u_electrolysis_0_1) annotation (
    Line(points={{-279,210},{-270,210},{-270,230.167},{-257.625,230.167}},
                                                                        color = {0, 0, 127}));
connect(booleanConstant.y, fMU_PhyModel.u_disturb_electrolysis) annotation (
    Line(points={{-285,296},{-270,296},{-270,236},{-257.625,236}},      color = {255, 0, 255}));
connect(const1.y, fMU_PhyModel.u_temperature_heatingGrid_set) annotation (
    Line(points={{-279,40},{-270,40},{-270,126},{-257.625,126}},      color = {0, 0, 127}));
  connect(Lastprofile.y,fMU_PhyModel.u_loadProfile_ProductionPV_kW)
    annotation (Line(points={{-423,312},{-406,312},{-406,259.333},{-257.625,
          259.333}}, color={0,0,127}));
  connect(Lastprofile.y, fMU_PhyModel.u_loadProfile_DemandPower_kW)
    annotation (Line(points={{-423,312},{-406,312},{-406,256},{-257.625,256}},
        color={0,0,127}));
  connect(Lastprofile.y, fMU_PhyModel.u_loadProfile_DemandEMob_kW)
    annotation (Line(points={{-423,312},{-406,312},{-406,252.667},{-257.625,
          252.667}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}}), graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
    Icon(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}})),
    experiment(StopTime = 31536000, Interval = 900, Tolerance = 0.01, __Dymola_Algorithm = "Dassl"));
end Gesamt_Sim_noLP;
