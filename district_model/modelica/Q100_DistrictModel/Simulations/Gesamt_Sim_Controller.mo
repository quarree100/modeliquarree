within Q100_DistrictModel.Simulations;
model Gesamt_Sim_Controller
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant Boiler_inputsignal(k=0)
    annotation (Placement(transformation(extent={{-288,-82},{-268,-62}})));
  Modelica.Blocks.Sources.Constant HeatPump_inputsignal(k=0.1)
    annotation (Placement(transformation(extent={{-516,-82},{-496,-62}})));
  Q100_DistrictModel.FMUs.FMU_PhyModel fMU_PhyModel annotation (Placement(
        visible=true, transformation(extent={{-104,64},{156,264}}, rotation=0)));
  Modelica.Blocks.Sources.Constant HeatStorage_loading(k=1)
    annotation (Placement(transformation(extent={{-716,-118},{-696,-98}})));
  Modelica.Blocks.Sources.Constant HeatStorage_unloading(k=1)
    annotation (Placement(transformation(extent={{-716,-152},{-696,-132}})));
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
  Modelica.Blocks.Sources.Constant CHP_inputsignal(k=0.5)
    annotation (Placement(transformation(extent={{-408,-82},{-388,-62}})));
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
Modelica.Blocks.Sources.Constant const1(k = 70) annotation (
    Placement(visible = true, transformation(extent={{-168,-134},{-148,-114}},  rotation = 0)));
  Modelica.Blocks.Sources.Constant Lastprofile(k=0)
    annotation (Placement(transformation(extent={{-418,300},{-398,320}})));
  Modelica.Blocks.Sources.Constant Boiler_disturb(k=1)
    annotation (Placement(transformation(extent={{-288,-52},{-268,-32}})));
  Modelica.Blocks.Sources.Constant CHP_disturb(k=1)
    annotation (Placement(transformation(extent={{-176,-104},{-156,-84}})));
  Modelica.Blocks.Sources.Constant HeatPump1_disturb(k=1)
    annotation (Placement(transformation(extent={{-516,-112},{-496,-92}})));
  Modelica.Blocks.Sources.Constant HeatPump2_disturb(k=1)
    annotation (Placement(transformation(extent={{-516,-52},{-496,-32}})));
Modelica.Blocks.Sources.Constant Electrolysis_disturb(k=0) annotation (
      Placement(visible=true, transformation(extent={{-300,224},{-280,244}},
          rotation=0)));
  UnitController.Controller controller
    annotation (Placement(transformation(extent={{-110,332},{64,528}})));
equation
  connect(Boiler_inputsignal.y, fMU_PhyModel.u_boiler_0_1) annotation (Line(
        points={{-267,-72},{-148,-72},{-148,147.333},{-105.625,147.333}},
                                                                        color={
          0,0,127}));
  connect(HeatPump_inputsignal.y, fMU_PhyModel.u_heatpump_0_1) annotation (Line(
        points={{-495,-72},{-452,-72},{-452,186.167},{-105.625,186.167}}, color=
         {0,0,127}));
  connect(HeatStorage_unloading.y, fMU_PhyModel.u_7202_NS) annotation (Line(
        points={{-695,-142},{-676,-142},{-676,177.333},{-105.625,177.333}},
                                                                          color=
         {0,0,127}));
  connect(HeatStorage_loading.y, fMU_PhyModel.u_7102_NS) annotation (Line(
        points={{-695,-108},{-680,-108},{-680,179.833},{-105.625,179.833}},
                                                                          color=
         {0,0,127}));
  connect(add2.y,add4. u2) annotation (
    Line(points={{-470,409},{-470,398},{-386,398},{-386,392}},      color = {0, 0, 127}));
  connect(add3.y,add4. u1) annotation (
    Line(points={{-330,409},{-330,400},{-374,400},{-374,392}},      color = {0, 0, 127}));
