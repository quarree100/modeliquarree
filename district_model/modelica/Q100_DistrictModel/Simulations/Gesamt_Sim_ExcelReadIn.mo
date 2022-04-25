within Q100_DistrictModel.Simulations;
model Gesamt_Sim_ExcelReadIn
  extends Modelica.Icons.Example;
  Q100_DistrictModel.FMUs.FMU_PhyModel fMU_PhyModel annotation (Placement(
        visible=true, transformation(extent={{-256,66},{4,266}}, rotation=0)));
Modelica.Blocks.Sources.Constant const1(k = 70) annotation (
    Placement(visible = true, transformation(extent={{-400,116},{-380,136}},    rotation = 0)));
  Modelica.Blocks.Sources.Constant Lastprofile(k=0)
    annotation (Placement(transformation(extent={{-400,350},{-380,370}})));
  Components.Excel_ReadIn.ExcelReader_LoadProfiles excelReader_LoadProfiles
    annotation (Placement(transformation(extent={{-440,312},{-416,342}})));
  Components.Excel_ReadIn.ExcelReader_ScheudleProfiles
    excelReader_ScheudleProfiles
    annotation (Placement(transformation(extent={{-440,278},{-416,304}})));
  Components.Excel_ReadIn.ExcelReader_ErrorProfiles excelReader_ErrorScheudle
    annotation (Placement(transformation(extent={{-440,238},{-416,268}})));
equation
connect(const1.y, fMU_PhyModel.u_temperature_heatingGrid_set) annotation (
    Line(points={{-379,126},{-257.625,126}},                          color = {0, 0, 127}));
  connect(Lastprofile.y,fMU_PhyModel.u_loadProfile_ProductionPV_kW)
    annotation (Line(points={{-379,360},{-340,360},{-340,259.333},{-257.625,
          259.333}}, color={0,0,127}));
  connect(Lastprofile.y, fMU_PhyModel.u_loadProfile_DemandEMob_kW)
    annotation (Line(points={{-379,360},{-340,360},{-340,256},{-272,256},{-272,
          252.667},{-257.625,252.667}},
                     color={0,0,127}));
  connect(fMU_PhyModel.u_loadProfile_kW, excelReader_LoadProfiles.E_th_load)
    annotation (Line(points={{-257.625,262.667},{-257.625,262},{-264,262},{-264,
          330.462},{-414.8,330.462}},
                            color={0,0,127}));
  connect(excelReader_LoadProfiles.E_el_load, fMU_PhyModel.u_loadProfile_DemandPower_kW)
    annotation (Line(points={{-414.8,316.615},{-344,316.615},{-344,316},{-268,
          316},{-268,256},{-257.625,256}},
                 color={0,0,127}));
  connect(fMU_PhyModel.u_electrolysis_0_1, excelReader_ScheudleProfiles.u_Electrolyzer_scheudle)
    annotation (Line(points={{-257.625,230.167},{-314.813,230.167},{-314.813,
          298.091},{-414.8,298.091}}, color={0,0,127}));
  connect(fMU_PhyModel.u_heatpump_0_1, excelReader_ScheudleProfiles.u_HeatPump_scheudle)
    annotation (Line(points={{-257.625,188.167},{-348,188.167},{-348,302},{-368,
          302},{-368,302.818},{-414.8,302.818}},      color={0,0,127}));
  connect(fMU_PhyModel.u_7102_NS, excelReader_ScheudleProfiles.u_StorageLoad_scheudle)
    annotation (Line(points={{-257.625,181.833},{-320,181.833},{-320,284},{-368,
          284},{-368,283.909},{-414.8,283.909}},
                                      color={0,0,127}));
  connect(excelReader_ScheudleProfiles.u_StorageUnload_scheudle, fMU_PhyModel.u_7202_NS)
    annotation (Line(points={{-414.8,279.182},{-324,279.182},{-324,180},{-286,
          180},{-286,179.333},{-257.625,179.333}},
                                        color={0,0,127}));
  connect(fMU_PhyModel.u_CHP_0_1, excelReader_ScheudleProfiles.u_CHP_scheudle)
    annotation (Line(points={{-257.625,173.5},{-360,173.5},{-360,293.364},{
          -414.8,293.364}}, color={0,0,127}));
  connect(fMU_PhyModel.u_boiler_0_1, excelReader_ScheudleProfiles.u_boiler_scheudle)
    annotation (Line(points={{-257.625,149.333},{-328,149.333},{-328,288.636},{
          -414.8,288.636}},  color={0,0,127}));
  connect(excelReader_ErrorScheudle.u_HeatPump1_ErrorScheudle, fMU_PhyModel.u_disturb_heatpump1)
    annotation (Line(points={{-414.8,266.846},{-364,266.846},{-364,191.833},{
          -257.625,191.833}}, color={0,0,127}));
  connect(excelReader_ErrorScheudle.u_HeatPump2_ErrorScheudle, fMU_PhyModel.u_disturb_heatpump2)
    annotation (Line(points={{-414.8,262.231},{-366,262.231},{-366,184.333},{
          -257.625,184.333}}, color={0,0,127}));
  connect(excelReader_ErrorScheudle.u_Electrolyzer_ErrorScheudle, fMU_PhyModel.u_disturb_electrolysis)
    annotation (Line(points={{-414.8,257.615},{-384,257.615},{-384,258},{-354,
          258},{-354,236},{-257.625,236}}, color={0,0,127}));
  connect(excelReader_ErrorScheudle.u_CHP_ErrorScheudle, fMU_PhyModel.u_disturb_CHP)
    annotation (Line(points={{-414.8,253},{-370,253},{-370,176.833},{-257.625,
          176.833}}, color={0,0,127}));
  connect(excelReader_ErrorScheudle.u_Boiler_ErrorScheudle, fMU_PhyModel.u_disturb_boiler)
    annotation (Line(points={{-414.8,248.385},{-374,248.385},{-374,152.667},{
          -257.625,152.667}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-680,-60},{80,440}}),            graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
    Icon(coordinateSystem(extent={{-680,-60},{80,440}})),
    experiment(
      StopTime=900,
      Interval=900,
      Tolerance=0.01,
      __Dymola_Algorithm="Dassl"));
end Gesamt_Sim_ExcelReadIn;
