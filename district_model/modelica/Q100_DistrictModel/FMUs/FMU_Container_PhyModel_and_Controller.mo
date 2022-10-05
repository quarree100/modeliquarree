within Q100_DistrictModel.FMUs;
model FMU_Container_PhyModel_and_Controller
  //system units dimensions
  parameter Real ScaleFactor_HP1 = 0.8 "Scaling factor for heat pump 1 (1=550kW)" annotation (Dialog(tab = "System units dimensions",group = "Heatpump properties",enable=not selectable));
  parameter Real ScaleFactor_HP2 = 0.2 "Scaling factor for heat pump 2 (1=550kW)" annotation (Dialog(tab = "System units dimensions",group = "Heatpump properties",enable=not selectable));
  parameter Modelica.SIunits.Power capP_el_chp=1000 "CHPs electrical capacity" annotation (Dialog(tab = "System units dimensions",group = "CHP properties",enable=not selectable));
  parameter Modelica.SIunits.Efficiency eta_el_chp= 0.25 "CHP's electrical efficiency"
                                                                                      annotation (Dialog(tab = "System units dimensions",group = "CHP properties",enable=not selectable));
  parameter Modelica.SIunits.Efficiency eta_th_chp = 0.65 "CHP's thermal efficiency" annotation (Dialog(tab = "System units dimensions",group = "CHP properties",enable=not selectable));
  parameter Modelica.SIunits.Power capP_el_electrolyser = 250 "installed electrical capacity for electrolyser" annotation (Dialog(tab = "System units dimensions",group = "Electrolyser properties",enable=not selectable));
  parameter Modelica.SIunits.Efficiency eta_el_electrolyser= 1 "CHP's electrical efficiency"
                                                                                            annotation (Dialog(tab = "System units dimensions",group = "Electrolyser properties",enable=not selectable));
  parameter Modelica.SIunits.Efficiency eta_th_electrolyser = 0.16 "CHP's thermal efficiency" annotation (Dialog(tab = "System units dimensions",group = "Electrolyser properties",enable=not selectable));
  parameter Modelica.SIunits.Power capP_el_pv = 2000000 "installed electrical capacity for pv" annotation (Dialog(tab = "System units dimensions",group = "PV properties",enable=not selectable));
  parameter Modelica.SIunits.Power capQ_th_boiler = 2000000 "installed thermal capacity for boiler" annotation (Dialog(tab = "System units dimensions",group = "Boiler properties",enable=not selectable));
  parameter Modelica.SIunits.Height h_tes = 3.2 "Height of thermal energy storage" annotation (Dialog(tab = "System units dimensions",group = "TES properties",enable=not selectable));
  parameter Modelica.SIunits.Diameter d_tes = 20 "Inner diameter of thermal energy storage" annotation (Dialog(tab = "System units dimensions",group = "TES properties",enable=not selectable));

  //external parameters
  replaceable
  Modelica.Blocks.Interfaces.RealInput el_costs_extern "Electricity price intensity of the upstream electricity grid in €/kWh" annotation (Dialog(tab = "External parameters",group = "Electricity market properties",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput co2_extern "CO2 intensity of the upstream electricity grid in g/kWh" annotation (Dialog(tab = "External parameters",group = "Electricity market properties",enable=not selectable));

  //ambient parameters
  replaceable
  Modelica.Blocks.Interfaces.RealInput T_amb "Ambient temperature in °C" annotation (Dialog(tab = "Ambient parameters",enable=not selectable));

  //external profiles
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_HeatPump_scheudle
  annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_Electrolyzer_scheudle
  annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_Boiler_scheudle
  annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_CHP_scheudle
  annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_HeatPump1_error
  annotation (Dialog(tab = "External profiles",group = "Error profiles",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_HeatPump2_error
  annotation (Dialog(tab = "External profiles",group = "Error profiles",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_Electrolyzer_error
  annotation (Dialog(tab = "External profiles",group = "Error profiles",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_Boiler_error
  annotation (Dialog(tab = "External profiles",group = "Error profiles",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_CHP_error
  annotation (Dialog(tab = "External profiles",group = "Error profiles",enable=not selectable));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_loadProfile_DemandEMob_kW(final quantity = "Power", final unit = "kW", displayUnit = "kW", min = 0) "E-Mobilität Lastprofil" annotation (Dialog(tab = "External profiles",group = "Load profiles",enable=not selectable),Placement(transformation(extent={{-20,-20},{20,20}}, origin={-2226,1122}), iconTransformation(extent={{-20,-20},{20,20}}, origin={-2216,1126})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_loadProfile_DemandPower_kW(final quantity = "Power", final unit = "kW", displayUnit = "kW", min = 0) "Elektrischer Verbraucher Lastprofil" annotation (Dialog(tab = "External profiles",group = "Load profiles",enable=not selectable),Placement(transformation(extent={{-20,-20},{20,20}}, origin={-2226,1186}), iconTransformation(extent={{-20,-20},{20,20}}, origin={-2216,1190})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_loadProfile_ProductionPV_kW(final quantity = "Power", final unit = "kW", displayUnit = "kW", min = 0) "Elektrischer Verbraucher Lastprofil" annotation (Dialog(tab = "External profiles",group = "Load profiles",enable=not selectable),Placement(transformation(extent={{-20,-20},{20,20}}, origin={-2226,1238}), iconTransformation(extent={{-20,-20},{20,20}}, origin={-2216,1242})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_loadProfile_DemandHeat_kW(final quantity = "Power", final unit = "kW", displayUnit = "kW", min = 0) "Thermische Verbraucher Lastprofil" annotation (Dialog(tab = "External profiles",group = "Load profiles",enable=not selectable),Placement(transformation(extent={{-20,-20},{20,20}}, origin={-2226,1354}), iconTransformation(extent={{-20,-20},{20,20}}, origin={-2216,1358})));




  replaceable
  Q100_DistrictModel.FMUs.FMU_PhyModel fMU_PhyModel(
    ScaleFactor_heatPump1=ScaleFactor_HP1,
    ScaleFactor_heatPump2=ScaleFactor_HP2,
    capP_el_chp=capP_el_chp*1000,
    eta_el_chp=eta_el_chp,
    eta_th_chp=eta_th_chp,
    eta_el_electrolyser=eta_el_electrolyser,
    eta_th_electrolyser=eta_th_electrolyser,
    capP_el_electrolyser=capP_el_electrolyser*1000,
    capP_el_pv=capP_el_pv*1000,
    capQ_th_boiler=capQ_th_boiler*1000,
    h_tes=h_tes,
    d_tes=d_tes,
    u_7102_NS=0,
    u_7202_NS=0,
    u_CHP_0_1=controller.u_CHP_controll,
    u_boiler_0_1=controller.u_Boiler_controll,
    u_electrolysis_0_1=controller.u_Electrolyzer_controll,
    u_heatpump_0_1=controller.u_HeatPump_controll,
    u_loadProfile_DemandEMob_kW=u_loadProfile_DemandEMob_kW,
    u_loadProfile_DemandPower_kW=u_loadProfile_DemandPower_kW,
    u_loadProfile_ProductionPV_kW=u_loadProfile_ProductionPV_kW,
    u_loadProfile_kW=dynamic_Heatload_Scale.Qdot_heatload_scaled,
    u_temperature_heatingGrid_set=controller.u_T_HeatGrid_FF_set,
    u_disturb_electrolysis=u_Electrolyzer_error,
    u_disturb_heatpump1=u_HeatPump1_error,
    u_disturb_heatpump2=u_HeatPump2_error,
    u_disturb_CHP=u_CHP_error,
    u_disturb_boiler=u_Boiler_error,
    u_temperature_amb=T_amb + 273)                                   annotation (Placement(visible=true, transformation(extent={{-128,-108},{132,92}},rotation=0)));



  replaceable
  FMU_Controller controller(
    u_TempAmb_extern=T_amb,
    u_co2_extern=co2_extern,
    u_el_costs_extern=el_costs_extern,
    u_T_HeatGrid_FF_actual=fMU_PhyModel.temperature_HeatGrid_FF.T - 273,
    P_el_pv_district=u_loadProfile_ProductionPV_kW,
    u_HeatPump_scheudle=u_HeatPump_scheudle,
    u_Electrolyzer_scheudle=u_Electrolyzer_scheudle,
    u_Boiler_scheudle=u_Boiler_scheudle,
    u_CHP_scheudle=u_CHP_scheudle,
    E_el_EES=0,
    P_inst_el_HP1=550*ScaleFactor_HP1,
    P_inst_el_HP2=550*ScaleFactor_HP2,
    P_inst_el_Electrolyzer=capP_el_electrolyser,
    u_heatpump1_OA=fMU_PhyModel.y_2101_OA_1_real,
    u_electrolyzer_OA=fMU_PhyModel.y_1101_OA_real,
    u_CHP_OA=fMU_PhyModel.y_4201_OA_real,
    u_boiler_OA=fMU_PhyModel.y_5203_OA_real,
    u_heatpump2_OA=fMU_PhyModel.y_2101_OA_2_real,
    P_el_CHP_district=fMU_PhyModel.CHP.Capacity[2]/1000,
    u_T_TES_load=fMU_PhyModel.temperature_HeatGrid_FF.T - 273,
    u_T_TES_unload=fMU_PhyModel.temperature_HeatGrid_FF.T - 273,
    P_el_demand_district=u_loadProfile_DemandPower_kW,
    P_el_demand_emobility=u_loadProfile_DemandEMob_kW,
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
    u_Qdot_Boiler=fMU_PhyModel.y_boiler_dotQ) annotation (Placement(transformation(extent={{-226,114},{-116,232}})));

  replaceable
  Components.Dynamic_Heatload_Scale dynamic_Heatload_Scale(
    Qdot_heatload= u_loadProfile_DemandHeat_kW,
    T_amb=T_amb,
    T_heatgrid_FF=fMU_PhyModel.temperature_HeatGrid_FF.T - 273) annotation (Placement(transformation(extent={{-214,56},{-194,76}})));
  annotation (
    Diagram(coordinateSystem(extent={{-240,-240},{240,240}}),          graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
    Icon(coordinateSystem(extent={{-240,-240},{240,240}})),
    experiment(
      StopTime=1728000,
      Interval=3600.00288,
      Tolerance=0.01,
      __Dymola_Algorithm="Dassl"));
end FMU_Container_PhyModel_and_Controller;
