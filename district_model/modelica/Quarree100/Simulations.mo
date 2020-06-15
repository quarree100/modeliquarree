within Quarree100;

package Simulations
  extends Modelica.Icons.ExamplesPackage;

  model V008_Quarree100
    extends Modelica.Icons.Example;
    parameter String Pfad = "Z:/owncloud/Consolinno/Projekte/Quarree100_Consolinno/Simulation_Modelica/";
    parameter String inputFileNameWeatherData = Pfad + "TRY2015_541957091051_Jahr.mos";
    parameter String inputFileNameCHP_P = Pfad + "Fahrplan_optCHP_P.txt";
    parameter String inputFileNameCHP_OP = Pfad + "Fahrplan_optCHP_OP.txt";
    parameter String inputFileNameElectrolyser_P = Pfad + "Fahrplan_optElectrolyser_P.txt";
    parameter String inputFileNameElectrolyser_OP = Pfad + "Fahrplan_optElectrolyser_OP.txt";
    parameter String inputFileNameBoiler = Pfad + "Fahrplan_optBoiler.txt";
    parameter String inputFileNameHeatPump = Pfad + "Fahrplan_optHeatPump.txt";
    parameter String inputFileNameHeatSword = Pfad + "Fahrplan_optHeatSword.txt";
    parameter String inputFileNameBat = Pfad + "Fahrplan_optBat.txt";
    parameter String inputFileNameDemandThermal = Pfad + "Waermebedarf_normiert.txt";
    parameter String inputFileNameDemandPower = Pfad + "Strombedarf_normiert.txt";
    parameter String inputFileNameEMob = Pfad + "EMobilitaet_normiert.txt";
    parameter String inputFileNameH2Mob = Pfad + "H2Mobilitaet_normiert.txt";
    parameter String inputFileNameSpot = Pfad + "SpotPreis.txt";
    Modelica.Blocks.Sources.Constant constElectrolyzer_T_setpoint_specification(k = 77 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-590, 792}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(348.15, 8), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 3.2, dTank = 20, sIns = 0.2, lambdaIns = 0.032), load_cycles = [8, 1; 8, 1; 8, 1], n = 8, n_load_cycles = 3, n_unload_cycles = 1, unload_cycles = [1, 8], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {30, 601}, extent = {{-60, -81}, {60, 81}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(
      Placement(visible = true, transformation(origin = {-930, 960}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-970, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP annotation(
      Placement(visible = true, transformation(origin = {-820, 712}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
      Placement(visible = true, transformation(origin = {-570, 684}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Electrolyzer annotation(
      Placement(visible = true, transformation(origin = {-820, 892}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_HeatPumpAir annotation(
      Placement(visible = true, transformation(origin = {-820, 832}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-970, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseHeatPumpAir(amplitude = 0, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-970, 840}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt Electrolyzer(T0 = 368.15, T_Out = 368.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation(
      Placement(visible = true, transformation(origin = {-530, 810}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
      Placement(visible = true, transformation(origin = {-570, 864}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(visible = true, transformation(origin = {650, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(visible = true, transformation(origin = {620, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 1, controllerType = .Modelica.Blocks.Types.SimpleController.PID, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.0001, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation(
      Placement(visible = true, transformation(origin = {690, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {730, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation(
      Placement(visible = true, transformation(origin = {130, -706}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {170, -700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_cost_Spot annotation(
      Placement(visible = true, transformation(origin = {210, -700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {726, 696}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 40) annotation(
      Placement(visible = true, transformation(origin = {690, 730}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation(
      Placement(visible = true, transformation(origin = {700, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation(
      Placement(visible = true, transformation(origin = {770, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {170, 340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_FF(T_0 = 343.15, diameter = 0.3, length = 5000) annotation(
      Placement(visible = true, transformation(origin = {390, 340}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {620, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain_DemandHeat_Houses(k = 5177304.074) annotation(
      Placement(visible = true, transformation(origin = {762, 810}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = inputFileNameDemandThermal, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {714, 826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31 annotation(
      Placement(visible = true, transformation(origin = {-60, 470}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation(
      Placement(visible = true, transformation(origin = {-20, 470}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation(
      Placement(visible = true, transformation(origin = {-40, 428}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation(
      Placement(visible = true, transformation(origin = {-40, 390}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = inputFileNameSpot, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {70, -706}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {762, 730}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation(
      Placement(visible = true, transformation(origin = {-489, 243}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt CHP(capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238, uHigh = 1, uLow = -6) annotation(
      Placement(visible = true, transformation(origin = {-450, 190}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 73 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-510, 174}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_HeatGrid_FF annotation(
      Placement(visible = true, transformation(origin = {310, 340}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const2(k = 71 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-510, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_Boiler_opt2 Boiler(Q_nom = 2000000, uHigh = 343.15, uLow = 338.15) annotation(
      Placement(visible = true, transformation(origin = {-450, 30}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO3 annotation(
      Placement(visible = true, transformation(origin = {-489, 83}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseBoiler(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-970, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Boiler annotation(
      Placement(visible = true, transformation(origin = {-820, 652}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_HePu_opt HePu_Air(Scale_Factor = 100, T_Out = 368.15) annotation(
      Placement(visible = true, transformation(origin = {-530, 630}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constHeatPumpAir_T_setpoint_specification(k = 77 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-590, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constHeatPumpAir_mdot_amb(k = 100) annotation(
      Placement(visible = true, transformation(origin = {-650, 636}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = inputFileNameWeatherData) annotation(
      Placement(visible = true, transformation(origin = {-970, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain3(k = 1.01) annotation(
      Placement(visible = true, transformation(origin = {-720, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gainPV_500kW(k = 50) annotation(
      Placement(visible = true, transformation(origin = {-608, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.busbar_4consumer busbar_4consumer annotation(
      Placement(visible = true, transformation(origin = {-126, -148}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandPower(fileName = inputFileNameDemandPower, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-708, -156}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_Houses(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-668, -156}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandEMob(fileName = inputFileNameEMob, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-708, -186}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_EMob(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-668, -186}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.Electrical.PVSystem.PVSystemTMY3 pVSystemTMY3(MaxOutputPower = 15000, NumberOfPanels = 300, data = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()) annotation(
      Placement(visible = true, transformation(origin = {-708, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    BuildingSystems.Technologies.ElectricalStorages.BatterySimple batterySimple1(SOC_start = 0, batteryData = BuildingSystems.Technologies.ElectricalStorages.Data.LithiumIon.LithiumIonAquion(), nBat = 10) annotation(
      Placement(visible = true, transformation(origin = {4, -190}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__CHP_dotE = CHP.y_dotE annotation(
      Placement(visible = true, transformation(origin = {-840, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__Boiler_dotE = Boiler.y_dotE annotation(
      Placement(visible = true, transformation(origin = {-840, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.LessThreshold lessThreshold annotation(
      Placement(visible = true, transformation(origin = {152, -176}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch_GridLoad annotation(
      Placement(visible = true, transformation(origin = {232, -146}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch_FeedIn_PV_500kW annotation(
      Placement(visible = true, transformation(origin = {232, -204}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const5(k = 0) annotation(
      Placement(visible = true, transformation(origin = {192, -176}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__FeedIn_PV_500kW = switch_FeedIn_PV_500kW.y annotation(
      Placement(visible = true, transformation(origin = {-840, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__FeedIn_CHP = busbar_4consumer.y_FeedInCHP annotation(
      Placement(visible = true, transformation(origin = {-840, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__GridLoad = gain_GridLoad.y annotation(
      Placement(visible = true, transformation(origin = {-840, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__GridLoad annotation(
      Placement(visible = true, transformation(origin = {-790, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__FeedIn_CHP annotation(
      Placement(visible = true, transformation(origin = {-790, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__FeedIn_PV_500kW annotation(
      Placement(visible = true, transformation(origin = {-790, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__CHP_dotE annotation(
      Placement(visible = true, transformation(origin = {-790, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__Boiler_dotE annotation(
      Placement(visible = true, transformation(origin = {-790, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__Electrolyzer_H2 = Electrolyzer.y_dotE annotation(
      Placement(visible = true, transformation(origin = {-840, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__Electrolyzer_H2 annotation(
      Placement(visible = true, transformation(origin = {-790, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_Boiler_dotE_CO2(k = 0.2 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_CHP_dotE_CO2(k = 0.2 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_PV_500kW_CO2(k = -0.474 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_CHP_CO2(k = -0.474 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_GridLoad_CO2(k = 0.474 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_Electrolyzer_H2(k = 0 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_CO2_dotE annotation(
      Placement(visible = true, transformation(origin = {-710, -800}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_CO2_FeedIn annotation(
      Placement(visible = true, transformation(origin = {-710, -880}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_CO2_Power annotation(
      Placement(visible = true, transformation(origin = {-670, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_CO2 annotation(
      Placement(visible = true, transformation(origin = {-610, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_FeedIn_PV_500kW = switch_FeedIn_PV_500kW.y annotation(
      Placement(visible = true, transformation(origin = {120, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {170, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DemandPower_EMob annotation(
      Placement(visible = true, transformation(origin = {170, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandPower_EMob = gain_DemandPower_EMob.y annotation(
      Placement(visible = true, transformation(origin = {120, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandPower_Houses = gain_DemandPower_Houses.y annotation(
      Placement(visible = true, transformation(origin = {120, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DemandPower_Houses annotation(
      Placement(visible = true, transformation(origin = {170, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_Houses_cost(k = -0.25 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_EMob_cost(k = -0.20 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_PV_500kW_cost(k = -0.0855 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandHeat_Houses_cost(k = -0.12 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DemandHeat_Houses annotation(
      Placement(visible = true, transformation(origin = {170, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandHeat_Houses = gain_DemandHeat_Houses.y annotation(
      Placement(visible = true, transformation(origin = {120, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_CHP_dotE = CHP.y_dotE annotation(
      Placement(visible = true, transformation(origin = {120, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_CHP_dotE annotation(
      Placement(visible = true, transformation(origin = {170, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_CHP_dotE_cost(k = (0.04 + 0.2 * 0.019) / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_Boiler_dotE_cost(k = (0.04 + 0.2 * 0.019) / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_Boiler_dotE annotation(
      Placement(visible = true, transformation(origin = {170, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_Boiler_dotE = Boiler.y_dotE annotation(
      Placement(visible = true, transformation(origin = {120, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_FeedIn_CHP = busbar_4consumer.y_FeedInCHP annotation(
      Placement(visible = true, transformation(origin = {120, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_FeedIn_CHP annotation(
      Placement(visible = true, transformation(origin = {170, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_CHP_cost(k = -0.0528 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_dotE annotation(
      Placement(visible = true, transformation(origin = {250, -320}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_DemandPower annotation(
      Placement(visible = true, transformation(origin = {250, -440}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_Advancement annotation(
      Placement(visible = true, transformation(origin = {250, -640}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_FeedIn annotation(
      Placement(visible = true, transformation(origin = {290, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_Demand annotation(
      Placement(visible = true, transformation(origin = {290, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_cost annotation(
      Placement(visible = true, transformation(origin = {370, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption_PV_500_kW = busbar_4consumer.y_DirectConsumptionPV annotation(
      Placement(visible = true, transformation(origin = {120, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DirectConsumption_PV_500kW annotation(
      Placement(visible = true, transformation(origin = {170, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DirectConsumption_PV_500kW_cost(k = 0.06756 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption_CHP = busbar_4consumer.y_DirectConsumptionCHP annotation(
      Placement(visible = true, transformation(origin = {120, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DirectConsumption_CHP annotation(
      Placement(visible = true, transformation(origin = {170, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DirectConsumption_CHP_cost(k = 0.06756 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_DirectConsumption annotation(
      Placement(visible = true, transformation(origin = {250, -560}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_GridLoad(k = -1) annotation(
      Placement(visible = true, transformation(origin = {270, -146}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_GridLoad = gain_GridLoad.y annotation(
      Placement(visible = true, transformation(origin = {120, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_GridLoad annotation(
      Placement(visible = true, transformation(origin = {170, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_GridLoad_cost(k = 0.30 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_cost_Power annotation(
      Placement(visible = true, transformation(origin = {330, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switchElectrolyzer annotation(
      Placement(visible = true, transformation(origin = {-890, 892}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThresholdElectrolyzer annotation(
      Placement(visible = true, transformation(origin = {-850, 920}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const7(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-940, 930}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThresholdHeatPumpAir annotation(
      Placement(visible = true, transformation(origin = {-850, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switchHeatPumpAir annotation(
      Placement(visible = true, transformation(origin = {-890, 832}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switchHeatPumpGeo annotation(
      Placement(visible = true, transformation(origin = {-890, 772}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThresholdHeatPumpGeo annotation(
      Placement(visible = true, transformation(origin = {-850, 800}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_HeatPumpGeo annotation(
      Placement(visible = true, transformation(origin = {-820, 772}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-364, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseHeatPumpGeo(amplitude = 0, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-970, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThresholdCHP annotation(
      Placement(visible = true, transformation(origin = {-850, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switchCHP annotation(
      Placement(visible = true, transformation(origin = {-890, 712}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch1 annotation(
      Placement(visible = true, transformation(origin = {-888, 652}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation(
      Placement(visible = true, transformation(origin = {-850, 680}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_HePu_opt HePu_Geo(Scale_Factor = 50, T_Out = 368.15) annotation(
      Placement(visible = true, transformation(origin = {-530, 450}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constHeatPumpGeo_mdot_amb(k = 100) annotation(
      Placement(visible = true, transformation(origin = {-650, 456}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constHeatPumpGeo_T_setpoint_specification(k = 77 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-590, 430}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO4 annotation(
      Placement(visible = true, transformation(origin = {-570, 504}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    Modelica.Blocks.Sources.Sine sineGeo_T_amb(amplitude = 15, freqHz = 1 / (3600 * 24 * 365 * 2), offset = 3 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-970, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_HeatStorage_unload annotation(
      Placement(visible = true, transformation(origin = {68, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.HeatExchangers.DHWHeatExchanger HeatExchanger(A_HE = 20, T0 = 343.15, T_inlet_DHW = 343.15, T_set_DHW_ideal = 343.15) annotation(
      Placement(visible = true, transformation(origin = {253, 263.273}, extent = {{-20.9085, 43}, {16.7268, -43}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_RF(T_0 = 323.15, diameter = 0.3, length = 5000) annotation(
      Placement(visible = true, transformation(origin = {390, 300}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_RF(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {170, 300}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold1(n = 2) annotation(
      Placement(visible = true, transformation(origin = {130, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Splitter splitter(n = 2) annotation(
      Placement(visible = true, transformation(origin = {130, 120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_AdditionalHeating_RF(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {170, 120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_AdditionalHeating_FF(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {170, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {176, 662}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_P_HeatPumps annotation(
      Placement(visible = true, transformation(origin = {-460, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation(
      Placement(visible = true, transformation(origin = {350, 320}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = 1) annotation(
      Placement(visible = true, transformation(origin = {762, 770}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    AixLib.BoundaryConditions.WeatherData.Bus WetterBus annotation(
      Placement(visible = true, transformation(extent = {{-740, 118}, {-700, 158}}, rotation = 0), iconTransformation(extent = {{-1008, 160}, {-988, 180}}, rotation = 0)));
  equation
    connect(const3.y, PID.u_s) annotation(
      Line(points = {{719, 520}, {702, 520}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation(
      Line(points = {{679, 520}, {620, 520}, {620, 551}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation(
      Line(points = {{141, -706}, {158, -706}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation(
      Line(points = {{701, 730}, {726, 730}, {726, 708}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation(
      Line(points = {{660, 660}, {690.4, 660}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation(
      Line(points = {{715, 696}, {700, 696}, {700, 668}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{709.6, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{709.6, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{620, 600.2}, {620, 570}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation(
      Line(points = {{781, 660}, {802, 660}, {802, 560}, {629.8, 560}}, color = {0, 85, 255}));
    connect(combiTimeTable_DemandHeat.y[1], gain_DemandHeat_Houses.u) annotation(
      Line(points = {{725, 826}, {762, 826}, {762, 822}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation(
      Line(points = {{-60, 459}, {-60, 448}, {-48, 448}, {-48, 440}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation(
      Line(points = {{-20, 459}, {-20, 447}, {-32, 447}, {-32, 440}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation(
      Line(points = {{-23.25, 601}, {-40, 601}, {-40, 440}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation(
      Line(points = {{-18.75, 601}, {-40, 601}, {-40, 500}, {-68, 500}, {-68, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation(
      Line(points = {{-20.25, 601}, {-40, 601}, {-40, 500}, {-60, 500}, {-60, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation(
      Line(points = {{-21.75, 601}, {-40, 601}, {-40, 500}, {-52, 500}, {-52, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation(
      Line(points = {{-24.75, 601}, {-40, 601}, {-40, 500}, {-28, 500}, {-28, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation(
      Line(points = {{-26.25, 601}, {-40, 601}, {-40, 500}, {-20, 500}, {-20, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation(
      Line(points = {{-27.75, 601}, {-40, 601}, {-40, 500}, {-12, 500}, {-12, 482}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation(
      Line(points = {{-40, 417}, {-40, 402}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[1], gain.u) annotation(
      Line(points = {{81, -706}, {118, -706}}, color = {0, 0, 127}));
    connect(gain2.y, consumer_simple.u_sink) annotation(
      Line(points = {{762, 719}, {762, 672}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, Electrolyzer.u_control_boolean) annotation(
      Line(points = {{-565.6, 865.6}, {-542, 865.6}, {-542, 846}}, color = {255, 0, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe2.enthalpyPort_b1) annotation(
      Line(points = {{640, 660.5}, {620, 660.5}, {620, 619.8}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation(
      Line(points = {{781, 668}, {800, 668}, {800, 696}, {738, 696}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation(
      Line(points = {{781, 664}, {820, 664}, {820, 540}, {690, 540}, {690, 532}}, color = {0, 0, 127}));
    connect(Electrolyzer.u_T_setpoint_specification, constElectrolyzer_T_setpoint_specification.y) annotation(
      Line(points = {{-566, 792.6}, {-571.5, 792.6}, {-571.5, 792}, {-579, 792}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_value, CHP.u_control_value) annotation(
      Line(points = {{-484.6, 241.4}, {-474, 241.4}, {-474, 226}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_boolean, CHP.u_control_boolean) annotation(
      Line(points = {{-484.6, 244.6}, {-462, 244.6}, {-462, 226}}, color = {255, 0, 255}));
    connect(const.y, CHP.u_T_setpoint_specification) annotation(
      Line(points = {{-499, 174}, {-490.5, 174}, {-490.5, 172.6}, {-486, 172.6}}, color = {0, 0, 127}));
    connect(gainPV_500kW.y, busbar_4consumer.uProductionPV) annotation(
      Line(points = {{-597, -86}, {-126, -86}, {-126, -112}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_DemandHouses, gain_DemandPower_Houses.y) annotation(
      Line(points = {{-162, -157}, {-580, -157}, {-580, -156}, {-657, -156}}, color = {0, 0, 127}));
    connect(gain_DemandPower_Houses.u, combiTimeTable_DemandPower.y[1]) annotation(
      Line(points = {{-680, -156}, {-697, -156}}, color = {0, 0, 127}));
    connect(combiTimeTable_DemandEMob.y[1], gain_DemandPower_EMob.u) annotation(
      Line(points = {{-697, -186}, {-680, -186}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_EMob, gain_DemandPower_EMob.y) annotation(
      Line(points = {{-162, -172}, {-638, -172}, {-638, -186}, {-657, -186}}, color = {0, 0, 127}));
    connect(pVSystemTMY3.weaBus, weaDat.weaBus) annotation(
      Line(points = {{-718, -86}, {-718, -85}, {-940, -85}, {-940, 120}, {-960, 120}}, color = {255, 204, 51}, thickness = 0.5));
    connect(pVSystemTMY3.PVPowerW, gainPV_500kW.u) annotation(
      Line(points = {{-697, -86}, {-620, -86}}, color = {0, 0, 127}));
    connect(busbar_4consumer.y_PVProductionToBattery, batterySimple1.PCharge) annotation(
      Line(points = {{-93, -169}, {-93, -170}, {-58, -170}, {-58, -190}, {-9, -190}}, color = {0, 0, 127}));
    connect(busbar_4consumer.y_LoadToBattery, batterySimple1.PLoad) annotation(
      Line(points = {{-93, -160}, {44, -160}, {44, -190}, {17, -190}}, color = {0, 0, 127}));
    connect(product.y, integrator_cost_Spot.u) annotation(
      Line(points = {{181, -700}, {198, -700}}, color = {0, 0, 127}));
    connect(switch_GridLoad.u3, const5.y) annotation(
      Line(points = {{220, -154}, {212, -154}, {212, -176}, {203, -176}}, color = {0, 0, 127}));
    connect(switch_FeedIn_PV_500kW.u1, const5.y) annotation(
      Line(points = {{220, -196}, {220, -30}, {212, -30}, {212, -176}, {203, -176}}, color = {0, 0, 127}));
    connect(switch_GridLoad.u2, lessThreshold.y) annotation(
      Line(points = {{220, -146}, {172, -146}, {172, -176}, {163, -176}}, color = {255, 0, 255}));
    connect(switch_FeedIn_PV_500kW.u2, lessThreshold.y) annotation(
      Line(points = {{220, -204}, {172, -204}, {172, -176}, {163, -176}}, color = {255, 0, 255}));
    connect(batterySimple1.PGrid, switch_FeedIn_PV_500kW.u3) annotation(
      Line(points = {{18.04, -179.6}, {122, -179.6}, {122, -212}, {220, -212}}, color = {0, 0, 127}));
    connect(switch_GridLoad.u1, batterySimple1.PGrid) annotation(
      Line(points = {{220, -138}, {122, -138}, {122, -179.6}, {18.04, -179.6}}, color = {0, 0, 127}));
    connect(lessThreshold.u, batterySimple1.PGrid) annotation(
      Line(points = {{140, -176}, {129, -176}, {129, -179.6}, {18.04, -179.6}}, color = {0, 0, 127}));
    connect(gain_FeedIn_PV_500kW_CO2.y, add_CO2_FeedIn.u1) annotation(
      Line(points = {{-739, -860}, {-732, -860}, {-732, -874}, {-722, -874}}, color = {0, 0, 127}));
    connect(gain_FeedIn_CHP_CO2.y, add_CO2_FeedIn.u2) annotation(
      Line(points = {{-739, -900}, {-732, -900}, {-732, -886}, {-722, -886}}, color = {0, 0, 127}));
    connect(gain_Boiler_dotE_CO2.y, add_CO2_dotE.u1) annotation(
      Line(points = {{-739, -780}, {-730, -780}, {-730, -794}, {-722, -794}, {-722, -794}}, color = {0, 0, 127}));
    connect(gain_CHP_dotE_CO2.y, add_CO2_dotE.u2) annotation(
      Line(points = {{-739, -820}, {-730, -820}, {-730, -806}, {-722, -806}, {-722, -806}}, color = {0, 0, 127}));
    connect(gain_GridLoad_CO2.y, add_CO2_Power.u2) annotation(
      Line(points = {{-739, -940}, {-690, -940}, {-690, -906}, {-682, -906}, {-682, -906}}, color = {0, 0, 127}));
    connect(add_CO2_FeedIn.y, add_CO2_Power.u1) annotation(
      Line(points = {{-699, -880}, {-690, -880}, {-690, -894}, {-682, -894}, {-682, -894}}, color = {0, 0, 127}));
    connect(add_CO2_Power.y, add3_CO2.u2) annotation(
      Line(points = {{-659, -900}, {-622, -900}, {-622, -900}, {-622, -900}}, color = {0, 0, 127}));
    connect(add3_CO2.u1, add_CO2_dotE.y) annotation(
      Line(points = {{-622, -892}, {-640, -892}, {-640, -800}, {-699, -800}, {-699, -800}}, color = {0, 0, 127}));
    connect(add3_CO2.u3, gain_Electrolyzer_H2.y) annotation(
      Line(points = {{-622, -908}, {-640, -908}, {-640, -980}, {-739, -980}, {-739, -980}}, color = {0, 0, 127}));
    connect(y__Boiler_dotE, integrator__Boiler_dotE.u) annotation(
      Line(points = {{-840, -780}, {-802, -780}, {-802, -780}, {-802, -780}}, color = {0, 0, 127}));
    connect(integrator__Boiler_dotE.y, gain_Boiler_dotE_CO2.u) annotation(
      Line(points = {{-779, -780}, {-764, -780}, {-764, -780}, {-762, -780}}, color = {0, 0, 127}));
    connect(y__CHP_dotE, integrator__CHP_dotE.u) annotation(
      Line(points = {{-840, -820}, {-802, -820}, {-802, -820}, {-802, -820}}, color = {0, 0, 127}));
    connect(integrator__CHP_dotE.y, gain_CHP_dotE_CO2.u) annotation(
      Line(points = {{-779, -820}, {-762, -820}, {-762, -820}, {-762, -820}}, color = {0, 0, 127}));
    connect(y__FeedIn_PV_500kW, integrator__FeedIn_PV_500kW.u) annotation(
      Line(points = {{-840, -860}, {-804, -860}, {-804, -860}, {-802, -860}}, color = {0, 0, 127}));
    connect(integrator__FeedIn_PV_500kW.y, gain_FeedIn_PV_500kW_CO2.u) annotation(
      Line(points = {{-779, -860}, {-764, -860}, {-764, -860}, {-762, -860}}, color = {0, 0, 127}));
    connect(y__FeedIn_CHP, integrator__FeedIn_CHP.u) annotation(
      Line(points = {{-840, -900}, {-802, -900}, {-802, -900}, {-802, -900}}, color = {0, 0, 127}));
    connect(integrator__FeedIn_CHP.y, gain_FeedIn_CHP_CO2.u) annotation(
      Line(points = {{-779, -900}, {-762, -900}, {-762, -900}, {-762, -900}}, color = {0, 0, 127}));
    connect(y__GridLoad, integrator__GridLoad.u) annotation(
      Line(points = {{-840, -940}, {-804, -940}, {-804, -940}, {-802, -940}}, color = {0, 0, 127}));
    connect(integrator__GridLoad.y, gain_GridLoad_CO2.u) annotation(
      Line(points = {{-779, -940}, {-764, -940}, {-764, -940}, {-762, -940}}, color = {0, 0, 127}));
    connect(y__Electrolyzer_H2, integrator__Electrolyzer_H2.u) annotation(
      Line(points = {{-840, -980}, {-802, -980}, {-802, -980}, {-802, -980}}, color = {0, 0, 127}));
    connect(integrator__Electrolyzer_H2.y, gain_Electrolyzer_H2.u) annotation(
      Line(points = {{-779, -980}, {-762, -980}, {-762, -980}, {-762, -980}}, color = {0, 0, 127}));
    connect(y_Boiler_dotE, integrator_Boiler_dotE.u) annotation(
      Line(points = {{120, -300}, {156, -300}, {156, -300}, {158, -300}}, color = {0, 0, 127}));
    connect(integrator_Boiler_dotE.y, gain_Boiler_dotE_cost.u) annotation(
      Line(points = {{181, -300}, {198, -300}, {198, -300}, {198, -300}}, color = {0, 0, 127}));
    connect(y_CHP_dotE, integrator_CHP_dotE.u) annotation(
      Line(points = {{120, -340}, {158, -340}, {158, -340}, {158, -340}}, color = {0, 0, 127}));
    connect(integrator_CHP_dotE.y, gain_CHP_dotE_cost.u) annotation(
      Line(points = {{181, -340}, {198, -340}, {198, -340}, {198, -340}}, color = {0, 0, 127}));
    connect(product.u1, y_FeedIn_CHP) annotation(
      Line(points = {{158, -694}, {140, -694}, {140, -660}, {120, -660}}, color = {0, 0, 127}));
    connect(integrator_FeedIn_CHP.u, y_FeedIn_CHP) annotation(
      Line(points = {{158, -660}, {120, -660}}, color = {0, 0, 127}));
    connect(integrator_FeedIn_CHP.y, gain_FeedIn_CHP_cost.u) annotation(
      Line(points = {{181, -660}, {198, -660}}, color = {0, 0, 127}));
    connect(y_FeedIn_PV_500kW, integrator.u) annotation(
      Line(points = {{120, -620}, {158, -620}}, color = {0, 0, 127}));
    connect(integrator.y, gain_FeedIn_PV_500kW_cost.u) annotation(
      Line(points = {{181, -620}, {198, -620}}, color = {0, 0, 127}));
    connect(integrator_DemandPower_EMob.u, y_DemandPower_EMob) annotation(
      Line(points = {{158, -460}, {116, -460}, {116, -460}, {120, -460}}, color = {0, 0, 127}));
    connect(gain_DemandPower_EMob_cost.u, integrator_DemandPower_EMob.y) annotation(
      Line(points = {{198, -460}, {180, -460}, {180, -460}, {181, -460}}, color = {0, 0, 127}));
    connect(gain_DemandPower_Houses_cost.u, integrator_DemandPower_Houses.y) annotation(
      Line(points = {{198, -420}, {182, -420}, {182, -420}, {181, -420}}, color = {0, 0, 127}));
    connect(integrator_DemandPower_Houses.u, y_DemandPower_Houses) annotation(
      Line(points = {{158, -420}, {116, -420}, {116, -420}, {120, -420}}, color = {0, 0, 127}));
    connect(gain_DemandHeat_Houses_cost.u, integrator_DemandHeat_Houses.y) annotation(
      Line(points = {{198, -380}, {180, -380}, {180, -380}, {181, -380}}, color = {0, 0, 127}));
    connect(integrator_DemandHeat_Houses.u, y_DemandHeat_Houses) annotation(
      Line(points = {{158, -380}, {114, -380}, {114, -380}, {120, -380}}, color = {0, 0, 127}));
    connect(add_cost_dotE.u1, gain_Boiler_dotE_cost.y) annotation(
      Line(points = {{238, -314}, {230, -314}, {230, -300}, {221, -300}, {221, -300}}, color = {0, 0, 127}));
    connect(add_cost_dotE.u2, gain_CHP_dotE_cost.y) annotation(
      Line(points = {{238, -326}, {230, -326}, {230, -340}, {221, -340}, {221, -340}}, color = {0, 0, 127}));
    connect(gain_DemandPower_Houses_cost.y, add_cost_DemandPower.u1) annotation(
      Line(points = {{221, -420}, {230, -420}, {230, -434}, {238, -434}, {238, -434}}, color = {0, 0, 127}));
    connect(gain_DemandPower_EMob_cost.y, add_cost_DemandPower.u2) annotation(
      Line(points = {{221, -460}, {230, -460}, {230, -446}, {238, -446}, {238, -446}}, color = {0, 0, 127}));
    connect(add_cost_Advancement.u2, gain_FeedIn_CHP_cost.y) annotation(
      Line(points = {{238, -646}, {230, -646}, {230, -660}, {221, -660}}, color = {0, 0, 127}));
    connect(gain_FeedIn_PV_500kW_cost.y, add_cost_Advancement.u1) annotation(
      Line(points = {{221, -620}, {228, -620}, {228, -634}, {238, -634}}, color = {0, 0, 127}));
    connect(add_cost_FeedIn.u1, add_cost_Advancement.y) annotation(
      Line(points = {{278, -654}, {268, -654}, {268, -640}, {261, -640}}, color = {0, 0, 127}));
    connect(add_cost_FeedIn.u2, integrator_cost_Spot.y) annotation(
      Line(points = {{278, -666}, {268, -666}, {268, -700}, {221, -700}}, color = {0, 0, 127}));
    connect(gain_DemandHeat_Houses_cost.y, add_cost_Demand.u1) annotation(
      Line(points = {{221, -380}, {270, -380}, {270, -414}, {278, -414}, {278, -414}}, color = {0, 0, 127}));
    connect(add_cost_Demand.u2, add_cost_DemandPower.y) annotation(
      Line(points = {{278, -426}, {270, -426}, {270, -440}, {261, -440}, {261, -440}}, color = {0, 0, 127}));
    connect(add3_cost.u2, add_cost_Demand.y) annotation(
      Line(points = {{358, -420}, {302, -420}, {302, -420}, {301, -420}}, color = {0, 0, 127}));
    connect(add3_cost.u1, add_cost_dotE.y) annotation(
      Line(points = {{358, -412}, {320, -412}, {320, -320}, {261, -320}, {261, -320}}, color = {0, 0, 127}));
    connect(y_DirectConsumption_PV_500_kW, integrator_DirectConsumption_PV_500kW.u) annotation(
      Line(points = {{120, -540}, {158, -540}}, color = {0, 0, 127}));
    connect(y_DirectConsumption_CHP, integrator_DirectConsumption_CHP.u) annotation(
      Line(points = {{120, -580}, {158, -580}}, color = {0, 0, 127}));
    connect(integrator_DirectConsumption_PV_500kW.y, gain_DirectConsumption_PV_500kW_cost.u) annotation(
      Line(points = {{181, -540}, {198, -540}}, color = {0, 0, 127}));
    connect(integrator_DirectConsumption_CHP.y, gain_DirectConsumption_CHP_cost.u) annotation(
      Line(points = {{181, -580}, {198, -580}}, color = {0, 0, 127}));
    connect(gain_DirectConsumption_PV_500kW_cost.y, add_cost_DirectConsumption.u1) annotation(
      Line(points = {{221, -540}, {228, -540}, {228, -554}, {238, -554}}, color = {0, 0, 127}));
    connect(gain_DirectConsumption_CHP_cost.y, add_cost_DirectConsumption.u2) annotation(
      Line(points = {{221, -580}, {228, -580}, {228, -566}, {238, -566}}, color = {0, 0, 127}));
    connect(gain_GridLoad.u, switch_GridLoad.y) annotation(
      Line(points = {{258, -146}, {243, -146}}, color = {0, 0, 127}));
    connect(y_GridLoad, integrator_GridLoad.u) annotation(
      Line(points = {{120, -760}, {158, -760}, {158, -760}, {158, -760}}, color = {0, 0, 127}));
    connect(integrator_GridLoad.y, gain_GridLoad_cost.u) annotation(
      Line(points = {{181, -760}, {198, -760}, {198, -760}, {198, -760}}, color = {0, 0, 127}));
    connect(gain_GridLoad_cost.y, add3_cost_Power.u3) annotation(
      Line(points = {{221, -760}, {310, -760}, {310, -668}, {318, -668}, {318, -668}}, color = {0, 0, 127}));
    connect(add3_cost_Power.u2, add_cost_FeedIn.y) annotation(
      Line(points = {{318, -660}, {300, -660}, {300, -660}, {301, -660}}, color = {0, 0, 127}));
    connect(add_cost_DirectConsumption.y, add3_cost_Power.u1) annotation(
      Line(points = {{261, -560}, {310, -560}, {310, -652}, {318, -652}, {318, -652}}, color = {0, 0, 127}));
    connect(add3_cost_Power.y, add3_cost.u3) annotation(
      Line(points = {{341, -660}, {348, -660}, {348, -428}, {358, -428}, {358, -428}}, color = {0, 0, 127}));
    connect(switchElectrolyzer.y, greaterThresholdElectrolyzer.u) annotation(
      Line(points = {{-879, 892}, {-870, 892}, {-870, 920}, {-862, 920}}, color = {0, 0, 127}));
    connect(greaterThresholdElectrolyzer.y, controlBus_Electrolyzer.control_boolean) annotation(
      Line(points = {{-839, 920}, {-820, 920}, {-820, 892}}, color = {255, 0, 255}));
    connect(switchElectrolyzer.y, controlBus_Electrolyzer.control_value) annotation(
      Line(points = {{-879, 892}, {-820, 892}}, color = {0, 0, 127}));
    connect(pulseElectrolyzer.y, switchElectrolyzer.u1) annotation(
      Line(points = {{-959, 900}, {-902, 900}}, color = {0, 0, 127}));
    connect(booleanConstant.y, switchElectrolyzer.u2) annotation(
      Line(points = {{-919, 960}, {-912, 960}, {-912, 892}, {-902, 892}}, color = {255, 0, 255}));
    connect(const7.y, switchElectrolyzer.u3) annotation(
      Line(points = {{-929, 930}, {-920, 930}, {-920, 884}, {-902, 884}}, color = {0, 0, 127}));
    connect(greaterThresholdHeatPumpAir.y, controlBus_HeatPumpAir.control_boolean) annotation(
      Line(points = {{-839, 860}, {-820, 860}, {-820, 832}}, color = {255, 0, 255}));
    connect(switchHeatPumpAir.y, controlBus_HeatPumpAir.control_value) annotation(
      Line(points = {{-879, 832}, {-820, 832}}, color = {0, 0, 127}));
    connect(pulseHeatPumpAir.y, switchHeatPumpAir.u1) annotation(
      Line(points = {{-959, 840}, {-902, 840}}, color = {0, 0, 127}));
    connect(switchHeatPumpAir.u2, booleanConstant.y) annotation(
      Line(points = {{-902, 832}, {-912, 832}, {-912, 960}, {-919, 960}}, color = {255, 0, 255}));
    connect(switchHeatPumpAir.u3, const7.y) annotation(
      Line(points = {{-902, 824}, {-902, 823}, {-920, 823}, {-920, 930}, {-929, 930}}, color = {0, 0, 127}));
    connect(greaterThresholdHeatPumpGeo.y, controlBus_HeatPumpGeo.control_boolean) annotation(
      Line(points = {{-839, 800}, {-820, 800}, {-820, 772}}, color = {255, 0, 255}));
    connect(switchHeatPumpGeo.y, controlBus_HeatPumpGeo.control_value) annotation(
      Line(points = {{-879, 772}, {-820, 772}}, color = {0, 0, 127}));
    connect(pulseHeatPumpGeo.y, switchHeatPumpGeo.u1) annotation(
      Line(points = {{-959, 780}, {-902, 780}}, color = {0, 0, 127}));
    connect(switchHeatPumpGeo.u2, booleanConstant.y) annotation(
      Line(points = {{-902, 772}, {-912, 772}, {-912, 960}, {-919, 960}}, color = {255, 0, 255}));
    connect(switchHeatPumpGeo.u3, const7.y) annotation(
      Line(points = {{-902, 764}, {-902, 763}, {-920, 763}, {-920, 930}, {-929, 930}}, color = {0, 0, 127}));
    connect(switchCHP.u1, pulseCHP.y) annotation(
      Line(points = {{-902, 720}, {-959, 720}}, color = {0, 0, 127}));
    connect(switchCHP.u2, booleanConstant.y) annotation(
      Line(points = {{-902, 712}, {-912, 712}, {-912, 960}, {-919, 960}}, color = {255, 0, 255}));
    connect(const7.y, switchCHP.u3) annotation(
      Line(points = {{-929, 930}, {-920, 930}, {-920, 704}, {-902, 704}}, color = {0, 0, 127}));
    connect(switchCHP.y, controlBus_CHP.control_value) annotation(
      Line(points = {{-879, 712}, {-820, 712}}, color = {0, 0, 127}));
    connect(greaterThresholdCHP.y, controlBus_CHP.control_boolean) annotation(
      Line(points = {{-839, 740}, {-820, 740}, {-820, 712}}, color = {255, 0, 255}));
    connect(greaterThresholdCHP.u, switchCHP.y) annotation(
      Line(points = {{-862, 740}, {-870, 740}, {-870, 712}, {-879, 712}}, color = {0, 0, 127}));
    connect(greaterThreshold.y, controlBus_Boiler.control_boolean) annotation(
      Line(points = {{-839, 680}, {-820, 680}, {-820, 652}}, color = {255, 0, 255}));
    connect(switch1.y, controlBus_Boiler.control_value) annotation(
      Line(points = {{-877, 652}, {-820, 652}}, color = {0, 0, 127}));
    connect(pulseBoiler.y, switch1.u1) annotation(
      Line(points = {{-959, 660}, {-900, 660}}, color = {0, 0, 127}));
    connect(switch1.u2, booleanConstant.y) annotation(
      Line(points = {{-900, 652}, {-912, 652}, {-912, 960}, {-919, 960}}, color = {255, 0, 255}));
    connect(const7.y, switch1.u3) annotation(
      Line(points = {{-929, 930}, {-920, 930}, {-920, 644}, {-900, 644}}, color = {0, 0, 127}));
    connect(greaterThresholdHeatPumpAir.u, switchHeatPumpAir.y) annotation(
      Line(points = {{-862, 860}, {-868, 860}, {-868, 832}, {-879, 832}, {-879, 832}}, color = {0, 0, 127}));
    connect(greaterThresholdHeatPumpGeo.u, switchHeatPumpGeo.y) annotation(
      Line(points = {{-862, 800}, {-868, 800}, {-868, 772}, {-879, 772}, {-879, 772}}, color = {0, 0, 127}));
    connect(greaterThreshold.u, switch1.y) annotation(
      Line(points = {{-862, 680}, {-870, 680}, {-870, 652}, {-877, 652}, {-877, 652}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, Electrolyzer.u_control_value) annotation(
      Line(points = {{-565.6, 862.4}, {-554, 862.4}, {-554, 846}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_Electrolyzer) annotation(
      Line(points = {{-574, 864}, {-720, 864}, {-720, 892}, {-820, 892}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_HeatPumpAir) annotation(
      Line(points = {{-574, 684}, {-740, 684}, {-740, 832}, {-820, 832}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO2.y_control_value, HePu_Air.u_control_value) annotation(
      Line(points = {{-565.6, 682.4}, {-553.4, 682.4}, {-553.4, 666}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO2.y_control_boolean, HePu_Air.u_control_boolean) annotation(
      Line(points = {{-565.6, 685.6}, {-541.4, 685.6}, {-541.4, 666}}, color = {255, 0, 255}));
    connect(constHeatPumpAir_T_setpoint_specification.y, HePu_Air.u_T_setpoint_specification) annotation(
      Line(points = {{-579, 610}, {-568, 610}, {-568, 612}, {-567, 612}, {-567, 612.6}, {-566, 612.6}}, color = {0, 0, 127}));
    connect(constHeatPumpAir_mdot_amb.y, HePu_Air.u_dotm_source) annotation(
      Line(points = {{-639, 636}, {-568, 636}, {-568, 637.2}, {-566, 637.2}}, color = {0, 0, 127}));
    connect(HePu_Air.u_T_fluid_source, gain3.y) annotation(
      Line(points = {{-566, 654}, {-720, 654}, {-720, 221}}, color = {0, 0, 127}));
    connect(constHeatPumpGeo_T_setpoint_specification.y, HePu_Geo.u_T_setpoint_specification) annotation(
      Line(points = {{-579, 430}, {-566, 430}, {-566, 432.6}, {-566, 432.6}}, color = {0, 0, 127}));
    connect(constHeatPumpGeo_mdot_amb.y, HePu_Geo.u_dotm_source) annotation(
      Line(points = {{-639, 456}, {-568, 456}, {-568, 457.2}, {-566, 457.2}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO4.y_control_value, HePu_Geo.u_control_value) annotation(
      Line(points = {{-565.6, 502.4}, {-554, 502.4}, {-554, 486}, {-553.4, 486}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO4.y_control_boolean, HePu_Geo.u_control_boolean) annotation(
      Line(points = {{-565.6, 505.6}, {-542, 505.6}, {-542, 486}, {-541.4, 486}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO4.controlBus, controlBus_HeatPumpGeo) annotation(
      Line(points = {{-574, 504}, {-760, 504}, {-760, 772}, {-820, 772}}, color = {255, 204, 51}, thickness = 0.5));
    connect(Electrolyzer.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-530, 777}, {-530, 777}, {-530, 740}, {-440, 740}, {-440, 360}, {18, 360}, {18, 514.6}, {18, 514.6}}, color = {0, 85, 255}));
    connect(HePu_Air.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation(
      Line(points = {{-530, 597}, {-530, 597}, {-530, 560}, {-440, 560}, {-440, 360}, {18, 360}, {18, 520}, {18, 520}}, color = {0, 85, 255}));
    connect(HePu_Geo.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[3]) annotation(
      Line(points = {{-530, 417}, {-530, 417}, {-530, 360}, {18, 360}, {18, 525.4}, {18, 525.4}}, color = {0, 85, 255}));
    connect(Electrolyzer.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-530, 843}, {-530, 843}, {-530, 880}, {18, 880}, {18, 676.6}, {18, 676.6}}, color = {176, 0, 0}));
    connect(HePu_Air.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation(
      Line(points = {{-529.4, 663}, {-529.4, 663}, {-529.4, 700}, {-460, 700}, {-460, 880}, {18, 880}, {18, 682}, {18, 682}}, color = {176, 0, 0}));
    connect(HePu_Geo.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[3]) annotation(
      Line(points = {{-529.4, 483}, {-529.4, 483}, {-529.4, 520}, {-460, 520}, {-460, 880}, {18, 880}, {18, 687.4}, {18, 687.4}}, color = {176, 0, 0}));
    connect(temperature_HeatStorage_unload.enthalpyPort_a, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{59.2, 719.9}, {42, 719.9}, {42, 682}, {42, 682}}, color = {176, 0, 0}));
    connect(temperature_HeatStorage_unload.T, Electrolyzer.u_T_setpoint) annotation(
      Line(points = {{69, 731}, {68, 731}, {68, 792}, {-494, 792}, {-494, 792.6}}, color = {0, 0, 127}));
    connect(temperature_HeatStorage_unload.T, HePu_Air.u_T_setpoint) annotation(
      Line(points = {{69, 731}, {68, 731}, {68, 792}, {-420, 792}, {-420, 612}, {-494, 612}, {-494, 612.6}}, color = {0, 0, 127}));
    connect(temperature_HeatStorage_unload.T, HePu_Geo.u_T_setpoint) annotation(
      Line(points = {{69, 731}, {68, 731}, {68, 792}, {-420, 792}, {-420, 432}, {-494, 432}, {-494, 432.6}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF.enthalpyPort_b1, HeatExchanger.enthalpyPort_dHWIn) annotation(
      Line(points = {{179.8, 340}, {222.04, 340}, {222.04, 279.582}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF.enthalpyPort_a1, temperature_HeatStorage_unload.enthalpyPort_b) annotation(
      Line(points = {{160.2, 340}, {120, 340}, {120, 719.9}, {77, 719.9}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatGrid_RF.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{399.8, 300}, {600, 300}, {600, 560}, {610, 560}}, color = {0, 85, 255}));
    connect(dynamicPipe_HeatGrid_RF.enthalpyPort_b1, dynamicPipe_HeatStorage_unload_RF.enthalpyPort_a1) annotation(
      Line(points = {{380.2, 300}, {179.8, 300}}, color = {0, 85, 255}));
    connect(dynamicPipe_HeatStorage_unload_RF.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{160.2, 300}, {42, 300}, {42, 520}, {42, 520}}, color = {0, 85, 255}));
    connect(dynamicPipe_AdditionalHeating_FF.enthalpyPort_b1, HeatExchanger.enthalpyPort_heaterIn) annotation(
      Line(points = {{179.8, 200}, {266, 200}, {266, 243.201}, {265.04, 243.201}}, color = {176, 0, 0}));
    connect(manifold1.enthalpyPort_b, dynamicPipe_AdditionalHeating_FF.enthalpyPort_a1) annotation(
      Line(points = {{140, 200}, {158, 200}, {158, 200}, {160.2, 200}, {160.2, 200}}, color = {176, 0, 0}));
    connect(dynamicPipe_AdditionalHeating_RF.enthalpyPort_a1, HeatExchanger.enthalpyPort_heaterOut) annotation(
      Line(points = {{179.8, 120}, {222, 120}, {222, 242.783}, {222.04, 242.783}}, color = {0, 85, 255}));
    connect(dynamicPipe_AdditionalHeating_RF.enthalpyPort_b1, splitter.enthalpyPort_a) annotation(
      Line(points = {{160.2, 120}, {140, 120}, {140, 120}, {140, 120}}, color = {0, 85, 255}));
    connect(temperature_HeatGrid_FF.enthalpyPort_b, dynamicPipe_HeatGrid_FF.enthalpyPort_a1) annotation(
      Line(points = {{319, 340.1}, {350.2, 340.1}, {350.2, 340}, {380.2, 340}}, color = {176, 0, 0}));
    connect(temperature_HeatGrid_FF.enthalpyPort_a, HeatExchanger.enthalpyPort_dHWOut) annotation(
      Line(points = {{301.2, 340.1}, {264, 340.1}, {264, 280}, {265.04, 280}}, color = {176, 0, 0}));
    connect(manifold1.enthalpyPort_a[1], CHP.enthalpyPort_b) annotation(
      Line(points = {{120, 199.5}, {-140, 199.5}, {-140, 260}, {-450, 260}, {-450, 223}, {-450, 223}}, color = {176, 0, 0}));
    connect(splitter.enthalpyPort_b[1], CHP.enthalpyPort_a) annotation(
      Line(points = {{120, 119.5}, {-450, 119.5}, {-450, 157}, {-450, 157}}, color = {0, 85, 255}));
    connect(bus2SOBoolean_SO3.y_control_value, Boiler.u_control_value) annotation(
      Line(points = {{-484.6, 81.4}, {-476, 81.4}, {-476, 66}, {-474, 66}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_boolean, Boiler.u_control_boolean) annotation(
      Line(points = {{-484.6, 84.6}, {-462, 84.6}, {-462, 66}, {-462, 66}}, color = {255, 0, 255}));
    connect(const2.y, Boiler.u_T_setpoint_specification) annotation(
      Line(points = {{-499, 10}, {-488, 10}, {-488, 12.6}, {-486, 12.6}}, color = {0, 0, 127}));
    connect(Boiler.enthalpyPort_b, manifold1.enthalpyPort_a[2]) annotation(
      Line(points = {{-450, 63}, {-450, 63}, {-450, 100}, {-140, 100}, {-140, 200}, {120, 200}, {120, 200.5}}, color = {176, 0, 0}));
    connect(splitter.enthalpyPort_b[2], Boiler.enthalpyPort_a) annotation(
      Line(points = {{120, 120.5}, {-120, 120.5}, {-120, -40}, {-450, -40}, {-450, -3}, {-450, -3}}, color = {0, 85, 255}));
    connect(bus2SOBoolean_SO3.controlBus, controlBus_Boiler) annotation(
      Line(points = {{-493, 83}, {-800, 83}, {-800, 652}, {-820, 652}, {-820, 652}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO.controlBus, controlBus_CHP) annotation(
      Line(points = {{-493, 243}, {-780, 243}, {-780, 712}, {-820, 712}, {-820, 712}}, color = {255, 204, 51}, thickness = 0.5));
    connect(CHP.u_T_setpoint, temperature_HeatGrid_FF.T) annotation(
      Line(points = {{-414, 172.6}, {310, 172.6}, {310, 329}, {311, 329}}, color = {0, 0, 127}));
    connect(Boiler.u_T_setpoint, temperature_HeatGrid_FF.T) annotation(
      Line(points = {{-414, 12.6}, {310, 12.6}, {310, 329}, {311, 329}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatGrid_FF.enthalpyPort_b1, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{399.8, 340}, {560, 340}, {560, 659.5}, {640, 659.5}}, color = {176, 0, 0}));
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation(
      Line(points = {{166, 662}, {66, 662}, {66, 665.8}, {66, 665.8}}, color = {191, 0, 0}));
    connect(busbar_4consumer.u_ProductionCHP, CHP.y_P) annotation(
      Line(points = {{-144, -112}, {-144, -112}, {-144, 140}, {-438, 140}, {-438, 157}, {-438, 157}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_DemandElectrolyser, Electrolyzer.y_P) annotation(
      Line(points = {{-162, -124}, {-180, -124}, {-180, 760}, {-518, 760}, {-518, 777}, {-518, 777}}, color = {0, 0, 127}));
    connect(add_P_HeatPumps.u2, HePu_Geo.y_P) annotation(
      Line(points = {{-472, 384}, {-518, 384}, {-518, 417}, {-518, 417}}, color = {0, 0, 127}));
    connect(add_P_HeatPumps.u1, HePu_Air.y_P) annotation(
      Line(points = {{-472, 396}, {-480, 396}, {-480, 580}, {-518, 580}, {-518, 597}, {-518, 597}}, color = {0, 0, 127}));
    connect(add_P_HeatPumps.y, busbar_4consumer.u_DemandHeatPump) annotation(
      Line(points = {{-449, 390}, {-200, 390}, {-200, -140}, {-162, -140}, {-162, -139}}, color = {0, 0, 127}));
    connect(HePu_Geo.u_T_fluid_source, gain3.y) annotation(
      Line(points = {{-566, 474}, {-720, 474}, {-720, 221}, {-720, 221}}, color = {0, 0, 127}));
    connect(prescribedTemperature.port, dynamicPipe_HeatGrid_RF.heatPort_outside) annotation(
      Line(points = {{360, 320}, {398, 320}, {398, 305.2}, {398.8, 305.2}}, color = {191, 0, 0}));
    connect(prescribedTemperature.port, dynamicPipe_HeatGrid_FF.heatPort_outside) annotation(
      Line(points = {{360, 320}, {382, 320}, {382, 334.8}, {381.2, 334.8}}, color = {191, 0, 0}));
    connect(prescribedTemperature.T, sineGeo_T_amb.y) annotation(
      Line(points = {{338, 320}, {-940, 320}, {-940, 160}, {-959, 160}, {-959, 160}}, color = {0, 0, 127}));
    connect(gain1.y, gain2.u) annotation(
      Line(points = {{762, 759}, {762, 759}, {762, 742}, {762, 742}}, color = {0, 0, 127}));
    connect(gain_DemandHeat_Houses.y, gain1.u) annotation(
      Line(points = {{762, 799}, {762, 799}, {762, 782}, {762, 782}}, color = {0, 0, 127}));
    connect(weaDat.weaBus, WetterBus) annotation(
      Line(points = {{-960, 120}, {-720, 120}, {-720, 138}, {-720, 138}}, color = {255, 204, 51}, thickness = 0.5));
    connect(gain3.u, WetterBus.TWetBul) annotation(
      Line(points = {{-720, 198}, {-720, 198}, {-720, 138}, {-720, 138}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}}, initialScale = 0.1), graphics = {Line(origin = {688, 520}, points = {{0, 0}})}),
      Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      experiment(StopTime = 315360, Interval = 3600, Tolerance = 1e-06, StartTime = 0));
  end V008_Quarree100;

  model V007_Quarree100
    extends Modelica.Icons.Example;
    parameter String Pfad = "Z:/owncloud/Consolinno/Projekte/Quarree100_Consolinno/Simulation_Modelica/";
    parameter String inputFileNameWeatherData = Pfad + "TRY2015_541957091051_Jahr.mos";
    parameter String inputFileNameCHP_P = Pfad + "Fahrplan_optCHP_P.txt";
    parameter String inputFileNameCHP_OP = Pfad + "Fahrplan_optCHP_OP.txt";
    parameter String inputFileNameElectrolyser_P = Pfad + "Fahrplan_optElectrolyser_P.txt";
    parameter String inputFileNameElectrolyser_OP = Pfad + "Fahrplan_optElectrolyser_OP.txt";
    parameter String inputFileNameBoiler = Pfad + "Fahrplan_optBoiler.txt";
    parameter String inputFileNameHeatPump = Pfad + "Fahrplan_optHeatPump.txt";
    parameter String inputFileNameHeatSword = Pfad + "Fahrplan_optHeatSword.txt";
    parameter String inputFileNameBat = Pfad + "Fahrplan_optBat.txt";
    parameter String inputFileNameDemandThermal = Pfad + "Waermebedarf_normiert.txt";
    parameter String inputFileNameDemandPower = Pfad + "Strombedarf_normiert.txt";
    parameter String inputFileNameEMob = Pfad + "EMobilitaet_normiert.txt";
    parameter String inputFileNameH2Mob = Pfad + "H2Mobilitaet_normiert.txt";
    parameter String inputFileNameSpot = Pfad + "SpotPreis.txt";
    Modelica.Blocks.Sources.Constant const1(k = 60 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-200, 624}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 7), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 3.2, dTank = 20, sIns = 0.2, lambdaIns = 0.032), load_cycles = [5, 1; 7, 4], n = 7, n_load_cycles = 2, n_unload_cycles = 1, unload_cycles = [1, 7], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {-3, 611}, extent = {{-25, -27}, {25, 27}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(
      Placement(visible = true, transformation(origin = {-714, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP annotation(
      Placement(visible = true, transformation(origin = {-594, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {40, 632}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
      Placement(visible = true, transformation(origin = {-257, 609}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Electrolyzer annotation(
      Placement(visible = true, transformation(origin = {-604, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_HeatPump annotation(
      Placement(visible = true, transformation(origin = {-614, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseHeatPump(amplitude = 0, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt Electrolyzer(T0 = 343.15, T_Out = 343.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation(
      Placement(visible = true, transformation(origin = {-160, 630}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
      Placement(visible = true, transformation(origin = {-177, 649}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(visible = true, transformation(origin = {650, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(visible = true, transformation(origin = {620, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation(
      Placement(visible = true, transformation(origin = {690, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {730, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation(
      Placement(visible = true, transformation(origin = {130, -706}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {170, -700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_cost_Spot annotation(
      Placement(visible = true, transformation(origin = {210, -700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {726, 696}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 40) annotation(
      Placement(visible = true, transformation(origin = {690, 730}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation(
      Placement(visible = true, transformation(origin = {700, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation(
      Placement(visible = true, transformation(origin = {770, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {34, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe1(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {36, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {620, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain_DemandHeat_Houses(k = 5177304.074) annotation(
      Placement(visible = true, transformation(origin = {762, 784}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = inputFileNameDemandThermal, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {714, 826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31 annotation(
      Placement(visible = true, transformation(origin = {-60, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation(
      Placement(visible = true, transformation(origin = {-20, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation(
      Placement(visible = true, transformation(origin = {-40, 448}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation(
      Placement(visible = true, transformation(origin = {-40, 410}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = inputFileNameSpot, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {70, -706}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {762, 726}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureCHP annotation(
      Placement(visible = true, transformation(origin = {198, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation(
      Placement(visible = true, transformation(origin = {162, 630}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt_through CHP(capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238, uHigh = 7, uLow = -3) annotation(
      Placement(visible = true, transformation(origin = {180, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 75 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {140, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureBoiler annotation(
      Placement(visible = true, transformation(origin = {460, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const2(k = 73 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {400, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_Boiler_opt_through Boiler(Q_nom = 2000000, uHigh = 2, uLow = 0) annotation(
      Placement(visible = true, transformation(origin = {440, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO3 annotation(
      Placement(visible = true, transformation(origin = {424, 628}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseBoiler(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Boiler annotation(
      Placement(visible = true, transformation(origin = {-584, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_HePu_opt HePu(Scale_Factor = 56, T_Out = 323.15) annotation(
      Placement(visible = true, transformation(origin = {-240, 590}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const4(k = 60 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-280, 570}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const6(k = 100) annotation(
      Placement(visible = true, transformation(origin = {-340, 580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = inputFileNameWeatherData) annotation(
      Placement(visible = true, transformation(origin = {-770, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain3(k = 1.01) annotation(
      Placement(visible = true, transformation(origin = {-360, 368}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gainPV_500kW(k = 50) annotation(
      Placement(visible = true, transformation(origin = {-590, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.busbar_4consumer busbar_4consumer annotation(
      Placement(visible = true, transformation(origin = {-108, 148}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandPower(fileName = inputFileNameDemandPower, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-690, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_Houses(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-650, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandEMob(fileName = inputFileNameEMob, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-690, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_EMob(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-650, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.Electrical.PVSystem.PVSystemTMY3 pVSystemTMY3(MaxOutputPower = 15000, NumberOfPanels = 300, data = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()) annotation(
      Placement(visible = true, transformation(origin = {-690, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    BuildingSystems.Technologies.ElectricalStorages.BatterySimple batterySimple1(SOC_start = 0, batteryData = BuildingSystems.Technologies.ElectricalStorages.Data.LithiumIon.LithiumIonAquion(), nBat = 10) annotation(
      Placement(visible = true, transformation(origin = {22, 106}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__CHP_dotE = CHP.y_dotE annotation(
      Placement(visible = true, transformation(origin = {-840, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__Boiler_dotE = Boiler.y_dotE annotation(
      Placement(visible = true, transformation(origin = {-840, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.LessThreshold lessThreshold annotation(
      Placement(visible = true, transformation(origin = {170, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch_GridLoad annotation(
      Placement(visible = true, transformation(origin = {250, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch_FeedIn_PV_500kW annotation(
      Placement(visible = true, transformation(origin = {250, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const5(k = 0) annotation(
      Placement(visible = true, transformation(origin = {210, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__FeedIn_PV_500kW = switch_FeedIn_PV_500kW.y annotation(
      Placement(visible = true, transformation(origin = {-840, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__FeedIn_CHP = busbar_4consumer.y_FeedInCHP annotation(
      Placement(visible = true, transformation(origin = {-840, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__GridLoad = gain_GridLoad.y annotation(
      Placement(visible = true, transformation(origin = {-840, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__GridLoad annotation(
      Placement(visible = true, transformation(origin = {-790, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__FeedIn_CHP annotation(
      Placement(visible = true, transformation(origin = {-790, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__FeedIn_PV_500kW annotation(
      Placement(visible = true, transformation(origin = {-790, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__CHP_dotE annotation(
      Placement(visible = true, transformation(origin = {-790, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__Boiler_dotE annotation(
      Placement(visible = true, transformation(origin = {-790, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__Electrolyzer_H2 = Electrolyzer.y_dotE annotation(
      Placement(visible = true, transformation(origin = {-840, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__Electrolyzer_H2 annotation(
      Placement(visible = true, transformation(origin = {-790, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_Boiler_dotE_CO2(k = 0.2 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_CHP_dotE_CO2(k = 0.2 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_PV_500kW_CO2(k = -0.474 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_CHP_CO2(k = -0.474 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_GridLoad_CO2(k = 0.474 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_Electrolyzer_H2(k = 0 / 3600 / 1000) annotation(
      Placement(visible = true, transformation(origin = {-750, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_CO2_dotE annotation(
      Placement(visible = true, transformation(origin = {-710, -800}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_CO2_FeedIn annotation(
      Placement(visible = true, transformation(origin = {-710, -880}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_CO2_Power annotation(
      Placement(visible = true, transformation(origin = {-670, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_CO2 annotation(
      Placement(visible = true, transformation(origin = {-610, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_FeedIn_PV_500kW = switch_FeedIn_PV_500kW.y annotation(
      Placement(visible = true, transformation(origin = {120, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {170, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DemandPower_EMob annotation(
      Placement(visible = true, transformation(origin = {170, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandPower_EMob = gain_DemandPower_EMob.y annotation(
      Placement(visible = true, transformation(origin = {120, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandPower_Houses = gain_DemandPower_Houses.y annotation(
      Placement(visible = true, transformation(origin = {120, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DemandPower_Houses annotation(
      Placement(visible = true, transformation(origin = {170, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_Houses_cost(k = -0.25 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_EMob_cost(k = -0.20 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_PV_500kW_cost(k = -0.0855 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandHeat_Houses_cost(k = -0.12 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DemandHeat_Houses annotation(
      Placement(visible = true, transformation(origin = {170, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandHeat_Houses = gain_DemandHeat_Houses.y annotation(
      Placement(visible = true, transformation(origin = {120, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_CHP_dotE = CHP.y_dotE annotation(
      Placement(visible = true, transformation(origin = {120, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_CHP_dotE annotation(
      Placement(visible = true, transformation(origin = {170, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_CHP_dotE_cost(k = (0.04 + 0.2 * 0.019) / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_Boiler_dotE_cost(k = (0.04 + 0.2 * 0.019) / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_Boiler_dotE annotation(
      Placement(visible = true, transformation(origin = {170, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_Boiler_dotE = Boiler.y_dotE annotation(
      Placement(visible = true, transformation(origin = {120, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_FeedIn_CHP = busbar_4consumer.y_FeedInCHP annotation(
      Placement(visible = true, transformation(origin = {120, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_FeedIn_CHP annotation(
      Placement(visible = true, transformation(origin = {170, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_CHP_cost(k = -0.0528 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_dotE annotation(
      Placement(visible = true, transformation(origin = {250, -320}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_DemandPower annotation(
      Placement(visible = true, transformation(origin = {250, -440}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_Advancement annotation(
      Placement(visible = true, transformation(origin = {250, -640}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_FeedIn annotation(
      Placement(visible = true, transformation(origin = {290, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_Demand annotation(
      Placement(visible = true, transformation(origin = {290, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_cost annotation(
      Placement(visible = true, transformation(origin = {370, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption_PV_500_kW = busbar_4consumer.y_DirectConsumptionPV annotation(
      Placement(visible = true, transformation(origin = {120, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DirectConsumption_PV_500kW annotation(
      Placement(visible = true, transformation(origin = {170, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DirectConsumption_PV_500kW_cost(k = 0.06756 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption_CHP = busbar_4consumer.y_DirectConsumptionCHP annotation(
      Placement(visible = true, transformation(origin = {120, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DirectConsumption_CHP annotation(
      Placement(visible = true, transformation(origin = {170, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DirectConsumption_CHP_cost(k = 0.06756 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_DirectConsumption annotation(
      Placement(visible = true, transformation(origin = {250, -560}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_GridLoad(k = -1) annotation(
      Placement(visible = true, transformation(origin = {288, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_GridLoad = gain_GridLoad.y annotation(
      Placement(visible = true, transformation(origin = {120, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_GridLoad annotation(
      Placement(visible = true, transformation(origin = {170, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_GridLoad_cost(k = 0.30 / 1000 / 3600) annotation(
      Placement(visible = true, transformation(origin = {210, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_cost_Power annotation(
      Placement(visible = true, transformation(origin = {330, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(pulseCHP.y, controlBus_CHP.control_value) annotation(
      Line(points = {{-703, 820}, {-594, 820}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_CHP.control_boolean) annotation(
      Line(points = {{-703, 900}, {-594, 900}, {-594, 820}}, color = {255, 0, 255}));
    connect(pulseElectrolyzer.y, controlBus_Electrolyzer.control_value) annotation(
      Line(points = {{-703, 780}, {-604, 780}}, color = {0, 0, 127}));
    connect(pulseHeatPump.y, controlBus_HeatPump.control_value) annotation(
      Line(points = {{-703, 740}, {-614, 740}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_Electrolyzer.control_boolean) annotation(
      Line(points = {{-703, 900}, {-604, 900}, {-604, 780}}, color = {255, 0, 255}));
    connect(booleanConstant.y, controlBus_HeatPump.control_boolean) annotation(
      Line(points = {{-703, 900}, {-614, 900}, {-614, 740}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_Electrolyzer) annotation(
      Line(points = {{-180, 649}, {-200, 649}, {-200, 779.5}, {-604, 779.5}, {-604, 780}}, color = {255, 204, 51}, thickness = 0.5));
    connect(const3.y, PID.u_s) annotation(
      Line(points = {{719, 520}, {702, 520}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation(
      Line(points = {{679, 520}, {620, 520}, {620, 551}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation(
      Line(points = {{141, -706}, {158, -706}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation(
      Line(points = {{701, 730}, {726, 730}, {726, 708}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation(
      Line(points = {{660, 660}, {690, 660}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation(
      Line(points = {{715, 696}, {700, 696}, {700, 668}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{24, 660}, {2, 660}, {2, 638}}, color = {176, 0, 0}));
    connect(dynamicPipe1.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{26, 560}, {2, 560}, {2, 584}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{620, 600}, {620, 570}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation(
      Line(points = {{781, 660}, {802, 660}, {802, 560}, {630, 560}}, color = {176, 0, 0}));
    connect(combiTimeTable_DemandHeat.y[2], gain_DemandHeat_Houses.u) annotation(
      Line(points = {{725, 826}, {762, 826}, {762, 796}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation(
      Line(points = {{-60, 479}, {-60, 468}, {-48, 468}, {-48, 460}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation(
      Line(points = {{-20, 479}, {-20, 435}, {-32, 435}, {-32, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation(
      Line(points = {{-25.5, 611}, {-40, 611}, {-40, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation(
      Line(points = {{-25.5, 611}, {-40, 611}, {-40, 520}, {-68, 520}, {-68, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation(
      Line(points = {{-25.5, 611}, {-40, 611}, {-40, 520}, {-60, 520}, {-60, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation(
      Line(points = {{-25.5, 611}, {-40, 611}, {-40, 520}, {-52, 520}, {-52, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation(
      Line(points = {{-25.5, 611}, {-40, 611}, {-40, 520}, {-28, 520}, {-28, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation(
      Line(points = {{-25.5, 611}, {-40, 611}, {-40, 520}, {-20, 520}, {-20, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation(
      Line(points = {{-25.5, 611}, {-40, 611}, {-40, 520}, {-12, 520}, {-12, 502}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation(
      Line(points = {{-40, 437}, {-40, 422}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[2], gain.u) annotation(
      Line(points = {{81, -706}, {118, -706}}, color = {0, 0, 127}));
    connect(gain_DemandHeat_Houses.y, gain2.u) annotation(
      Line(points = {{762, 773}, {762, 738}}, color = {0, 0, 127}));
    connect(gain2.y, consumer_simple.u_sink) annotation(
      Line(points = {{762, 715}, {762, 672}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, Electrolyzer.u_control_value) annotation(
      Line(points = {{-174, 648}, {-168, 648}, {-168, 642}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, Electrolyzer.u_control_boolean) annotation(
      Line(points = {{-174, 650}, {-164, 650}, {-164, 642}}, color = {255, 0, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe2.enthalpyPort_b1) annotation(
      Line(points = {{640, 660}, {620, 660}, {620, 620}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation(
      Line(points = {{781, 668}, {800, 668}, {800, 696}, {738, 696}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation(
      Line(points = {{781, 664}, {820, 664}, {820, 540}, {690, 540}, {690, 532}}, color = {0, 0, 127}));
    connect(dynamicPipe1.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{46, 560}, {610, 560}}, color = {176, 0, 0}));
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation(
      Line(points = {{30, 632}, {20, 632}, {20, 633}, {12, 633}}, color = {191, 0, 0}));
    connect(Electrolyzer.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation(
      Line(points = {{-160, 641}, {-160, 660}, {-8, 660}, {-8, 638}}, color = {176, 0, 0}));
    connect(Electrolyzer.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-172, 624}, {-189, 624}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_value, CHP.u_control_value) annotation(
      Line(points = {{166, 628}, {172, 628}, {172, 622}, {172, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_boolean, CHP.u_control_boolean) annotation(
      Line(points = {{166, 632}, {176, 632}, {176, 622}, {176, 622}}, color = {255, 0, 255}));
    connect(dynamicPipe.enthalpyPort_b1, CHP.enthalpyPort_a) annotation(
      Line(points = {{44, 660}, {120, 660}, {120, 580}, {180, 580}, {180, 598}, {180, 598}}, color = {176, 0, 0}));
    connect(temperatureCHP.enthalpyPort_a, CHP.enthalpyPort_b) annotation(
      Line(points = {{189, 660}, {180, 660}, {180, 622}}, color = {176, 0, 0}));
    connect(CHP.u_T_setpoint, temperatureCHP.T) annotation(
      Line(points = {{192, 604}, {199, 604}, {199, 649}}, color = {0, 0, 127}));
    connect(const.y, CHP.u_T_setpoint_specification) annotation(
      Line(points = {{151, 604}, {168, 604}}, color = {0, 0, 127}));
    connect(temperatureBoiler.enthalpyPort_b, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{469, 660}, {640, 660}}, color = {176, 0, 0}));
    connect(const2.y, Boiler.u_T_setpoint_specification) annotation(
      Line(points = {{412, 604}, {426, 604}, {426, 604}, {428, 604}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_value, Boiler.u_control_value) annotation(
      Line(points = {{428, 626}, {432, 626}, {432, 622}, {432, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_boolean, Boiler.u_control_boolean) annotation(
      Line(points = {{428, 630}, {436, 630}, {436, 622}, {436, 622}}, color = {255, 0, 255}));
    connect(temperatureBoiler.enthalpyPort_a, Boiler.enthalpyPort_b) annotation(
      Line(points = {{451, 660}, {440, 660}, {440, 622}}, color = {176, 0, 0}));
    connect(Boiler.u_T_setpoint, temperatureBoiler.T) annotation(
      Line(points = {{452, 604}, {461, 604}, {461, 649}}, color = {0, 0, 127}));
    connect(temperatureCHP.enthalpyPort_b, Boiler.enthalpyPort_a) annotation(
      Line(points = {{207, 660}, {380, 660}, {380, 580}, {440, 580}, {440, 598}}, color = {176, 0, 0}));
    connect(booleanConstant.y, controlBus_Boiler.control_boolean) annotation(
      Line(points = {{-703, 900}, {-584, 900}, {-584, 860}}, color = {255, 0, 255}));
    connect(pulseBoiler.y, controlBus_Boiler.control_value) annotation(
      Line(points = {{-703, 860}, {-584, 860}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.controlBus, controlBus_CHP) annotation(
      Line(points = {{160, 630}, {140, 630}, {140, 820}, {-594, 820}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO3.controlBus, controlBus_Boiler) annotation(
      Line(points = {{422, 628}, {400, 628}, {400, 860}, {-584, 860}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_HeatPump) annotation(
      Line(points = {{-260, 609}, {-279, 609}, {-279, 740}, {-614, 740}}, color = {255, 204, 51}, thickness = 0.5));
    connect(Electrolyzer.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation(
      Line(points = {{-160, 620}, {-160, 560}, {-8, 560}, {-8, 584}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_value, HePu.u_control_value) annotation(
      Line(points = {{-254, 608}, {-248, 608}, {-248, 602}, {-248, 602}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO2.y_control_boolean, HePu.u_control_boolean) annotation(
      Line(points = {{-254, 610}, {-244, 610}, {-244, 602}, {-244, 602}}, color = {255, 0, 255}));
    connect(HePu.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-240, 578}, {-240, 540}, {-8, 540}, {-8, 584}}, color = {176, 0, 0}));
    connect(HePu.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-240, 602}, {-240, 680}, {-8, 680}, {-8, 638}}, color = {176, 0, 0}));
    connect(gain_HeatStorage_TempMean.y, Electrolyzer.u_T_setpoint) annotation(
      Line(points = {{-40, 400}, {-40, 380}, {-80, 380}, {-80, 550}, {-140, 550}, {-140, 624}, {-148, 624}}, color = {0, 0, 127}));
    connect(gain_HeatStorage_TempMean.y, HePu.u_T_setpoint) annotation(
      Line(points = {{-40, 400}, {-40, 380}, {-80, 380}, {-80, 550}, {-220, 550}, {-220, 584}, {-228, 584}}, color = {0, 0, 127}));
    connect(const4.y, HePu.u_T_setpoint_specification) annotation(
      Line(points = {{-268, 570}, {-260, 570}, {-260, 584}, {-252, 584}, {-252, 584}}, color = {0, 0, 127}));
    connect(const6.y, HePu.u_dotm_source) annotation(
      Line(points = {{-328, 580}, {-320, 580}, {-320, 592}, {-252, 592}, {-252, 592}}, color = {0, 0, 127}));
    connect(weaDat.weaBus.TWetBul, gain3.u) annotation(
      Line(points = {{-760, 330}, {-360, 330}, {-360, 356}}, color = {0, 0, 127}));
    connect(HePu.u_T_fluid_source, gain3.y) annotation(
      Line(points = {{-252, 598}, {-360, 598}, {-360, 379}}, color = {0, 0, 127}));
    connect(gainPV_500kW.y, busbar_4consumer.uProductionPV) annotation(
      Line(points = {{-578, 210}, {-108, 210}, {-108, 184}}, color = {0, 0, 127}));
    connect(CHP.y_P, busbar_4consumer.u_ProductionCHP) annotation(
      Line(points = {{184, 600}, {184, 220}, {-126, 220}, {-126, 184}}, color = {0, 0, 127}));
    connect(Electrolyzer.y_P, busbar_4consumer.u_DemandElectrolyser) annotation(
      Line(points = {{-156, 620}, {-156, 172}, {-144, 172}}, color = {0, 0, 127}));
    connect(HePu.y_P, busbar_4consumer.u_DemandHeatPump) annotation(
      Line(points = {{-236, 580}, {-236, 161}, {-168, 161}, {-168, 160}, {-144, 160}, {-144, 157}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_DemandHouses, gain_DemandPower_Houses.y) annotation(
      Line(points = {{-144, 139}, {-562, 139}, {-562, 140}, {-638, 140}}, color = {0, 0, 127}));
    connect(gain_DemandPower_Houses.u, combiTimeTable_DemandPower.y[2]) annotation(
      Line(points = {{-662, 140}, {-680, 140}, {-680, 140}, {-678, 140}}, color = {0, 0, 127}));
    connect(combiTimeTable_DemandEMob.y[2], gain_DemandPower_EMob.u) annotation(
      Line(points = {{-678, 110}, {-662, 110}, {-662, 110}, {-662, 110}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_EMob, gain_DemandPower_EMob.y) annotation(
      Line(points = {{-144, 124}, {-620, 124}, {-620, 110}, {-638, 110}}, color = {0, 0, 127}));
    connect(pVSystemTMY3.weaBus, weaDat.weaBus) annotation(
      Line(points = {{-700, 210}, {-720, 210}, {-720, 330}, {-760, 330}}, color = {255, 204, 51}, thickness = 0.5));
    connect(pVSystemTMY3.PVPowerW, gainPV_500kW.u) annotation(
      Line(points = {{-679, 210}, {-602, 210}}, color = {0, 0, 127}));
    connect(busbar_4consumer.y_PVProductionToBattery, batterySimple1.PCharge) annotation(
      Line(points = {{-75, 127}, {-75, 126}, {-40, 126}, {-40, 106}, {9, 106}}, color = {0, 0, 127}));
    connect(busbar_4consumer.y_LoadToBattery, batterySimple1.PLoad) annotation(
      Line(points = {{-75, 136}, {62, 136}, {62, 106}, {35, 106}}, color = {0, 0, 127}));
    connect(product.y, integrator_cost_Spot.u) annotation(
      Line(points = {{181, -700}, {198, -700}}, color = {0, 0, 127}));
    connect(switch_GridLoad.u3, const5.y) annotation(
      Line(points = {{238, 142}, {230, 142}, {230, 120}, {222, 120}, {222, 120}}, color = {0, 0, 127}));
    connect(switch_FeedIn_PV_500kW.u1, const5.y) annotation(
      Line(points = {{238, 100}, {230, 100}, {230, 120}, {222, 120}, {222, 120}}, color = {0, 0, 127}));
    connect(switch_GridLoad.u2, lessThreshold.y) annotation(
      Line(points = {{238, 150}, {190, 150}, {190, 120}, {182, 120}, {182, 120}}, color = {255, 0, 255}));
    connect(switch_FeedIn_PV_500kW.u2, lessThreshold.y) annotation(
      Line(points = {{238, 92}, {190, 92}, {190, 120}, {182, 120}, {182, 120}}, color = {255, 0, 255}));
    connect(batterySimple1.PGrid, switch_FeedIn_PV_500kW.u3) annotation(
      Line(points = {{36, 116}, {140, 116}, {140, 84}, {238, 84}, {238, 84}}, color = {0, 0, 127}));
    connect(switch_GridLoad.u1, batterySimple1.PGrid) annotation(
      Line(points = {{238, 158}, {140, 158}, {140, 116}, {36, 116}, {36, 116}}, color = {0, 0, 127}));
    connect(lessThreshold.u, batterySimple1.PGrid) annotation(
      Line(points = {{158, 120}, {144, 120}, {144, 116}, {36, 116}, {36, 116}}, color = {0, 0, 127}));
    connect(gain_FeedIn_PV_500kW_CO2.y, add_CO2_FeedIn.u1) annotation(
      Line(points = {{-738, -860}, {-732, -860}, {-732, -874}, {-722, -874}}, color = {0, 0, 127}));
    connect(gain_FeedIn_CHP_CO2.y, add_CO2_FeedIn.u2) annotation(
      Line(points = {{-738, -900}, {-732, -900}, {-732, -886}, {-722, -886}}, color = {0, 0, 127}));
    connect(gain_Boiler_dotE_CO2.y, add_CO2_dotE.u1) annotation(
      Line(points = {{-738, -780}, {-730, -780}, {-730, -794}, {-722, -794}, {-722, -794}}, color = {0, 0, 127}));
    connect(gain_CHP_dotE_CO2.y, add_CO2_dotE.u2) annotation(
      Line(points = {{-738, -820}, {-730, -820}, {-730, -806}, {-722, -806}, {-722, -806}}, color = {0, 0, 127}));
    connect(gain_GridLoad_CO2.y, add_CO2_Power.u2) annotation(
      Line(points = {{-738, -940}, {-690, -940}, {-690, -906}, {-682, -906}, {-682, -906}}, color = {0, 0, 127}));
    connect(add_CO2_FeedIn.y, add_CO2_Power.u1) annotation(
      Line(points = {{-698, -880}, {-690, -880}, {-690, -894}, {-682, -894}, {-682, -894}}, color = {0, 0, 127}));
    connect(add_CO2_Power.y, add3_CO2.u2) annotation(
      Line(points = {{-658, -900}, {-622, -900}, {-622, -900}, {-622, -900}}, color = {0, 0, 127}));
    connect(add3_CO2.u1, add_CO2_dotE.y) annotation(
      Line(points = {{-622, -892}, {-640, -892}, {-640, -800}, {-698, -800}, {-698, -800}}, color = {0, 0, 127}));
    connect(add3_CO2.u3, gain_Electrolyzer_H2.y) annotation(
      Line(points = {{-622, -908}, {-640, -908}, {-640, -980}, {-738, -980}, {-738, -980}}, color = {0, 0, 127}));
    connect(y__Boiler_dotE, integrator__Boiler_dotE.u) annotation(
      Line(points = {{-840, -780}, {-802, -780}, {-802, -780}, {-802, -780}}, color = {0, 0, 127}));
    connect(integrator__Boiler_dotE.y, gain_Boiler_dotE_CO2.u) annotation(
      Line(points = {{-778, -780}, {-764, -780}, {-764, -780}, {-762, -780}}, color = {0, 0, 127}));
    connect(y__CHP_dotE, integrator__CHP_dotE.u) annotation(
      Line(points = {{-840, -820}, {-802, -820}, {-802, -820}, {-802, -820}}, color = {0, 0, 127}));
    connect(integrator__CHP_dotE.y, gain_CHP_dotE_CO2.u) annotation(
      Line(points = {{-778, -820}, {-762, -820}, {-762, -820}, {-762, -820}}, color = {0, 0, 127}));
    connect(y__FeedIn_PV_500kW, integrator__FeedIn_PV_500kW.u) annotation(
      Line(points = {{-840, -860}, {-804, -860}, {-804, -860}, {-802, -860}}, color = {0, 0, 127}));
    connect(integrator__FeedIn_PV_500kW.y, gain_FeedIn_PV_500kW_CO2.u) annotation(
      Line(points = {{-778, -860}, {-764, -860}, {-764, -860}, {-762, -860}}, color = {0, 0, 127}));
    connect(y__FeedIn_CHP, integrator__FeedIn_CHP.u) annotation(
      Line(points = {{-840, -900}, {-802, -900}, {-802, -900}, {-802, -900}}, color = {0, 0, 127}));
    connect(integrator__FeedIn_CHP.y, gain_FeedIn_CHP_CO2.u) annotation(
      Line(points = {{-778, -900}, {-762, -900}, {-762, -900}, {-762, -900}}, color = {0, 0, 127}));
    connect(y__GridLoad, integrator__GridLoad.u) annotation(
      Line(points = {{-840, -940}, {-804, -940}, {-804, -940}, {-802, -940}}, color = {0, 0, 127}));
    connect(integrator__GridLoad.y, gain_GridLoad_CO2.u) annotation(
      Line(points = {{-778, -940}, {-764, -940}, {-764, -940}, {-762, -940}}, color = {0, 0, 127}));
    connect(y__Electrolyzer_H2, integrator__Electrolyzer_H2.u) annotation(
      Line(points = {{-840, -980}, {-802, -980}, {-802, -980}, {-802, -980}}, color = {0, 0, 127}));
    connect(integrator__Electrolyzer_H2.y, gain_Electrolyzer_H2.u) annotation(
      Line(points = {{-778, -980}, {-762, -980}, {-762, -980}, {-762, -980}}, color = {0, 0, 127}));
    connect(y_Boiler_dotE, integrator_Boiler_dotE.u) annotation(
      Line(points = {{120, -300}, {156, -300}, {156, -300}, {158, -300}}, color = {0, 0, 127}));
    connect(integrator_Boiler_dotE.y, gain_Boiler_dotE_cost.u) annotation(
      Line(points = {{182, -300}, {198, -300}, {198, -300}, {198, -300}}, color = {0, 0, 127}));
    connect(y_CHP_dotE, integrator_CHP_dotE.u) annotation(
      Line(points = {{120, -340}, {158, -340}, {158, -340}, {158, -340}}, color = {0, 0, 127}));
    connect(integrator_CHP_dotE.y, gain_CHP_dotE_cost.u) annotation(
      Line(points = {{182, -340}, {198, -340}, {198, -340}, {198, -340}}, color = {0, 0, 127}));
    connect(product.u1, y_FeedIn_CHP) annotation(
      Line(points = {{158, -694}, {140, -694}, {140, -660}, {120, -660}}, color = {0, 0, 127}));
    connect(integrator_FeedIn_CHP.u, y_FeedIn_CHP) annotation(
      Line(points = {{158, -660}, {120, -660}}, color = {0, 0, 127}));
    connect(integrator_FeedIn_CHP.y, gain_FeedIn_CHP_cost.u) annotation(
      Line(points = {{181, -660}, {198, -660}}, color = {0, 0, 127}));
    connect(y_FeedIn_PV_500kW, integrator.u) annotation(
      Line(points = {{120, -620}, {158, -620}}, color = {0, 0, 127}));
    connect(integrator.y, gain_FeedIn_PV_500kW_cost.u) annotation(
      Line(points = {{181, -620}, {198, -620}}, color = {0, 0, 127}));
    connect(integrator_DemandPower_EMob.u, y_DemandPower_EMob) annotation(
      Line(points = {{158, -460}, {116, -460}, {116, -460}, {120, -460}}, color = {0, 0, 127}));
    connect(gain_DemandPower_EMob_cost.u, integrator_DemandPower_EMob.y) annotation(
      Line(points = {{198, -460}, {180, -460}, {180, -460}, {182, -460}}, color = {0, 0, 127}));
    connect(gain_DemandPower_Houses_cost.u, integrator_DemandPower_Houses.y) annotation(
      Line(points = {{198, -420}, {182, -420}, {182, -420}, {182, -420}}, color = {0, 0, 127}));
    connect(integrator_DemandPower_Houses.u, y_DemandPower_Houses) annotation(
      Line(points = {{158, -420}, {116, -420}, {116, -420}, {120, -420}}, color = {0, 0, 127}));
    connect(gain_DemandHeat_Houses_cost.u, integrator_DemandHeat_Houses.y) annotation(
      Line(points = {{198, -380}, {180, -380}, {180, -380}, {182, -380}}, color = {0, 0, 127}));
    connect(integrator_DemandHeat_Houses.u, y_DemandHeat_Houses) annotation(
      Line(points = {{158, -380}, {114, -380}, {114, -380}, {120, -380}}, color = {0, 0, 127}));
    connect(add_cost_dotE.u1, gain_Boiler_dotE_cost.y) annotation(
      Line(points = {{238, -314}, {230, -314}, {230, -300}, {222, -300}, {222, -300}}, color = {0, 0, 127}));
    connect(add_cost_dotE.u2, gain_CHP_dotE_cost.y) annotation(
      Line(points = {{238, -326}, {230, -326}, {230, -340}, {222, -340}, {222, -340}}, color = {0, 0, 127}));
    connect(gain_DemandPower_Houses_cost.y, add_cost_DemandPower.u1) annotation(
      Line(points = {{222, -420}, {230, -420}, {230, -434}, {238, -434}, {238, -434}}, color = {0, 0, 127}));
    connect(gain_DemandPower_EMob_cost.y, add_cost_DemandPower.u2) annotation(
      Line(points = {{222, -460}, {230, -460}, {230, -446}, {238, -446}, {238, -446}}, color = {0, 0, 127}));
    connect(add_cost_Advancement.u2, gain_FeedIn_CHP_cost.y) annotation(
      Line(points = {{238, -646}, {230, -646}, {230, -660}, {221, -660}}, color = {0, 0, 127}));
    connect(gain_FeedIn_PV_500kW_cost.y, add_cost_Advancement.u1) annotation(
      Line(points = {{221, -620}, {228, -620}, {228, -634}, {238, -634}}, color = {0, 0, 127}));
    connect(add_cost_FeedIn.u1, add_cost_Advancement.y) annotation(
      Line(points = {{278, -654}, {268, -654}, {268, -640}, {261, -640}}, color = {0, 0, 127}));
    connect(add_cost_FeedIn.u2, integrator_cost_Spot.y) annotation(
      Line(points = {{278, -666}, {268, -666}, {268, -700}, {221, -700}}, color = {0, 0, 127}));
    connect(gain_DemandHeat_Houses_cost.y, add_cost_Demand.u1) annotation(
      Line(points = {{222, -380}, {270, -380}, {270, -414}, {278, -414}, {278, -414}}, color = {0, 0, 127}));
    connect(add_cost_Demand.u2, add_cost_DemandPower.y) annotation(
      Line(points = {{278, -426}, {270, -426}, {270, -440}, {262, -440}, {262, -440}}, color = {0, 0, 127}));
    connect(add3_cost.u2, add_cost_Demand.y) annotation(
      Line(points = {{358, -420}, {302, -420}, {302, -420}, {302, -420}}, color = {0, 0, 127}));
    connect(add3_cost.u1, add_cost_dotE.y) annotation(
      Line(points = {{358, -412}, {320, -412}, {320, -320}, {262, -320}, {262, -320}}, color = {0, 0, 127}));
    connect(y_DirectConsumption_PV_500_kW, integrator_DirectConsumption_PV_500kW.u) annotation(
      Line(points = {{120, -540}, {158, -540}}, color = {0, 0, 127}));
    connect(y_DirectConsumption_CHP, integrator_DirectConsumption_CHP.u) annotation(
      Line(points = {{120, -580}, {158, -580}}, color = {0, 0, 127}));
    connect(integrator_DirectConsumption_PV_500kW.y, gain_DirectConsumption_PV_500kW_cost.u) annotation(
      Line(points = {{181, -540}, {198, -540}}, color = {0, 0, 127}));
    connect(integrator_DirectConsumption_CHP.y, gain_DirectConsumption_CHP_cost.u) annotation(
      Line(points = {{181, -580}, {198, -580}}, color = {0, 0, 127}));
    connect(gain_DirectConsumption_PV_500kW_cost.y, add_cost_DirectConsumption.u1) annotation(
      Line(points = {{221, -540}, {228, -540}, {228, -554}, {238, -554}}, color = {0, 0, 127}));
    connect(gain_DirectConsumption_CHP_cost.y, add_cost_DirectConsumption.u2) annotation(
      Line(points = {{221, -580}, {228, -580}, {228, -566}, {238, -566}}, color = {0, 0, 127}));
    connect(gain_GridLoad.u, switch_GridLoad.y) annotation(
      Line(points = {{276, 150}, {260, 150}, {260, 150}, {262, 150}}, color = {0, 0, 127}));
    connect(y_GridLoad, integrator_GridLoad.u) annotation(
      Line(points = {{120, -760}, {158, -760}, {158, -760}, {158, -760}}, color = {0, 0, 127}));
    connect(integrator_GridLoad.y, gain_GridLoad_cost.u) annotation(
      Line(points = {{182, -760}, {198, -760}, {198, -760}, {198, -760}}, color = {0, 0, 127}));
    connect(gain_GridLoad_cost.y, add3_cost_Power.u3) annotation(
      Line(points = {{222, -760}, {310, -760}, {310, -668}, {318, -668}, {318, -668}}, color = {0, 0, 127}));
    connect(add3_cost_Power.u2, add_cost_FeedIn.y) annotation(
      Line(points = {{318, -660}, {300, -660}, {300, -660}, {302, -660}}, color = {0, 0, 127}));
    connect(add_cost_DirectConsumption.y, add3_cost_Power.u1) annotation(
      Line(points = {{262, -560}, {310, -560}, {310, -652}, {318, -652}, {318, -652}}, color = {0, 0, 127}));
    connect(add3_cost_Power.y, add3_cost.u3) annotation(
      Line(points = {{342, -660}, {348, -660}, {348, -428}, {358, -428}, {358, -428}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      experiment(StartTime = 0, StopTime = 604800, Tolerance = 1e-06, Interval = 3600));
  end V007_Quarree100;

  model V006_Quarree100
    extends Modelica.Icons.Example;
    parameter String Pfad = "Z:/owncloud/Consolinno/Projekte/Quarree100_Consolinno/Simulation_Modelica/";
    parameter String inputFileNameWeatherData = Pfad + "TRY2015_541957091051_Jahr.mos";
    parameter String inputFileNameCHP_P = Pfad + "Fahrplan_optCHP_P.txt";
    parameter String inputFileNameCHP_OP = Pfad + "Fahrplan_optCHP_OP.txt";
    parameter String inputFileNameElectrolyser_P = Pfad + "Fahrplan_optElectrolyser_P.txt";
    parameter String inputFileNameElectrolyser_OP = Pfad + "Fahrplan_optElectrolyser_OP.txt";
    parameter String inputFileNameBoiler = Pfad + "Fahrplan_optBoiler.txt";
    parameter String inputFileNameHeatPump = Pfad + "Fahrplan_optHeatPump.txt";
    parameter String inputFileNameHeatSword = Pfad + "Fahrplan_optHeatSword.txt";
    parameter String inputFileNameBat = Pfad + "Fahrplan_optBat.txt";
    parameter String inputFileNameDemandThermal = Pfad + "Waermebedarf_normiert.txt";
    parameter String inputFileNameDemandPower = Pfad + "Strombedarf_normiert.txt";
    parameter String inputFileNameEMob = Pfad + "EMobilitaet_normiert.txt";
    parameter String inputFileNameH2Mob = Pfad + "H2Mobilitaet_normiert.txt";
    parameter String inputFileNameSpot = Pfad + "SpotPreis.txt";
    Modelica.Blocks.Sources.Constant const1(k = 60 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-200, 624}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 7), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 3.2, dTank = 20, sIns = 0.2, lambdaIns = 0.032), load_cycles = [5, 1; 7, 4], n = 7, n_load_cycles = 2, n_unload_cycles = 1, unload_cycles = [1, 7], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {-5, 611}, extent = {{-25, -27}, {25, 27}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(
      Placement(visible = true, transformation(origin = {-714, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP annotation(
      Placement(visible = true, transformation(origin = {-594, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {40, 632}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
      Placement(visible = true, transformation(origin = {-257, 609}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Electrolyzer annotation(
      Placement(visible = true, transformation(origin = {-604, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_HeatPump annotation(
      Placement(visible = true, transformation(origin = {-614, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseHeatPump(amplitude = 0, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt Electrolyzer(T0 = 343.15, T_Out = 343.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation(
      Placement(visible = true, transformation(origin = {-160, 630}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
      Placement(visible = true, transformation(origin = {-177, 649}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(visible = true, transformation(origin = {650, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(visible = true, transformation(origin = {620, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation(
      Placement(visible = true, transformation(origin = {690, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {730, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation(
      Placement(visible = true, transformation(origin = {126, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {178, 160}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {206, 112}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {726, 696}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 40) annotation(
      Placement(visible = true, transformation(origin = {690, 730}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation(
      Placement(visible = true, transformation(origin = {700, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation(
      Placement(visible = true, transformation(origin = {770, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {34, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe1(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {36, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {620, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain1(k = 5177304.074) annotation(
      Placement(visible = true, transformation(origin = {762, 784}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = inputFileNameDemandThermal, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {714, 826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31 annotation(
      Placement(visible = true, transformation(origin = {-60, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation(
      Placement(visible = true, transformation(origin = {-20, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation(
      Placement(visible = true, transformation(origin = {-40, 448}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation(
      Placement(visible = true, transformation(origin = {-40, 410}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = inputFileNameSpot, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {66, 192}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {762, 726}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureCHP annotation(
      Placement(visible = true, transformation(origin = {198, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation(
      Placement(visible = true, transformation(origin = {162, 630}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt_through CHP(capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238, uHigh = 7, uLow = -3) annotation(
      Placement(visible = true, transformation(origin = {180, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 75 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {140, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureBoiler annotation(
      Placement(visible = true, transformation(origin = {460, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const2(k = 73 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {400, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_Boiler_opt_through Boiler(Q_nom = 2000000, uHigh = 2, uLow = 0) annotation(
      Placement(visible = true, transformation(origin = {440, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO3 annotation(
      Placement(visible = true, transformation(origin = {424, 628}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseBoiler(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Boiler annotation(
      Placement(visible = true, transformation(origin = {-584, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_HePu_opt HePu(Scale_Factor = 56, T_Out = 323.15) annotation(
      Placement(visible = true, transformation(origin = {-240, 590}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const4(k = 60 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-280, 570}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const6(k = 100) annotation(
      Placement(visible = true, transformation(origin = {-340, 580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = inputFileNameWeatherData) annotation(
      Placement(visible = true, transformation(origin = {-770, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain3(k = 1.01) annotation(
      Placement(visible = true, transformation(origin = {-666, 356}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gainPV_500kW(k = 50) annotation(
      Placement(visible = true, transformation(origin = {-590, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.busbar_4consumer busbar_4consumer annotation(
      Placement(visible = true, transformation(origin = {-108, 148}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandPower(fileName = inputFileNameDemandPower, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-690, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-650, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandEMob(fileName = inputFileNameEMob, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-690, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandEMob(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-650, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.Electrical.PVSystem.PVSystemTMY3 pVSystemTMY3(MaxOutputPower = 10000, data = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()) annotation(
      Placement(visible = true, transformation(origin = {-690, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    BuildingSystems.Technologies.ElectricalStorages.BatterySimple batterySimple1(SOC_start = 0, batteryData = BuildingSystems.Technologies.ElectricalStorages.Data.LithiumIon.LithiumIonAquion(), nBat = 10) annotation(
      Placement(visible = true, transformation(origin = {22, 106}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
  equation
    connect(pulseCHP.y, controlBus_CHP.control_value) annotation(
      Line(points = {{-703, 820}, {-594, 820}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_CHP.control_boolean) annotation(
      Line(points = {{-703, 900}, {-594, 900}, {-594, 820}}, color = {255, 0, 255}));
    connect(pulseElectrolyzer.y, controlBus_Electrolyzer.control_value) annotation(
      Line(points = {{-703, 780}, {-604, 780}}, color = {0, 0, 127}));
    connect(pulseHeatPump.y, controlBus_HeatPump.control_value) annotation(
      Line(points = {{-703, 740}, {-614, 740}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_Electrolyzer.control_boolean) annotation(
      Line(points = {{-703, 900}, {-604, 900}, {-604, 780}}, color = {255, 0, 255}));
    connect(booleanConstant.y, controlBus_HeatPump.control_boolean) annotation(
      Line(points = {{-703, 900}, {-614, 900}, {-614, 740}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_Electrolyzer) annotation(
      Line(points = {{-180, 649}, {-200, 649}, {-200, 779.5}, {-604, 779.5}, {-604, 780}}, color = {255, 204, 51}, thickness = 0.5));
    connect(const3.y, PID.u_s) annotation(
      Line(points = {{719, 520}, {702, 520}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation(
      Line(points = {{679, 520}, {620, 520}, {620, 551}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation(
      Line(points = {{137, 192}, {172, 192}, {172, 172}}, color = {0, 0, 127}));
    connect(product.y, integrator.u) annotation(
      Line(points = {{178, 149}, {178, 144.5}, {206, 144.5}, {206, 124}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation(
      Line(points = {{701, 730}, {726, 730}, {726, 708}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation(
      Line(points = {{660, 660}, {690, 660}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation(
      Line(points = {{715, 696}, {700, 696}, {700, 668}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{24, 660}, {0, 660}, {0, 638}}, color = {176, 0, 0}));
    connect(dynamicPipe1.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{26, 560}, {0, 560}, {0, 584}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{620, 600}, {620, 570}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation(
      Line(points = {{781, 660}, {802, 660}, {802, 560}, {630, 560}}, color = {176, 0, 0}));
    connect(combiTimeTable_DemandHeat.y[2], gain1.u) annotation(
      Line(points = {{725, 826}, {762, 826}, {762, 796}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation(
      Line(points = {{-60, 479}, {-60, 468}, {-48, 468}, {-48, 460}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation(
      Line(points = {{-20, 479}, {-20, 435}, {-32, 435}, {-32, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-68, 520}, {-68, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-60, 520}, {-60, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-52, 520}, {-52, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-28, 520}, {-28, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-20, 520}, {-20, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-12, 520}, {-12, 502}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation(
      Line(points = {{-40, 437}, {-40, 422}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[2], gain.u) annotation(
      Line(points = {{77, 192}, {114, 192}}, color = {0, 0, 127}));
    connect(gain1.y, gain2.u) annotation(
      Line(points = {{762, 773}, {762, 738}}, color = {0, 0, 127}));
    connect(gain2.y, consumer_simple.u_sink) annotation(
      Line(points = {{762, 715}, {762, 672}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, Electrolyzer.u_control_value) annotation(
      Line(points = {{-174, 648}, {-168, 648}, {-168, 642}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, Electrolyzer.u_control_boolean) annotation(
      Line(points = {{-174, 650}, {-164, 650}, {-164, 642}}, color = {255, 0, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe2.enthalpyPort_b1) annotation(
      Line(points = {{640, 660}, {620, 660}, {620, 620}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation(
      Line(points = {{781, 668}, {800, 668}, {800, 696}, {738, 696}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation(
      Line(points = {{781, 664}, {820, 664}, {820, 540}, {690, 540}, {690, 532}}, color = {0, 0, 127}));
    connect(dynamicPipe1.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{46, 560}, {610, 560}}, color = {176, 0, 0}));
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation(
      Line(points = {{30, 632}, {10, 632}, {10, 632}, {10, 632}}, color = {191, 0, 0}));
    connect(Electrolyzer.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation(
      Line(points = {{-160, 641}, {-160, 660}, {-10, 660}, {-10, 638}}, color = {176, 0, 0}));
    connect(Electrolyzer.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-172, 624}, {-189, 624}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_value, CHP.u_control_value) annotation(
      Line(points = {{166, 628}, {172, 628}, {172, 622}, {172, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_boolean, CHP.u_control_boolean) annotation(
      Line(points = {{166, 632}, {176, 632}, {176, 622}, {176, 622}}, color = {255, 0, 255}));
    connect(dynamicPipe.enthalpyPort_b1, CHP.enthalpyPort_a) annotation(
      Line(points = {{44, 660}, {120, 660}, {120, 580}, {180, 580}, {180, 598}, {180, 598}}, color = {176, 0, 0}));
    connect(temperatureCHP.enthalpyPort_a, CHP.enthalpyPort_b) annotation(
      Line(points = {{189, 660}, {180, 660}, {180, 622}}, color = {176, 0, 0}));
    connect(CHP.u_T_setpoint, temperatureCHP.T) annotation(
      Line(points = {{192, 604}, {199, 604}, {199, 649}}, color = {0, 0, 127}));
    connect(const.y, CHP.u_T_setpoint_specification) annotation(
      Line(points = {{151, 604}, {168, 604}}, color = {0, 0, 127}));
    connect(temperatureBoiler.enthalpyPort_b, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{469, 660}, {640, 660}}, color = {176, 0, 0}));
    connect(const2.y, Boiler.u_T_setpoint_specification) annotation(
      Line(points = {{412, 604}, {426, 604}, {426, 604}, {428, 604}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_value, Boiler.u_control_value) annotation(
      Line(points = {{428, 626}, {432, 626}, {432, 622}, {432, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_boolean, Boiler.u_control_boolean) annotation(
      Line(points = {{428, 630}, {436, 630}, {436, 622}, {436, 622}}, color = {255, 0, 255}));
    connect(temperatureBoiler.enthalpyPort_a, Boiler.enthalpyPort_b) annotation(
      Line(points = {{451, 660}, {440, 660}, {440, 622}}, color = {176, 0, 0}));
    connect(Boiler.u_T_setpoint, temperatureBoiler.T) annotation(
      Line(points = {{452, 604}, {461, 604}, {461, 649}}, color = {0, 0, 127}));
    connect(temperatureCHP.enthalpyPort_b, Boiler.enthalpyPort_a) annotation(
      Line(points = {{207, 660}, {380, 660}, {380, 580}, {440, 580}, {440, 598}}, color = {176, 0, 0}));
    connect(booleanConstant.y, controlBus_Boiler.control_boolean) annotation(
      Line(points = {{-703, 900}, {-584, 900}, {-584, 860}}, color = {255, 0, 255}));
    connect(pulseBoiler.y, controlBus_Boiler.control_value) annotation(
      Line(points = {{-703, 860}, {-584, 860}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.controlBus, controlBus_CHP) annotation(
      Line(points = {{160, 630}, {140, 630}, {140, 820}, {-594, 820}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO3.controlBus, controlBus_Boiler) annotation(
      Line(points = {{422, 628}, {400, 628}, {400, 860}, {-584, 860}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_HeatPump) annotation(
      Line(points = {{-260, 609}, {-279, 609}, {-279, 740}, {-614, 740}}, color = {255, 204, 51}, thickness = 0.5));
    connect(CHP.y_P, product.u1) annotation(
      Line(points = {{184, 600}, {184, 172}}, color = {0, 0, 127}));
    connect(Electrolyzer.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation(
      Line(points = {{-160, 620}, {-160, 620}, {-160, 560}, {-10, 560}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_value, HePu.u_control_value) annotation(
      Line(points = {{-254, 608}, {-248, 608}, {-248, 602}, {-248, 602}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO2.y_control_boolean, HePu.u_control_boolean) annotation(
      Line(points = {{-254, 610}, {-244, 610}, {-244, 602}, {-244, 602}}, color = {255, 0, 255}));
    connect(HePu.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-240, 578}, {-240, 578}, {-240, 540}, {-10, 540}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(HePu.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-240, 602}, {-240, 602}, {-240, 680}, {-10, 680}, {-10, 638}, {-10, 638}}, color = {176, 0, 0}));
    connect(gain_HeatStorage_TempMean.y, Electrolyzer.u_T_setpoint) annotation(
      Line(points = {{-40, 400}, {-40, 380}, {-80, 380}, {-80, 550}, {-140, 550}, {-140, 624}, {-148, 624}}, color = {0, 0, 127}));
    connect(gain_HeatStorage_TempMean.y, HePu.u_T_setpoint) annotation(
      Line(points = {{-40, 400}, {-40, 380}, {-80, 380}, {-80, 550}, {-220, 550}, {-220, 584}, {-228, 584}}, color = {0, 0, 127}));
    connect(const4.y, HePu.u_T_setpoint_specification) annotation(
      Line(points = {{-268, 570}, {-260, 570}, {-260, 584}, {-252, 584}, {-252, 584}}, color = {0, 0, 127}));
    connect(const6.y, HePu.u_dotm_source) annotation(
      Line(points = {{-328, 580}, {-320, 580}, {-320, 592}, {-252, 592}, {-252, 592}}, color = {0, 0, 127}));
    connect(weaDat.weaBus.TWetBul, gain3.u) annotation(
      Line(points = {{-760, 330}, {-666, 330}, {-666, 344}, {-666, 344}}, color = {0, 0, 127}));
    connect(HePu.u_T_fluid_source, gain3.y) annotation(
      Line(points = {{-252, 598}, {-666, 598}, {-666, 368}, {-666, 368}}, color = {0, 0, 127}));
    connect(gainPV_500kW.y, busbar_4consumer.uProductionPV) annotation(
      Line(points = {{-578, 210}, {-108, 210}, {-108, 184}}, color = {0, 0, 127}));
    connect(CHP.y_P, busbar_4consumer.u_ProductionCHP) annotation(
      Line(points = {{184, 600}, {184, 220}, {-126, 220}, {-126, 184}}, color = {0, 0, 127}));
    connect(Electrolyzer.y_P, busbar_4consumer.u_DemandElectrolyser) annotation(
      Line(points = {{-156, 620}, {-156, 172}, {-144, 172}}, color = {0, 0, 127}));
    connect(HePu.y_P, busbar_4consumer.u_DemandHeatPump) annotation(
      Line(points = {{-236, 580}, {-236, 161}, {-168, 161}, {-168, 160}, {-144, 160}, {-144, 157}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_DemandHouses, gain_DemandPower.y) annotation(
      Line(points = {{-144, 139}, {-562, 139}, {-562, 140}, {-638, 140}}, color = {0, 0, 127}));
    connect(gain_DemandPower.u, combiTimeTable_DemandPower.y[2]) annotation(
      Line(points = {{-662, 140}, {-680, 140}, {-680, 140}, {-678, 140}}, color = {0, 0, 127}));
    connect(combiTimeTable_DemandEMob.y[2], gain_DemandEMob.u) annotation(
      Line(points = {{-678, 110}, {-662, 110}, {-662, 110}, {-662, 110}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_EMob, gain_DemandEMob.y) annotation(
      Line(points = {{-144, 124}, {-620, 124}, {-620, 110}, {-638, 110}}, color = {0, 0, 127}));
    connect(pVSystemTMY3.weaBus, weaDat.weaBus) annotation(
      Line(points = {{-700, 210}, {-720, 210}, {-720, 330}, {-760, 330}}, color = {255, 204, 51}, thickness = 0.5));
    connect(pVSystemTMY3.PVPowerW, gainPV_500kW.u) annotation(
      Line(points = {{-679, 210}, {-602, 210}}, color = {0, 0, 127}));
    connect(busbar_4consumer.y_PVProductionToBattery, batterySimple1.PCharge) annotation(
      Line(points = {{-75, 127}, {-75, 126}, {-40, 126}, {-40, 106}, {9, 106}}, color = {0, 0, 127}));
    connect(busbar_4consumer.y_LoadToBattery, batterySimple1.PLoad) annotation(
      Line(points = {{-75, 136}, {62, 136}, {62, 106}, {35, 106}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      experiment(StartTime = 0, StopTime = 604800, Tolerance = 1e-06, Interval = 3600));
  end V006_Quarree100;

  model V005_Quarree100
    extends Modelica.Icons.Example;
    parameter String Pfad = "Z:/owncloud/Consolinno/Projekte/Quarree100_Consolinno/Simulation_Modelica/";
    parameter String inputFileNameWeatherData = Pfad + "TRY2015_541957091051_Jahr.mos";
    parameter String inputFileNameCHP_P = Pfad + "Fahrplan_optCHP_P.txt";
    parameter String inputFileNameCHP_OP = Pfad + "Fahrplan_optCHP_OP.txt";
    parameter String inputFileNameElectrolyser_P = Pfad + "Fahrplan_optElectrolyser_P.txt";
    parameter String inputFileNameElectrolyser_OP = Pfad + "Fahrplan_optElectrolyser_OP.txt";
    parameter String inputFileNameBoiler = Pfad + "Fahrplan_optBoiler.txt";
    parameter String inputFileNameHeatPump = Pfad + "Fahrplan_optHeatPump.txt";
    parameter String inputFileNameHeatSword = Pfad + "Fahrplan_optHeatSword.txt";
    parameter String inputFileNameBat = Pfad + "Fahrplan_optBat.txt";
    parameter String inputFileNameDemandThermal = Pfad + "Waermebedarf_normiert.txt";
    parameter String inputFileNameDemandPower = Pfad + "Strombedarf_normiert.txt";
    parameter String inputFileNameEMob = Pfad + "EMobilitaet_normiert.txt";
    parameter String inputFileNameH2Mob = Pfad + "H2Mobilitaet_normiert.txt";
    parameter String inputFileNameSpot = Pfad + "SpotPreis.txt";
    Modelica.Blocks.Sources.Constant const1(k = 60 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-200, 624}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 7), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 3.2, dTank = 20, sIns = 0.2, lambdaIns = 0.032), load_cycles = [5, 1; 7, 4], n = 7, n_load_cycles = 2, n_unload_cycles = 1, unload_cycles = [1, 7], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {-5, 611}, extent = {{-25, -27}, {25, 27}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(
      Placement(visible = true, transformation(origin = {-714, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP annotation(
      Placement(visible = true, transformation(origin = {-594, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {40, 632}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
      Placement(visible = true, transformation(origin = {-257, 609}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Electrolyzer annotation(
      Placement(visible = true, transformation(origin = {-604, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_HeatPump annotation(
      Placement(visible = true, transformation(origin = {-614, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseHeatPump(amplitude = 0, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt Electrolyzer(T0 = 343.15, T_Out = 343.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation(
      Placement(visible = true, transformation(origin = {-160, 630}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
      Placement(visible = true, transformation(origin = {-177, 649}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(visible = true, transformation(origin = {650, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(visible = true, transformation(origin = {620, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation(
      Placement(visible = true, transformation(origin = {690, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {730, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation(
      Placement(visible = true, transformation(origin = {126, 480}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {178, 448}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {206, 400}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {726, 696}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 40) annotation(
      Placement(visible = true, transformation(origin = {690, 730}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation(
      Placement(visible = true, transformation(origin = {700, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation(
      Placement(visible = true, transformation(origin = {770, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {34, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe1(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {36, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {620, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain1(k = 5177304.074) annotation(
      Placement(visible = true, transformation(origin = {762, 784}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = inputFileNameDemandThermal, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {714, 826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31 annotation(
      Placement(visible = true, transformation(origin = {-60, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation(
      Placement(visible = true, transformation(origin = {-20, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation(
      Placement(visible = true, transformation(origin = {-40, 448}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation(
      Placement(visible = true, transformation(origin = {-40, 410}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = inputFileNameSpot, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {66, 480}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {762, 726}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureCHP annotation(
      Placement(visible = true, transformation(origin = {198, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation(
      Placement(visible = true, transformation(origin = {162, 630}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt_through CHP(capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238, uHigh = 7, uLow = -3) annotation(
      Placement(visible = true, transformation(origin = {180, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 75 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {140, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureBoiler annotation(
      Placement(visible = true, transformation(origin = {460, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const2(k = 73 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {400, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_Boiler_opt_through Boiler(Q_nom = 2000000, uHigh = 2, uLow = 0) annotation(
      Placement(visible = true, transformation(origin = {440, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO3 annotation(
      Placement(visible = true, transformation(origin = {424, 628}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseBoiler(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Boiler annotation(
      Placement(visible = true, transformation(origin = {-584, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_HePu_opt HePu(Scale_Factor = 56, T_Out = 323.15) annotation(
      Placement(visible = true, transformation(origin = {-240, 590}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const4(k = 60 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-280, 570}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const6(k = 100) annotation(
      Placement(visible = true, transformation(origin = {-340, 580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const5(k = 20 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-370, 598}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(pulseCHP.y, controlBus_CHP.control_value) annotation(
      Line(points = {{-703, 820}, {-594, 820}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_CHP.control_boolean) annotation(
      Line(points = {{-703, 900}, {-594, 900}, {-594, 820}}, color = {255, 0, 255}));
    connect(pulseElectrolyzer.y, controlBus_Electrolyzer.control_value) annotation(
      Line(points = {{-703, 780}, {-604, 780}}, color = {0, 0, 127}));
    connect(pulseHeatPump.y, controlBus_HeatPump.control_value) annotation(
      Line(points = {{-703, 740}, {-614, 740}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_Electrolyzer.control_boolean) annotation(
      Line(points = {{-703, 900}, {-604, 900}, {-604, 780}}, color = {255, 0, 255}));
    connect(booleanConstant.y, controlBus_HeatPump.control_boolean) annotation(
      Line(points = {{-703, 900}, {-614, 900}, {-614, 740}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_Electrolyzer) annotation(
      Line(points = {{-180, 649}, {-200, 649}, {-200, 779.5}, {-604, 779.5}, {-604, 780}}, color = {255, 204, 51}, thickness = 0.5));
    connect(const3.y, PID.u_s) annotation(
      Line(points = {{719, 520}, {702, 520}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation(
      Line(points = {{679, 520}, {620, 520}, {620, 551}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation(
      Line(points = {{137, 480}, {172, 480}, {172, 460}}, color = {0, 0, 127}));
    connect(product.y, integrator.u) annotation(
      Line(points = {{178, 437}, {178, 432.5}, {206, 432.5}, {206, 412}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation(
      Line(points = {{701, 730}, {726, 730}, {726, 708}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation(
      Line(points = {{660, 660}, {690, 660}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation(
      Line(points = {{715, 696}, {700, 696}, {700, 668}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{24, 660}, {0, 660}, {0, 638}}, color = {176, 0, 0}));
    connect(dynamicPipe1.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{26, 560}, {0, 560}, {0, 584}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{620, 600}, {620, 570}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation(
      Line(points = {{781, 660}, {802, 660}, {802, 560}, {630, 560}}, color = {176, 0, 0}));
    connect(combiTimeTable_DemandHeat.y[2], gain1.u) annotation(
      Line(points = {{725, 826}, {762, 826}, {762, 796}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation(
      Line(points = {{-60, 479}, {-60, 468}, {-48, 468}, {-48, 460}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation(
      Line(points = {{-20, 479}, {-20, 435}, {-32, 435}, {-32, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-68, 520}, {-68, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-60, 520}, {-60, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-52, 520}, {-52, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-28, 520}, {-28, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-20, 520}, {-20, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-12, 520}, {-12, 502}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation(
      Line(points = {{-40, 437}, {-40, 422}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[2], gain.u) annotation(
      Line(points = {{77, 480}, {114, 480}}, color = {0, 0, 127}));
    connect(gain1.y, gain2.u) annotation(
      Line(points = {{762, 773}, {762, 738}}, color = {0, 0, 127}));
    connect(gain2.y, consumer_simple.u_sink) annotation(
      Line(points = {{762, 715}, {762, 672}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, Electrolyzer.u_control_value) annotation(
      Line(points = {{-174, 648}, {-168, 648}, {-168, 642}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, Electrolyzer.u_control_boolean) annotation(
      Line(points = {{-174, 650}, {-164, 650}, {-164, 642}}, color = {255, 0, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe2.enthalpyPort_b1) annotation(
      Line(points = {{640, 660}, {620, 660}, {620, 620}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation(
      Line(points = {{781, 668}, {800, 668}, {800, 696}, {738, 696}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation(
      Line(points = {{781, 664}, {820, 664}, {820, 540}, {690, 540}, {690, 532}}, color = {0, 0, 127}));
    connect(dynamicPipe1.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{46, 560}, {610, 560}}, color = {176, 0, 0}));
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation(
      Line(points = {{30, 632}, {10, 632}, {10, 632}, {10, 632}}, color = {191, 0, 0}));
    connect(Electrolyzer.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation(
      Line(points = {{-160, 641}, {-160, 660}, {-10, 660}, {-10, 638}}, color = {176, 0, 0}));
    connect(Electrolyzer.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-172, 624}, {-189, 624}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_value, CHP.u_control_value) annotation(
      Line(points = {{166, 628}, {172, 628}, {172, 622}, {172, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_boolean, CHP.u_control_boolean) annotation(
      Line(points = {{166, 632}, {176, 632}, {176, 622}, {176, 622}}, color = {255, 0, 255}));
    connect(dynamicPipe.enthalpyPort_b1, CHP.enthalpyPort_a) annotation(
      Line(points = {{44, 660}, {120, 660}, {120, 580}, {180, 580}, {180, 598}, {180, 598}}, color = {176, 0, 0}));
    connect(temperatureCHP.enthalpyPort_a, CHP.enthalpyPort_b) annotation(
      Line(points = {{189, 660}, {180, 660}, {180, 622}}, color = {176, 0, 0}));
    connect(CHP.u_T_setpoint, temperatureCHP.T) annotation(
      Line(points = {{192, 604}, {199, 604}, {199, 649}}, color = {0, 0, 127}));
    connect(const.y, CHP.u_T_setpoint_specification) annotation(
      Line(points = {{151, 604}, {168, 604}}, color = {0, 0, 127}));
    connect(temperatureBoiler.enthalpyPort_b, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{469, 660}, {640, 660}}, color = {176, 0, 0}));
    connect(const2.y, Boiler.u_T_setpoint_specification) annotation(
      Line(points = {{412, 604}, {426, 604}, {426, 604}, {428, 604}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_value, Boiler.u_control_value) annotation(
      Line(points = {{428, 626}, {432, 626}, {432, 622}, {432, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_boolean, Boiler.u_control_boolean) annotation(
      Line(points = {{428, 630}, {436, 630}, {436, 622}, {436, 622}}, color = {255, 0, 255}));
    connect(temperatureBoiler.enthalpyPort_a, Boiler.enthalpyPort_b) annotation(
      Line(points = {{451, 660}, {440, 660}, {440, 622}}, color = {176, 0, 0}));
    connect(Boiler.u_T_setpoint, temperatureBoiler.T) annotation(
      Line(points = {{452, 604}, {461, 604}, {461, 649}}, color = {0, 0, 127}));
    connect(temperatureCHP.enthalpyPort_b, Boiler.enthalpyPort_a) annotation(
      Line(points = {{207, 660}, {380, 660}, {380, 580}, {440, 580}, {440, 598}}, color = {176, 0, 0}));
    connect(booleanConstant.y, controlBus_Boiler.control_boolean) annotation(
      Line(points = {{-703, 900}, {-584, 900}, {-584, 860}}, color = {255, 0, 255}));
    connect(pulseBoiler.y, controlBus_Boiler.control_value) annotation(
      Line(points = {{-703, 860}, {-584, 860}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.controlBus, controlBus_CHP) annotation(
      Line(points = {{160, 630}, {140, 630}, {140, 820}, {-594, 820}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO3.controlBus, controlBus_Boiler) annotation(
      Line(points = {{422, 628}, {400, 628}, {400, 860}, {-584, 860}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_HeatPump) annotation(
      Line(points = {{-260, 609}, {-279, 609}, {-279, 740}, {-614, 740}}, color = {255, 204, 51}, thickness = 0.5));
    connect(CHP.y_P, product.u1) annotation(
      Line(points = {{184, 600}, {184, 600}, {184, 460}, {184, 460}}, color = {0, 0, 127}));
    connect(Electrolyzer.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation(
      Line(points = {{-160, 620}, {-160, 620}, {-160, 560}, {-10, 560}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_value, HePu.u_control_value) annotation(
      Line(points = {{-254, 608}, {-248, 608}, {-248, 602}, {-248, 602}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO2.y_control_boolean, HePu.u_control_boolean) annotation(
      Line(points = {{-254, 610}, {-244, 610}, {-244, 602}, {-244, 602}}, color = {255, 0, 255}));
    connect(HePu.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-240, 578}, {-240, 578}, {-240, 540}, {-10, 540}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(HePu.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-240, 602}, {-240, 602}, {-240, 680}, {-10, 680}, {-10, 638}, {-10, 638}}, color = {176, 0, 0}));
    connect(gain_HeatStorage_TempMean.y, Electrolyzer.u_T_setpoint) annotation(
      Line(points = {{-40, 400}, {-40, 380}, {-80, 380}, {-80, 550}, {-140, 550}, {-140, 624}, {-148, 624}}, color = {0, 0, 127}));
    connect(gain_HeatStorage_TempMean.y, HePu.u_T_setpoint) annotation(
      Line(points = {{-40, 400}, {-40, 380}, {-80, 380}, {-80, 550}, {-220, 550}, {-220, 584}, {-228, 584}}, color = {0, 0, 127}));
    connect(const4.y, HePu.u_T_setpoint_specification) annotation(
      Line(points = {{-268, 570}, {-260, 570}, {-260, 584}, {-252, 584}, {-252, 584}}, color = {0, 0, 127}));
    connect(const6.y, HePu.u_dotm_source) annotation(
      Line(points = {{-328, 580}, {-320, 580}, {-320, 592}, {-252, 592}, {-252, 592}}, color = {0, 0, 127}));
    connect(const5.y, HePu.u_T_fluid_source) annotation(
      Line(points = {{-358, 598}, {-252, 598}, {-252, 598}, {-252, 598}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      experiment(StartTime = 0, StopTime = 604800, Tolerance = 1e-06, Interval = 3600));
  end V005_Quarree100;

  model V004_Quarree100
    extends Modelica.Icons.Example;
    parameter String Pfad = "Z:/owncloud/Consolinno/Projekte/Quarree100_Consolinno/Simulation_Modelica/";
    parameter String inputFileNameWeatherData = Pfad + "TRY2015_541957091051_Jahr.mos";
    parameter String inputFileNameCHP_P = Pfad + "Fahrplan_optCHP_P.txt";
    parameter String inputFileNameCHP_OP = Pfad + "Fahrplan_optCHP_OP.txt";
    parameter String inputFileNameElectrolyser_P = Pfad + "Fahrplan_optElectrolyser_P.txt";
    parameter String inputFileNameElectrolyser_OP = Pfad + "Fahrplan_optElectrolyser_OP.txt";
    parameter String inputFileNameBoiler = Pfad + "Fahrplan_optBoiler.txt";
    parameter String inputFileNameHeatPump = Pfad + "Fahrplan_optHeatPump.txt";
    parameter String inputFileNameHeatSword = Pfad + "Fahrplan_optHeatSword.txt";
    parameter String inputFileNameBat = Pfad + "Fahrplan_optBat.txt";
    parameter String inputFileNameDemandThermal = Pfad + "Waermebedarf_normiert.txt";
    parameter String inputFileNameDemandPower = Pfad + "Strombedarf_normiert.txt";
    parameter String inputFileNameEMob = Pfad + "EMobilitaet_normiert.txt";
    parameter String inputFileNameH2Mob = Pfad + "H2Mobilitaet_normiert.txt";
    parameter String inputFileNameSpot = Pfad + "SpotPreis.txt";
    Modelica.Blocks.Sources.Constant const1(k = 60 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-410, 550}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 7), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 3.2, dTank = 20, sIns = 0.2, lambdaIns = 0.032), load_cycles = [7, 1; 7, 1], n = 7, n_load_cycles = 2, n_unload_cycles = 1, unload_cycles = [1, 7], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {-5, 611}, extent = {{-25, -27}, {25, 27}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(
      Placement(visible = true, transformation(origin = {-714, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP annotation(
      Placement(visible = true, transformation(origin = {-594, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {40, 632}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
      Placement(visible = true, transformation(origin = {-257, 665}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Electrolyzer annotation(
      Placement(visible = true, transformation(origin = {-604, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP3 annotation(
      Placement(visible = true, transformation(origin = {-614, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP3(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt Electrolyzer(T0 = 343.15, T_Out = 343.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation(
      Placement(visible = true, transformation(origin = {-160, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
      Placement(visible = true, transformation(origin = {-177, 629}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(visible = true, transformation(origin = {650, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(visible = true, transformation(origin = {620, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation(
      Placement(visible = true, transformation(origin = {690, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {730, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation(
      Placement(visible = true, transformation(origin = {-350, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {-164, 438}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {-136, 390}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {726, 696}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 20) annotation(
      Placement(visible = true, transformation(origin = {690, 730}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation(
      Placement(visible = true, transformation(origin = {700, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation(
      Placement(visible = true, transformation(origin = {770, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {34, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe1(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {36, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {620, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain1(k = 5177304.074) annotation(
      Placement(visible = true, transformation(origin = {762, 784}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = inputFileNameDemandThermal, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {714, 826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31 annotation(
      Placement(visible = true, transformation(origin = {-60, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation(
      Placement(visible = true, transformation(origin = {-20, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation(
      Placement(visible = true, transformation(origin = {-40, 448}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation(
      Placement(visible = true, transformation(origin = {-40, 410}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = inputFileNameSpot, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-410, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {762, 726}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Simulationsumgebung.Components.Producer_CHP_opt CHP2(T0 = 343.15, T_Out = 343.15, eta_el = 0.38095, eta_th = 0.55238) annotation(
      Placement(visible = true, transformation(origin = {-240, 646}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureCHP annotation(
      Placement(visible = true, transformation(origin = {198, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation(
      Placement(visible = true, transformation(origin = {162, 630}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt_through CHP(capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238, uHigh = 7, uLow = -3) annotation(
      Placement(visible = true, transformation(origin = {180, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 75 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {140, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureBoiler annotation(
      Placement(visible = true, transformation(origin = {460, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const2(k = 73 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {400, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_Boiler_opt_through Boiler(Q_nom = 2000000, uHigh = 2, uLow = 0) annotation(
      Placement(visible = true, transformation(origin = {440, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO3 annotation(
      Placement(visible = true, transformation(origin = {424, 628}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseBoiler(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-714, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Boiler annotation(
      Placement(visible = true, transformation(origin = {-584, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(pulseCHP.y, controlBus_CHP.control_value) annotation(
      Line(points = {{-703, 820}, {-594, 820}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_CHP.control_boolean) annotation(
      Line(points = {{-703, 900}, {-594, 900}, {-594, 820}}, color = {255, 0, 255}));
    connect(pulseElectrolyzer.y, controlBus_Electrolyzer.control_value) annotation(
      Line(points = {{-703, 780}, {-604, 780}}, color = {0, 0, 127}));
    connect(pulseCHP3.y, controlBus_CHP3.control_value) annotation(
      Line(points = {{-703, 740}, {-614, 740}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_Electrolyzer.control_boolean) annotation(
      Line(points = {{-703, 900}, {-604, 900}, {-604, 780}}, color = {255, 0, 255}));
    connect(booleanConstant.y, controlBus_CHP3.control_boolean) annotation(
      Line(points = {{-703, 900}, {-614, 900}, {-614, 740}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_Electrolyzer) annotation(
      Line(points = {{-180, 629}, {-200, 629}, {-200, 779.5}, {-604, 779.5}, {-604, 780}}, color = {255, 204, 51}, thickness = 0.5));
    connect(const3.y, PID.u_s) annotation(
      Line(points = {{719, 520}, {702, 520}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation(
      Line(points = {{679, 520}, {620, 520}, {620, 551}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation(
      Line(points = {{-339, 470}, {-170, 470}, {-170, 450}}, color = {0, 0, 127}));
    connect(product.y, integrator.u) annotation(
      Line(points = {{-164, 427}, {-164, 410.5}, {-136, 410.5}, {-136, 402}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation(
      Line(points = {{701, 730}, {726, 730}, {726, 708}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation(
      Line(points = {{660, 660}, {690, 660}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation(
      Line(points = {{715, 696}, {700, 696}, {700, 668}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{24, 660}, {0, 660}, {0, 638}}, color = {176, 0, 0}));
    connect(dynamicPipe1.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{26, 560}, {0, 560}, {0, 584}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{620, 600}, {620, 570}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation(
      Line(points = {{781, 660}, {802, 660}, {802, 560}, {630, 560}}, color = {176, 0, 0}));
    connect(combiTimeTable_DemandHeat.y[2], gain1.u) annotation(
      Line(points = {{725, 826}, {762, 826}, {762, 796}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation(
      Line(points = {{-60, 479}, {-60, 468}, {-48, 468}, {-48, 460}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation(
      Line(points = {{-20, 479}, {-20, 435}, {-32, 435}, {-32, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-68, 520}, {-68, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-60, 520}, {-60, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-52, 520}, {-52, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-28, 520}, {-28, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-20, 520}, {-20, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-12, 520}, {-12, 502}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation(
      Line(points = {{-40, 437}, {-40, 422}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[2], gain.u) annotation(
      Line(points = {{-399, 470}, {-362, 470}}, color = {0, 0, 127}));
    connect(gain1.y, gain2.u) annotation(
      Line(points = {{762, 773}, {762, 738}}, color = {0, 0, 127}));
    connect(gain2.y, consumer_simple.u_sink) annotation(
      Line(points = {{762, 715}, {762, 672}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, Electrolyzer.u_control_value) annotation(
      Line(points = {{-174, 628}, {-168, 628}, {-168, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, Electrolyzer.u_control_boolean) annotation(
      Line(points = {{-174, 630}, {-164, 630}, {-164, 622}}, color = {255, 0, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe2.enthalpyPort_b1) annotation(
      Line(points = {{640, 660}, {620, 660}, {620, 620}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation(
      Line(points = {{781, 668}, {800, 668}, {800, 696}, {738, 696}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation(
      Line(points = {{781, 664}, {820, 664}, {820, 540}, {690, 540}, {690, 532}}, color = {0, 0, 127}));
    connect(dynamicPipe1.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{46, 560}, {610, 560}}, color = {176, 0, 0}));
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation(
      Line(points = {{30, 632}, {10, 632}, {10, 632}, {10, 632}}, color = {191, 0, 0}));
    connect(Electrolyzer.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation(
      Line(points = {{-160, 600}, {-160, 600}, {-160, 560}, {-10, 560}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(Electrolyzer.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation(
      Line(points = {{-160, 622}, {-160, 622}, {-160, 660}, {-10, 660}, {-10, 638}, {-10, 638}}, color = {176, 0, 0}));
    connect(heatStorageVariablePorts_central.T_layers[5], Electrolyzer.u_T_setpoint) annotation(
      Line(points = {{-28, 612}, {-146, 612}, {-146, 604}, {-148, 604}}, color = {0, 0, 127}));
    connect(Electrolyzer.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-172, 604}, {-180, 604}, {-180, 550}, {-398, 550}, {-398, 550}}, color = {0, 0, 127}));
    connect(CHP2.y_P, product.u1) annotation(
      Line(points = {{-236, 635}, {-236, 480}, {-158, 480}, {-158, 450}}, color = {0, 0, 127}));
    connect(CHP2.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-252, 640}, {-252, 550}, {-398, 550}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], CHP2.u_T_setpoint) annotation(
      Line(points = {{-28, 612}, {-40, 612}, {-40, 640}, {-228, 640}}, color = {0, 0, 127}));
    connect(CHP2.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-240, 635}, {-240, 540}, {-10, 540}, {-10, 584}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_boolean, CHP2.u_control_boolean) annotation(
      Line(points = {{-254, 666}, {-244, 666}, {-244, 658}}, color = {255, 0, 255}));
    connect(CHP2.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-240, 657}, {-240, 662}, {-10, 662}, {-10, 638}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_value, CHP2.u_control_value) annotation(
      Line(points = {{-254, 664}, {-248, 664}, {-248, 658}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_value, CHP.u_control_value) annotation(
      Line(points = {{166, 628}, {172, 628}, {172, 622}, {172, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_boolean, CHP.u_control_boolean) annotation(
      Line(points = {{166, 632}, {176, 632}, {176, 622}, {176, 622}}, color = {255, 0, 255}));
    connect(dynamicPipe.enthalpyPort_b1, CHP.enthalpyPort_a) annotation(
      Line(points = {{44, 660}, {120, 660}, {120, 580}, {180, 580}, {180, 598}, {180, 598}}, color = {176, 0, 0}));
    connect(temperatureCHP.enthalpyPort_a, CHP.enthalpyPort_b) annotation(
      Line(points = {{189, 660}, {180, 660}, {180, 622}}, color = {176, 0, 0}));
    connect(CHP.u_T_setpoint, temperatureCHP.T) annotation(
      Line(points = {{192, 604}, {199, 604}, {199, 649}}, color = {0, 0, 127}));
    connect(const.y, CHP.u_T_setpoint_specification) annotation(
      Line(points = {{151, 604}, {168, 604}}, color = {0, 0, 127}));
    connect(temperatureBoiler.enthalpyPort_b, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{469, 660}, {640, 660}}, color = {176, 0, 0}));
    connect(const2.y, Boiler.u_T_setpoint_specification) annotation(
      Line(points = {{412, 604}, {426, 604}, {426, 604}, {428, 604}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_value, Boiler.u_control_value) annotation(
      Line(points = {{428, 626}, {432, 626}, {432, 622}, {432, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_boolean, Boiler.u_control_boolean) annotation(
      Line(points = {{428, 630}, {436, 630}, {436, 622}, {436, 622}}, color = {255, 0, 255}));
    connect(temperatureBoiler.enthalpyPort_a, Boiler.enthalpyPort_b) annotation(
      Line(points = {{451, 660}, {440, 660}, {440, 622}}, color = {176, 0, 0}));
    connect(Boiler.u_T_setpoint, temperatureBoiler.T) annotation(
      Line(points = {{452, 604}, {461, 604}, {461, 649}}, color = {0, 0, 127}));
    connect(temperatureCHP.enthalpyPort_b, Boiler.enthalpyPort_a) annotation(
      Line(points = {{207, 660}, {380, 660}, {380, 580}, {440, 580}, {440, 598}}, color = {176, 0, 0}));
    connect(booleanConstant.y, controlBus_Boiler.control_boolean) annotation(
      Line(points = {{-703, 900}, {-584, 900}, {-584, 860}}, color = {255, 0, 255}));
    connect(pulseBoiler.y, controlBus_Boiler.control_value) annotation(
      Line(points = {{-703, 860}, {-584, 860}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.controlBus, controlBus_CHP) annotation(
      Line(points = {{160, 630}, {140, 630}, {140, 820}, {-594, 820}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO3.controlBus, controlBus_Boiler) annotation(
      Line(points = {{422, 628}, {400, 628}, {400, 860}, {-584, 860}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_CHP3) annotation(
      Line(points = {{-260, 666}, {-279, 666}, {-279, 740}, {-614, 740}}, color = {255, 204, 51}, thickness = 0.5));
    annotation(
      Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      experiment(StartTime = 0, StopTime = 604800, Tolerance = 1e-06, Interval = 3600));
  end V004_Quarree100;

  model V003_Quarree100
    extends Modelica.Icons.Example;
    parameter String Pfad = "Z:/owncloud/Consolinno/Projekte/Quarree100_Consolinno/Simulation_Modelica/";
    parameter String inputFileNameWeatherData = Pfad + "TRY2015_541957091051_Jahr.mos";
    parameter String inputFileNameCHP_P = Pfad + "Fahrplan_optCHP_P.txt";
    parameter String inputFileNameCHP_OP = Pfad + "Fahrplan_optCHP_OP.txt";
    parameter String inputFileNameElectrolyser_P = Pfad + "Fahrplan_optElectrolyser_P.txt";
    parameter String inputFileNameElectrolyser_OP = Pfad + "Fahrplan_optElectrolyser_OP.txt";
    parameter String inputFileNameBoiler = Pfad + "Fahrplan_optBoiler.txt";
    parameter String inputFileNameHeatPump = Pfad + "Fahrplan_optHeatPump.txt";
    parameter String inputFileNameHeatSword = Pfad + "Fahrplan_optHeatSword.txt";
    parameter String inputFileNameBat = Pfad + "Fahrplan_optBat.txt";
    parameter String inputFileNameDemandThermal = Pfad + "Waermebedarf_normiert.txt";
    parameter String inputFileNameDemandPower = Pfad + "Strombedarf_normiert.txt";
    parameter String inputFileNameEMob = Pfad + "EMobilitaet_normiert.txt";
    parameter String inputFileNameH2Mob = Pfad + "H2Mobilitaet_normiert.txt";
    parameter String inputFileNameSpot = Pfad + "SpotPreis.txt";
    Modelica.Blocks.Sources.Constant const1(k = 60 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-410, 550}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 7), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 6.37, dTank = 4, sIns = 0.2, lambdaIns = 0.032), load_cycles = [7, 1; 7, 1], n = 7, n_load_cycles = 2, n_unload_cycles = 1, unload_cycles = [1, 7], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {-5, 611}, extent = {{-25, -27}, {25, 27}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(
      Placement(visible = true, transformation(origin = {-410, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP annotation(
      Placement(visible = true, transformation(origin = {-290, 820}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {40, 632}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
      Placement(visible = true, transformation(origin = {-257, 665}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Electrolyzer annotation(
      Placement(visible = true, transformation(origin = {-300, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP3 annotation(
      Placement(visible = true, transformation(origin = {-310, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP3(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt Electrolyzer(T0 = 343.15, T_Out = 343.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation(
      Placement(visible = true, transformation(origin = {-160, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
      Placement(visible = true, transformation(origin = {-177, 629}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(visible = true, transformation(origin = {650, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(visible = true, transformation(origin = {620, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation(
      Placement(visible = true, transformation(origin = {690, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 65 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {730, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation(
      Placement(visible = true, transformation(origin = {-350, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {-164, 438}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {-136, 390}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {726, 696}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 20) annotation(
      Placement(visible = true, transformation(origin = {690, 730}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation(
      Placement(visible = true, transformation(origin = {700, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation(
      Placement(visible = true, transformation(origin = {770, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {34, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe1(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {36, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {620, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain1(k = 2000000) annotation(
      Placement(visible = true, transformation(origin = {766, 784}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = inputFileNameDemandThermal, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {714, 826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31 annotation(
      Placement(visible = true, transformation(origin = {-60, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation(
      Placement(visible = true, transformation(origin = {-20, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation(
      Placement(visible = true, transformation(origin = {-40, 448}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation(
      Placement(visible = true, transformation(origin = {-40, 410}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = inputFileNameSpot, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-410, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {766, 726}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Simulationsumgebung.Components.Producer_CHP_opt CHP2(T0 = 343.15, T_Out = 343.15, capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238) annotation(
      Placement(visible = true, transformation(origin = {-240, 646}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureCHP annotation(
      Placement(visible = true, transformation(origin = {238, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation(
      Placement(visible = true, transformation(origin = {162, 630}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt_through CHP(uHigh = 2, uLow = 0) annotation(
      Placement(visible = true, transformation(origin = {180, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {140, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureBoiler annotation(
      Placement(visible = true, transformation(origin = {538, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const2(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {400, 604}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_Boiler_opt_through Boiler(Q_nom = 20000, uHigh = 2, uLow = 0) annotation(
      Placement(visible = true, transformation(origin = {440, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO3 annotation(
      Placement(visible = true, transformation(origin = {424, 628}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseBoiler(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Boiler annotation(
      Placement(visible = true, transformation(origin = {-280, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(pulseCHP.y, controlBus_CHP.control_value) annotation(
      Line(points = {{-399, 820}, {-290, 820}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_CHP.control_boolean) annotation(
      Line(points = {{-399, 900}, {-290, 900}, {-290, 820}}, color = {255, 0, 255}));
    connect(pulseElectrolyzer.y, controlBus_Electrolyzer.control_value) annotation(
      Line(points = {{-399, 780}, {-300, 780}}, color = {0, 0, 127}));
    connect(pulseCHP3.y, controlBus_CHP3.control_value) annotation(
      Line(points = {{-399, 740}, {-310, 740}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_Electrolyzer.control_boolean) annotation(
      Line(points = {{-399, 900}, {-300, 900}, {-300, 780}}, color = {255, 0, 255}));
    connect(booleanConstant.y, controlBus_CHP3.control_boolean) annotation(
      Line(points = {{-399, 900}, {-310, 900}, {-310, 740}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_Electrolyzer) annotation(
      Line(points = {{-180, 629}, {-200, 629}, {-200, 779.5}, {-300, 779.5}, {-300, 780}}, color = {255, 204, 51}, thickness = 0.5));
    connect(const3.y, PID.u_s) annotation(
      Line(points = {{719, 520}, {702, 520}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation(
      Line(points = {{679, 520}, {620, 520}, {620, 551}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation(
      Line(points = {{-339, 470}, {-170, 470}, {-170, 450}}, color = {0, 0, 127}));
    connect(product.y, integrator.u) annotation(
      Line(points = {{-164, 427}, {-164, 410.5}, {-136, 410.5}, {-136, 402}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation(
      Line(points = {{701, 730}, {726, 730}, {726, 708}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation(
      Line(points = {{660, 660}, {690, 660}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation(
      Line(points = {{715, 696}, {700, 696}, {700, 668}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{24, 660}, {0, 660}, {0, 638}}, color = {176, 0, 0}));
    connect(dynamicPipe1.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{26, 560}, {0, 560}, {0, 584}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{620, 600}, {620, 570}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation(
      Line(points = {{781, 660}, {802, 660}, {802, 560}, {630, 560}}, color = {176, 0, 0}));
    connect(combiTimeTable_DemandHeat.y[2], gain1.u) annotation(
      Line(points = {{725, 826}, {766, 826}, {766, 796}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation(
      Line(points = {{-60, 479}, {-60, 468}, {-48, 468}, {-48, 460}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation(
      Line(points = {{-20, 479}, {-20, 435}, {-32, 435}, {-32, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-68, 520}, {-68, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-60, 520}, {-60, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation(
      Line(points = {{-27.5, 611}, {-66, 611}, {-66, 580}, {-52, 580}, {-52, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-28, 520}, {-28, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-20, 520}, {-20, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-12, 520}, {-12, 502}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation(
      Line(points = {{-40, 437}, {-40, 422}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[2], gain.u) annotation(
      Line(points = {{-399, 470}, {-362, 470}}, color = {0, 0, 127}));
    connect(gain1.y, gain2.u) annotation(
      Line(points = {{766, 773}, {766, 738}}, color = {0, 0, 127}));
    connect(gain2.y, consumer_simple.u_sink) annotation(
      Line(points = {{766, 715}, {766, 692.5}, {762, 692.5}, {762, 672}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, Electrolyzer.u_control_value) annotation(
      Line(points = {{-174, 628}, {-168, 628}, {-168, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, Electrolyzer.u_control_boolean) annotation(
      Line(points = {{-174, 630}, {-164, 630}, {-164, 622}}, color = {255, 0, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe2.enthalpyPort_b1) annotation(
      Line(points = {{640, 660}, {620, 660}, {620, 620}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation(
      Line(points = {{781, 668}, {800, 668}, {800, 696}, {738, 696}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation(
      Line(points = {{781, 664}, {820, 664}, {820, 540}, {690, 540}, {690, 532}}, color = {0, 0, 127}));
    connect(dynamicPipe1.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{46, 560}, {610, 560}}, color = {176, 0, 0}));
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation(
      Line(points = {{30, 632}, {10, 632}, {10, 632}, {10, 632}}, color = {191, 0, 0}));
    connect(Electrolyzer.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation(
      Line(points = {{-160, 600}, {-160, 600}, {-160, 560}, {-10, 560}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(Electrolyzer.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation(
      Line(points = {{-160, 622}, {-160, 622}, {-160, 660}, {-10, 660}, {-10, 638}, {-10, 638}}, color = {176, 0, 0}));
    connect(heatStorageVariablePorts_central.T_layers[5], Electrolyzer.u_T_setpoint) annotation(
      Line(points = {{-28, 612}, {-146, 612}, {-146, 604}, {-148, 604}}, color = {0, 0, 127}));
    connect(Electrolyzer.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-172, 604}, {-180, 604}, {-180, 550}, {-398, 550}, {-398, 550}}, color = {0, 0, 127}));
    connect(CHP2.y_P, product.u1) annotation(
      Line(points = {{-236, 635}, {-236, 480}, {-158, 480}, {-158, 450}}, color = {0, 0, 127}));
    connect(CHP2.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-252, 640}, {-252, 550}, {-398, 550}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], CHP2.u_T_setpoint) annotation(
      Line(points = {{-28, 612}, {-66, 612}, {-66, 640}, {-228, 640}}, color = {0, 0, 127}));
    connect(CHP2.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-240, 635}, {-240, 540}, {-10, 540}, {-10, 584}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_boolean, CHP2.u_control_boolean) annotation(
      Line(points = {{-254, 666}, {-244, 666}, {-244, 658}}, color = {255, 0, 255}));
    connect(CHP2.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-240, 657}, {-240, 662}, {-10, 662}, {-10, 638}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_value, CHP2.u_control_value) annotation(
      Line(points = {{-254, 664}, {-248, 664}, {-248, 658}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_value, CHP.u_control_value) annotation(
      Line(points = {{166, 628}, {172, 628}, {172, 622}, {172, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_boolean, CHP.u_control_boolean) annotation(
      Line(points = {{166, 632}, {176, 632}, {176, 622}, {176, 622}}, color = {255, 0, 255}));
    connect(dynamicPipe.enthalpyPort_b1, CHP.enthalpyPort_a) annotation(
      Line(points = {{44, 660}, {120, 660}, {120, 580}, {180, 580}, {180, 598}, {180, 598}}, color = {176, 0, 0}));
    connect(temperatureCHP.enthalpyPort_a, CHP.enthalpyPort_b) annotation(
      Line(points = {{230, 660}, {180, 660}, {180, 622}, {180, 622}}, color = {176, 0, 0}));
    connect(CHP.u_T_setpoint, temperatureCHP.T) annotation(
      Line(points = {{192, 604}, {240, 604}, {240, 648}, {240, 648}}, color = {0, 0, 127}));
    connect(const.y, CHP.u_T_setpoint_specification) annotation(
      Line(points = {{151, 604}, {168, 604}}, color = {0, 0, 127}));
    connect(temperatureBoiler.enthalpyPort_b, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{548, 660}, {640, 660}, {640, 660}, {640, 660}}, color = {176, 0, 0}));
    connect(const2.y, Boiler.u_T_setpoint_specification) annotation(
      Line(points = {{412, 604}, {426, 604}, {426, 604}, {428, 604}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_value, Boiler.u_control_value) annotation(
      Line(points = {{428, 626}, {432, 626}, {432, 622}, {432, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_boolean, Boiler.u_control_boolean) annotation(
      Line(points = {{428, 630}, {436, 630}, {436, 622}, {436, 622}}, color = {255, 0, 255}));
    connect(temperatureBoiler.enthalpyPort_a, Boiler.enthalpyPort_b) annotation(
      Line(points = {{530, 660}, {440, 660}, {440, 622}, {440, 622}}, color = {176, 0, 0}));
    connect(Boiler.u_T_setpoint, temperatureBoiler.T) annotation(
      Line(points = {{452, 604}, {540, 604}, {540, 650}, {540, 650}}, color = {0, 0, 127}));
    connect(temperatureCHP.enthalpyPort_b, Boiler.enthalpyPort_a) annotation(
      Line(points = {{248, 660}, {380, 660}, {380, 580}, {440, 580}, {440, 598}, {440, 598}}, color = {176, 0, 0}));
    connect(booleanConstant.y, controlBus_Boiler.control_boolean) annotation(
      Line(points = {{-398, 900}, {-280, 900}, {-280, 860}, {-280, 860}}, color = {255, 0, 255}));
    connect(pulseBoiler.y, controlBus_Boiler.control_value) annotation(
      Line(points = {{-398, 860}, {-282, 860}, {-282, 860}, {-280, 860}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.controlBus, controlBus_CHP) annotation(
      Line(points = {{160, 630}, {140, 630}, {140, 820}, {-290, 820}, {-290, 820}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO3.controlBus, controlBus_Boiler) annotation(
      Line(points = {{422, 628}, {400, 628}, {400, 860}, {-280, 860}, {-280, 860}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_CHP3) annotation(
      Line(points = {{-260, 666}, {-310, 666}, {-310, 740}, {-310, 740}}, color = {255, 204, 51}, thickness = 0.5));
    annotation(
      Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      experiment(StartTime = 0, StopTime = 604800, Tolerance = 1e-06, Interval = 3600));
  end V003_Quarree100;

  model V002_Quarree100
    extends Modelica.Icons.Example;
    parameter String Pfad = "Z:/owncloud/Consolinno/Projekte/Quarree100_Consolinno/Simulation_Modelica/";
    parameter String inputFileNameWeatherData = Pfad + "TRY2015_541957091051_Jahr.mos";
    parameter String inputFileNameCHP_P = Pfad + "Fahrplan_optCHP_P.txt";
    parameter String inputFileNameCHP_OP = Pfad + "Fahrplan_optCHP_OP.txt";
    parameter String inputFileNameElectrolyser_P = Pfad + "Fahrplan_optElectrolyser_P.txt";
    parameter String inputFileNameElectrolyser_OP = Pfad + "Fahrplan_optElectrolyser_OP.txt";
    parameter String inputFileNameBoiler = Pfad + "Fahrplan_optBoiler.txt";
    parameter String inputFileNameHeatPump = Pfad + "Fahrplan_optHeatPump.txt";
    parameter String inputFileNameHeatSword = Pfad + "Fahrplan_optHeatSword.txt";
    parameter String inputFileNameBat = Pfad + "Fahrplan_optBat.txt";
    parameter String inputFileNameDemandThermal = Pfad + "Waermebedarf_normiert.txt";
    parameter String inputFileNameDemandPower = Pfad + "Strombedarf_normiert.txt";
    parameter String inputFileNameEMob = Pfad + "EMobilitaet_normiert.txt";
    parameter String inputFileNameH2Mob = Pfad + "H2Mobilitaet_normiert.txt";
    parameter String inputFileNameSpot = Pfad + "SpotPreis.txt";
    Modelica.Blocks.Sources.Constant const1(k = 60 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-410, 550}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 7), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 6.37, dTank = 4, sIns = 0.2, lambdaIns = 0.032), load_cycles = [7, 1; 7, 1], n = 7, n_load_cycles = 2, n_unload_cycles = 1, unload_cycles = [1, 7], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {-5, 611}, extent = {{-25, -27}, {25, 27}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(
      Placement(visible = true, transformation(origin = {-410, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 818}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP1 annotation(
      Placement(visible = true, transformation(origin = {-290, 818}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {40, 632}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
      Placement(visible = true, transformation(origin = {-219, 669}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP2 annotation(
      Placement(visible = true, transformation(origin = {-300, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP3 annotation(
      Placement(visible = true, transformation(origin = {-310, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP3(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt Electrolyzer(T0 = 343.15, T_Out = 343.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation(
      Placement(visible = true, transformation(origin = {-160, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
      Placement(visible = true, transformation(origin = {-177, 629}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(visible = true, transformation(origin = {650, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(visible = true, transformation(origin = {620, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation(
      Placement(visible = true, transformation(origin = {690, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 65 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {730, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation(
      Placement(visible = true, transformation(origin = {-350, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {-164, 438}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {-136, 390}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {726, 696}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 20) annotation(
      Placement(visible = true, transformation(origin = {690, 730}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation(
      Placement(visible = true, transformation(origin = {700, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation(
      Placement(visible = true, transformation(origin = {770, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {34, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe1(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {36, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {620, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain1(k = 2000000) annotation(
      Placement(visible = true, transformation(origin = {766, 784}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = inputFileNameDemandThermal, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {714, 826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31 annotation(
      Placement(visible = true, transformation(origin = {-60, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation(
      Placement(visible = true, transformation(origin = {-20, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation(
      Placement(visible = true, transformation(origin = {-40, 448}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation(
      Placement(visible = true, transformation(origin = {-40, 410}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = inputFileNameSpot, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-410, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {766, 726}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Components.Producer_CHP_opt CHP2(T0 = 343.15, T_Out = 343.15, capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238) annotation(
      Placement(visible = true, transformation(origin = {-202, 650}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperatureCHP annotation(
      Placement(visible = true, transformation(origin = {238, 660}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation(
      Placement(visible = true, transformation(origin = {162, 630}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt_through CHP(uHigh = 2, uLow = 0) annotation(
      Placement(visible = true, transformation(origin = {180, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-370, 530}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(pulseCHP.y, controlBus_CHP1.control_value) annotation(
      Line(points = {{-399, 818}, {-290, 818}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_CHP1.control_boolean) annotation(
      Line(points = {{-399, 900}, {-290, 900}, {-290, 818}}, color = {255, 0, 255}));
    connect(pulseElectrolyzer.y, controlBus_CHP2.control_value) annotation(
      Line(points = {{-399, 780}, {-300, 780}}, color = {0, 0, 127}));
    connect(pulseCHP3.y, controlBus_CHP3.control_value) annotation(
      Line(points = {{-399, 740}, {-310, 740}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_CHP2.control_boolean) annotation(
      Line(points = {{-399, 900}, {-300, 900}, {-300, 780}}, color = {255, 0, 255}));
    connect(booleanConstant.y, controlBus_CHP3.control_boolean) annotation(
      Line(points = {{-399, 900}, {-310, 900}, {-310, 740}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_CHP1) annotation(
      Line(points = {{-222, 669}, {-290, 669}, {-290, 818}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_CHP2) annotation(
      Line(points = {{-180, 629}, {-300, 629}, {-300, 780}}, color = {255, 204, 51}, thickness = 0.5));
    connect(const3.y, PID.u_s) annotation(
      Line(points = {{719, 520}, {702, 520}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation(
      Line(points = {{679, 520}, {620, 520}, {620, 551}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation(
      Line(points = {{-339, 470}, {-170, 470}, {-170, 450}}, color = {0, 0, 127}));
    connect(product.y, integrator.u) annotation(
      Line(points = {{-164, 427}, {-164, 410.5}, {-136, 410.5}, {-136, 402}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation(
      Line(points = {{701, 730}, {726, 730}, {726, 708}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation(
      Line(points = {{660, 660}, {690, 660}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation(
      Line(points = {{715, 696}, {700, 696}, {700, 668}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{24, 660}, {0, 660}, {0, 638}}, color = {176, 0, 0}));
    connect(dynamicPipe1.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{26, 560}, {0, 560}, {0, 584}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{620, 600}, {620, 570}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation(
      Line(points = {{781, 660}, {802, 660}, {802, 560}, {630, 560}}, color = {176, 0, 0}));
    connect(combiTimeTable_DemandHeat.y[2], gain1.u) annotation(
      Line(points = {{725, 826}, {766, 826}, {766, 796}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation(
      Line(points = {{-60, 479}, {-60, 468}, {-48, 468}, {-48, 460}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation(
      Line(points = {{-20, 479}, {-20, 435}, {-32, 435}, {-32, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-68, 520}, {-68, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-60, 520}, {-60, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation(
      Line(points = {{-27.5, 611}, {-66, 611}, {-66, 580}, {-52, 580}, {-52, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-28, 520}, {-28, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-20, 520}, {-20, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-12, 520}, {-12, 502}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation(
      Line(points = {{-40, 437}, {-40, 422}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[2], gain.u) annotation(
      Line(points = {{-399, 470}, {-362, 470}}, color = {0, 0, 127}));
    connect(gain1.y, gain2.u) annotation(
      Line(points = {{766, 773}, {766, 738}}, color = {0, 0, 127}));
    connect(gain2.y, consumer_simple.u_sink) annotation(
      Line(points = {{766, 715}, {766, 692.5}, {762, 692.5}, {762, 672}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, Electrolyzer.u_control_value) annotation(
      Line(points = {{-174, 628}, {-168, 628}, {-168, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, Electrolyzer.u_control_boolean) annotation(
      Line(points = {{-174, 630}, {-164, 630}, {-164, 622}}, color = {255, 0, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe2.enthalpyPort_b1) annotation(
      Line(points = {{640, 660}, {620, 660}, {620, 620}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation(
      Line(points = {{781, 668}, {800, 668}, {800, 696}, {738, 696}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation(
      Line(points = {{781, 664}, {820, 664}, {820, 540}, {690, 540}, {690, 532}}, color = {0, 0, 127}));
    connect(dynamicPipe1.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{46, 560}, {610, 560}}, color = {176, 0, 0}));
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation(
      Line(points = {{30, 632}, {10, 632}, {10, 632}, {10, 632}}, color = {191, 0, 0}));
    connect(Electrolyzer.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation(
      Line(points = {{-160, 600}, {-160, 600}, {-160, 560}, {-10, 560}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(Electrolyzer.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation(
      Line(points = {{-160, 622}, {-160, 622}, {-160, 660}, {-10, 660}, {-10, 638}, {-10, 638}}, color = {176, 0, 0}));
    connect(heatStorageVariablePorts_central.T_layers[5], Electrolyzer.u_T_setpoint) annotation(
      Line(points = {{-28, 612}, {-146, 612}, {-146, 604}, {-148, 604}}, color = {0, 0, 127}));
    connect(Electrolyzer.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-172, 604}, {-180, 604}, {-180, 550}, {-398, 550}, {-398, 550}}, color = {0, 0, 127}));
    connect(CHP2.y_P, product.u1) annotation(
      Line(points = {{-198, 640}, {-198, 640}, {-198, 480}, {-158, 480}, {-158, 450}, {-158, 450}}, color = {0, 0, 127}));
    connect(CHP2.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-214, 644}, {-220, 644}, {-220, 550}, {-398, 550}, {-398, 550}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], CHP2.u_T_setpoint) annotation(
      Line(points = {{-28, 612}, {-66, 612}, {-66, 644}, {-190, 644}, {-190, 644}}, color = {0, 0, 127}));
    connect(CHP2.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-202, 640}, {-202, 640}, {-202, 540}, {-10, 540}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_boolean, CHP2.u_control_boolean) annotation(
      Line(points = {{-216, 670}, {-206, 670}, {-206, 662}, {-206, 662}}, color = {255, 0, 255}));
    connect(CHP2.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-202, 662}, {-202, 662}, {-202, 680}, {-10, 680}, {-10, 638}, {-10, 638}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_value, CHP2.u_control_value) annotation(
      Line(points = {{-216, 668}, {-210, 668}, {-210, 662}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.controlBus, controlBus_CHP3) annotation(
      Line(points = {{160, 630}, {140, 630}, {140, 740}, {-310, 740}, {-310, 740}}, color = {255, 204, 51}, thickness = 0.5));
    connect(temperatureCHP.enthalpyPort_b, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{248, 660}, {640, 660}, {640, 660}, {640, 660}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO.y_control_value, CHP.u_control_value) annotation(
      Line(points = {{166, 628}, {172, 628}, {172, 622}, {172, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_boolean, CHP.u_control_boolean) annotation(
      Line(points = {{166, 632}, {176, 632}, {176, 622}, {176, 622}}, color = {255, 0, 255}));
    connect(dynamicPipe.enthalpyPort_b1, CHP.enthalpyPort_a) annotation(
      Line(points = {{44, 660}, {120, 660}, {120, 580}, {180, 580}, {180, 598}, {180, 598}}, color = {176, 0, 0}));
    connect(temperatureCHP.enthalpyPort_a, CHP.enthalpyPort_b) annotation(
      Line(points = {{230, 660}, {180, 660}, {180, 622}, {180, 622}}, color = {176, 0, 0}));
    connect(CHP.u_T_setpoint, temperatureCHP.T) annotation(
      Line(points = {{192, 604}, {240, 604}, {240, 648}, {240, 648}}, color = {0, 0, 127}));
    connect(const.y, CHP.u_T_setpoint_specification) annotation(
      Line(points = {{-358, 530}, {160, 530}, {160, 604}, {168, 604}, {168, 604}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      experiment(StartTime = 0, StopTime = 604800, Tolerance = 1e-06, Interval = 3600));
  end V002_Quarree100;

  model V001_Quarree100
    extends Modelica.Icons.Example;
    parameter String Pfad = "Z:/owncloud/Consolinno/Projekte/Quarree100_Consolinno/Simulation_Modelica/";
    parameter String inputFileNameWeatherData = Pfad + "TRY2015_541957091051_Jahr.mos";
    parameter String inputFileNameCHP_P = Pfad + "Fahrplan_optCHP_P.txt";
    parameter String inputFileNameCHP_OP = Pfad + "Fahrplan_optCHP_OP.txt";
    parameter String inputFileNameElectrolyser_P = Pfad + "Fahrplan_optElectrolyser_P.txt";
    parameter String inputFileNameElectrolyser_OP = Pfad + "Fahrplan_optElectrolyser_OP.txt";
    parameter String inputFileNameBoiler = Pfad + "Fahrplan_optBoiler.txt";
    parameter String inputFileNameHeatPump = Pfad + "Fahrplan_optHeatPump.txt";
    parameter String inputFileNameHeatSword = Pfad + "Fahrplan_optHeatSword.txt";
    parameter String inputFileNameBat = Pfad + "Fahrplan_optBat.txt";
    parameter String inputFileNameDemandThermal = Pfad + "Waermebedarf_normiert.txt";
    parameter String inputFileNameDemandPower = Pfad + "Strombedarf_normiert.txt";
    parameter String inputFileNameEMob = Pfad + "EMobilitaet_normiert.txt";
    parameter String inputFileNameH2Mob = Pfad + "H2Mobilitaet_normiert.txt";
    parameter String inputFileNameSpot = Pfad + "SpotPreis.txt";
    Modelica.Blocks.Sources.Constant const1(k = 65 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-410, 550}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 7), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 6.37, dTank = 4, sIns = 0.2, lambdaIns = 0.032), load_cycles = [7, 1; 7, 1], n = 7, n_load_cycles = 2, n_unload_cycles = 1, unload_cycles = [1, 7], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {-5, 611}, extent = {{-25, -27}, {25, 27}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(
      Placement(visible = true, transformation(origin = {-410, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 818}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP1 annotation(
      Placement(visible = true, transformation(origin = {-290, 818}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {40, 632}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
      Placement(visible = true, transformation(origin = {-219, 669}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt CHP(T0 = 343.15, T_Out = 343.15, capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238) annotation(
      Placement(visible = true, transformation(origin = {-202, 650}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP2 annotation(
      Placement(visible = true, transformation(origin = {-300, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP3 annotation(
      Placement(visible = true, transformation(origin = {-310, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP3(amplitude = 1, period = 7200, width = 30) annotation(
      Placement(visible = true, transformation(origin = {-410, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt Electrolyzer(T0 = 343.15, T_Out = 343.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation(
      Placement(visible = true, transformation(origin = {-160, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
      Placement(visible = true, transformation(origin = {-177, 629}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(visible = true, transformation(origin = {650, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(visible = true, transformation(origin = {620, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation(
      Placement(visible = true, transformation(origin = {690, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 65 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {730, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation(
      Placement(visible = true, transformation(origin = {-350, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {-164, 438}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {-136, 390}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {726, 696}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 20) annotation(
      Placement(visible = true, transformation(origin = {690, 730}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation(
      Placement(visible = true, transformation(origin = {700, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation(
      Placement(visible = true, transformation(origin = {770, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {34, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe1(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {36, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {620, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain1(k = 2000000) annotation(
      Placement(visible = true, transformation(origin = {766, 784}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = inputFileNameDemandThermal, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {714, 826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31 annotation(
      Placement(visible = true, transformation(origin = {-60, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation(
      Placement(visible = true, transformation(origin = {-20, 490}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation(
      Placement(visible = true, transformation(origin = {-40, 448}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation(
      Placement(visible = true, transformation(origin = {-40, 410}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = inputFileNameSpot, tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-410, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {766, 726}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(pulseCHP.y, controlBus_CHP1.control_value) annotation(
      Line(points = {{-399, 818}, {-290, 818}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_CHP1.control_boolean) annotation(
      Line(points = {{-399, 900}, {-290, 900}, {-290, 818}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO2.y_control_value, CHP.u_control_value) annotation(
      Line(points = {{-216, 668}, {-210, 668}, {-210, 662}}, color = {0, 0, 127}));
    connect(pulseElectrolyzer.y, controlBus_CHP2.control_value) annotation(
      Line(points = {{-399, 780}, {-300, 780}}, color = {0, 0, 127}));
    connect(pulseCHP3.y, controlBus_CHP3.control_value) annotation(
      Line(points = {{-399, 740}, {-310, 740}}, color = {0, 0, 127}));
    connect(booleanConstant.y, controlBus_CHP2.control_boolean) annotation(
      Line(points = {{-399, 900}, {-300, 900}, {-300, 780}}, color = {255, 0, 255}));
    connect(booleanConstant.y, controlBus_CHP3.control_boolean) annotation(
      Line(points = {{-399, 900}, {-310, 900}, {-310, 740}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_CHP1) annotation(
      Line(points = {{-222, 669}, {-290, 669}, {-290, 818}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_CHP2) annotation(
      Line(points = {{-180, 629}, {-300, 629}, {-300, 780}}, color = {255, 204, 51}, thickness = 0.5));
    connect(const3.y, PID.u_s) annotation(
      Line(points = {{719, 520}, {702, 520}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation(
      Line(points = {{679, 520}, {620, 520}, {620, 551}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation(
      Line(points = {{-339, 470}, {-170, 470}, {-170, 450}}, color = {0, 0, 127}));
    connect(product.y, integrator.u) annotation(
      Line(points = {{-164, 427}, {-164, 410.5}, {-136, 410.5}, {-136, 402}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation(
      Line(points = {{701, 730}, {726, 730}, {726, 708}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation(
      Line(points = {{660, 660}, {690, 660}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation(
      Line(points = {{715, 696}, {700, 696}, {700, 668}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{710, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{24, 660}, {0, 660}, {0, 638}}, color = {176, 0, 0}));
    connect(dynamicPipe1.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{26, 560}, {0, 560}, {0, 584}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{620, 600}, {620, 570}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation(
      Line(points = {{781, 660}, {802, 660}, {802, 560}, {630, 560}}, color = {176, 0, 0}));
    connect(combiTimeTable_DemandHeat.y[2], gain1.u) annotation(
      Line(points = {{725, 826}, {766, 826}, {766, 796}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation(
      Line(points = {{-60, 479}, {-60, 468}, {-48, 468}, {-48, 460}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation(
      Line(points = {{-20, 479}, {-20, 435}, {-32, 435}, {-32, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 460}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-68, 520}, {-68, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-60, 520}, {-60, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation(
      Line(points = {{-27.5, 611}, {-66, 611}, {-66, 580}, {-52, 580}, {-52, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-28, 520}, {-28, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-20, 520}, {-20, 502}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation(
      Line(points = {{-27.5, 611}, {-40, 611}, {-40, 520}, {-12, 520}, {-12, 502}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation(
      Line(points = {{-40, 437}, {-40, 422}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[2], gain.u) annotation(
      Line(points = {{-399, 470}, {-362, 470}}, color = {0, 0, 127}));
    connect(gain1.y, gain2.u) annotation(
      Line(points = {{766, 773}, {766, 738}}, color = {0, 0, 127}));
    connect(gain2.y, consumer_simple.u_sink) annotation(
      Line(points = {{766, 715}, {766, 692.5}, {762, 692.5}, {762, 672}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, Electrolyzer.u_control_value) annotation(
      Line(points = {{-174, 628}, {-168, 628}, {-168, 622}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, Electrolyzer.u_control_boolean) annotation(
      Line(points = {{-174, 630}, {-164, 630}, {-164, 622}}, color = {255, 0, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe2.enthalpyPort_b1) annotation(
      Line(points = {{640, 660}, {620, 660}, {620, 620}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation(
      Line(points = {{781, 668}, {800, 668}, {800, 696}, {738, 696}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation(
      Line(points = {{781, 664}, {820, 664}, {820, 540}, {690, 540}, {690, 532}}, color = {0, 0, 127}));
    connect(dynamicPipe1.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{46, 560}, {610, 560}}, color = {176, 0, 0}));
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation(
      Line(points = {{30, 632}, {10, 632}, {10, 632}, {10, 632}}, color = {191, 0, 0}));
    connect(dynamicPipe.enthalpyPort_b1, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{44, 660}, {640, 660}, {640, 660}, {640, 660}}, color = {176, 0, 0}));
    connect(Electrolyzer.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation(
      Line(points = {{-160, 600}, {-160, 600}, {-160, 560}, {-10, 560}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(Electrolyzer.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation(
      Line(points = {{-160, 622}, {-160, 622}, {-160, 660}, {-10, 660}, {-10, 638}, {-10, 638}}, color = {176, 0, 0}));
    connect(CHP.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-202, 662}, {-202, 662}, {-202, 680}, {-10, 680}, {-10, 638}, {-10, 638}}, color = {176, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_boolean, CHP.u_control_boolean) annotation(
      Line(points = {{-216, 670}, {-206, 670}, {-206, 662}, {-206, 662}}, color = {255, 0, 255}));
    connect(CHP.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-202, 640}, {-202, 640}, {-202, 540}, {-10, 540}, {-10, 584}, {-10, 584}}, color = {176, 0, 0}));
    connect(heatStorageVariablePorts_central.T_layers[3], CHP.u_T_setpoint) annotation(
      Line(points = {{-28, 612}, {-66, 612}, {-66, 644}, {-190, 644}, {-190, 644}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], Electrolyzer.u_T_setpoint) annotation(
      Line(points = {{-28, 612}, {-146, 612}, {-146, 604}, {-148, 604}}, color = {0, 0, 127}));
    connect(Electrolyzer.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-172, 604}, {-180, 604}, {-180, 550}, {-398, 550}, {-398, 550}}, color = {0, 0, 127}));
    connect(CHP.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-214, 644}, {-220, 644}, {-220, 550}, {-398, 550}, {-398, 550}}, color = {0, 0, 127}));
    connect(CHP.y_P, product.u1) annotation(
      Line(points = {{-198, 640}, {-198, 640}, {-198, 480}, {-158, 480}, {-158, 450}, {-158, 450}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      experiment(StartTime = 0, StopTime = 604800, Tolerance = 1e-06, Interval = 3600));
  end V001_Quarree100;

  model Sim_Umgebung
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Constant const1(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-570, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = 1117800) annotation(
      Placement(visible = true, transformation(origin = {-518, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = "Z:/owncloud/Consolinno/Projekte/ZukunftsR/Optimierung_Modelica_RoitherBerg/Modelica/Lastprofile.txt", tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-570, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = "Z:/owncloud/Consolinno/Projekte/ZukunftsR/Optimierung_Modelica_RoitherBerg/Modelica/Lastprofile.txt", tableName = "tab3", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-570, -250}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.FMUs.FMU_EinfachesModell FMU annotation(
      Placement(visible = true, transformation(origin = {33.6416, -46.5472}, extent = {{-253.642, -169.094}, {84.5472, 84.5472}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_CHP1(fileName = "Z:/owncloud/Consolinno/Projekte/ZukunftsR/Optimierung_Modelica_RoitherBerg/R_Script/Fahrplan_optCHP1.txt", tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-570, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_CHP2(fileName = "Z:/owncloud/Consolinno/Projekte/ZukunftsR/Optimierung_Modelica_RoitherBerg/R_Script/Fahrplan_optCHP2.txt", tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-570, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_CHP3(fileName = "Z:/owncloud/Consolinno/Projekte/ZukunftsR/Optimierung_Modelica_RoitherBerg/R_Script/Fahrplan_optCHP3.txt", tableName = "tab1", tableOnFile = true) annotation(
      Placement(visible = true, transformation(origin = {-570, -130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(combiTimeTable_DemandHeat.y[2], gain1.u) annotation(
      Line(points = {{-559, 90}, {-518, 90}, {-518, 60}}, color = {0, 0, 127}));
    connect(FMU.u_DemandHeat, gain1.y) annotation(
      Line(points = {{-293, -3}, {-518, -3}, {-518, 38}}, color = {0, 0, 127}));
    connect(FMU.u_controlOn, const1.y) annotation(
      Line(points = {{-293, -20}, {-559, -20}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[2], FMU.u_Spot) annotation(
      Line(points = {{-558, -250}, {-460, -250}, {-460, -185}, {-293, -185}}, color = {0, 0, 127}));
    connect(combiTimeTable_CHP3.y[2], FMU.u_CHP3) annotation(
      Line(points = {{-558, -130}, {-340, -130}, {-340, -72}, {-293, -72}, {-293, -70}}, color = {0, 0, 127}));
    connect(combiTimeTable_CHP2.y[2], FMU.u_CHP2) annotation(
      Line(points = {{-558, -100}, {-360, -100}, {-360, -53}, {-293, -53}}, color = {0, 0, 127}));
    connect(combiTimeTable_CHP1.y[2], FMU.u_CHP1) annotation(
      Line(points = {{-558, -70}, {-380, -70}, {-380, -37}, {-293, -37}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-600, -400}, {200, 200}})),
      Icon(coordinateSystem(extent = {{-600, -400}, {200, 200}})),
      experiment(StartTime = 0, StopTime = 86400, Tolerance = 1e-06, Interval = 3600));
  end Sim_Umgebung;
  annotation(
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
    Documentation(info = "<html>
      <p>Im package Simulations werden alle Modelle der unterschiedlichen Simulationen abgelegt.</p>
      <p>Erstellt wurden die Simulationsmodelle durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
end Simulations;
