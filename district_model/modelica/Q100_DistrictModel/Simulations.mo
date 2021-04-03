within Q100_DistrictModel;
package Simulations
  extends Modelica.Icons.ExamplesPackage;

  model SIM_RI_Schema
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Constant constElectrolyzer_T_setpoint_specification(k = 77 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-590, 792}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(348.15, 8), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 3.2, dTank = 20, sIns = 0.2, lambdaIns = 0.032), load_cycles = [8, 1; 8, 1; 8, 1], n = 8, n_load_cycles = 3, n_unload_cycles = 1, unload_cycles = [1, 8], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation (
      Placement(visible = true, transformation(origin = {30, 601}, extent = {{-60, -81}, {60, 81}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation (
      Placement(visible = true, transformation(origin = {-930, 960}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseCHP(amplitude = 1, period = 7200, width = 30) annotation (
      Placement(visible = true, transformation(origin = {-970, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP annotation (
      Placement(visible = true, transformation(origin = {-820, 712}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation (
      Placement(visible = true, transformation(origin = {-570, 684}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Electrolyzer annotation (
      Placement(visible = true, transformation(origin = {-820, 892}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_HeatPumpAir annotation (
      Placement(visible = true, transformation(origin = {-820, 832}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseElectrolyzer(amplitude = 1, period = 7200, width = 30) annotation (
      Placement(visible = true, transformation(origin = {-970, 900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseHeatPumpAir(amplitude = 0, period = 7200, width = 30) annotation (
      Placement(visible = true, transformation(origin = {-970, 840}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.Producer_CHP_opt Electrolyzer(T0 = 368.15, T_Out = 368.15, capP_el = 300000, eta_el = 1.67, eta_th = 0.28) annotation (
      Placement(visible = true, transformation(origin = {-530, 810}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Q100_DistrictModel.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation (
      Placement(visible = true, transformation(origin = {-570, 864}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation (
      Placement(visible = true, transformation(origin = {650, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation (
      Placement(visible = true, transformation(origin = {620, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 1, controllerType = .Modelica.Blocks.Types.SimpleController.PID, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.0001, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation (
      Placement(visible = true, transformation(origin = {690, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 70 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {730, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation (
      Placement(visible = true, transformation(origin = {130, -706}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation (
      Placement(visible = true, transformation(origin = {170, -700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_cost_Spot annotation (
      Placement(visible = true, transformation(origin = {210, -700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation (
      Placement(visible = true, transformation(origin = {726, 696}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 40) annotation (
      Placement(visible = true, transformation(origin = {690, 730}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation (
      Placement(visible = true, transformation(origin = {700, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.Consumer_simple consumer_simple(T0 = 318.15) annotation (
      Placement(visible = true, transformation(origin = {770, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF(T_0 = 343.15) annotation (
      Placement(visible = true, transformation(origin = {170, 340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_FF(T_0 = 343.15, diameter = 0.3, length = 5000) annotation (
      Placement(visible = true, transformation(origin = {390, 340}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation (
      Placement(visible = true, transformation(origin = {620, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain_DemandHeat_Houses(k = 5177304.074) annotation (
      Placement(visible = true, transformation(origin = {762, 810}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(fileName = inputData.inputFileNameDemandThermal, tableName = "tab1", tableOnFile = true) annotation (
      Placement(visible = true, transformation(origin = {714, 826}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add31 annotation (
      Placement(visible = true, transformation(origin = {-60, 470}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation (
      Placement(visible = true, transformation(origin = {-20, 470}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation (
      Placement(visible = true, transformation(origin = {-40, 428}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation (
      Placement(visible = true, transformation(origin = {-40, 390}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(fileName = inputData.inputFileNameSpot, tableName = "tab1", tableOnFile = true) annotation (
      Placement(visible = true, transformation(origin = {70, -706}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation (
      Placement(visible = true, transformation(origin = {762, 730}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Q100_DistrictModel.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation (
      Placement(visible = true, transformation(origin = {-489, 243}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    Q100_DistrictModel.Components.Producer_CHP_opt CHP(capP_el = 400000, eta_el = 0.38095, eta_th = 0.55238, uHigh = 1, uLow = -6) annotation (
      Placement(visible = true, transformation(origin = {-450, 190}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const(k = 73 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-510, 174}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_HeatGrid_FF annotation (
      Placement(visible = true, transformation(origin = {310, 340}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const2(k = 71 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-510, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.Producer_Boiler_opt Boiler(Q_nom = 2000000, uHigh = 343.15, uLow = 338.15) annotation (
      Placement(visible = true, transformation(origin = {-450, 30}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Q100_DistrictModel.Components.bus2SOBoolean_SO bus2SOBoolean_SO3 annotation (
      Placement(visible = true, transformation(origin = {-489, 83}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseBoiler(amplitude = 1, period = 7200, width = 30) annotation (
      Placement(visible = true, transformation(origin = {-970, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_Boiler annotation (
      Placement(visible = true, transformation(origin = {-820, 652}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.Producer_HePu_opt HePu_Air(Scale_Factor = 100, T_Out = 368.15) annotation (
      Placement(visible = true, transformation(origin = {-530, 630}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constHeatPumpAir_T_setpoint_specification(k = 77 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-590, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constHeatPumpAir_mdot_amb(k = 100) annotation (
      Placement(visible = true, transformation(origin = {-650, 636}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = inputData.inputFileNameWeatherData) annotation (
      Placement(visible = true, transformation(origin = {-970, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain3(k = 1.01) annotation (
      Placement(visible = true, transformation(origin = {-720, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gainPV_500kW(k = 50) annotation (
      Placement(visible = true, transformation(origin = {-608, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.busbar_4consumer busbar_4consumer annotation (
      Placement(visible = true, transformation(origin = {-126, -148}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandPower(fileName = inputData.inputFileNameDemandPower, tableName = "tab1", tableOnFile = true) annotation (
      Placement(visible = true, transformation(origin = {-708, -156}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_Houses(k = 1) annotation (
      Placement(visible = true, transformation(origin = {-668, -156}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandEMob(fileName = inputData.inputFileNameEMob, tableName = "tab1", tableOnFile = true) annotation (
      Placement(visible = true, transformation(origin = {-708, -186}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_EMob(k = 1) annotation (
      Placement(visible = true, transformation(origin = {-668, -186}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.Electrical.PVSystem.PVSystemTMY3 pVSystemTMY3(MaxOutputPower = 15000, NumberOfPanels = 300, data = AixLib.DataBase.SolarElectric.SymphonyEnergySE6M181()) annotation (
      Placement(visible = true, transformation(origin = {-708, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    BuildingSystems.Technologies.ElectricalStorages.BatterySimple batterySimple1(SOC_start = 0, batteryData = BuildingSystems.Technologies.ElectricalStorages.Data.LithiumIon.LithiumIonAquion(), nBat = 10) annotation (
      Placement(visible = true, transformation(origin = {4, -190}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__CHP_dotE = CHP.y_dotE annotation (
      Placement(visible = true, transformation(origin = {-840, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__Boiler_dotE = Boiler.y_dotE annotation (
      Placement(visible = true, transformation(origin = {-840, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.LessThreshold lessThreshold annotation (
      Placement(visible = true, transformation(origin = {152, -176}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch_GridLoad annotation (
      Placement(visible = true, transformation(origin = {232, -146}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch_FeedIn_PV_500kW annotation (
      Placement(visible = true, transformation(origin = {232, -204}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const5(k = 0) annotation (
      Placement(visible = true, transformation(origin = {192, -176}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__FeedIn_PV_500kW = switch_FeedIn_PV_500kW.y annotation (
      Placement(visible = true, transformation(origin = {-840, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__FeedIn_CHP = busbar_4consumer.y_FeedInCHP annotation (
      Placement(visible = true, transformation(origin = {-840, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__GridLoad = gain_GridLoad.y annotation (
      Placement(visible = true, transformation(origin = {-840, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__GridLoad annotation (
      Placement(visible = true, transformation(origin = {-790, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__FeedIn_CHP annotation (
      Placement(visible = true, transformation(origin = {-790, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__FeedIn_PV_500kW annotation (
      Placement(visible = true, transformation(origin = {-790, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__CHP_dotE annotation (
      Placement(visible = true, transformation(origin = {-790, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__Boiler_dotE annotation (
      Placement(visible = true, transformation(origin = {-790, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y__Electrolyzer_H2 = Electrolyzer.y_dotE annotation (
      Placement(visible = true, transformation(origin = {-840, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-840, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator__Electrolyzer_H2 annotation (
      Placement(visible = true, transformation(origin = {-790, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_Boiler_dotE_CO2(k = 0.2 / 3600 / 1000) annotation (
      Placement(visible = true, transformation(origin = {-750, -780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_CHP_dotE_CO2(k = 0.2 / 3600 / 1000) annotation (
      Placement(visible = true, transformation(origin = {-750, -820}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_PV_500kW_CO2(k = -0.474 / 3600 / 1000) annotation (
      Placement(visible = true, transformation(origin = {-750, -860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_CHP_CO2(k = -0.474 / 3600 / 1000) annotation (
      Placement(visible = true, transformation(origin = {-750, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_GridLoad_CO2(k = 0.474 / 3600 / 1000) annotation (
      Placement(visible = true, transformation(origin = {-750, -940}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_Electrolyzer_H2(k = 0 / 3600 / 1000) annotation (
      Placement(visible = true, transformation(origin = {-750, -980}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_CO2_dotE annotation (
      Placement(visible = true, transformation(origin = {-710, -800}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_CO2_FeedIn annotation (
      Placement(visible = true, transformation(origin = {-710, -880}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_CO2_Power annotation (
      Placement(visible = true, transformation(origin = {-670, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_CO2 annotation (
      Placement(visible = true, transformation(origin = {-610, -900}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_FeedIn_PV_500kW = switch_FeedIn_PV_500kW.y annotation (
      Placement(visible = true, transformation(origin = {120, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator annotation (
      Placement(visible = true, transformation(origin = {170, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DemandPower_EMob annotation (
      Placement(visible = true, transformation(origin = {170, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandPower_EMob = gain_DemandPower_EMob.y annotation (
      Placement(visible = true, transformation(origin = {120, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandPower_Houses = gain_DemandPower_Houses.y annotation (
      Placement(visible = true, transformation(origin = {120, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DemandPower_Houses annotation (
      Placement(visible = true, transformation(origin = {170, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_Houses_cost(k = -0.25 / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandPower_EMob_cost(k = -0.20 / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -460}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_PV_500kW_cost(k = -0.0855 / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -620}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DemandHeat_Houses_cost(k = -0.12 / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DemandHeat_Houses annotation (
      Placement(visible = true, transformation(origin = {170, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandHeat_Houses = gain_DemandHeat_Houses.y annotation (
      Placement(visible = true, transformation(origin = {120, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_CHP_dotE = CHP.y_dotE annotation (
      Placement(visible = true, transformation(origin = {120, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_CHP_dotE annotation (
      Placement(visible = true, transformation(origin = {170, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_CHP_dotE_cost(k = (0.04 + 0.2 * 0.019) / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_Boiler_dotE_cost(k = (0.04 + 0.2 * 0.019) / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_Boiler_dotE annotation (
      Placement(visible = true, transformation(origin = {170, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_Boiler_dotE = Boiler.y_dotE annotation (
      Placement(visible = true, transformation(origin = {120, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -300}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_FeedIn_CHP = busbar_4consumer.y_FeedInCHP annotation (
      Placement(visible = true, transformation(origin = {120, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_FeedIn_CHP annotation (
      Placement(visible = true, transformation(origin = {170, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_FeedIn_CHP_cost(k = -0.0528 / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_dotE annotation (
      Placement(visible = true, transformation(origin = {250, -320}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_DemandPower annotation (
      Placement(visible = true, transformation(origin = {250, -440}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_Advancement annotation (
      Placement(visible = true, transformation(origin = {250, -640}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_FeedIn annotation (
      Placement(visible = true, transformation(origin = {290, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_Demand annotation (
      Placement(visible = true, transformation(origin = {290, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_cost annotation (
      Placement(visible = true, transformation(origin = {370, -420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption_PV_500_kW = busbar_4consumer.y_DirectConsumptionPV annotation (
      Placement(visible = true, transformation(origin = {120, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DirectConsumption_PV_500kW annotation (
      Placement(visible = true, transformation(origin = {170, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DirectConsumption_PV_500kW_cost(k = 0.06756 / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption_CHP = busbar_4consumer.y_DirectConsumptionCHP annotation (
      Placement(visible = true, transformation(origin = {120, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_DirectConsumption_CHP annotation (
      Placement(visible = true, transformation(origin = {170, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_DirectConsumption_CHP_cost(k = 0.06756 / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -580}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_cost_DirectConsumption annotation (
      Placement(visible = true, transformation(origin = {250, -560}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_GridLoad(k = -1) annotation (
      Placement(visible = true, transformation(origin = {270, -146}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_GridLoad = gain_GridLoad.y annotation (
      Placement(visible = true, transformation(origin = {120, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.Integrator integrator_GridLoad annotation (
      Placement(visible = true, transformation(origin = {170, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain_GridLoad_cost(k = 0.30 / 1000 / 3600) annotation (
      Placement(visible = true, transformation(origin = {210, -760}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add3 add3_cost_Power annotation (
      Placement(visible = true, transformation(origin = {330, -660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switchElectrolyzer annotation (
      Placement(visible = true, transformation(origin = {-890, 892}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThresholdElectrolyzer annotation (
      Placement(visible = true, transformation(origin = {-850, 920}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const7(k = 0) annotation (
      Placement(visible = true, transformation(origin = {-940, 930}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThresholdHeatPumpAir annotation (
      Placement(visible = true, transformation(origin = {-850, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switchHeatPumpAir annotation (
      Placement(visible = true, transformation(origin = {-890, 832}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switchHeatPumpGeo annotation (
      Placement(visible = true, transformation(origin = {-890, 772}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThresholdHeatPumpGeo annotation (
      Placement(visible = true, transformation(origin = {-850, 800}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_HeatPumpGeo annotation (
      Placement(visible = true, transformation(origin = {-820, 772}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-364, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulseHeatPumpGeo(amplitude = 0, period = 7200, width = 30) annotation (
      Placement(visible = true, transformation(origin = {-970, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThresholdCHP annotation (
      Placement(visible = true, transformation(origin = {-850, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switchCHP annotation (
      Placement(visible = true, transformation(origin = {-890, 712}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch1 annotation (
      Placement(visible = true, transformation(origin = {-888, 652}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation (
      Placement(visible = true, transformation(origin = {-850, 680}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.Producer_HePu_opt HePu_Geo(Scale_Factor = 50, T_Out = 368.15) annotation (
      Placement(visible = true, transformation(origin = {-530, 450}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constHeatPumpGeo_mdot_amb(k = 100) annotation (
      Placement(visible = true, transformation(origin = {-650, 456}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant constHeatPumpGeo_T_setpoint_specification(k = 77 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-590, 430}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.bus2SOBoolean_SO bus2SOBoolean_SO4 annotation (
      Placement(visible = true, transformation(origin = {-570, 504}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
    Modelica.Blocks.Sources.Sine sineGeo_T_amb(amplitude = 15, freqHz = 1 / (3600 * 24 * 365 * 2), offset = 3 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-970, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_HeatStorage_unload annotation (
      Placement(visible = true, transformation(origin = {68, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.HeatExchangers.DHWHeatExchanger HeatExchanger(A_HE = 20, T0 = 343.15, T_inlet_DHW = 343.15, T_set_DHW_ideal = 343.15) annotation (
      Placement(visible = true, transformation(origin = {253, 263.273}, extent = {{-20.9085, 43}, {16.7268, -43}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_RF(T_0 = 323.15, diameter = 0.3, length = 5000) annotation (
      Placement(visible = true, transformation(origin = {390, 300}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_RF(T_0 = 323.15) annotation (
      Placement(visible = true, transformation(origin = {170, 300}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold1(n = 2) annotation (
      Placement(visible = true, transformation(origin = {130, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Splitter splitter(n = 2) annotation (
      Placement(visible = true, transformation(origin = {130, 120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_AdditionalHeating_RF(T_0 = 323.15) annotation (
      Placement(visible = true, transformation(origin = {170, 120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_AdditionalHeating_FF(T_0 = 343.15) annotation (
      Placement(visible = true, transformation(origin = {170, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation (
      Placement(visible = true, transformation(origin = {176, 662}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add_P_HeatPumps annotation (
      Placement(visible = true, transformation(origin = {-460, 390}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (
      Placement(visible = true, transformation(origin = {350, 320}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = 1) annotation (
      Placement(visible = true, transformation(origin = {762, 770}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    AixLib.BoundaryConditions.WeatherData.Bus WetterBus annotation (
      Placement(visible = true, transformation(extent = {{-740, 118}, {-700, 158}}, rotation = 0), iconTransformation(extent = {{-1008, 160}, {-988, 180}}, rotation = 0)));
    replaceable Q100_DistrictModel.Data.inputData inputData constrainedby
      Data.inputData                                                                     annotation (
       Placement(transformation(extent = {{-980, 58}, {-960, 78}})),
       __Dymola_choicesAllMatching = true);
  equation
    connect(const3.y, PID.u_s) annotation (
      Line(points = {{719, 520}, {702, 520}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation (
      Line(points = {{679, 520}, {620, 520}, {620, 551}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation (
      Line(points = {{141, -706}, {158, -706}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation (
      Line(points = {{701, 730}, {726, 730}, {726, 708}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation (
      Line(points = {{660, 660}, {690.4, 660}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation (
      Line(points = {{715, 696}, {700, 696}, {700, 668}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation (
      Line(points = {{709.6, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation (
      Line(points = {{709.6, 660}, {759, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation (
      Line(points = {{620, 600.2}, {620, 570}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation (
      Line(points = {{781, 660}, {802, 660}, {802, 560}, {629.8, 560}}, color = {0, 85, 255}));
    connect(combiTimeTable_DemandHeat.y[1], gain_DemandHeat_Houses.u) annotation (
      Line(points = {{725, 826}, {762, 826}, {762, 822}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation (
      Line(points = {{-60, 459}, {-60, 448}, {-48, 448}, {-48, 440}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation (
      Line(points = {{-20, 459}, {-20, 447}, {-32, 447}, {-32, 440}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation (
      Line(points = {{-23.25, 601}, {-40, 601}, {-40, 440}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation (
      Line(points = {{-18.75, 601}, {-40, 601}, {-40, 500}, {-68, 500}, {-68, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation (
      Line(points = {{-20.25, 601}, {-40, 601}, {-40, 500}, {-60, 500}, {-60, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation (
      Line(points = {{-21.75, 601}, {-40, 601}, {-40, 500}, {-52, 500}, {-52, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation (
      Line(points = {{-24.75, 601}, {-40, 601}, {-40, 500}, {-28, 500}, {-28, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation (
      Line(points = {{-26.25, 601}, {-40, 601}, {-40, 500}, {-20, 500}, {-20, 482}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation (
      Line(points = {{-27.75, 601}, {-40, 601}, {-40, 500}, {-12, 500}, {-12, 482}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation (
      Line(points = {{-40, 417}, {-40, 402}}, color = {0, 0, 127}));
    connect(combiTimeTable_Spot.y[1], gain.u) annotation (
      Line(points = {{81, -706}, {118, -706}}, color = {0, 0, 127}));
    connect(gain2.y, consumer_simple.u_sink) annotation (
      Line(points = {{762, 719}, {762, 672}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, Electrolyzer.u_control_boolean) annotation (
      Line(points = {{-565.6, 865.6}, {-542, 865.6}, {-542, 846}}, color = {255, 0, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe2.enthalpyPort_b1) annotation (
      Line(points = {{640, 660.5}, {620, 660.5}, {620, 619.8}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation (
      Line(points = {{781, 668}, {800, 668}, {800, 696}, {738, 696}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation (
      Line(points = {{781, 664}, {820, 664}, {820, 540}, {690, 540}, {690, 532}}, color = {0, 0, 127}));
    connect(Electrolyzer.u_T_setpoint_specification, constElectrolyzer_T_setpoint_specification.y) annotation (
      Line(points = {{-566, 792.6}, {-571.5, 792.6}, {-571.5, 792}, {-579, 792}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_value, CHP.u_control_value) annotation (
      Line(points = {{-484.6, 241.4}, {-474, 241.4}, {-474, 226}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_boolean, CHP.u_control_boolean) annotation (
      Line(points = {{-484.6, 244.6}, {-462, 244.6}, {-462, 226}}, color = {255, 0, 255}));
    connect(const.y, CHP.u_T_setpoint_specification) annotation (
      Line(points = {{-499, 174}, {-490.5, 174}, {-490.5, 172.6}, {-486, 172.6}}, color = {0, 0, 127}));
    connect(gainPV_500kW.y, busbar_4consumer.uProductionPV) annotation (
      Line(points = {{-597, -86}, {-126, -86}, {-126, -112}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_DemandHouses, gain_DemandPower_Houses.y) annotation (
      Line(points = {{-162, -157}, {-580, -157}, {-580, -156}, {-657, -156}}, color = {0, 0, 127}));
    connect(gain_DemandPower_Houses.u, combiTimeTable_DemandPower.y[1]) annotation (
      Line(points = {{-680, -156}, {-697, -156}}, color = {0, 0, 127}));
    connect(combiTimeTable_DemandEMob.y[1], gain_DemandPower_EMob.u) annotation (
      Line(points = {{-697, -186}, {-680, -186}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_EMob, gain_DemandPower_EMob.y) annotation (
      Line(points = {{-162, -172}, {-638, -172}, {-638, -186}, {-657, -186}}, color = {0, 0, 127}));
    connect(pVSystemTMY3.weaBus, weaDat.weaBus) annotation (
      Line(points = {{-718, -86}, {-718, -85}, {-940, -85}, {-940, 120}, {-960, 120}}, color = {255, 204, 51}, thickness = 0.5));
    connect(pVSystemTMY3.PVPowerW, gainPV_500kW.u) annotation (
      Line(points = {{-697, -86}, {-620, -86}}, color = {0, 0, 127}));
    connect(busbar_4consumer.y_PVProductionToBattery, batterySimple1.PCharge) annotation (
      Line(points = {{-93, -169}, {-93, -170}, {-58, -170}, {-58, -190}, {-9, -190}}, color = {0, 0, 127}));
    connect(busbar_4consumer.y_LoadToBattery, batterySimple1.PLoad) annotation (
      Line(points = {{-93, -160}, {44, -160}, {44, -190}, {17, -190}}, color = {0, 0, 127}));
    connect(product.y, integrator_cost_Spot.u) annotation (
      Line(points = {{181, -700}, {198, -700}}, color = {0, 0, 127}));
    connect(switch_GridLoad.u3, const5.y) annotation (
      Line(points = {{220, -154}, {212, -154}, {212, -176}, {203, -176}}, color = {0, 0, 127}));
    connect(switch_FeedIn_PV_500kW.u1, const5.y) annotation (
      Line(points = {{220, -196}, {220, -30}, {212, -30}, {212, -176}, {203, -176}}, color = {0, 0, 127}));
    connect(switch_GridLoad.u2, lessThreshold.y) annotation (
      Line(points = {{220, -146}, {172, -146}, {172, -176}, {163, -176}}, color = {255, 0, 255}));
    connect(switch_FeedIn_PV_500kW.u2, lessThreshold.y) annotation (
      Line(points = {{220, -204}, {172, -204}, {172, -176}, {163, -176}}, color = {255, 0, 255}));
    connect(batterySimple1.PGrid, switch_FeedIn_PV_500kW.u3) annotation (
      Line(points = {{18.04, -179.6}, {122, -179.6}, {122, -212}, {220, -212}}, color = {0, 0, 127}));
    connect(switch_GridLoad.u1, batterySimple1.PGrid) annotation (
      Line(points = {{220, -138}, {122, -138}, {122, -179.6}, {18.04, -179.6}}, color = {0, 0, 127}));
    connect(lessThreshold.u, batterySimple1.PGrid) annotation (
      Line(points = {{140, -176}, {129, -176}, {129, -179.6}, {18.04, -179.6}}, color = {0, 0, 127}));
    connect(gain_FeedIn_PV_500kW_CO2.y, add_CO2_FeedIn.u1) annotation (
      Line(points = {{-739, -860}, {-732, -860}, {-732, -874}, {-722, -874}}, color = {0, 0, 127}));
    connect(gain_FeedIn_CHP_CO2.y, add_CO2_FeedIn.u2) annotation (
      Line(points = {{-739, -900}, {-732, -900}, {-732, -886}, {-722, -886}}, color = {0, 0, 127}));
    connect(gain_Boiler_dotE_CO2.y, add_CO2_dotE.u1) annotation (
      Line(points = {{-739, -780}, {-730, -780}, {-730, -794}, {-722, -794}, {-722, -794}}, color = {0, 0, 127}));
    connect(gain_CHP_dotE_CO2.y, add_CO2_dotE.u2) annotation (
      Line(points = {{-739, -820}, {-730, -820}, {-730, -806}, {-722, -806}, {-722, -806}}, color = {0, 0, 127}));
    connect(gain_GridLoad_CO2.y, add_CO2_Power.u2) annotation (
      Line(points = {{-739, -940}, {-690, -940}, {-690, -906}, {-682, -906}, {-682, -906}}, color = {0, 0, 127}));
    connect(add_CO2_FeedIn.y, add_CO2_Power.u1) annotation (
      Line(points = {{-699, -880}, {-690, -880}, {-690, -894}, {-682, -894}, {-682, -894}}, color = {0, 0, 127}));
    connect(add_CO2_Power.y, add3_CO2.u2) annotation (
      Line(points = {{-659, -900}, {-622, -900}, {-622, -900}, {-622, -900}}, color = {0, 0, 127}));
    connect(add3_CO2.u1, add_CO2_dotE.y) annotation (
      Line(points = {{-622, -892}, {-640, -892}, {-640, -800}, {-699, -800}, {-699, -800}}, color = {0, 0, 127}));
    connect(add3_CO2.u3, gain_Electrolyzer_H2.y) annotation (
      Line(points = {{-622, -908}, {-640, -908}, {-640, -980}, {-739, -980}, {-739, -980}}, color = {0, 0, 127}));
    connect(y__Boiler_dotE, integrator__Boiler_dotE.u) annotation (
      Line(points = {{-840, -780}, {-802, -780}, {-802, -780}, {-802, -780}}, color = {0, 0, 127}));
    connect(integrator__Boiler_dotE.y, gain_Boiler_dotE_CO2.u) annotation (
      Line(points = {{-779, -780}, {-764, -780}, {-764, -780}, {-762, -780}}, color = {0, 0, 127}));
    connect(y__CHP_dotE, integrator__CHP_dotE.u) annotation (
      Line(points = {{-840, -820}, {-802, -820}, {-802, -820}, {-802, -820}}, color = {0, 0, 127}));
    connect(integrator__CHP_dotE.y, gain_CHP_dotE_CO2.u) annotation (
      Line(points = {{-779, -820}, {-762, -820}, {-762, -820}, {-762, -820}}, color = {0, 0, 127}));
    connect(y__FeedIn_PV_500kW, integrator__FeedIn_PV_500kW.u) annotation (
      Line(points = {{-840, -860}, {-804, -860}, {-804, -860}, {-802, -860}}, color = {0, 0, 127}));
    connect(integrator__FeedIn_PV_500kW.y, gain_FeedIn_PV_500kW_CO2.u) annotation (
      Line(points = {{-779, -860}, {-764, -860}, {-764, -860}, {-762, -860}}, color = {0, 0, 127}));
    connect(y__FeedIn_CHP, integrator__FeedIn_CHP.u) annotation (
      Line(points = {{-840, -900}, {-802, -900}, {-802, -900}, {-802, -900}}, color = {0, 0, 127}));
    connect(integrator__FeedIn_CHP.y, gain_FeedIn_CHP_CO2.u) annotation (
      Line(points = {{-779, -900}, {-762, -900}, {-762, -900}, {-762, -900}}, color = {0, 0, 127}));
    connect(y__GridLoad, integrator__GridLoad.u) annotation (
      Line(points = {{-840, -940}, {-804, -940}, {-804, -940}, {-802, -940}}, color = {0, 0, 127}));
    connect(integrator__GridLoad.y, gain_GridLoad_CO2.u) annotation (
      Line(points = {{-779, -940}, {-764, -940}, {-764, -940}, {-762, -940}}, color = {0, 0, 127}));
    connect(y__Electrolyzer_H2, integrator__Electrolyzer_H2.u) annotation (
      Line(points = {{-840, -980}, {-802, -980}, {-802, -980}, {-802, -980}}, color = {0, 0, 127}));
    connect(integrator__Electrolyzer_H2.y, gain_Electrolyzer_H2.u) annotation (
      Line(points = {{-779, -980}, {-762, -980}, {-762, -980}, {-762, -980}}, color = {0, 0, 127}));
    connect(y_Boiler_dotE, integrator_Boiler_dotE.u) annotation (
      Line(points = {{120, -300}, {156, -300}, {156, -300}, {158, -300}}, color = {0, 0, 127}));
    connect(integrator_Boiler_dotE.y, gain_Boiler_dotE_cost.u) annotation (
      Line(points = {{181, -300}, {198, -300}, {198, -300}, {198, -300}}, color = {0, 0, 127}));
    connect(y_CHP_dotE, integrator_CHP_dotE.u) annotation (
      Line(points = {{120, -340}, {158, -340}, {158, -340}, {158, -340}}, color = {0, 0, 127}));
    connect(integrator_CHP_dotE.y, gain_CHP_dotE_cost.u) annotation (
      Line(points = {{181, -340}, {198, -340}, {198, -340}, {198, -340}}, color = {0, 0, 127}));
    connect(product.u1, y_FeedIn_CHP) annotation (
      Line(points = {{158, -694}, {140, -694}, {140, -660}, {120, -660}}, color = {0, 0, 127}));
    connect(integrator_FeedIn_CHP.u, y_FeedIn_CHP) annotation (
      Line(points = {{158, -660}, {120, -660}}, color = {0, 0, 127}));
    connect(integrator_FeedIn_CHP.y, gain_FeedIn_CHP_cost.u) annotation (
      Line(points = {{181, -660}, {198, -660}}, color = {0, 0, 127}));
    connect(y_FeedIn_PV_500kW, integrator.u) annotation (
      Line(points = {{120, -620}, {158, -620}}, color = {0, 0, 127}));
    connect(integrator.y, gain_FeedIn_PV_500kW_cost.u) annotation (
      Line(points = {{181, -620}, {198, -620}}, color = {0, 0, 127}));
    connect(integrator_DemandPower_EMob.u, y_DemandPower_EMob) annotation (
      Line(points = {{158, -460}, {116, -460}, {116, -460}, {120, -460}}, color = {0, 0, 127}));
    connect(gain_DemandPower_EMob_cost.u, integrator_DemandPower_EMob.y) annotation (
      Line(points = {{198, -460}, {180, -460}, {180, -460}, {181, -460}}, color = {0, 0, 127}));
    connect(gain_DemandPower_Houses_cost.u, integrator_DemandPower_Houses.y) annotation (
      Line(points = {{198, -420}, {182, -420}, {182, -420}, {181, -420}}, color = {0, 0, 127}));
    connect(integrator_DemandPower_Houses.u, y_DemandPower_Houses) annotation (
      Line(points = {{158, -420}, {116, -420}, {116, -420}, {120, -420}}, color = {0, 0, 127}));
    connect(gain_DemandHeat_Houses_cost.u, integrator_DemandHeat_Houses.y) annotation (
      Line(points = {{198, -380}, {180, -380}, {180, -380}, {181, -380}}, color = {0, 0, 127}));
    connect(integrator_DemandHeat_Houses.u, y_DemandHeat_Houses) annotation (
      Line(points = {{158, -380}, {114, -380}, {114, -380}, {120, -380}}, color = {0, 0, 127}));
    connect(add_cost_dotE.u1, gain_Boiler_dotE_cost.y) annotation (
      Line(points = {{238, -314}, {230, -314}, {230, -300}, {221, -300}, {221, -300}}, color = {0, 0, 127}));
    connect(add_cost_dotE.u2, gain_CHP_dotE_cost.y) annotation (
      Line(points = {{238, -326}, {230, -326}, {230, -340}, {221, -340}, {221, -340}}, color = {0, 0, 127}));
    connect(gain_DemandPower_Houses_cost.y, add_cost_DemandPower.u1) annotation (
      Line(points = {{221, -420}, {230, -420}, {230, -434}, {238, -434}, {238, -434}}, color = {0, 0, 127}));
    connect(gain_DemandPower_EMob_cost.y, add_cost_DemandPower.u2) annotation (
      Line(points = {{221, -460}, {230, -460}, {230, -446}, {238, -446}, {238, -446}}, color = {0, 0, 127}));
    connect(add_cost_Advancement.u2, gain_FeedIn_CHP_cost.y) annotation (
      Line(points = {{238, -646}, {230, -646}, {230, -660}, {221, -660}}, color = {0, 0, 127}));
    connect(gain_FeedIn_PV_500kW_cost.y, add_cost_Advancement.u1) annotation (
      Line(points = {{221, -620}, {228, -620}, {228, -634}, {238, -634}}, color = {0, 0, 127}));
    connect(add_cost_FeedIn.u1, add_cost_Advancement.y) annotation (
      Line(points = {{278, -654}, {268, -654}, {268, -640}, {261, -640}}, color = {0, 0, 127}));
    connect(add_cost_FeedIn.u2, integrator_cost_Spot.y) annotation (
      Line(points = {{278, -666}, {268, -666}, {268, -700}, {221, -700}}, color = {0, 0, 127}));
    connect(gain_DemandHeat_Houses_cost.y, add_cost_Demand.u1) annotation (
      Line(points = {{221, -380}, {270, -380}, {270, -414}, {278, -414}, {278, -414}}, color = {0, 0, 127}));
    connect(add_cost_Demand.u2, add_cost_DemandPower.y) annotation (
      Line(points = {{278, -426}, {270, -426}, {270, -440}, {261, -440}, {261, -440}}, color = {0, 0, 127}));
    connect(add3_cost.u2, add_cost_Demand.y) annotation (
      Line(points = {{358, -420}, {302, -420}, {302, -420}, {301, -420}}, color = {0, 0, 127}));
    connect(add3_cost.u1, add_cost_dotE.y) annotation (
      Line(points = {{358, -412}, {320, -412}, {320, -320}, {261, -320}, {261, -320}}, color = {0, 0, 127}));
    connect(y_DirectConsumption_PV_500_kW, integrator_DirectConsumption_PV_500kW.u) annotation (
      Line(points = {{120, -540}, {158, -540}}, color = {0, 0, 127}));
    connect(y_DirectConsumption_CHP, integrator_DirectConsumption_CHP.u) annotation (
      Line(points = {{120, -580}, {158, -580}}, color = {0, 0, 127}));
    connect(integrator_DirectConsumption_PV_500kW.y, gain_DirectConsumption_PV_500kW_cost.u) annotation (
      Line(points = {{181, -540}, {198, -540}}, color = {0, 0, 127}));
    connect(integrator_DirectConsumption_CHP.y, gain_DirectConsumption_CHP_cost.u) annotation (
      Line(points = {{181, -580}, {198, -580}}, color = {0, 0, 127}));
    connect(gain_DirectConsumption_PV_500kW_cost.y, add_cost_DirectConsumption.u1) annotation (
      Line(points = {{221, -540}, {228, -540}, {228, -554}, {238, -554}}, color = {0, 0, 127}));
    connect(gain_DirectConsumption_CHP_cost.y, add_cost_DirectConsumption.u2) annotation (
      Line(points = {{221, -580}, {228, -580}, {228, -566}, {238, -566}}, color = {0, 0, 127}));
    connect(gain_GridLoad.u, switch_GridLoad.y) annotation (
      Line(points = {{258, -146}, {243, -146}}, color = {0, 0, 127}));
    connect(y_GridLoad, integrator_GridLoad.u) annotation (
      Line(points = {{120, -760}, {158, -760}, {158, -760}, {158, -760}}, color = {0, 0, 127}));
    connect(integrator_GridLoad.y, gain_GridLoad_cost.u) annotation (
      Line(points = {{181, -760}, {198, -760}, {198, -760}, {198, -760}}, color = {0, 0, 127}));
    connect(gain_GridLoad_cost.y, add3_cost_Power.u3) annotation (
      Line(points = {{221, -760}, {310, -760}, {310, -668}, {318, -668}, {318, -668}}, color = {0, 0, 127}));
    connect(add3_cost_Power.u2, add_cost_FeedIn.y) annotation (
      Line(points = {{318, -660}, {300, -660}, {300, -660}, {301, -660}}, color = {0, 0, 127}));
    connect(add_cost_DirectConsumption.y, add3_cost_Power.u1) annotation (
      Line(points = {{261, -560}, {310, -560}, {310, -652}, {318, -652}, {318, -652}}, color = {0, 0, 127}));
    connect(add3_cost_Power.y, add3_cost.u3) annotation (
      Line(points = {{341, -660}, {348, -660}, {348, -428}, {358, -428}, {358, -428}}, color = {0, 0, 127}));
    connect(switchElectrolyzer.y, greaterThresholdElectrolyzer.u) annotation (
      Line(points = {{-879, 892}, {-870, 892}, {-870, 920}, {-862, 920}}, color = {0, 0, 127}));
    connect(greaterThresholdElectrolyzer.y, controlBus_Electrolyzer.control_boolean) annotation (
      Line(points = {{-839, 920}, {-820, 920}, {-820, 892}}, color = {255, 0, 255}));
    connect(switchElectrolyzer.y, controlBus_Electrolyzer.control_value) annotation (
      Line(points = {{-879, 892}, {-820, 892}}, color = {0, 0, 127}));
    connect(pulseElectrolyzer.y, switchElectrolyzer.u1) annotation (
      Line(points = {{-959, 900}, {-902, 900}}, color = {0, 0, 127}));
    connect(booleanConstant.y, switchElectrolyzer.u2) annotation (
      Line(points = {{-919, 960}, {-912, 960}, {-912, 892}, {-902, 892}}, color = {255, 0, 255}));
    connect(const7.y, switchElectrolyzer.u3) annotation (
      Line(points = {{-929, 930}, {-920, 930}, {-920, 884}, {-902, 884}}, color = {0, 0, 127}));
    connect(greaterThresholdHeatPumpAir.y, controlBus_HeatPumpAir.control_boolean) annotation (
      Line(points = {{-839, 860}, {-820, 860}, {-820, 832}}, color = {255, 0, 255}));
    connect(switchHeatPumpAir.y, controlBus_HeatPumpAir.control_value) annotation (
      Line(points = {{-879, 832}, {-820, 832}}, color = {0, 0, 127}));
    connect(pulseHeatPumpAir.y, switchHeatPumpAir.u1) annotation (
      Line(points = {{-959, 840}, {-902, 840}}, color = {0, 0, 127}));
    connect(switchHeatPumpAir.u2, booleanConstant.y) annotation (
      Line(points = {{-902, 832}, {-912, 832}, {-912, 960}, {-919, 960}}, color = {255, 0, 255}));
    connect(switchHeatPumpAir.u3, const7.y) annotation (
      Line(points = {{-902, 824}, {-902, 823}, {-920, 823}, {-920, 930}, {-929, 930}}, color = {0, 0, 127}));
    connect(greaterThresholdHeatPumpGeo.y, controlBus_HeatPumpGeo.control_boolean) annotation (
      Line(points = {{-839, 800}, {-820, 800}, {-820, 772}}, color = {255, 0, 255}));
    connect(switchHeatPumpGeo.y, controlBus_HeatPumpGeo.control_value) annotation (
      Line(points = {{-879, 772}, {-820, 772}}, color = {0, 0, 127}));
    connect(pulseHeatPumpGeo.y, switchHeatPumpGeo.u1) annotation (
      Line(points = {{-959, 780}, {-902, 780}}, color = {0, 0, 127}));
    connect(switchHeatPumpGeo.u2, booleanConstant.y) annotation (
      Line(points = {{-902, 772}, {-912, 772}, {-912, 960}, {-919, 960}}, color = {255, 0, 255}));
    connect(switchHeatPumpGeo.u3, const7.y) annotation (
      Line(points = {{-902, 764}, {-902, 763}, {-920, 763}, {-920, 930}, {-929, 930}}, color = {0, 0, 127}));
    connect(switchCHP.u1, pulseCHP.y) annotation (
      Line(points = {{-902, 720}, {-959, 720}}, color = {0, 0, 127}));
    connect(switchCHP.u2, booleanConstant.y) annotation (
      Line(points = {{-902, 712}, {-912, 712}, {-912, 960}, {-919, 960}}, color = {255, 0, 255}));
    connect(const7.y, switchCHP.u3) annotation (
      Line(points = {{-929, 930}, {-920, 930}, {-920, 704}, {-902, 704}}, color = {0, 0, 127}));
    connect(switchCHP.y, controlBus_CHP.control_value) annotation (
      Line(points = {{-879, 712}, {-820, 712}}, color = {0, 0, 127}));
    connect(greaterThresholdCHP.y, controlBus_CHP.control_boolean) annotation (
      Line(points = {{-839, 740}, {-820, 740}, {-820, 712}}, color = {255, 0, 255}));
    connect(greaterThresholdCHP.u, switchCHP.y) annotation (
      Line(points = {{-862, 740}, {-870, 740}, {-870, 712}, {-879, 712}}, color = {0, 0, 127}));
    connect(greaterThreshold.y, controlBus_Boiler.control_boolean) annotation (
      Line(points = {{-839, 680}, {-820, 680}, {-820, 652}}, color = {255, 0, 255}));
    connect(switch1.y, controlBus_Boiler.control_value) annotation (
      Line(points = {{-877, 652}, {-820, 652}}, color = {0, 0, 127}));
    connect(pulseBoiler.y, switch1.u1) annotation (
      Line(points = {{-959, 660}, {-900, 660}}, color = {0, 0, 127}));
    connect(switch1.u2, booleanConstant.y) annotation (
      Line(points = {{-900, 652}, {-912, 652}, {-912, 960}, {-919, 960}}, color = {255, 0, 255}));
    connect(const7.y, switch1.u3) annotation (
      Line(points = {{-929, 930}, {-920, 930}, {-920, 644}, {-900, 644}}, color = {0, 0, 127}));
    connect(greaterThresholdHeatPumpAir.u, switchHeatPumpAir.y) annotation (
      Line(points = {{-862, 860}, {-868, 860}, {-868, 832}, {-879, 832}, {-879, 832}}, color = {0, 0, 127}));
    connect(greaterThresholdHeatPumpGeo.u, switchHeatPumpGeo.y) annotation (
      Line(points = {{-862, 800}, {-868, 800}, {-868, 772}, {-879, 772}, {-879, 772}}, color = {0, 0, 127}));
    connect(greaterThreshold.u, switch1.y) annotation (
      Line(points = {{-862, 680}, {-870, 680}, {-870, 652}, {-877, 652}, {-877, 652}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, Electrolyzer.u_control_value) annotation (
      Line(points = {{-565.6, 862.4}, {-554, 862.4}, {-554, 846}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_Electrolyzer) annotation (
      Line(points = {{-574, 864}, {-720, 864}, {-720, 892}, {-820, 892}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_HeatPumpAir) annotation (
      Line(points = {{-574, 684}, {-740, 684}, {-740, 832}, {-820, 832}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO2.y_control_value, HePu_Air.u_control_value) annotation (
      Line(points = {{-565.6, 682.4}, {-553.4, 682.4}, {-553.4, 666}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO2.y_control_boolean, HePu_Air.u_control_boolean) annotation (
      Line(points = {{-565.6, 685.6}, {-541.4, 685.6}, {-541.4, 666}}, color = {255, 0, 255}));
    connect(constHeatPumpAir_T_setpoint_specification.y, HePu_Air.u_T_setpoint_specification) annotation (
      Line(points = {{-579, 610}, {-568, 610}, {-568, 612}, {-567, 612}, {-567, 612.6}, {-566, 612.6}}, color = {0, 0, 127}));
    connect(constHeatPumpAir_mdot_amb.y, HePu_Air.u_dotm_source) annotation (
      Line(points = {{-639, 636}, {-568, 636}, {-568, 637.2}, {-566, 637.2}}, color = {0, 0, 127}));
    connect(HePu_Air.u_T_fluid_source, gain3.y) annotation (
      Line(points = {{-566, 654}, {-720, 654}, {-720, 221}}, color = {0, 0, 127}));
    connect(constHeatPumpGeo_T_setpoint_specification.y, HePu_Geo.u_T_setpoint_specification) annotation (
      Line(points = {{-579, 430}, {-566, 430}, {-566, 432.6}, {-566, 432.6}}, color = {0, 0, 127}));
    connect(constHeatPumpGeo_mdot_amb.y, HePu_Geo.u_dotm_source) annotation (
      Line(points = {{-639, 456}, {-568, 456}, {-568, 457.2}, {-566, 457.2}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO4.y_control_value, HePu_Geo.u_control_value) annotation (
      Line(points = {{-565.6, 502.4}, {-554, 502.4}, {-554, 486}, {-553.4, 486}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO4.y_control_boolean, HePu_Geo.u_control_boolean) annotation (
      Line(points = {{-565.6, 505.6}, {-542, 505.6}, {-542, 486}, {-541.4, 486}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO4.controlBus, controlBus_HeatPumpGeo) annotation (
      Line(points = {{-574, 504}, {-760, 504}, {-760, 772}, {-820, 772}}, color = {255, 204, 51}, thickness = 0.5));
    connect(Electrolyzer.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation (
      Line(points = {{-530, 777}, {-530, 777}, {-530, 740}, {-440, 740}, {-440, 360}, {18, 360}, {18, 514.6}, {18, 514.6}}, color = {0, 85, 255}));
    connect(HePu_Air.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation (
      Line(points = {{-530, 597}, {-530, 597}, {-530, 560}, {-440, 560}, {-440, 360}, {18, 360}, {18, 520}, {18, 520}}, color = {0, 85, 255}));
    connect(HePu_Geo.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[3]) annotation (
      Line(points = {{-530, 417}, {-530, 417}, {-530, 360}, {18, 360}, {18, 525.4}, {18, 525.4}}, color = {0, 85, 255}));
    connect(Electrolyzer.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation (
      Line(points = {{-530, 843}, {-530, 843}, {-530, 880}, {18, 880}, {18, 676.6}, {18, 676.6}}, color = {176, 0, 0}));
    connect(HePu_Air.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation (
      Line(points = {{-529.4, 663}, {-529.4, 663}, {-529.4, 700}, {-460, 700}, {-460, 880}, {18, 880}, {18, 682}, {18, 682}}, color = {176, 0, 0}));
    connect(HePu_Geo.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[3]) annotation (
      Line(points = {{-529.4, 483}, {-529.4, 483}, {-529.4, 520}, {-460, 520}, {-460, 880}, {18, 880}, {18, 687.4}, {18, 687.4}}, color = {176, 0, 0}));
    connect(temperature_HeatStorage_unload.enthalpyPort_a, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation (
      Line(points = {{59.2, 719.9}, {42, 719.9}, {42, 682}, {42, 682}}, color = {176, 0, 0}));
    connect(temperature_HeatStorage_unload.T, Electrolyzer.u_T_setpoint) annotation (
      Line(points = {{69, 731}, {68, 731}, {68, 792}, {-494, 792}, {-494, 792.6}}, color = {0, 0, 127}));
    connect(temperature_HeatStorage_unload.T, HePu_Air.u_T_setpoint) annotation (
      Line(points = {{69, 731}, {68, 731}, {68, 792}, {-420, 792}, {-420, 612}, {-494, 612}, {-494, 612.6}}, color = {0, 0, 127}));
    connect(temperature_HeatStorage_unload.T, HePu_Geo.u_T_setpoint) annotation (
      Line(points = {{69, 731}, {68, 731}, {68, 792}, {-420, 792}, {-420, 432}, {-494, 432}, {-494, 432.6}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF.enthalpyPort_b1, HeatExchanger.enthalpyPort_dHWIn) annotation (
      Line(points={{179.8,340},{222.04,340},{222.04,279.582}},        color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF.enthalpyPort_a1, temperature_HeatStorage_unload.enthalpyPort_b) annotation (
      Line(points = {{160.2, 340}, {120, 340}, {120, 719.9}, {77, 719.9}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatGrid_RF.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation (
      Line(points = {{399.8, 300}, {600, 300}, {600, 560}, {610, 560}}, color = {0, 85, 255}));
    connect(dynamicPipe_HeatGrid_RF.enthalpyPort_b1, dynamicPipe_HeatStorage_unload_RF.enthalpyPort_a1) annotation (
      Line(points = {{380.2, 300}, {179.8, 300}}, color = {0, 85, 255}));
    connect(dynamicPipe_HeatStorage_unload_RF.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation (
      Line(points = {{160.2, 300}, {42, 300}, {42, 520}, {42, 520}}, color = {0, 85, 255}));
    connect(dynamicPipe_AdditionalHeating_FF.enthalpyPort_b1, HeatExchanger.enthalpyPort_heaterIn) annotation (
      Line(points={{179.8,200},{266,200},{266,243.201},{265.04,243.201}},          color = {176, 0, 0}));
    connect(manifold1.enthalpyPort_b, dynamicPipe_AdditionalHeating_FF.enthalpyPort_a1) annotation (
      Line(points = {{140, 200}, {158, 200}, {158, 200}, {160.2, 200}, {160.2, 200}}, color = {176, 0, 0}));
    connect(dynamicPipe_AdditionalHeating_RF.enthalpyPort_a1, HeatExchanger.enthalpyPort_heaterOut) annotation (
      Line(points={{179.8,120},{222,120},{222,242.783},{222.04,242.783}},          color = {0, 85, 255}));
    connect(dynamicPipe_AdditionalHeating_RF.enthalpyPort_b1, splitter.enthalpyPort_a) annotation (
      Line(points = {{160.2, 120}, {140, 120}, {140, 120}, {140, 120}}, color = {0, 85, 255}));
    connect(temperature_HeatGrid_FF.enthalpyPort_b, dynamicPipe_HeatGrid_FF.enthalpyPort_a1) annotation (
      Line(points = {{319, 340.1}, {350.2, 340.1}, {350.2, 340}, {380.2, 340}}, color = {176, 0, 0}));
    connect(temperature_HeatGrid_FF.enthalpyPort_a, HeatExchanger.enthalpyPort_dHWOut) annotation (
      Line(points={{301.2,340.1},{264,340.1},{264,280},{265.04,280}},          color = {176, 0, 0}));
    connect(manifold1.enthalpyPort_a[1], CHP.enthalpyPort_b) annotation (
      Line(points = {{120, 199.5}, {-140, 199.5}, {-140, 260}, {-450, 260}, {-450, 223}, {-450, 223}}, color = {176, 0, 0}));
    connect(splitter.enthalpyPort_b[1], CHP.enthalpyPort_a) annotation (
      Line(points = {{120, 119.5}, {-450, 119.5}, {-450, 157}, {-450, 157}}, color = {0, 85, 255}));
    connect(bus2SOBoolean_SO3.y_control_value, Boiler.u_control_value) annotation (
      Line(points = {{-484.6, 81.4}, {-476, 81.4}, {-476, 66}, {-474, 66}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO3.y_control_boolean, Boiler.u_control_boolean) annotation (
      Line(points = {{-484.6, 84.6}, {-462, 84.6}, {-462, 66}, {-462, 66}}, color = {255, 0, 255}));
    connect(const2.y, Boiler.u_T_setpoint_specification) annotation (
      Line(points = {{-499, 10}, {-488, 10}, {-488, 12.6}, {-486, 12.6}}, color = {0, 0, 127}));
    connect(Boiler.enthalpyPort_b, manifold1.enthalpyPort_a[2]) annotation (
      Line(points = {{-450, 63}, {-450, 63}, {-450, 100}, {-140, 100}, {-140, 200}, {120, 200}, {120, 200.5}}, color = {176, 0, 0}));
    connect(splitter.enthalpyPort_b[2], Boiler.enthalpyPort_a) annotation (
      Line(points = {{120, 120.5}, {-120, 120.5}, {-120, -40}, {-450, -40}, {-450, -3}, {-450, -3}}, color = {0, 85, 255}));
    connect(bus2SOBoolean_SO3.controlBus, controlBus_Boiler) annotation (
      Line(points = {{-493, 83}, {-800, 83}, {-800, 652}, {-820, 652}, {-820, 652}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO.controlBus, controlBus_CHP) annotation (
      Line(points = {{-493, 243}, {-780, 243}, {-780, 712}, {-820, 712}, {-820, 712}}, color = {255, 204, 51}, thickness = 0.5));
    connect(CHP.u_T_setpoint, temperature_HeatGrid_FF.T) annotation (
      Line(points = {{-414, 172.6}, {310, 172.6}, {310, 329}, {311, 329}}, color = {0, 0, 127}));
    connect(Boiler.u_T_setpoint, temperature_HeatGrid_FF.T) annotation (
      Line(points = {{-414, 12.6}, {310, 12.6}, {310, 329}, {311, 329}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatGrid_FF.enthalpyPort_b1, manifold.enthalpyPort_a[1]) annotation (
      Line(points = {{399.8, 340}, {560, 340}, {560, 659.5}, {640, 659.5}}, color = {176, 0, 0}));
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation (
      Line(points = {{166, 662}, {66, 662}, {66, 665.8}, {66, 665.8}}, color = {191, 0, 0}));
    connect(busbar_4consumer.u_ProductionCHP, CHP.y_P) annotation (
      Line(points = {{-144, -112}, {-144, -112}, {-144, 140}, {-438, 140}, {-438, 157}, {-438, 157}}, color = {0, 0, 127}));
    connect(busbar_4consumer.u_DemandElectrolyser, Electrolyzer.y_P) annotation (
      Line(points = {{-162, -124}, {-180, -124}, {-180, 760}, {-518, 760}, {-518, 777}, {-518, 777}}, color = {0, 0, 127}));
    connect(add_P_HeatPumps.u2, HePu_Geo.y_P) annotation (
      Line(points = {{-472, 384}, {-518, 384}, {-518, 417}, {-518, 417}}, color = {0, 0, 127}));
    connect(add_P_HeatPumps.u1, HePu_Air.y_P) annotation (
      Line(points = {{-472, 396}, {-480, 396}, {-480, 580}, {-518, 580}, {-518, 597}, {-518, 597}}, color = {0, 0, 127}));
    connect(add_P_HeatPumps.y, busbar_4consumer.u_DemandHeatPump) annotation (
      Line(points = {{-449, 390}, {-200, 390}, {-200, -140}, {-162, -140}, {-162, -139}}, color = {0, 0, 127}));
    connect(HePu_Geo.u_T_fluid_source, gain3.y) annotation (
      Line(points = {{-566, 474}, {-720, 474}, {-720, 221}, {-720, 221}}, color = {0, 0, 127}));
    connect(prescribedTemperature.port, dynamicPipe_HeatGrid_RF.heatPort_outside) annotation (
      Line(points = {{360, 320}, {398, 320}, {398, 305.2}, {398.8, 305.2}}, color = {191, 0, 0}));
    connect(prescribedTemperature.port, dynamicPipe_HeatGrid_FF.heatPort_outside) annotation (
      Line(points = {{360, 320}, {382, 320}, {382, 334.8}, {381.2, 334.8}}, color = {191, 0, 0}));
    connect(prescribedTemperature.T, sineGeo_T_amb.y) annotation (
      Line(points = {{338, 320}, {-940, 320}, {-940, 160}, {-959, 160}, {-959, 160}}, color = {0, 0, 127}));
    connect(gain1.y, gain2.u) annotation (
      Line(points = {{762, 759}, {762, 759}, {762, 742}, {762, 742}}, color = {0, 0, 127}));
    connect(gain_DemandHeat_Houses.y, gain1.u) annotation (
      Line(points = {{762, 799}, {762, 799}, {762, 782}, {762, 782}}, color = {0, 0, 127}));
    connect(weaDat.weaBus, WetterBus) annotation (
      Line(points = {{-960, 120}, {-720, 120}, {-720, 138}, {-720, 138}}, color = {255, 204, 51}, thickness = 0.5));
    connect(gain3.u, WetterBus.TWetBul) annotation (
      Line(points = {{-720, 198}, {-720, 198}, {-720, 138}, {-720, 138}}, color = {0, 0, 127}));
    annotation (
      Diagram(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}}, initialScale = 0.1), graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
      Icon(coordinateSystem(extent = {{-1000, -1000}, {1000, 1000}})),
      experiment(StopTime = 31536000, Interval = 3600, Tolerance = 1e-06, StartTime = 0));
  end SIM_RI_Schema;

  model Gesamt_Sim
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Constant Gaskessel(k = 0) annotation (
      Placement(transformation(extent={{-340,70},{-320,90}})));
    Modelica.Blocks.Sources.Constant WP(k=0.1) annotation (
      Placement(transformation(extent={{-502,260},{-482,280}})));
    FMUs.FMU_PhyModel fMU_PhyModel annotation (
      Placement(transformation(extent={{-254,62},{6,262}})));
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
      annotation (Placement(transformation(extent={{-400,232},{-380,252}})));
  equation
    connect(Gaskessel.y, fMU_PhyModel.u_boiler_0_1) annotation (
      Line(points={{-319,80},{-300,80},{-300,145.333},{-255.625,145.333}},color = {0, 0, 127}));
    connect(WP.y, fMU_PhyModel.u_heatpump_0_1) annotation (
      Line(points={{-481,270},{-436,270},{-436,184.167},{-255.625,184.167}},
                                                                          color = {0, 0, 127}));
    connect(Speicherentladung.y, fMU_PhyModel.u_7202_NS) annotation (
      Line(points={{-479,190},{-460,190},{-460,175.333},{-255.625,175.333}},
                                                                          color = {0, 0, 127}));
    connect(Speicherbeladung.y, fMU_PhyModel.u_7102_NS) annotation (
      Line(points={{-513,206},{-348,206},{-348,177.833},{-255.625,177.833}},
                                                                          color = {0, 0, 127}));
    connect(Boiler_disturb.y, fMU_PhyModel.u_disturb_boiler) annotation (Line(
          points={{-319,110},{-306,110},{-306,148.667},{-255.625,148.667}},
          color={255,0,255}));
    connect(WP1_disturb.y, fMU_PhyModel.u_disturb_heatpump2) annotation (Line(
          points={{-481,240},{-440,240},{-440,180.333},{-255.625,180.333}},
          color={255,0,255}));
    connect(add2.y,add4. u2) annotation (
      Line(points={{-470,409},{-470,398},{-386,398},{-386,392}},      color = {0, 0, 127}));
    connect(add3.y,add4. u1) annotation (
      Line(points={{-330,409},{-330,400},{-374,400},{-374,392}},      color = {0, 0, 127}));
    connect(add4.y, fMU_PhyModel.u_loadProfile_kW) annotation (Line(points={{-380,
            369},{-380,258.667},{-255.625,258.667}},
                                              color={0,0,127}));
    connect(BHKW.y, fMU_PhyModel.u_CHP_0_1) annotation (Line(points={{-399,140},
            {-360,140},{-360,169.5},{-255.625,169.5}},
                                               color={0,0,127}));
    connect(fMU_PhyModel.u_disturb_CHP, BHKW_disturb.y) annotation (Line(points
          ={{-255.625,172.833},{-366,172.833},{-366,170},{-399,170}}, color={
            255,0,255}));
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
    connect(WP2_disturb.y, fMU_PhyModel.u_disturb_heatpump1) annotation (Line(
          points={{-379,242},{-318,242},{-318,187.833},{-255.625,187.833}},
          color={255,0,255}));
    annotation (
      Diagram(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}}), graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
      Icon(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}})),
      experiment(StopTime = 31536000, Interval = 900, Tolerance = 0.01, __Dymola_Algorithm = "Dassl"));
  end Gesamt_Sim;

  model Gesamt_Sim_noLP
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Constant Gaskessel(k = 0) annotation (
      Placement(transformation(extent={{-340,70},{-320,90}})));
    Modelica.Blocks.Sources.Constant WP(k=0.1) annotation (
      Placement(transformation(extent={{-502,260},{-482,280}})));
    FMUs.FMU_PhyModel fMU_PhyModel annotation (
      Placement(transformation(extent={{-254,62},{6,262}})));
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
      annotation (Placement(transformation(extent={{-392,230},{-372,250}})));
  equation
    connect(Gaskessel.y, fMU_PhyModel.u_boiler_0_1) annotation (
      Line(points={{-319,80},{-300,80},{-300,145.333},{-255.625,145.333}},color = {0, 0, 127}));
    connect(WP.y, fMU_PhyModel.u_heatpump_0_1) annotation (
      Line(points={{-481,270},{-436,270},{-436,184.167},{-255.625,184.167}},
                                                                          color = {0, 0, 127}));
    connect(Speicherentladung.y, fMU_PhyModel.u_7202_NS) annotation (
      Line(points={{-479,190},{-460,190},{-460,175.333},{-255.625,175.333}},
                                                                          color = {0, 0, 127}));
    connect(Speicherbeladung.y, fMU_PhyModel.u_7102_NS) annotation (
      Line(points={{-513,206},{-348,206},{-348,177.833},{-255.625,177.833}},
                                                                          color = {0, 0, 127}));
    connect(Heatpump_disturb.y, fMU_PhyModel.u_disturb_boiler) annotation (Line(
          points={{-319,110},{-306,110},{-306,148.667},{-255.625,148.667}},
          color={255,0,255}));
    connect(WP2_disturb.y, fMU_PhyModel.u_disturb_heatpump2) annotation (Line(
          points={{-481,240},{-440,240},{-440,180.333},{-255.625,180.333}},
          color={255,0,255}));
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
    connect(add4.y, fMU_PhyModel.u_loadProfile_kW) annotation (Line(points={{-380,
            369},{-380,258.667},{-255.625,258.667}},
                                              color={0,0,127}));
    connect(BHKW.y, fMU_PhyModel.u_CHP_0_1) annotation (Line(points={{-399,140},
            {-360,140},{-360,169.5},{-255.625,169.5}},
                                               color={0,0,127}));
    connect(fMU_PhyModel.u_disturb_CHP, BHKW_disturb.y) annotation (Line(points
          ={{-255.625,172.833},{-366,172.833},{-366,170},{-399,170}}, color={
            255,0,255}));
    connect(WP1_disturb.y, fMU_PhyModel.u_disturb_heatpump1) annotation (Line(
          points={{-371,240},{-314,240},{-314,187.833},{-255.625,187.833}},
          color={255,0,255}));
    annotation (
      Diagram(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}}), graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
      Icon(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}})),
      experiment(StopTime = 31536000, Interval = 900, Tolerance = 0.01, __Dymola_Algorithm = "Dassl"));
  end Gesamt_Sim_noLP;
  annotation (
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.10.7")),
    Documentation(info = "<html>
      <p>Im package Simulations werden alle Modelle der unterschiedlichen Simulationen abgelegt.</p>
      <p>Erstellt wurden die Simulationsmodelle durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
end Simulations;
