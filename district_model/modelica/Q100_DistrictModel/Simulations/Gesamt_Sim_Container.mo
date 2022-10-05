within Q100_DistrictModel.Simulations;
model Gesamt_Sim_Container
  extends Modelica.Icons.Example;

  Components.Excel_ReadIn.CSVReader_LoadProfiles cSVReader_LoadProfiles
    annotation (Placement(transformation(extent={{-192,-2},{-160,40}})));
  Components.Excel_ReadIn.CSVReader_ScheudleProfiles cSVReader_ScheudleProfiles
    annotation (Placement(transformation(extent={{-194,-60},{-160,-20}})));
  Components.Excel_ReadIn.CSVReader_ErrorProfiles cSVReader_ErrorProfiles
    annotation (Placement(transformation(extent={{-192,-120},{-160,-78}})));
  Components.Excel_ReadIn.CSVReader_WeatherData cSVReader_WeatherData
    annotation (Placement(transformation(extent={{-200,60},{-160,100}})));
  FMUs.FMU_Container_PhyModel_and_Controller fMU_Container_PhyModel_and_Controller(
    ScaleFactor_HP1=0.8,
    ScaleFactor_HP2=0.2,
    capP_el_chp(displayUnit="W") = 400,
    capP_el_electrolyser(displayUnit="W") = 250,
    capP_el_pv(displayUnit="W") = 2000,
    capQ_th_boiler(displayUnit="W") = 2000,
    el_costs_extern=0,
    co2_extern=0,
    T_amb=cSVReader_WeatherData.T_amb,
    u_HeatPump_scheudle=cSVReader_ScheudleProfiles.u_HeatPump_scheudle,
    u_Electrolyzer_scheudle=cSVReader_ScheudleProfiles.u_Electrolyzer_scheudle,
    u_Boiler_scheudle=cSVReader_ScheudleProfiles.u_boiler_scheudle,
    u_CHP_scheudle=cSVReader_ScheudleProfiles.u_CHP_scheudle,
    u_HeatPump1_error=cSVReader_ErrorProfiles.u_HeatPump1_ErrorScheudle,
    u_HeatPump2_error=cSVReader_ErrorProfiles.u_HeatPump2_ErrorScheudle,
    u_Electrolyzer_error=cSVReader_ErrorProfiles.u_Electrolyzer_ErrorScheudle,
    u_Boiler_error=cSVReader_ErrorProfiles.u_Boiler_ErrorScheudle,
    u_CHP_error=cSVReader_ErrorProfiles.u_CHP_ErrorScheudle,
    u_loadProfile_DemandEMob_kW=0,
    u_loadProfile_DemandPower_kW=0,
    u_loadProfile_ProductionPV_kW=0,
    u_loadProfile_DemandHeat_kW=cSVReader_LoadProfiles.E_th_load,
    fMU_PhyModel(
      capP_el_chp(displayUnit="kW"),
      capP_el_electrolyser(displayUnit="kW"),
      capP_el_pv(displayUnit="kW"),
      capQ_th_boiler(displayUnit="kW")))                                                                       annotation (Placement(transformation(extent={{-116,-112},{118,122}})));
  annotation (
    Diagram(coordinateSystem(extent={{-520,-340},{520,340}}),          graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
    Icon(coordinateSystem(extent={{-520,-340},{520,340}})),
    experiment(
      StopTime=1728000,
      Interval=3600.00288,
      Tolerance=0.01,
      __Dymola_Algorithm="Dassl"));
end Gesamt_Sim_Container;
