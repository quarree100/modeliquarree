within Q100_DistrictModel.Simulations;
model Gesamt_Sim_CSVReadIn
  extends Modelica.Icons.Example;
  Q100_DistrictModel.FMUs.FMU_PhyModel fMU_PhyModel(
    u_7102_NS=0,
    u_7202_NS=0,
    u_CHP_0_1=cSVReader_ScheudleProfiles.u_CHP_scheudle,
    u_boiler_0_1=cSVReader_ScheudleProfiles.u_boiler_scheudle,
    u_electrolysis_0_1=cSVReader_ScheudleProfiles.u_Electrolyzer_scheudle,
    u_heatpump_0_1=cSVReader_ScheudleProfiles.u_HeatPump_scheudle,
    u_loadProfile_DemandEMob_kW=0,
    u_loadProfile_DemandPower_kW=cSVReader_LoadProfiles.E_el_load,
    u_loadProfile_ProductionPV_kW=0,
    u_loadProfile_kW=cSVReader_LoadProfiles.E_th_load,
    u_temperature_heatingGrid_set=70,
    u_disturb_electrolysis=cSVReader_ErrorProfiles.u_Electrolyzer_ErrorScheudle,
    u_disturb_heatpump1=cSVReader_ErrorProfiles.u_HeatPump1_ErrorScheudle,
    u_disturb_heatpump2=cSVReader_ErrorProfiles.u_HeatPump2_ErrorScheudle,
    u_disturb_CHP=cSVReader_ErrorProfiles.u_CHP_ErrorScheudle,
    u_disturb_boiler=cSVReader_ErrorProfiles.u_Boiler_ErrorScheudle) annotation (Placement(visible=true, transformation(extent={{-106,64},{154,264}}, rotation=0)));

  Components.Excel_ReadIn.CSVReader_LoadProfiles cSVReader_LoadProfiles
    annotation (Placement(transformation(extent={{-220,218},{-188,260}})));
  Components.Excel_ReadIn.CSVReader_ScheudleProfiles cSVReader_ScheudleProfiles
    annotation (Placement(transformation(extent={{-222,160},{-188,200}})));
  Components.Excel_ReadIn.CSVReader_ErrorProfiles cSVReader_ErrorProfiles
    annotation (Placement(transformation(extent={{-220,100},{-188,142}})));
  Components.calc_Qdot_production calc_Qdot_production1(
    u_Qdot_Heatpump2=fMU_PhyModel.y_heatpump2_dotQ,
    u_Qdot_Heatpump1=fMU_PhyModel.y_heatpump1_dotQ,
    u_Qdot_CHP=fMU_PhyModel.y_CHP_dotQ,
    u_Qdot_Electrolyzer=fMU_PhyModel.y_Elektrolyseur_dotQ,
    u_Qdot_Boiler=fMU_PhyModel.y_boiler_dotQ,
    u_Qdot_StorageUnload=0) annotation (Placement(transformation(extent={{-172,18},{-152,38}})));
  annotation (
    Diagram(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}}), graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
    Icon(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}})),
    experiment(StopTime = 31536000, Interval = 900, Tolerance = 0.01, __Dymola_Algorithm = "Dassl"));
end Gesamt_Sim_CSVReadIn;