connect(add4.y, fMU_PhyModel.u_loadProfile_kW) annotation (
    Line(points={{-380,369},{-380,260.667},{-105.625,260.667}},
                                                           color = {0, 0, 127}));
  connect(CHP_inputsignal.y, fMU_PhyModel.u_CHP_0_1) annotation (Line(points={{-387,
          -72},{-368,-72},{-368,171.5},{-105.625,171.5}},    color={0,0,127}));
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
connect(const1.y, fMU_PhyModel.u_temperature_heatingGrid_set) annotation (
    Line(points={{-147,-124},{-112,-124},{-112,32},{-128,32},{-128,80},{
          -105.625,80},{-105.625,124}},                               color = {0, 0, 127}));
  connect(Lastprofile.y, fMU_PhyModel.u_loadProfile_DemandPower_kW)
    annotation (Line(points={{-397,310},{-390,310},{-390,254},{-105.625,254}},
                                                         color={0,0,127}));
  connect(Lastprofile.y, fMU_PhyModel.u_loadProfile_DemandEMob_kW)
    annotation (Line(points={{-397,310},{-390,310},{-390,250},{-105.625,250},{
          -105.625,250.667}},  color={0,0,127}));
  connect(Lastprofile.y,fMU_PhyModel.u_loadProfile_ProductionPV_kW)
    annotation (Line(points={{-397,310},{-390,310},{-390,257.333},{-105.625,
          257.333}}, color={0,0,127}));
  connect(Boiler_disturb.y, fMU_PhyModel.u_disturb_boiler) annotation (Line(
        points={{-267,-42},{-154,-42},{-154,150.667},{-105.625,150.667}}, color=
         {0,0,127}));
  connect(CHP_disturb.y, fMU_PhyModel.u_disturb_CHP) annotation (Line(points={{-155,
          -94},{-155,-128},{-96,-128},{-96,144},{-105.625,144},{-105.625,
          174.833}},                                               color={0,0,
          127}));
  connect(HeatPump1_disturb.y, fMU_PhyModel.u_disturb_heatpump2) annotation (
      Line(points={{-495,-102},{-456,-102},{-456,182.333},{-105.625,182.333}},
        color={0,0,127}));
  connect(HeatPump2_disturb.y, fMU_PhyModel.u_disturb_heatpump1) annotation (
      Line(points={{-495,-42},{-448,-42},{-448,189.833},{-105.625,189.833}},
        color={0,0,127}));
  connect(Lastprofile.y, controller.P_el_demand_district) annotation (Line(
        points={{-397,310},{148,310},{148,472},{65.9333,472},{65.9333,471.576}},
        color={0,0,127}));
  connect(controller.P_el_pv_district, Lastprofile.y) annotation (Line(points={{65.9333,
          489.394},{106,489.394},{106,490},{148,490},{148,310},{-397,310}},
                 color={0,0,127}));
  connect(controller.u_Boiler_scheudle, Lastprofile.y) annotation (Line(points=
          {{-111.16,421.091},{-190,421.091},{-190,310},{-397,310}}, color={0,0,
          127}));
  connect(controller.u_CHP_scheudle, Lastprofile.y) annotation (Line(points={{
          -111.16,427.03},{-190,427.03},{-190,310},{-397,310}}, color={0,0,127}));
  connect(controller.u_Electrolyzer_scheudle, Lastprofile.y) annotation (Line(
        points={{-111.16,432.97},{-190,432.97},{-190,310},{-397,310}}, color={0,
          0,127}));
  connect(controller.u_HeatPump_scheudle, Lastprofile.y) annotation (Line(
        points={{-111.16,438.909},{-190,438.909},{-190,310},{-397,310}}, color=
          {0,0,127}));
  connect(controller.u_Electrolyzer_controll, fMU_PhyModel.u_electrolysis_0_1)
    annotation (Line(points={{64.9667,431.485},{96,431.485},{96,284},{-142,284},
          {-142,228},{-105.625,228},{-105.625,228.167}}, color={0,0,127}));
  connect(controller.E_el_EES, Lastprofile.y) annotation (Line(points={{65.9333,
          465.636},{148,465.636},{148,310},{-397,310}}, color={0,0,127}));
  connect(controller.P_el_demand_emobility, Lastprofile.y) annotation (Line(
        points={{65.9333,476.03},{148,476.03},{148,310},{-397,310}}, color={0,0,
          127}));
  connect(Electrolysis_disturb.y, fMU_PhyModel.u_disturb_electrolysis)
    annotation (Line(points={{-279,234},{-105.625,234}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}}), graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
    Icon(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}})),
    experiment(StopTime = 31536000, Interval = 900, Tolerance = 0.01, __Dymola_Algorithm = "Dassl"));
end Gesamt_Sim_Controller;
