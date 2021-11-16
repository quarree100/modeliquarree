within Q100_DistrictModel.Simulations;
model Gesamt_Sim
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Gaskessel(k = 0) annotation (
    Placement(transformation(extent={{-340,70},{-320,90}})));
  Modelica.Blocks.Sources.Constant WP(k=0.1) annotation (
    Placement(transformation(extent={{-502,260},{-482,280}})));
  Q100_DistrictModel.FMUs.FMU_PhyModel fMU_PhyModel annotation (
    Placement(visible = true, transformation(extent = {{-254, 64}, {6, 264}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Speicherbeladung(k = 1) annotation (
    Placement(transformation(extent={{-534,196},{-514,216}})));
  Modelica.Blocks.Sources.Constant Speicherentladung(k = 1) annotation (
    Placement(transformation(extent={{-500,180},{-480,200}})));
  Modelica.Blocks.Sources.BooleanConstant WP1_disturb(k=true)
    annotation (Placement(transformation(extent={{-502,230},{-482,250}})));
  Modelica.Blocks.Sources.BooleanConstant Boiler_disturb(k=true)
    annotation (Placement(transformation(extent={{-340,100},{-320,120}})));
  Modelica.Blocks.Math.Add add2 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-470,420})));
  Modelica.Blocks.Math.Add add3 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-330,420})));
  Modelica.Blocks.Math.Add add4 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin={-380,380})));
  Modelica.Blocks.Math.Gain gain1(k=162898.75)
                                         annotation (
    Placement(visible = true, transformation(origin={-500,508},     extent = {{-10, -10}, {10, 10}}, rotation=270)));
  Modelica.Blocks.Math.Gain gain6(k=1374690.5)
                                         annotation (
    Placement(visible = true, transformation(origin={-420,510},     extent = {{-10, -10}, {10, 10}}, rotation=270)));
  Modelica.Blocks.Math.Gain gain7(k=12448)
                                         annotation (
    Placement(visible = true, transformation(origin={-360,510},     extent = {{-10, -10}, {10, 10}}, rotation=270)));
  Modelica.Blocks.Math.Gain gain8(k=2203638.5)
                                         annotation (
    Placement(visible = true, transformation(origin={-280,510},     extent = {{-10, -10}, {10, 10}}, rotation=270)));
  Modelica.Blocks.Sources.BooleanConstant BHKW_disturb(k=true)
    annotation (Placement(transformation(extent={{-420,160},{-400,180}})));
  Modelica.Blocks.Sources.Constant BHKW(k=0.5)
    annotation (Placement(transformation(extent={{-420,130},{-400,150}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_HeatDemand_DHW_Houses(table=
        e_th_TWW_HH.Profile)                                                                               annotation (
    Placement(transformation(extent={{-460,540},{-480,560}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_HeatDemand_RH_Houses(
      tableOnFile=false, table=e_th_RH_HH.Profile)                                                                            annotation (
    Placement(transformation(extent={{-460,580},{-440,600}})));
  Data.E_th_TWW_HH e_th_TWW_HH annotation (
    Placement(transformation(extent={{-454,540},{-434,560}})));
  Data.E_th_RH_HH e_th_RH_HH annotation (
    Placement(transformation(extent={{-486,580},{-466,600}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_HeatDemand_RH_GHD(table=
        e_th_RH_GHD.Profile)                                                                           annotation (
    Placement(transformation(extent={{-320,580},{-300,600}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_HeatDemand_DHW_GHD(table=
        e_th_TWW_GHD.Profile)                                                                            annotation (
    Placement(transformation(extent={{-320,540},{-340,560}})));
  Data.E_th_RH_GHD e_th_RH_GHD annotation (
    Placement(transformation(extent={{-346,580},{-326,600}})));
  Data.E_th_TWW_GHD e_th_TWW_GHD annotation (
    Placement(transformation(extent={{-314,540},{-294,560}})));
  Modelica.Blocks.Sources.BooleanConstant WP2_disturb(k=true)
    annotation (Placement(transformation(extent={{-382,216},{-362,236}})));
Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = true) annotation (
    Placement(visible = true, transformation(extent = {{-300, 268}, {-280, 288}}, rotation = 0)));
Modelica.Blocks.Sources.Constant const(k = 0.1) annotation (
    Placement(visible = true, transformation(extent = {{-300, 214}, {-280, 234}}, rotation = 0)));
Modelica.Blocks.Sources.Constant const1(k = 70) annotation (
    Placement(visible = true, transformation(extent = {{-280, 70}, {-260, 90}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Lastprofile(k=0)
    annotation (Placement(transformation(extent={{-418,244},{-398,264}})));
equation
connect(Gaskessel.y, fMU_PhyModel.u_boiler_0_1) annotation (
    Line(points={{-319,80},{-300,80},{-300,147.333},{-255.625,147.333}},
                                                                      color = {0, 0, 127}));
connect(WP.y, fMU_PhyModel.u_heatpump_0_1) annotation (
    Line(points={{-481,270},{-436,270},{-436,186.167},{-255.625,186.167}},
                                                                        color = {0, 0, 127}));
connect(Speicherentladung.y, fMU_PhyModel.u_7202_NS) annotation (
    Line(points={{-479,190},{-460,190},{-460,177.333},{-255.625,177.333}},
                                                                        color = {0, 0, 127}));
connect(Speicherbeladung.y, fMU_PhyModel.u_7102_NS) annotation (
    Line(points={{-513,206},{-348,206},{-348,179.833},{-255.625,179.833}},  color = {0, 0, 127}));
connect(Boiler_disturb.y, fMU_PhyModel.u_disturb_boiler) annotation (
    Line(points={{-319,110},{-306,110},{-306,150.667},{-255.625,150.667}},
                                                                        color = {255, 0, 255}));
connect(WP1_disturb.y, fMU_PhyModel.u_disturb_heatpump2) annotation (
    Line(points={{-481,240},{-440,240},{-440,182.333},{-255.625,182.333}},
                                                                        color = {255, 0, 255}));
  connect(add2.y,add4. u2) annotation (
    Line(points={{-470,409},{-470,398},{-386,398},{-386,392}},      color = {0, 0, 127}));
  connect(add3.y,add4. u1) annotation (
    Line(points={{-330,409},{-330,400},{-374,400},{-374,392}},      color = {0, 0, 127}));
connect(add4.y, fMU_PhyModel.u_loadProfile_kW) annotation (
    Line(points={{-380,369},{-380,260.667},{-255.625,260.667}},
                                                           color = {0, 0, 127}));
connect(BHKW.y, fMU_PhyModel.u_CHP_0_1) annotation (
    Line(points={{-399,140},{-360,140},{-360,171.5},{-255.625,171.5}},  color = {0, 0, 127}));
connect(fMU_PhyModel.u_disturb_CHP, BHKW_disturb.y) annotation (
    Line(points={{-255.625,174.833},{-366,174.833},{-366,170},{-399,170}},  color = {255, 0, 255}));
  connect(combiTimeTable_HeatDemand_RH_Houses.y[1], gain6.u) annotation (Line(
        points={{-439,590},{-420,590},{-420,522}}, color={0,0,127}));
  connect(combiTimeTable_HeatDemand_DHW_Houses.y[1], gain1.u) annotation (Line(
        points={{-481,550},{-500,550},{-500,520}}, color={0,0,127}));
  connect(combiTimeTable_HeatDemand_DHW_GHD.y[1], gain7.u) annotation (Line(
        points={{-341,550},{-360,550},{-360,522}}, color={0,0,127}));
  connect(combiTimeTable_HeatDemand_RH_GHD.y[1], gain8.u) annotation (Line(
        points={{-299,590},{-280,590},{-280,522}}, color={0,0,127}));
  connect(gain1.y, add2.u2) annotation (Line(points={{-500,497},{-500,460},{-476,
          460},{-476,432}}, color={0,0,127}));
  connect(gain6.y, add2.u1) annotation (Line(points={{-420,499},{-420,460},{-464,
          460},{-464,432}}, color={0,0,127}));
  connect(gain7.y, add3.u2) annotation (Line(points={{-360,499},{-360,460},{-336,
          460},{-336,432}}, color={0,0,127}));
  connect(gain8.y, add3.u1) annotation (Line(points={{-280,499},{-280,460},{-324,
          460},{-324,432}}, color={0,0,127}));
connect(WP2_disturb.y, fMU_PhyModel.u_disturb_heatpump1) annotation (
    Line(points={{-361,226},{-318,226},{-318,189.833},{-255.625,189.833}},  color = {255, 0, 255}));
connect(booleanConstant.y, fMU_PhyModel.u_disturb_electrolysis) annotation (
    Line(points={{-279,278},{-268,278},{-268,234},{-255.625,234}},      color = {255, 0, 255}));
connect(const.y, fMU_PhyModel.u_electrolysis_0_1) annotation (
    Line(points={{-279,224},{-268,224},{-268,228.167},{-255.625,228.167}},
                                              color = {0, 0, 127}));
connect(const1.y, fMU_PhyModel.u_temperature_heatingGrid_set) annotation (
    Line(points={{-259,80},{-252,80},{-252,124},{-255.625,124}},      color = {0, 0, 127}));
  connect(Lastprofile.y, fMU_PhyModel.u_loadProfile_DemandPower_kW)
    annotation (Line(points={{-397,254},{-255.625,254}}, color={0,0,127}));
  connect(Lastprofile.y, fMU_PhyModel.u_loadProfile_DemandEMob_kW)
    annotation (Line(points={{-397,254},{-390,254},{-390,250},{-255.625,250},
          {-255.625,250.667}}, color={0,0,127}));
  connect(Lastprofile.y,fMU_PhyModel.u_loadProfile_ProductionPV_kW)
    annotation (Line(points={{-397,254},{-390,254},{-390,257.333},{-255.625,
          257.333}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}}), graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
    Icon(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}})),
    experiment(StopTime = 31536000, Interval = 900, Tolerance = 0.01, __Dymola_Algorithm = "Dassl"));
end Gesamt_Sim;
