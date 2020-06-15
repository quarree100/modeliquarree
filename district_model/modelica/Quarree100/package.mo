package Quarree100
  extends Modelica.Icons.Package;

  package Simulations
    extends Modelica.Icons.ExamplesPackage;

    model SIM_RI_Schema
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
      Quarree100.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
        Placement(visible = true, transformation(origin = {-570, 684}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      AixLib.BoundaryConditions.WeatherData.Bus controlBus_Electrolyzer annotation(
        Placement(visible = true, transformation(origin = {-820, 892}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.BoundaryConditions.WeatherData.Bus controlBus_HeatPumpAir annotation(
        Placement(visible = true, transformation(origin = {-820, 832}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation(
        Placement(visible = true, transformation(origin = {-970, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Pulse pulseHeatPumpAir(amplitude = 0, period = 7200, width = 30) annotation(
        Placement(visible = true, transformation(origin = {-970, 840}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Quarree100.Components.Producer_CHP_opt Electrolyzer(T0 = 368.15, T_Out = 368.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation(
        Placement(visible = true, transformation(origin = {-530, 810}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      Quarree100.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
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
      Quarree100.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation(
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
      Quarree100.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation(
        Placement(visible = true, transformation(origin = {-489, 243}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Quarree100.Components.Producer_CHP_opt CHP(capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238, uHigh = 1, uLow = -6) annotation(
        Placement(visible = true, transformation(origin = {-450, 190}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 73 + 273.15) annotation(
        Placement(visible = true, transformation(origin = {-510, 174}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_HeatGrid_FF annotation(
        Placement(visible = true, transformation(origin = {310, 340}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const2(k = 71 + 273.15) annotation(
        Placement(visible = true, transformation(origin = {-510, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Quarree100.Components.Producer_Boiler_opt Boiler(Q_nom = 2000000, uHigh = 343.15, uLow = 338.15) annotation(
        Placement(visible = true, transformation(origin = {-450, 30}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      Quarree100.Components.bus2SOBoolean_SO bus2SOBoolean_SO3 annotation(
        Placement(visible = true, transformation(origin = {-489, 83}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
      Modelica.Blocks.Sources.Pulse pulseBoiler(amplitude = 1, period = 7200, width = 30) annotation(
        Placement(visible = true, transformation(origin = {-970, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.BoundaryConditions.WeatherData.Bus controlBus_Boiler annotation(
        Placement(visible = true, transformation(origin = {-820, 652}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Quarree100.Components.Producer_HePu_opt HePu_Air(Scale_Factor = 100, T_Out = 368.15) annotation(
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
      Quarree100.Components.busbar_4consumer busbar_4consumer annotation(
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
      Quarree100.Components.Producer_HePu_opt HePu_Geo(Scale_Factor = 50, T_Out = 368.15) annotation(
        Placement(visible = true, transformation(origin = {-530, 450}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constHeatPumpGeo_mdot_amb(k = 100) annotation(
        Placement(visible = true, transformation(origin = {-650, 456}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant constHeatPumpGeo_T_setpoint_specification(k = 77 + 273.15) annotation(
        Placement(visible = true, transformation(origin = {-590, 430}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Quarree100.Components.bus2SOBoolean_SO bus2SOBoolean_SO4 annotation(
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
        experiment(StopTime = 31536000, Interval = 3600, Tolerance = 1e-06, StartTime = 0));
    end SIM_RI_Schema;
    annotation(
      uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
      Documentation(info = "<html>
      <p>Im package Simulations werden alle Modelle der unterschiedlichen Simulationen abgelegt.</p>
      <p>Erstellt wurden die Simulationsmodelle durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
  end Simulations;

  package Components
    extends Modelica.Icons.Package;

    model Producer_Boiler_opt "Gasboiler with simple and optimized control and with pump"
      extends Modelica.Icons.Package;
      parameter Modelica.SIunits.Temperature T_start = 353.15 "Inital temperature" annotation(
        Dialog(tab = "General"));
      parameter Modelica.SIunits.Temperature T_Out = 353.15 "Output temperature" annotation(
        Dialog(tab = "General"));
      parameter Modelica.SIunits.Temperature uLow = 341.15 "Value of deltaT for switching on" annotation(
        Dialog(tab = "General"));
      parameter Modelica.SIunits.Temperature uHigh = 343.15 "Value of deltaT for switching off" annotation(
        Dialog(tab = "General"));
      parameter Real Q_nom = 200000 "Nominal power of gasboiler" annotation(
        Dialog(tab = "General"));
      parameter Real Q_min = 200000 * 0.0 "Minimal power of gasboiler" annotation(
        Dialog(tab = "General"));
      Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
        Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
      Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
        Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
        Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
        Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
        Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      AixLib.FastHVAC.Components.HeatGenerators.Boiler.Boiler Boiler(T_start = T_start, paramBoiler = AixLib.FastHVAC.Data.Boiler.General.Boiler_Vitocrossal200_311kW(Q_nom = Q_nom, Q_min = Q_min)) annotation(
        Placement(visible = true, transformation(origin = {22, 0}, extent = {{-20, -22}, {20, 22}}, rotation = 0)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
        Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Quarree100.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation(
        Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
        Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
        Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput y_dotE = Boiler.dotE_gas annotation(
        Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput y_dotQ = Boiler.heater.Q_flow annotation(
        Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Continuous.LimPID pid(Ti = 1, controllerType = .Modelica.Blocks.Types.SimpleController.PID, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.0001, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0) annotation(
        Placement(visible = true, transformation(origin = {-80, 12}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.Switch switch1 annotation(
        Placement(visible = true, transformation(origin = {-40, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const(k = 0) annotation(
        Placement(visible = true, transformation(origin = {-95, 43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uHigh = uHigh, uLow = uLow) annotation(
        Placement(visible = true, transformation(origin = {-40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0.000000000001, y_start = 0.000000000001) annotation(
        Placement(visible = true, transformation(origin = {30, -70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Pumps.Pump pump annotation(
        Placement(visible = true, transformation(origin = {0, -70}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant const1(k = T_Out) annotation(
        Placement(visible = true, transformation(origin = {70, -90}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    equation
      connect(Boiler.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation(
        Line(points = {{32, 0}, {40, 0}, {40, 42}}, color = {176, 0, 0}));
      connect(TemperatureInput.enthalpyPort_b, Boiler.enthalpyPort_a1) annotation(
        Line(points = {{-60, -20}, {-60, 0}, {12, 0}}, color = {176, 0, 0}));
      connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
        Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
      connect(control_opt_SI_BooleanSI.y_control_boolean, Boiler.onOff_boiler) annotation(
        Line(points = {{1, 26}, {28, 26}, {28, 15}}, color = {255, 0, 255}));
      connect(control_opt_SI_BooleanSI.y_control, Boiler.dotQ_rel) annotation(
        Line(points = {{1, 20}, {18, 20}, {18, 15}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation(
        Line(points = {{-10, 32}, {-10, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation(
        Line(points = {{-4, 32}, {-4, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
      connect(pid.u_s, u_T_setpoint_specification) annotation(
        Line(points = {{-92, 12}, {-92, -60}, {-120, -60}}, color = {0, 0, 127}));
      connect(pid.u_m, u_T_setpoint) annotation(
        Line(points = {{-80, 24}, {-80, 70}, {80, 70}, {80, -60}, {120, -60}}, color = {0, 0, 127}));
      connect(const.y, switch1.u3) annotation(
        Line(points = {{-90, 44}, {-60, 44}, {-60, 28}, {-52, 28}, {-52, 28}}, color = {0, 0, 127}));
      connect(hysteresis.y, switch1.u2) annotation(
        Line(points = {{-52, 50}, {-66, 50}, {-66, 20}, {-52, 20}, {-52, 20}}, color = {255, 0, 255}));
      connect(u_T_setpoint, hysteresis.u) annotation(
        Line(points = {{120, -60}, {80, -60}, {80, 70}, {-20, 70}, {-20, 50}, {-28, 50}, {-28, 50}}, color = {0, 0, 127}));
      connect(pump.enthalpyPort_a, enthalpyPort_a) annotation(
        Line(points = {{0, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
      connect(pump.dotm_setValue, PID_Pump.y) annotation(
        Line(points = {{8, -70}, {19, -70}}, color = {0, 0, 127}));
      connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation(
        Line(points = {{-60, -38}, {-60, -38}, {-60, -50}, {0, -50}, {0, -60}, {0, -60}}, color = {176, 0, 0}));
      connect(const1.y, PID_Pump.u_m) annotation(
        Line(points = {{60, -90}, {30, -90}, {30, -82}, {30, -82}}, color = {0, 0, 127}));
      connect(TemperatureOutput.T, PID_Pump.u_s) annotation(
        Line(points = {{52, 52}, {60, 52}, {60, -70}, {42, -70}, {42, -70}}, color = {0, 0, 127}));
      connect(pid.y, control_opt_SI_BooleanSI.u_control_standard) annotation(
        Line(points = {{-68, 12}, {-60, 12}, {-60, 4}, {-22, 4}, {-22, 20}, {-22, 20}}, color = {0, 0, 127}));
      connect(switch1.u1, pid.y) annotation(
        Line(points = {{-52, 12}, {-68, 12}, {-68, 12}, {-68, 12}}, color = {0, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>
This component simiulate a basboiler with a simple control system. 

<p>
Parameter:  
<p> 
<strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 


</html>"),
        Diagram,
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
    end Producer_Boiler_opt;

    model Producer_CHP_opt "CHP with pump and simple and optimized control"
      extends Modelica.Icons.Package;
      parameter Modelica.SIunits.Temperature T_Out = 353.15 "Output temperature" annotation(
        Dialog(tab = "General"));
      parameter Modelica.SIunits.Temperature T0 = 353.15 "Initial temperature" annotation(
        Dialog(tab = "General"));
      parameter Real uLow = -5 "Value of deltaT for switching on" annotation(
        Dialog(tab = "General"));
      parameter Real uHigh = 5 "Value of deltaT for switching off" annotation(
        Dialog(tab = "General"));
      parameter Real eta_el = 0.35 "Efficiency of electrical production" annotation(
        Dialog(tab = "General"));
      parameter Real eta_th = 0.6 "Efficiency of thermal production" annotation(
        Dialog(tab = "General"));
      parameter Real capP_el = 9000 "Electrical power" annotation(
        Dialog(tab = "General"));
      Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
        Placement(visible = true, transformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
      Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
        Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
        Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const_T_Out(k = T_Out) annotation(
        Placement(visible = true, transformation(origin = {70, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Continuous.LimPID PID_pump(initType = .Modelica.Blocks.Types.InitPID.InitialOutput, limitsAtInit = true, yMax = 100, yMin = 0.000000000001, y_start = 0.000000000001) annotation(
        Placement(visible = true, transformation(origin = {20, -60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Pumps.Pump pump annotation(
        Placement(visible = true, transformation(origin = {-60, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
        Placement(visible = true, transformation(origin = {-60, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
        Placement(visible = true, transformation(origin = {40, 50}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
        Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
        Placement(visible = true, transformation(origin = {-60, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation(
        Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = uHigh, uLow = uLow) annotation(
        Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Quarree100.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation(
        Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
        Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
        Placement(visible = true, transformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      AixLib.FastHVAC.Components.HeatGenerators.CHP.CHP_PT1 chp(T0 = T0, capP_el = capP_el, eta_el = eta_el, eta_th = eta_th, selectable = false) annotation(
        Placement(visible = true, transformation(origin = {10, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_dotE = chp.Capacity[3] annotation(
        Placement(visible = true, transformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-80, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput y_dotQ = chp.Capacity[2] annotation(
        Placement(visible = true, transformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput y_P = chp.Capacity[1] annotation(
        Placement(visible = true, transformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(const_T_Out.y, PID_pump.u_m) annotation(
        Line(points = {{60, -80}, {20, -80}, {20, -72}, {20, -72}}, color = {0, 0, 127}));
      connect(PID_pump.y, pump.dotm_setValue) annotation(
        Line(points = {{10, -60}, {-50, -60}, {-50, -60}, {-52, -60}}, color = {0, 0, 127}));
      connect(pump.enthalpyPort_a, enthalpyPort_a) annotation(
        Line(points = {{-60, -70}, {-60, -70}, {-60, -80}, {0, -80}, {0, -110}, {0, -110}}, color = {176, 0, 0}));
      connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation(
        Line(points = {{-60, -38}, {-60, -38}, {-60, -50}, {-60, -50}}, color = {176, 0, 0}));
      connect(TemperatureOutput.T, PID_pump.u_s) annotation(
        Line(points = {{52, 52}, {60, 52}, {60, -60}, {32, -60}, {32, -60}}, color = {0, 0, 127}));
      connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
        Line(points = {{40, 60}, {40, 80}, {0, 80}, {0, 110}}, color = {176, 0, 0}));
      connect(u_T_setpoint_specification, add.u2) annotation(
        Line(points = {{-120, -60}, {-90, -60}, {-90, 54}, {-82, 54}}, color = {0, 0, 127}));
      connect(add.y, hysteresis.u) annotation(
        Line(points = {{-59, 60}, {-52, 60}}, color = {0, 0, 127}));
      connect(add.u1, u_T_setpoint) annotation(
        Line(points = {{-82, 66}, {-90, 66}, {-90, 90}, {90, 90}, {90, -60}, {120, -60}}, color = {0, 0, 127}));
      connect(booleanToReal.y, control_opt_SI_BooleanSI.u_control_standard) annotation(
        Line(points = {{-48, 20}, {-26, 20}}, color = {0, 0, 127}));
      connect(booleanToReal.u, hysteresis.y) annotation(
        Line(points = {{-72, 20}, {-80, 20}, {-80, 40}, {-20, 40}, {-20, 60}, {-29, 60}}, color = {255, 0, 255}));
      connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation(
        Line(points = {{-14, 32}, {-14, 80}, {-80, 80}, {-80, 120}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation(
        Line(points = {{-8, 32}, {-8, 84}, {-40, 84}, {-40, 120}}, color = {255, 0, 255}));
      connect(control_opt_SI_BooleanSI.y_control, chp.P_elRel) annotation(
        Line(points = {{-2, 20}, {16, 20}, {16, 0}, {16, 0}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.y_control_boolean, chp.onOff) annotation(
        Line(points = {{-2, 26}, {6, 26}, {6, 0}, {6, 0}}, color = {255, 0, 255}));
      connect(chp.enthalpyPort_a, TemperatureInput.enthalpyPort_b) annotation(
        Line(points = {{0, -10}, {-60, -10}, {-60, -20}, {-60, -20}}, color = {176, 0, 0}));
      connect(chp.enthalpyPort_b, TemperatureOutput.enthalpyPort_a) annotation(
        Line(points = {{20, -10}, {40, -10}, {40, 42}, {40, 42}}, color = {176, 0, 0}));
      annotation(
        Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
        Diagram,
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
    end Producer_CHP_opt;

    model Producer_HePu_opt "HeatPump with pump and simple and optimized control"
      extends Modelica.Icons.Package;
      parameter Modelica.SIunits.Temperature T_Out = 323.15 "Output temperature" annotation(
        Dialog(tab = "General"));
      parameter Real uLow = -5 "Value of deltaT for switching on" annotation(
        Dialog(tab = "General"));
      parameter Real uHigh = 5 "Value of deltaT for switching off" annotation(
        Dialog(tab = "General"));
      parameter Real Scale_Factor = 1 "Scale factor for heat production power" annotation(
        Dialog(tab = "General"));
      Modelica.Blocks.Interfaces.RealInput u_T_setpoint annotation(
        Placement(visible = true, transformation(origin = {160, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 180), iconTransformation(origin = {120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 180)));
      Modelica.Blocks.Interfaces.RealInput u_T_setpoint_specification annotation(
        Placement(visible = true, transformation(origin = {-160, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
        Placement(visible = true, transformation(origin = {0, -150}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const_T_Out(k = T_Out) annotation(
        Placement(visible = true, transformation(origin = {110, -120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Continuous.LimPID PID_pump(initType = .Modelica.Blocks.Types.InitPID.InitialOutput, limitsAtInit = true, yMax = 1000, yMin = 0, y_start = 0.1) annotation(
        Placement(visible = true, transformation(origin = {40, -100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Pumps.Pump pump annotation(
        Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
        Placement(visible = true, transformation(origin = {0, -58}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
        Placement(visible = true, transformation(origin = {0, 98}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
        Placement(visible = true, transformation(origin = {0, 150}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
        Placement(visible = true, transformation(origin = {-92, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add(k1 = -1, k2 = +1) annotation(
        Placement(visible = true, transformation(origin = {-110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = false, uHigh = uHigh, uLow = uLow) annotation(
        Placement(visible = true, transformation(origin = {-80, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Quarree100.Components.control_opt_SI_BooleanSI control_opt_SI_BooleanSI annotation(
        Placement(visible = true, transformation(origin = {-46, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
        Placement(visible = true, transformation(origin = {-80, 160}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-78, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
        Placement(visible = true, transformation(origin = {-40, 160}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-38, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput y_dotQ = heatPump.innerCycle.PerformanceDataHPHeating.QCon annotation(
        Placement(visible = true, transformation(origin = {-40, -150}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput y_P = heatPump.innerCycle.PerformanceDataHPHeating.Pel annotation(
        Placement(visible = true, transformation(origin = {40, -150}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {40, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump(redeclare model PerDataHea = AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D(dataTable = AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(tableQdot_con = [0, -15, -7, 2, 7, 10, 20, 30; 35, 3020 * Scale_Factor, 3810 * Scale_Factor, 2610 * Scale_Factor, 3960 * Scale_Factor, 4340 * Scale_Factor, 5350 * Scale_Factor, 6610 * Scale_Factor; 45, 3020 * Scale_Factor, 3780 * Scale_Factor, 2220 * Scale_Factor, 3870 * Scale_Factor, 4120 * Scale_Factor, 5110 * Scale_Factor, 6310 * Scale_Factor; 55, 3120 * Scale_Factor, 3790 * Scale_Factor, 2430 * Scale_Factor, 3610 * Scale_Factor, 3910 * Scale_Factor, 4850 * Scale_Factor, 6000 * Scale_Factor], tableP_ele = [0, -15, -7, 2, 7, 10, 20, 30; 35, 1290 * Scale_Factor, 1310 * Scale_Factor, 730 * Scale_Factor, 870 * Scale_Factor, 850 * Scale_Factor, 830 * Scale_Factor, 780 * Scale_Factor; 45, 1550 * Scale_Factor, 1600 * Scale_Factor, 870 * Scale_Factor, 1110 * Scale_Factor, 1090 * Scale_Factor, 1080 * Scale_Factor, 1040 * Scale_Factor; 55, 1870 * Scale_Factor, 1940 * Scale_Factor, 1170 * Scale_Factor, 1370 * Scale_Factor, 1370 * Scale_Factor, 1370 * Scale_Factor, 1350 * Scale_Factor], mFlow_conNom = 3960 / 4180 / 5 * Scale_Factor, mFlow_evaNom = 2250 * 1.2 / 3600 * Scale_Factor, tableUppBou = [-20, 50; -10, 60; 30, 60; 35, 55], tableLowBou = [-20, 25; 25, 25; 35, 35])), redeclare model PerDataChi = AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.LookUpTable2D(dataTable = AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(tableQdot_con = [0, 20, 25, 27, 30, 35; 7, 2540 * Scale_Factor, 2440 * Scale_Factor, 2370 * Scale_Factor, 2230 * Scale_Factor, 2170 * Scale_Factor; 18, 5270 * Scale_Factor, 5060 * Scale_Factor, 4920 * Scale_Factor, 4610 * Scale_Factor, 4500 * Scale_Factor], tableP_ele = [0, 20, 25, 27, 30, 35; 7, 1380 * Scale_Factor, 1590 * Scale_Factor, 1680 * Scale_Factor, 1800 * Scale_Factor, 1970 * Scale_Factor; 18, 950 * Scale_Factor, 1060 * Scale_Factor, 1130 * Scale_Factor, 1200 * Scale_Factor, 1350 * Scale_Factor], mFlow_conNom = 3960 / 4180 / 5 * Scale_Factor, mFlow_evaNom = 2250 * 1.2 / 3600 * Scale_Factor, tableUppBou = [20, 20; 35, 20], tableLowBou = [20, 5; 35, 5])), CCon = 100, CEva = 100, GCon = 5, GEva = 5, Q_useNominal = 0, TAmbCon_nominal = 288.15, TCon_start(displayUnit = "K"), TEva_start(displayUnit = "K"), VCon = 0.4, VEva = 0.04, allowFlowReversalEva = true, deltaM_con = 0.1, deltaM_eva = 0.1, mFlow_conNominal = 0.5, mFlow_evaNominal = 0.5, refIneFre_constant = 1, transferHeat = true, use_ConCap = false, use_EvaCap = false, use_autoCalc = false, use_refIne = true, use_revHP = true) annotation(
        Placement(visible = true, transformation(origin = {-8, 28.6667}, extent = {{-13.3333, 16}, {13.3333, -16}}, rotation = 90)));
      AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource annotation(
        Placement(visible = true, transformation(origin = {-72, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Sinks.Vessel vessel annotation(
        Placement(visible = true, transformation(origin = {-66, 6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 1) annotation(
        Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_T_fluid_source annotation(
        Placement(visible = true, transformation(origin = {-160, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_dotm_source annotation(
        Placement(visible = true, transformation(origin = {-160, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 24}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      connect(const_T_Out.y, PID_pump.u_m) annotation(
        Line(points = {{99, -120}, {40.5, -120}, {40.5, -112}, {40, -112}}, color = {0, 0, 127}));
      connect(PID_pump.y, pump.dotm_setValue) annotation(
        Line(points = {{29, -100}, {8, -100}}, color = {0, 0, 127}));
      connect(pump.enthalpyPort_a, enthalpyPort_a) annotation(
        Line(points = {{0, -109.6}, {0, -150}}, color = {176, 0, 0}));
      connect(TemperatureInput.enthalpyPort_a, pump.enthalpyPort_b) annotation(
        Line(points = {{-0.1, -66.8}, {-0.1, -78.4}, {0, -78.4}, {0, -90.4}}, color = {176, 0, 0}));
      connect(TemperatureOutput.T, PID_pump.u_s) annotation(
        Line(points = {{11, 99}, {60, 99}, {60, -100}, {52, -100}}, color = {0, 0, 127}));
      connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
        Line(points = {{-0.1, 107}, {-0.1, 128}, {0, 128}, {0, 150}}, color = {176, 0, 0}));
      connect(u_T_setpoint_specification, add.u2) annotation(
        Line(points = {{-160, -60}, {-122, -60}}, color = {0, 0, 127}));
      connect(add.y, hysteresis.u) annotation(
        Line(points = {{-99, -54}, {-92, -54}}, color = {0, 0, 127}));
      connect(add.u1, u_T_setpoint) annotation(
        Line(points = {{-122, -48}, {-122, -47}, {-130, -47}, {-130, 120}, {90, 120}, {90, -60}, {160, -60}}, color = {0, 0, 127}));
      connect(booleanToReal.y, control_opt_SI_BooleanSI.u_control_standard) annotation(
        Line(points = {{-81, -20}, {-58, -20}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_value, u_control_value) annotation(
        Line(points = {{-46, -8}, {-46, 110}, {-80, 110}, {-80, 160}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.u_control_boolean, u_control_boolean) annotation(
        Line(points = {{-40, -8}, {-40, 160}}, color = {255, 0, 255}));
      connect(heatPump.enthalpyPort_a, TemperatureInput.enthalpyPort_b) annotation(
        Line(points = {{0, 15.3334}, {0, 15.3334}, {0, -49}, {-0.1, -49}}, color = {176, 0, 0}));
      connect(TemperatureOutput.enthalpyPort_a, heatPump.enthalpyPort_b) annotation(
        Line(points = {{-0.1, 89.2}, {-0.1, 89.2}, {-0.1, 42}, {0, 42}}, color = {176, 0, 0}));
      connect(hysteresis.y, booleanToReal.u) annotation(
        Line(points = {{-69, -54}, {-60, -54}, {-60, -36}, {-120, -36}, {-120, -20}, {-104, -20}, {-104, -20}}, color = {255, 0, 255}));
      connect(control_opt_SI_BooleanSI.y_control, heatPump.nSet) annotation(
        Line(points = {{-35, -20}, {-6, -20}, {-6, 13.2001}, {-5.33333, 13.2001}}, color = {0, 0, 127}));
      connect(control_opt_SI_BooleanSI.y_control_boolean, heatPump.modeSet) annotation(
        Line(points = {{-35, -14}, {-10, -14}, {-10, 13.2001}, {-10.4, 13.2001}}, color = {255, 0, 255}));
      connect(vessel.enthalpyPort_a, heatPump.enthalpyPort_b1) annotation(
        Line(points = {{-59, 6}, {-16, 6}, {-16, 15.3334}, {-16, 15.3334}}, color = {176, 0, 0}));
      connect(fluidSource.enthalpyPort_b, heatPump.enthalpyPort_a1) annotation(
        Line(points = {{-62, 63}, {-16, 63}, {-16, 42}}, color = {176, 0, 0}));
      connect(const.y, heatPump.iceFac_in) annotation(
        Line(points = {{-79, 20}, {-26, 20}, {-26, 18.5334}, {-26.1333, 18.5334}}, color = {0, 0, 127}));
      connect(u_T_fluid_source, fluidSource.T_fluid) annotation(
        Line(points = {{-160, 100}, {-100, 100}, {-100, 66.2}, {-80, 66.2}}, color = {0, 0, 127}));
      connect(u_dotm_source, fluidSource.dotm) annotation(
        Line(points = {{-160, 60}, {-82, 60}, {-82, 59.4}, {-80, 59.4}}, color = {0, 0, 127}));
      annotation(
        Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
        Diagram(coordinateSystem(extent = {{-140, -140}, {140, 140}})),
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
    end Producer_HePu_opt;

    model control_opt_SI_BooleanSI "Control unit for optimization"
      extends Modelica.Icons.Package;
      Modelica.Blocks.Interfaces.RealInput u_control_standard annotation(
        Placement(visible = true, transformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180), iconTransformation(origin = {-120, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 180)));
      Modelica.Blocks.Interfaces.RealOutput y_control annotation(
        Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold = 0.0001) annotation(
        Placement(visible = true, transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch1 annotation(
        Placement(visible = true, transformation(origin = {70, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.LogicalSwitch logicalSwitch annotation(
        Placement(visible = true, transformation(origin = {70, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Interfaces.BooleanOutput y_control_boolean annotation(
        Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_control_value annotation(
        Placement(visible = true, transformation(origin = {0, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90), iconTransformation(origin = {0, 120}, extent = {{20, -20}, {-20, 20}}, rotation = 90)));
      Modelica.Blocks.Interfaces.BooleanInput u_control_boolean annotation(
        Placement(visible = true, transformation(origin = {40, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    equation
      connect(realToBoolean.y, switch1.u2) annotation(
        Line(points = {{-18, 20}, {-10, 20}, {-10, 0}, {58, 0}}, color = {255, 0, 255}));
      connect(u_control_standard, realToBoolean.u) annotation(
        Line(points = {{-120, 0}, {-60, 0}, {-60, 20}, {-42, 20}, {-42, 20}}, color = {0, 0, 127}));
      connect(u_control_standard, switch1.u1) annotation(
        Line(points = {{-120, 0}, {-60, 0}, {-60, -8}, {58, -8}}, color = {0, 0, 127}));
      connect(switch1.y, y_control) annotation(
        Line(points = {{81, 0}, {110, 0}}, color = {0, 0, 127}));
      connect(logicalSwitch.u1, realToBoolean.y) annotation(
        Line(points = {{58, 52}, {-10, 52}, {-10, 20}, {-18, 20}}, color = {255, 0, 255}));
      connect(logicalSwitch.u2, realToBoolean.y) annotation(
        Line(points = {{58, 60}, {-10, 60}, {-10, 20}, {-18, 20}}, color = {255, 0, 255}));
      connect(logicalSwitch.y, y_control_boolean) annotation(
        Line(points = {{81, 60}, {110, 60}}, color = {255, 0, 255}));
      connect(switch1.u3, u_control_value) annotation(
        Line(points = {{58, 8}, {0, 8}, {0, 120}, {0, 120}}, color = {0, 0, 127}));
      connect(logicalSwitch.u3, u_control_boolean) annotation(
        Line(points = {{58, 68}, {40, 68}, {40, 120}, {40, 120}}, color = {255, 0, 255}));
      annotation(
        Documentation(info = "<html>
    <p>
    This component represents the control unit for optimized control. 
    
    <p>
    
    
    
    </html>"),
        Diagram,
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {2, -246}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
        experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
    end control_opt_SI_BooleanSI;

    model bus2SOBoolean_SO
      extends Modelica.Icons.Package;
      AixLib.BoundaryConditions.WeatherData.Bus controlBus annotation(
        Placement(visible = true, transformation(origin = {-99, -1}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_control_value annotation(
        Placement(visible = true, transformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.BooleanOutput y_control_boolean annotation(
        Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(y_control_boolean, controlBus.control_boolean) annotation(
        Line(points = {{110, 40}, {0, 40}, {0, 0}, {-98, 0}, {-98, 0}}, color = {255, 0, 255}));
      connect(y_control_value, controlBus.control_value) annotation(
        Line(points = {{110, -40}, {0, -40}, {0, 0}, {-98, 0}, {-98, 0}}, color = {0, 0, 127}));
      annotation(
        Documentation(info = "<html>
    <p>
    This cmoponent simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
        Diagram,
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
        experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
    end bus2SOBoolean_SO;

    model Consumer_simple
      extends Modelica.Icons.Package;
      parameter Modelica.SIunits.Temperature T0 = 343.15 "Inital temperature" annotation(
        Dialog(tab = "General"));
      AixLib.FastHVAC.Components.Sinks.Sink sink(fluid(T0 = T0)) annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
        Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
        Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add1(k1 = -1) annotation(
        Placement(visible = true, transformation(origin = {44, 60}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a annotation(
        Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b annotation(
        Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_sink annotation(
        Placement(visible = true, transformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-80, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput y_deltaT annotation(
        Placement(visible = true, transformation(origin = {108, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_Tin annotation(
        Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(u_sink, sink.Load) annotation(
        Line(points = {{-80, 120}, {-80, 80}, {0, 80}, {0, 11}}, color = {0, 0, 127}));
      connect(add1.y, y_deltaT) annotation(
        Line(points = {{44, 71}, {44, 80}, {108, 80}}, color = {0, 0, 127}));
      connect(TemperatureOutput.T, add1.u1) annotation(
        Line(points = {{52, 12}, {50, 12}, {50, 48}}, color = {0, 0, 127}));
      connect(enthalpyPort_a, TemperatureInput.enthalpyPort_a) annotation(
        Line(points = {{-110, 0}, {-59, 0}}, color = {176, 0, 0}));
      connect(TemperatureInput.enthalpyPort_b, sink.enthalpyPort_a1) annotation(
        Line(points = {{-41, 0}, {-11, 0}}, color = {176, 0, 0}));
      connect(sink.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation(
        Line(points = {{11, 0}, {42, 0}}));
      connect(TemperatureOutput.enthalpyPort_b, enthalpyPort_b) annotation(
        Line(points = {{60, 0}, {104, 0}, {104, 0}, {110, 0}}, color = {176, 0, 0}));
      connect(y_Tin, TemperatureInput.T) annotation(
        Line(points = {{110, 40}, {-50, 40}, {-50, 12}, {-48, 12}}, color = {0, 0, 127}));
      connect(add1.u2, TemperatureInput.T) annotation(
        Line(points = {{38, 48}, {38, 48}, {38, 40}, {-50, 40}, {-50, 12}, {-48, 12}}, color = {0, 0, 127}));
      annotation(
        Diagram,
        Icon(graphics = {Text(lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}));
    end Consumer_simple;

    model busbar_4consumer
      extends Modelica.Icons.Package;
      Modelica.Blocks.Interfaces.RealOutput y_DirectConsumptionCHP annotation(
        Placement(visible = true, transformation(origin = {210, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_ProductionCHP annotation(
        Placement(visible = true, transformation(origin = {-80, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput uProductionPV annotation(
        Placement(visible = true, transformation(origin = {-20, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput u_DemandHeatPump annotation(
        Placement(visible = true, transformation(origin = {-220, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_DemandHouses annotation(
        Placement(visible = true, transformation(origin = {-220, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_FeedInCHP annotation(
        Placement(visible = true, transformation(origin = {210, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_DirectConsumptionPV annotation(
        Placement(visible = true, transformation(origin = {210, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_LoadToBattery annotation(
        Placement(visible = true, transformation(origin = {210, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_PVProductionToBattery annotation(
        Placement(visible = true, transformation(origin = {210, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Quarree100.Components.busbar_1consumer Busbar_CHP annotation(
        Placement(visible = true, transformation(origin = {-71, 153}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
      Quarree100.Components.busbar_1consumer Busbar_PV annotation(
        Placement(visible = true, transformation(origin = {-27, 91}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealInput u_EMob annotation(
        Placement(visible = true, transformation(origin = {-220, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Math.Add3 add3_1 annotation(
        Placement(transformation(extent = {{-178, 30}, {-158, 50}})));
      Modelica.Blocks.Math.Add add annotation(
        Placement(transformation(extent = {{-140, 100}, {-120, 120}})));
      Modelica.Blocks.Interfaces.RealInput u_DemandElectrolyser annotation(
        Placement(visible = true, transformation(origin = {-220, 180}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      connect(Busbar_PV.y_GridLoad, y_LoadToBattery) annotation(
        Line(points = {{-27, 78.625}, {-27, -20}, {210, -20}}, color = {0, 0, 127}));
      connect(Busbar_PV.y_FeedIn, y_PVProductionToBattery) annotation(
        Line(points = {{-33.75, 78.625}, {-33.75, -40}, {210, -40}}, color = {0, 0, 127}));
      connect(uProductionPV, Busbar_PV.u_Production) annotation(
        Line(points = {{-20, 220}, {-20, 104.5}, {-20.25, 104.5}}, color = {0, 0, 127}));
      connect(Busbar_CHP.y_GridLoad, Busbar_PV.u_Demand) annotation(
        Line(points = {{-71, 140.625}, {-71, 128}, {-33.75, 128}, {-33.75, 104.5}}, color = {0, 0, 127}));
      connect(Busbar_PV.y_DirectConsumption, y_DirectConsumptionPV) annotation(
        Line(points = {{-20.25, 78.625}, {-20.25, 60}, {210, 60}}, color = {0, 0, 127}));
      connect(Busbar_CHP.y_FeedIn, y_FeedInCHP) annotation(
        Line(points = {{-77.75, 140.625}, {-77.75, 120}, {210, 120}}, color = {0, 0, 127}));
      connect(Busbar_CHP.y_DirectConsumption, y_DirectConsumptionCHP) annotation(
        Line(points = {{-64.25, 140.625}, {210, 140.625}, {210, 140}}, color = {0, 0, 127}));
      connect(u_ProductionCHP, Busbar_CHP.u_Production) annotation(
        Line(points = {{-80, 220}, {-80, 188}, {-64.25, 188}, {-64.25, 166.5}}, color = {0, 0, 127}));
      connect(u_DemandHeatPump, add3_1.u1) annotation(
        Line(points = {{-220, 120}, {-190, 120}, {-190, 48}, {-180, 48}}, color = {0, 0, 127}));
      connect(u_DemandHouses, add3_1.u2) annotation(
        Line(points = {{-220, 20}, {-200, 20}, {-200, 40}, {-180, 40}}, color = {0, 0, 127}));
      connect(u_EMob, add3_1.u3) annotation(
        Line(points = {{-220, -40}, {-190, -40}, {-190, 32}, {-180, 32}}, color = {0, 0, 127}));
      connect(add.y, Busbar_CHP.u_Demand) annotation(
        Line(points = {{-119, 110}, {-108, 110}, {-108, 180}, {-77.75, 180}, {-77.75, 166.5}}, color = {0, 0, 127}));
      connect(u_DemandElectrolyser, add.u1) annotation(
        Line(points = {{-220, 180}, {-142, 180}, {-142, 116}}, color = {0, 0, 127}));
      connect(add3_1.y, add.u2) annotation(
        Line(points = {{-157, 40}, {-150, 40}, {-150, 104}, {-142, 104}}, color = {0, 0, 127}));
      annotation(
        experiment(StartTime = 0, StopTime = 345600, Tolerance = 1e-06, Interval = 900),
        __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
        Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
        __OpenModelica_commandLineOptions = "");
    end busbar_4consumer;

    model busbar_1consumer
      extends Modelica.Icons.Package;
      Modelica.Blocks.Interfaces.RealInput u_Production annotation(
        Placement(visible = true, transformation(origin = {-220, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u_Demand annotation(
        Placement(visible = true, transformation(origin = {-220, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_FeedIn annotation(
        Placement(visible = true, transformation(origin = {210, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption annotation(
        Placement(visible = true, transformation(origin = {210, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add1(k1 = -1, k2 = +1) annotation(
        Placement(visible = true, transformation(origin = {-110, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1 annotation(
        Placement(visible = true, transformation(origin = {-70, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch1 annotation(
        Placement(visible = true, transformation(origin = {-10, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Constant const(k = 0) annotation(
        Placement(visible = true, transformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Logical.Switch switch11 annotation(
        Placement(visible = true, transformation(origin = {-10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y_GridLoad annotation(
        Placement(visible = true, transformation(origin = {210, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add3(k1 = +1, k2 = -1) annotation(
        Placement(visible = true, transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Gain gain1(k = -1) annotation(
        Placement(visible = true, transformation(origin = {30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(gain1.y, y_GridLoad) annotation(
        Line(points = {{42, 20}, {72, 20}, {72, 0}, {210, 0}, {210, 0}}, color = {0, 0, 127}));
      connect(gain1.y, add3.u2) annotation(
        Line(points = {{42, 20}, {72, 20}, {72, 34}, {98, 34}}, color = {0, 0, 127}));
      connect(switch11.y, gain1.u) annotation(
        Line(points = {{2, 20}, {18, 20}, {18, 22}, {18, 22}, {18, 20}}, color = {0, 0, 127}));
      connect(add3.y, y_DirectConsumption) annotation(
        Line(points = {{121, 40}, {210, 40}}, color = {0, 0, 127}));
      connect(u_Demand, add3.u1) annotation(
        Line(points = {{-220, -40}, {-140, -40}, {-140, 46}, {98, 46}}, color = {0, 0, 127}));
      connect(add1.u1, u_Demand) annotation(
        Line(points = {{-122, -26}, {-140, -26}, {-140, -40}, {-220, -40}, {-220, -40}}, color = {0, 0, 127}));
      connect(u_Production, add1.u2) annotation(
        Line(points = {{-220, 40}, {-180, 40}, {-180, -14}, {-122, -14}, {-122, -14}}, color = {0, 0, 127}));
      connect(add1.y, switch1.u1) annotation(
        Line(points = {{-99, -20}, {-92, -20}, {-92, -48}, {-22, -48}}, color = {0, 0, 127}));
      connect(add1.y, switch11.u3) annotation(
        Line(points = {{-99, -20}, {-92, -20}, {-92, 12}, {-22, 12}}, color = {0, 0, 127}));
      connect(add1.y, greaterThreshold1.u) annotation(
        Line(points = {{-99, -20}, {-83, -20}, {-83, -18}, {-84, -18}, {-84, -20}, {-83, -20}}, color = {0, 0, 127}));
      connect(const.y, switch1.u3) annotation(
        Line(points = {{-98, 80}, {-32, 80}, {-32, -32}, {-22, -32}, {-22, -32}}, color = {0, 0, 127}));
      connect(const.y, switch11.u1) annotation(
        Line(points = {{-98, 80}, {-32, 80}, {-32, 28}, {-22, 28}, {-22, 28}}, color = {0, 0, 127}));
      connect(greaterThreshold1.y, switch11.u2) annotation(
        Line(points = {{-59, -20}, {-39, -20}, {-39, 20}, {-21, 20}, {-21, 20}, {-23, 20}, {-23, 20}}, color = {255, 0, 255}));
      connect(switch1.y, y_FeedIn) annotation(
        Line(points = {{1, -40}, {210, -40}}, color = {0, 0, 127}));
      connect(greaterThreshold1.y, switch1.u2) annotation(
        Line(points = {{-59, -20}, {-39, -20}, {-39, -40}, {-21, -40}, {-21, -39}, {-23, -39}, {-23, -40}}, color = {255, 0, 255}));
      annotation(
        experiment(StartTime = 0, StopTime = 345600, Tolerance = 1e-06, Interval = 900),
        __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
        Icon(coordinateSystem(extent = {{-80, -80}, {80, 80}}, initialScale = 0.1), graphics = {Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name"), Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
        __OpenModelica_commandLineOptions = "");
    end busbar_1consumer;
    annotation(
      uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
      Documentation(info = "<html>
      <p>Im package Components werden alle selbst erstellten Komponenten der unterschiedlichen Modelle abgelegt.</p>
      <p>Erstellt wurden die Komponenten durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"),
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {Rectangle(origin = {0.0, 35.1488}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Rectangle(origin = {0.0, -34.8512}, fillColor = {255, 255, 255}, extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), Line(origin = {-51.25, 0.0}, points = {{21.25, -35.0}, {-13.75, -35.0}, {-13.75, 35.0}, {6.25, 35.0}}), Polygon(origin = {-40.0, 35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10.0, 0.0}, {-5.0, 5.0}, {-5.0, -5.0}}), Line(origin = {51.25, 0.0}, points = {{-21.25, 35.0}, {13.75, 35.0}, {13.75, -35.0}, {-6.25, -35.0}}), Polygon(origin = {40.0, -35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10.0, 0.0}, {5.0, 5.0}, {5.0, -5.0}})}));
  end Components;

  package Data
    extends Modelica.Icons.RecordsPackage;
    annotation(
      uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
      Documentation(info = "<html>
      <p>Im package Data werden alle Kennlinien, Daten, Datenblätter für die unterschiedlichen Simulationen abgelegt.</p>
      <p>Erstellt bzw. angepasst wurden die Daten durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
  end Data;

  package FMUs
    extends Modelica.Icons.ExamplesPackage;
    annotation(
      uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
      Documentation(info = "<html>
      <p>Im package FMUs werden alle Modelle der unterschiedlichen Simulationen abgelegt, welche mit entsprechenden Schnittstellen zu FMUs umgebaut worden sind.</p>
      <p>Erstellt wurden die Simulationsmodelle durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
  end FMUs;
  annotation(
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
    Documentation(info = "<html>
    <p>Die Quarree100 dient als package, in welchem alle wichtigen Komponenten und Simulationsmodelle abgelegt werden.</p>
    <p>Erstellt wurde das Modell durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
    <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
    <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
    </html>"));
end Quarree100;
