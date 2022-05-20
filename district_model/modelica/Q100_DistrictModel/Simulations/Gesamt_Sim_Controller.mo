within Q100_DistrictModel.Simulations;
model Gesamt_Sim_Controller
  extends Modelica.Icons.Example;
  Q100_DistrictModel.FMUs.FMU_PhyModel fMU_PhyModel(
    ScaleFactor_heatPump1=0,
    ScaleFactor_heatPump2=0,
    u_7102_NS=0,
    u_7202_NS=0,
    u_CHP_0_1=controller.u_CHP_controll,
    u_boiler_0_1=controller.u_Boiler_controll,
    u_electrolysis_0_1=controller.u_Electrolyzer_controll,
    u_heatpump_0_1=controller.u_HeatPump_controll,
    u_loadProfile_DemandEMob_kW=0,
    u_loadProfile_DemandPower_kW=cSVReader_LoadProfiles.E_el_load,
    u_loadProfile_ProductionPV_kW=0,
    u_loadProfile_kW=dynamic_Heatload_Scale.Qdot_heatload_scaled,
    u_temperature_heatingGrid_set=controller.u_T_HeatGrid_FF_set,
    u_disturb_electrolysis=cSVReader_ErrorProfiles.u_Electrolyzer_ErrorScheudle,
    u_disturb_heatpump1=cSVReader_ErrorProfiles.u_HeatPump1_ErrorScheudle,
    u_disturb_heatpump2=cSVReader_ErrorProfiles.u_HeatPump2_ErrorScheudle,
    u_disturb_CHP=cSVReader_ErrorProfiles.u_CHP_ErrorScheudle,
    u_disturb_boiler=cSVReader_ErrorProfiles.u_Boiler_ErrorScheudle) annotation (Placement(visible=true, transformation(extent={{202,-108},{462,92}}, rotation=0)));

  FMUs.FMU_Controller controller(
    u_TempAmp_extern=cSVReader_WeatherData.T_amb,
    u_co2_extern=0,
    u_el_costs_extern=0,
    u_T_HeatGrid_FF_actual=fMU_PhyModel.temperature_HeatGrid_FF.T - 273,
    P_el_pv_district=0,
    u_HeatPump_scheudle=cSVReader_ScheudleProfiles.u_HeatPump_scheudle,
    u_Electrolyzer_scheudle=cSVReader_ScheudleProfiles.u_Electrolyzer_scheudle,
    u_Boiler_scheudle=cSVReader_ScheudleProfiles.u_boiler_scheudle,
    u_CHP_scheudle=cSVReader_ScheudleProfiles.u_CHP_scheudle,
    E_el_EES=0,
    P_inst_el_HP1=550*0.8,
    P_inst_el_HP2=550*0.2,
    P_inst_el_Electrolyzer=250,
    u_heatpump1_OA=fMU_PhyModel.y_2101_OA_1_real,
    u_electrolyzer_OA=fMU_PhyModel.y_1101_OA_real,
    u_CHP_OA=fMU_PhyModel.y_4201_OA_real,
    u_boiler_OA=fMU_PhyModel.y_5203_OA_real,
    u_heatpump2_OA=fMU_PhyModel.y_2101_OA_2_real,
    P_el_CHP_district=fMU_PhyModel.CHP.Capacity[2]/1000,
    u_T_TES_load=fMU_PhyModel.temperature_HeatGrid_FF.T - 273,
    u_T_TES_unload=fMU_PhyModel.temperature_HeatGrid_FF.T - 273,
    P_el_demand_district=0,
    P_el_demand_emobility=0,
    u_TES_load_scheudle=-1,
    u_TES_unload_scheudle=-1,
    P_inst_th_TES_unload=300,
    P_inst_th_TES_load=300,
    P_th_demand_district=fMU_PhyModel.y_GridLoad,
    u_T_HeatGrid_RF_actual=fMU_PhyModel.temperature_8206_TRC.T,
    u_Qdot_Heatpump1=fMU_PhyModel.y_heatpump1_dotQ,
    u_Qdot_Heatpump2=fMU_PhyModel.y_heatpump2_dotQ,
    u_Qdot_Electrolyzer=fMU_PhyModel.y_Elektrolyseur_dotQ,
    u_Qdot_CHP=fMU_PhyModel.y_CHP_dotQ,
    u_Qdot_Boiler=fMU_PhyModel.y_boiler_dotQ) annotation (Placement(transformation(extent={{-94,-108},{80,88}})));

  Components.Excel_ReadIn.CSVReader_LoadProfiles cSVReader_LoadProfiles
    annotation (Placement(transformation(extent={{-192,-2},{-160,40}})));
  Components.Excel_ReadIn.CSVReader_ScheudleProfiles cSVReader_ScheudleProfiles
    annotation (Placement(transformation(extent={{-194,-60},{-160,-20}})));
  Components.Excel_ReadIn.CSVReader_ErrorProfiles cSVReader_ErrorProfiles
    annotation (Placement(transformation(extent={{-192,-120},{-160,-78}})));
  Components.Excel_ReadIn.CSVReader_WeatherData cSVReader_WeatherData
    annotation (Placement(transformation(extent={{-200,60},{-160,100}})));
  Components.Dynamic_Heatload_Scale dynamic_Heatload_Scale(
    Qdot_heatload=cSVReader_LoadProfiles.E_th_load,
    T_amb=cSVReader_WeatherData.T_amb,
    T_heatgrid_FF=fMU_PhyModel.temperature_HeatGrid_FF.T - 273) annotation (Placement(transformation(extent={{140,100},{160,120}})));
  annotation (
    Diagram(coordinateSystem(extent={{-520,-340},{520,340}}),          graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
    Icon(coordinateSystem(extent={{-520,-340},{520,340}})),
    experiment(
      StopTime=900000,
      Interval=3600,
      Tolerance=0.01,
      __Dymola_Algorithm="Dassl"));
end Gesamt_Sim_Controller;
