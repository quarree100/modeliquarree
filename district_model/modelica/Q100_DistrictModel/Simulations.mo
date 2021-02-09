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
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandHeat(
      fileName=inputData.inputFileNameDemandThermal,
      tableName="tab1",
      tableOnFile=true) annotation (Placement(visible=true, transformation(
          origin={714,826},
          extent={{-10,-10},{10,10}},
          rotation=0)));
      Modelica.Blocks.Math.Add3 add31 annotation (
        Placement(visible = true, transformation(origin = {-60, 470}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Add3 add32 annotation (
        Placement(visible = true, transformation(origin = {-20, 470}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Add3 add33 annotation (
        Placement(visible = true, transformation(origin = {-40, 428}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation (
        Placement(visible = true, transformation(origin = {-40, 390}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_Spot(
      fileName=inputData.inputFileNameSpot,
      tableName="tab1",
      tableOnFile=true) annotation (Placement(visible=true, transformation(
          origin={70,-706},
          extent={{-10,-10},{10,10}},
          rotation=0)));
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
    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=inputData.inputFileNameWeatherData)
      annotation (Placement(visible=true, transformation(
          origin={-970,120},
          extent={{-10,-10},{10,10}},
          rotation=0)));
      Modelica.Blocks.Math.Gain gain3(k = 1.01) annotation (
        Placement(visible = true, transformation(origin = {-720, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Math.Gain gainPV_500kW(k = 50) annotation (
        Placement(visible = true, transformation(origin = {-608, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Q100_DistrictModel.Components.busbar_4consumer busbar_4consumer annotation (
        Placement(visible = true, transformation(origin = {-126, -148}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandPower(
      fileName=inputData.inputFileNameDemandPower,
      tableName="tab1",
      tableOnFile=true) annotation (Placement(visible=true, transformation(
          origin={-708,-156},
          extent={{-10,-10},{10,10}},
          rotation=0)));
      Modelica.Blocks.Math.Gain gain_DemandPower_Houses(k = 1) annotation (
        Placement(visible = true, transformation(origin = {-668, -156}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_DemandEMob(
      fileName=inputData.inputFileNameEMob,
      tableName="tab1",
      tableOnFile=true) annotation (Placement(visible=true, transformation(
          origin={-708,-186},
          extent={{-10,-10},{10,10}},
          rotation=0)));
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
      Data.inputData
      annotation (Placement(transformation(extent={{-980,58},{-960,78}})),
        __Dymola_choicesAllMatching=true);
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


    model PhyModel
      extends Modelica.Icons.Example;

      AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(348.15, 8), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 3.2, dTank = 20, sIns = 0.2, lambdaIns = 0.032),
        load_cycles=[8,1],                                                                                                                                                                                                        n = 8,
        n_load_cycles=1,                                                                                                                                                                                                        n_unload_cycles = 1, unload_cycles = [1, 8], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation (
        Placement(visible = true, transformation(origin={18,722},    extent={{-102,-122},
                {102,122}},                                                                           rotation = 0)));
      Modelica.Blocks.Sources.Ramp ramp(duration = 0, height=20)   annotation (
        Placement(visible = true, transformation(origin={790,700},    extent={{10,-10},
                {-10,10}},                                                                             rotation = 0)));
      AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF(T_0 = 343.15) annotation (
        Placement(visible = true, transformation(origin={170,300},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_FF(T_0 = 343.15, diameter = 0.3, length = 5000) annotation (
        Placement(visible = true, transformation(origin={390,300},    extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Math.Gain gain_DemandHeat_Houses(k = 5177304.074) annotation (
        Placement(visible = true, transformation(origin={820,810},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Math.Gain gain2(k = 1000) annotation (
        Placement(visible = true, transformation(origin={820,730},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_HeatGrid_FF annotation (
        Placement(visible = true, transformation(origin={310,300},    extent = {{10, -10}, {-10, 10}}, rotation = 180)));
      Modelica.Blocks.Sources.Sine sineGeo_T_amb(amplitude = 15, freqHz = 1 / (3600 * 24 * 365 * 2), offset = 3 + 273.15) annotation (
        Placement(visible = true, transformation(origin={90,280},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_RF(T_0 = 323.15, diameter = 0.3, length = 5000) annotation (
        Placement(visible = true, transformation(origin={390,240},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_RF(T_0 = 323.15) annotation (
        Placement(visible = true, transformation(origin={170,240},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation (
        Placement(visible = true, transformation(origin={176,820},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (
        Placement(visible = true, transformation(origin={350,278},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Gain gain1(k = 1) annotation (
        Placement(visible = true, transformation(origin={820,770},    extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      AixLib.FastHVAC.Components.Pumps.Pump pump_NS_7106_1
        annotation (Placement(transformation(extent={{-150,870},{-130,890}})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_7104_1
        annotation (Placement(visible=true, transformation(
            origin={-202,880},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_FRC_7103_1
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-220,778})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_7104_2
        annotation (Placement(visible=true, transformation(
            origin={-220,920},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_FRC_7103_2
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-240,800})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_7103_1
        annotation (Placement(visible=true, transformation(
            origin={-178,560},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_7103_2
        annotation (Placement(visible=true, transformation(
            origin={-160,520},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_7102_1
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-480,740})));
      AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_7102_2(n=2)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-480,710})));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_7202_2
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-520,520})));
      AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_7202_1(n=2)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-520,570})));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve1 annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-700,860})));
      AixLib.FastHVAC.Components.Valves.Manifold manifold1(n=2) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-650,900})));
      Modelica.Blocks.Sources.Constant const1(k=1)   annotation (
        Placement(visible = true, transformation(origin={-730,880},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={-660,810})));
      AixLib.FastHVAC.Components.Sinks.Vessel vessel annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-700,768})));
      Modelica.Blocks.Sources.Constant const4(k=15 + 273.15)
                                                     annotation (
        Placement(visible = true, transformation(origin={-630,790},    extent={{10,-10},
                {-10,10}},                                                                              rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-700,796})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_8101
        annotation (Placement(visible=true, transformation(
            origin={-760,900},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_8102
        annotation (Placement(visible=true, transformation(
            origin={-780,860},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve2 annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-880,860})));
      AixLib.FastHVAC.Components.Valves.Manifold manifold2(n=2) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-830,900})));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_FRC_5310
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-1040,0})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_5311
        annotation (Placement(visible=true, transformation(
            origin={-1020,60},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_5312
        annotation (Placement(visible=true, transformation(
            origin={-1000,0},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Pumps.Pump pump_UP_5304
        annotation (Placement(transformation(extent={{-1150,-10},{-1170,10}})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_5303
        annotation (Placement(visible=true, transformation(
            origin={-1218,0},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.HeatGenerators.Boiler.Boiler boiler(paramBoiler=
            AixLib.FastHVAC.Data.Boiler.General.Boiler_Vitocrossal200_311kW())
        annotation (Placement(transformation(extent={{-1354,16},{-1306,64}})));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve3 annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-1000,860})));
      AixLib.FastHVAC.Components.Valves.Manifold manifold3(n=2) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-1030,900})));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate1 annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-1198,920})));
      AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource1 annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-1170,978})));
      AixLib.FastHVAC.Components.Sinks.Vessel vessel1 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-1226,920})));
      Modelica.Blocks.Sources.Constant const2(k=15 + 273.15)
                                                     annotation (
        Placement(visible = true, transformation(origin={-1270,990},   extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Modelica.Blocks.Sources.Constant const6(k=0)   annotation (
        Placement(visible = true, transformation(origin={-970,880},    extent={{10,-10},
                {-10,10}},                                                                              rotation = 0)));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve4 annotation (
          Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-1000,740})));
      AixLib.FastHVAC.Components.Valves.Manifold manifold4(n=2) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-1040,810})));
      Modelica.Blocks.Sources.Constant const7(k=0)   annotation (
        Placement(visible = true, transformation(origin={-970,740},    extent={{10,-10},
                {-10,10}},                                                                              rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate2 annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-1000,642})));
      AixLib.FastHVAC.Components.Sinks.Vessel vessel2 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-1000,614})));
      AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource2 annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-1038,670})));
      Modelica.Blocks.Sources.Constant const8(k=15 + 273.15)
                                                     annotation (
        Placement(visible = true, transformation(origin={-1070,650},   extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_2202
        annotation (Placement(visible=true, transformation(
            origin={-1340,740},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Pumps.Pump pump_UP_2205
        annotation (Placement(transformation(extent={{-1290,730},{-1310,750}})));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_FRC_2214
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-1140,740})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_2216
        annotation (Placement(visible=true, transformation(
            origin={-1100,740},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_2215
        annotation (Placement(visible=true, transformation(
            origin={-1120,800},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_2211
        annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=0,
            origin={-1240,740})));
      AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_2211(n=2) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-1230,800})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_2213
        annotation (Placement(visible=true, transformation(
            origin={-1180,740},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump(
        redeclare model PerDataHea =
            AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (dataTable=
                Q100_DistrictModel.Data.WP_55kW()),
        redeclare model PerDataChi =
            AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (dataTable=
                Q100_DistrictModel.Data.WP_55kW()),
        CCon=100,
        CEva=100,
        GCon=5,
        GEva=5,
        Q_useNominal=0,
        TAmbCon_nominal=288.15,
        TCon_start(displayUnit="K") = 55 + 273.15,
        TEva_start(displayUnit="K"),
        VCon=0.04,
        VEva=0.04,
        allowFlowReversalEva=true,
        deltaM_con=0.1,
        deltaM_eva=0.1,
        mFlow_conNominal=0.5,
        mFlow_evaNominal=0.5,
        refIneFre_constant=1,
        transferHeat=true,
        use_ConCap=false,
        use_EvaCap=false,
        use_autoCalc=false,
        use_refIne=true,
        use_revHP=true)                                                                                                                                                                                                         annotation (Placement(transformation(
            extent={{-11.9997,14},{11.9999,-14}},
            rotation=90,
            origin={-1408,770})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_2204
        annotation (Placement(visible=true, transformation(
            origin={-1280,800},
            extent={{-10,-10},{10,10}},
            rotation=0)));
      Modelica.Blocks.Sources.BooleanConstant booleanConstant
        annotation (Placement(transformation(extent={{-1460,710},{-1440,730}})));
      AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource3 annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-1450,800})));
      AixLib.FastHVAC.Components.Sinks.Vessel vessel3 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-1486,740})));
      Modelica.Blocks.Sources.Constant const10(k=1)  annotation (
        Placement(visible = true, transformation(origin={-1450,770},   extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Modelica.Blocks.Sources.Constant const11(k=2)  annotation (
        Placement(visible = true, transformation(origin={-1490,780},   extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_8106
        annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=270,
            origin={-520,380})));
      AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_8106(n=2) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-480,370})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_8104
        annotation (Placement(visible=true, transformation(
            origin={-480,460},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_8103
        annotation (Placement(visible=true, transformation(
            origin={-520,440},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      AixLib.FastHVAC.Components.Pumps.Pump pump_NP_8113
        annotation (Placement(transformation(extent={{-330,290},{-310,310}})));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_FRC_8204
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-20,240})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_8206
        annotation (Placement(visible=true, transformation(
            origin={20,240},
            extent={{10,-10},{-10,10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_8205
        annotation (Placement(visible=true, transformation(
            origin={0,300},
            extent={{-10,10},{10,-10}},
            rotation=0)));
      AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_1
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-180,240})));
      AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_1(n=2) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-250,240})));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_8301
        annotation (Placement(visible=true, transformation(
            origin={-180,180},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_TRC_8302
        annotation (Placement(visible=true, transformation(
            origin={-240,200},
            extent={{10,-10},{-10,10}},
            rotation=270)));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate3 annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-180,122})));
      AixLib.FastHVAC.Components.Sinks.Vessel vessel4 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-180,94})));
      AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource4 annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-238,148})));
      Modelica.Blocks.Sources.Constant const12(k=15 + 273.15)
                                                     annotation (
        Placement(visible = true, transformation(origin={-270,128},    extent={{-10,-10},
                {10,10}},                                                                               rotation=0)));
      Modelica.Blocks.Sources.Constant const13(k=1)  annotation (
        Placement(visible = true, transformation(origin={-150,260},    extent={{10,-10},
                {-10,10}},                                                                              rotation=0)));
      Components.calc_Qdot calc_Qdot
        annotation (Placement(transformation(extent={{-1380,70},{-1360,90}})));
      Components.calc_mdot_production calc_mdot_production annotation (Placement(
            transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-1190,30})));
      Modelica.Blocks.Sources.Constant const3(k=90 + 273.15)
                                                     annotation (
        Placement(visible = true, transformation(origin={-1240,36},    extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput boiler_dotQ = boiler.heater.Q_flow
        annotation (Placement(transformation(extent={{-1312,28},{-1304,36}})));
      Modelica.Blocks.Sources.BooleanConstant booleanConstant1
        annotation (Placement(transformation(extent={{-1288,80},{-1308,100}})));
      Modelica.Blocks.Sources.Constant const9(k=10)  annotation (
        Placement(visible = true, transformation(origin={-1390,110},   extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Modelica.Blocks.Sources.Constant const14(k=80 + 273.15)
                                                     annotation (
        Placement(visible = true, transformation(origin={-1430,60},    extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Modelica.Blocks.Sources.Constant const15(k=0.9)
                                                     annotation (
        Placement(visible = true, transformation(origin={-506,740},    extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Modelica.Blocks.Sources.Constant const16(k=0.7)
                                                     annotation (
        Placement(visible = true, transformation(origin={-550,520},    extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Modelica.Blocks.Sources.Constant const17(k=0)  annotation (
        Placement(visible = true, transformation(origin={-190,960},    extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput heatpump_dotQ=heatPump.innerCycle.PerformanceDataHPHeating.QCon
        annotation (Placement(transformation(extent={{-1394,776},{-1386,784}})));
      Modelica.Blocks.Interfaces.RealOutput heatpump_Pel=heatPump.innerCycle.PerformanceDataHPHeating.Pel
        annotation (Placement(transformation(extent={{-1394,756},{-1386,764}})));
      Modelica.Blocks.Sources.Constant const18(k=1)  annotation (
        Placement(visible = true, transformation(origin={-1258,710},   extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Components.calc_mdot_production calc_mdot_production1
                                                           annotation (Placement(
            transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-1320,760})));
      Modelica.Blocks.Sources.Constant const19(k=55 + 273.15)
                                                     annotation (
        Placement(visible = true, transformation(origin={-1362,760},   extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Modelica.Blocks.Sources.Constant const20(k=1)  annotation (
        Placement(visible = true, transformation(origin={-1430,690},   extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      Components.calc_mdot_consumer calc_mdot_consumer
        annotation (Placement(transformation(extent={{710,690},{690,710}})));
      AixLib.FastHVAC.Components.Sinks.Sink sink   annotation (
        Placement(visible = true, transformation(origin={820,660},extent = {{-12, -12}, {12, 12}}, rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation (
        Placement(visible = true, transformation(origin={720,660},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation (
        Placement(visible = true, transformation(origin={880,660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Math.Add add(k1=-1)
        annotation (Placement(transformation(extent={{760,690},{740,710}})));
      Modelica.Blocks.Noise.UniformNoise uniformNoise(
        samplePeriod=3600,
      y_min=0.0000001,
      y_max=0.0001)
        annotation (Placement(transformation(extent={{760,830},{780,850}})));
      Modelica.Blocks.Sources.Constant const5(k=15 + 273.15)
                                                     annotation (
        Placement(visible = true, transformation(origin={-1530,804},   extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate4
                                                                     annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-800,900})));
      Components.calc_valve_ratio calc_valve_ratio
        annotation (Placement(transformation(extent={{-920,950},{-900,930}})));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate5
                                                                     annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-940,900})));
    Components.calc_valve calc_valve
      annotation (Placement(transformation(extent={{-640,370},{-620,390}})));
      Modelica.Blocks.Sources.Constant const21(k=70 + 273.15)
                                                     annotation (
        Placement(visible = true, transformation(origin={-670,400},    extent={{-10,-10},
                {10,10}},                                                                               rotation = 0)));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate6
                                                                     annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-854,860})));
      AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate7
                                                                     annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-910,860})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-684,584},{-664,604}})));
    equation
      connect(dynamicPipe_HeatGrid_RF.enthalpyPort_b1, dynamicPipe_HeatStorage_unload_RF.enthalpyPort_a1) annotation (
        Line(points={{380.2,240},{179.8,240}},      color={0,128,255}));
      connect(temperature_HeatGrid_FF.enthalpyPort_b, dynamicPipe_HeatGrid_FF.enthalpyPort_a1) annotation (
        Line(points={{319,300.1},{350.2,300.1},{350.2,300},{380.2,300}},          color = {176, 0, 0}));
      connect(prescribedTemperature.port, dynamicPipe_HeatGrid_RF.heatPort_outside) annotation (
        Line(points={{360,278},{398,278},{398,245.2},{398.8,245.2}},          color = {191, 0, 0}));
      connect(prescribedTemperature.port, dynamicPipe_HeatGrid_FF.heatPort_outside) annotation (
        Line(points={{360,278},{382,278},{382,294.8},{381.2,294.8}},          color = {191, 0, 0}));
      connect(prescribedTemperature.T, sineGeo_T_amb.y) annotation (
        Line(points={{338,278},{278,278},{278,280},{101,280}},                          color = {0, 0, 127}));
      connect(gain1.y, gain2.u) annotation (
        Line(points={{820,759},{820,742}},                              color = {0, 0, 127}));
      connect(gain_DemandHeat_Houses.y, gain1.u) annotation (
        Line(points={{820,799},{820,782}},                              color = {0, 0, 127}));
      connect(heatStorageVariablePorts_central.out, fixedTemperature.port)
        annotation (Line(points={{79.2,819.6},{121.6,819.6},{121.6,820},{166,820}},
            color={191,0,0}));
      connect(pump_NS_7106_1.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[
        1]) annotation (Line(points={{-130.4,880},{-2.4,880},{-2.4,844}}, color={176,
              0,0}));
      connect(temperature_TRC_7104_1.enthalpyPort_b, pump_NS_7106_1.enthalpyPort_a)
        annotation (Line(points={{-193,879.9},{-171.5,879.9},{-171.5,880},{-149.6,880}},
            color={176,0,0}));
      connect(massFlowRate_FRC_7103_1.enthalpyPort_b, temperature_TRC_7104_1.enthalpyPort_a)
        annotation (Line(points={{-219.9,787},{-220,787},{-220,880},{-210,880},{-210,
              879.9},{-210.8,879.9}}, color={176,0,0}));
      connect(temperature_TRC_7104_2.enthalpyPort_b, massFlowRate_FRC_7103_2.enthalpyPort_a)
        annotation (Line(points={{-229,919.9},{-240,919.9},{-240,808.8},{-239.9,808.8}},
            color={176,0,0}));
      connect(threeWayValve_NS_7102_1.enthalpyPort_b, massFlowRate_FRC_7103_1.enthalpyPort_a)
        annotation (Line(points={{-470,740},{-219.9,740},{-219.9,769.2}}, color={176,
              0,0}));
      connect(massFlowRate_FRC_7103_2.enthalpyPort_b, manifold_NS_7102_2.enthalpyPort_a[
        2]) annotation (Line(points={{-239.9,791},{-239.9,780},{-240,780},{-240,720},
              {-479.5,720}}, color={176,0,0}));
      connect(threeWayValve_NS_7102_1.enthalpyPort_a, manifold_NS_7102_2.enthalpyPort_a[
        1]) annotation (Line(points={{-480,730},{-480,720},{-480.5,720}}, color={176,
              0,0}));
      connect(temperature_TRC_7103_2.enthalpyPort_a, threeWayValve_NS_7202_2.enthalpyPort_b)
        annotation (Line(points={{-168.8,519.9},{-349.4,519.9},{-349.4,520},{-510,520}},
            color={0,128,255}));
      connect(const1.y, threeWayValve1.opening) annotation (Line(points={{-719,880},
              {-700,880},{-700,869}}, color={0,0,127}));
      connect(manifold1.enthalpyPort_a[2], fluidSource.enthalpyPort_b) annotation (
          Line(points={{-660,900.5},{-660,820},{-659,820}}, color={176,0,0}));
      connect(const4.y, fluidSource.T_fluid) annotation (Line(points={{-641,790},{-655.8,
              790},{-655.8,802}}, color={0,0,127}));
      connect(threeWayValve1.enthalpyPort_b, massFlowRate.enthalpyPort_a)
        annotation (Line(points={{-700,850},{-700,827.4},{-700.1,827.4},{-700.1,804.8}},
            color={0,128,255}));
      connect(massFlowRate.enthalpyPort_b, vessel.enthalpyPort_a) annotation (Line(
            points={{-700.1,787},{-700.1,783},{-700,783},{-700,775}}, color={0,128,255}));
      connect(massFlowRate.dotm, fluidSource.dotm) annotation (Line(points={{-691,795},
              {-662.6,795},{-662.6,802}}, color={0,0,127}));
      connect(manifold1.enthalpyPort_b, threeWayValve_NS_7102_1.enthalpyPort_ab)
        annotation (Line(points={{-640,900},{-480,900},{-480,749.8}}, color={176,0,0}));
      connect(temperature_TRC_8102.enthalpyPort_a, threeWayValve1.enthalpyPort_a)
        annotation (Line(points={{-771.2,859.9},{-741.6,859.9},{-741.6,860},{-710,860}},
            color={0,128,255}));
      connect(temperature_TRC_8101.enthalpyPort_b, manifold1.enthalpyPort_a[1])
        annotation (Line(points={{-751,900.1},{-706.5,900.1},{-706.5,899.5},{-660,899.5}},
            color={176,0,0}));
      connect(massFlowRate_FRC_5310.enthalpyPort_a, temperature_TRC_5312.enthalpyPort_b)
        annotation (Line(points={{-1031.2,-0.1},{-1009,-0.1}}, color={0,128,255}));
      connect(temperature_TRC_5312.enthalpyPort_a, threeWayValve2.enthalpyPort_b)
        annotation (Line(points={{-991.2,-0.1},{-880,-0.1},{-880,850}}, color={0,128,
              255}));
      connect(manifold2.enthalpyPort_a[2], temperature_TRC_5311.enthalpyPort_b)
        annotation (Line(points={{-840,900.5},{-840,60.1},{-1011,60.1}}, color={176,
              0,0}));
      connect(boiler.enthalpyPort_b1, temperature_TRC_5311.enthalpyPort_a)
        annotation (Line(points={{-1318,40},{-1300,40},{-1300,60.1},{-1028.8,60.1}},
            color={176,0,0}));
      connect(temperature_TRC_5303.enthalpyPort_b, boiler.enthalpyPort_a1)
        annotation (Line(points={{-1227,-0.1},{-1234,-0.1},{-1234,0},{-1360,0},{-1360,
              39.52},{-1342,39.52}}, color={0,128,255}));
      connect(fluidSource1.enthalpyPort_b, manifold3.enthalpyPort_a[1]) annotation (
         Line(points={{-1160,979},{-1040,979},{-1040,899.5}}, color={176,0,0}));
      connect(const2.y, fluidSource1.T_fluid) annotation (Line(points={{-1259,990},{
              -1248,990},{-1248,982},{-1178,982},{-1178,982.2}}, color={0,0,127}));
      connect(vessel1.enthalpyPort_a, massFlowRate1.enthalpyPort_b) annotation (
          Line(points={{-1219,920},{-1212,920},{-1212,919.9},{-1207,919.9}}, color={
              0,128,255}));
      connect(massFlowRate1.enthalpyPort_a, threeWayValve3.enthalpyPort_a)
        annotation (Line(points={{-1189.2,919.9},{-1010,919.9},{-1010,860}}, color={
              0,128,255}));
      connect(fluidSource1.dotm, massFlowRate1.dotm) annotation (Line(points={{-1178,
              975.4},{-1199,975.4},{-1199,929}}, color={0,0,127}));
      connect(temperature_TRC_5303.enthalpyPort_a, pump_UP_5304.enthalpyPort_b)
        annotation (Line(points={{-1209.2,-0.1},{-1190.6,-0.1},{-1190.6,0},{-1169.6,
              0}}, color={0,128,255}));
      connect(const6.y, threeWayValve3.opening) annotation (Line(points={{-981,880},
              {-1000,880},{-1000,869}}, color={0,0,127}));
      connect(manifold3.enthalpyPort_a[2], manifold4.enthalpyPort_b)
        annotation (Line(points={{-1040,900.5},{-1040,820}}, color={176,0,0}));
      connect(threeWayValve3.enthalpyPort_b, threeWayValve4.enthalpyPort_ab)
        annotation (Line(points={{-1000,850},{-1000,749.8}}, color={0,128,255}));
      connect(threeWayValve4.opening, const7.y)
        annotation (Line(points={{-991,740},{-981,740}}, color={0,0,127}));
      connect(threeWayValve4.enthalpyPort_a, massFlowRate2.enthalpyPort_a)
        annotation (Line(points={{-1000,730},{-1000,650.8},{-999.9,650.8}}, color={0,
              128,255}));
      connect(massFlowRate2.enthalpyPort_b, vessel2.enthalpyPort_a) annotation (
          Line(points={{-999.9,633},{-999.9,627.5},{-1000,627.5},{-1000,621}},
            color={0,128,255}));
      connect(fluidSource2.dotm, massFlowRate2.dotm) annotation (Line(points={{-1035.4,
              662},{-1035.4,641},{-1009,641}}, color={0,0,127}));
      connect(const8.y, fluidSource2.T_fluid) annotation (Line(points={{-1059,650},{
              -1042.2,650},{-1042.2,662}}, color={0,0,127}));
      connect(manifold4.enthalpyPort_a[2], fluidSource2.enthalpyPort_b) annotation (
         Line(points={{-1040.5,800},{-1040.5,680},{-1039,680}}, color={176,0,0}));
      connect(pump_UP_5304.enthalpyPort_a, massFlowRate_FRC_5310.enthalpyPort_b)
        annotation (Line(points={{-1150.4,0},{-1100,0},{-1100,-0.1},{-1049,-0.1}},
            color={0,128,255}));
      connect(temperature_TRC_2216.enthalpyPort_a, threeWayValve4.enthalpyPort_b)
        annotation (Line(points={{-1091.2,739.9},{-1050.6,739.9},{-1050.6,740},{-1010,
              740}}, color={0,128,255}));
      connect(massFlowRate_FRC_2214.enthalpyPort_a, temperature_TRC_2216.enthalpyPort_b)
        annotation (Line(points={{-1131.2,739.9},{-1120.6,739.9},{-1120.6,739.9},{-1109,
              739.9}}, color={0,128,255}));
      connect(temperature_TRC_2202.enthalpyPort_a, pump_UP_2205.enthalpyPort_b)
        annotation (Line(points={{-1331.2,739.9},{-1308.6,739.9},{-1308.6,740},{-1309.6,
              740}}, color={0,128,255}));
      connect(pump_UP_2205.enthalpyPort_a, threeWayValve_NS_2211.enthalpyPort_a)
        annotation (Line(points={{-1290.4,740},{-1250,740}}, color={0,128,255}));
      connect(manifold_NS_2211.enthalpyPort_a[2], threeWayValve_NS_2211.enthalpyPort_b)
        annotation (Line(points={{-1240,799.5},{-1240,750}}, color={0,128,255}));
      connect(manifold_NS_2211.enthalpyPort_b, temperature_TRC_2215.enthalpyPort_a)
        annotation (Line(points={{-1220,800},{-1154,800},{-1154,800.1},{-1128.8,800.1}},
            color={176,0,0}));
      connect(temperature_TRC_2215.enthalpyPort_b, manifold4.enthalpyPort_a[1])
        annotation (Line(points={{-1111,800.1},{-1075.5,800.1},{-1075.5,800},{-1039.5,
              800}}, color={176,0,0}));
      connect(threeWayValve_NS_2211.enthalpyPort_ab, temperature_TRC_2213.enthalpyPort_b)
        annotation (Line(points={{-1230.2,740},{-1184,740},{-1184,739.9},{-1189,739.9}},
            color={0,128,255}));
      connect(temperature_TRC_2213.enthalpyPort_a, massFlowRate_FRC_2214.enthalpyPort_b)
        annotation (Line(points={{-1171.2,739.9},{-1149,739.9}}, color={0,128,255}));
      connect(temperature_TRC_2202.enthalpyPort_b, heatPump.enthalpyPort_a)
        annotation (Line(points={{-1349,739.9},{-1401,739.9},{-1401,758}}, color={0,128,
              255}));
      connect(temperature_TRC_2204.enthalpyPort_b, manifold_NS_2211.enthalpyPort_a[1])
        annotation (Line(points={{-1271,799.9},{-1234.5,799.9},{-1234.5,800.5},{-1240,
              800.5}}, color={176,0,0}));
      connect(temperature_TRC_2204.enthalpyPort_a, heatPump.enthalpyPort_b)
        annotation (Line(points={{-1288.8,799.9},{-1401,799.9},{-1401,782}}, color={
              176,0,0}));
      connect(booleanConstant.y, heatPump.modeSet) annotation (Line(points={{-1439,
            720},{-1410,720},{-1410,722},{-1410.1,722},{-1410.1,756.08}},
                                                                       color={255,0,
              255}));
      connect(fluidSource3.enthalpyPort_b, heatPump.enthalpyPort_a1) annotation (
          Line(points={{-1440,801},{-1430,801},{-1430,800},{-1415,800},{-1415,
            782}},
            color={176,0,0}));
      connect(vessel3.enthalpyPort_a, heatPump.enthalpyPort_b1) annotation (Line(
            points={{-1479,740},{-1415,740},{-1415,758}}, color={176,0,0}));
      connect(const10.y, heatPump.iceFac_in) annotation (Line(points={{-1439,
            770},{-1432,770},{-1432,760.88},{-1423.87,760.88}},
                                                      color={0,0,127}));
      connect(const11.y, fluidSource3.dotm) annotation (Line(points={{-1479,780},{-1470,
              780},{-1470,797.4},{-1458,797.4}}, color={0,0,127}));
      connect(temperature_TRC_8104.enthalpyPort_b, manifold_NS_8106.enthalpyPort_a[1])
        annotation (Line(points={{-479.9,451},{-479.9,394.5},{-479.5,394.5},{
            -479.5,380}},
                     color={176,0,0}));
      connect(threeWayValve_NS_8106.enthalpyPort_b, manifold_NS_8106.enthalpyPort_a[
        2]) annotation (Line(points={{-510,380},{-480.5,380}}, color={0,128,255}));
      connect(threeWayValve1.enthalpyPort_ab, manifold_NS_7202_1.enthalpyPort_b)
        annotation (Line(points={{-690.2,860},{-520,860},{-520,580}}, color={0,128,255}));
      connect(manifold_NS_7202_1.enthalpyPort_a[2], temperature_TRC_7103_1.enthalpyPort_b)
        annotation (Line(points={{-520.5,560},{-354,560},{-354,559.9},{-187,559.9}},
            color={0,128,255}));
      connect(manifold_NS_7202_1.enthalpyPort_a[1], threeWayValve_NS_7202_2.enthalpyPort_a)
        annotation (Line(points={{-519.5,560},{-519.5,546},{-520,546},{-520,530}},
            color={0,128,255}));
      connect(threeWayValve_NS_7202_2.enthalpyPort_ab, temperature_TRC_8103.enthalpyPort_b)
        annotation (Line(points={{-520,510.2},{-520,480},{-520,449},{-519.9,449}},
            color={0,128,255}));
      connect(manifold_NS_7102_2.enthalpyPort_b, temperature_TRC_8104.enthalpyPort_a)
        annotation (Line(points={{-480,700},{-480,584},{-480,468.8},{-479.9,
            468.8}},
            color={176,0,0}));
      connect(pump_NP_8113.enthalpyPort_a, manifold_NS_8106.enthalpyPort_b)
        annotation (Line(points={{-329.6,300},{-480,300},{-480,360}}, color={176,0,0}));
      connect(pump_NP_8113.enthalpyPort_b, temperature_TRC_8205.enthalpyPort_a)
        annotation (Line(points={{-310.4,300},{-160,300},{-160,300.1},{-8.8,300.1}},
            color={176,0,0}));
      connect(massFlowRate_FRC_8204.enthalpyPort_a, temperature_TRC_8206.enthalpyPort_b)
        annotation (Line(points={{-11.2,239.9},{0.4,239.9},{0.4,239.9},{11,239.9}},
            color={0,128,255}));
      connect(threeWayValve_NS_1.enthalpyPort_ab, massFlowRate_FRC_8204.enthalpyPort_b)
        annotation (Line(points={{-170.2,240},{-100,240},{-100,239.9},{-29,239.9}},
            color={0,128,255}));
      connect(threeWayValve_NS_1.enthalpyPort_b, temperature_TRC_8301.enthalpyPort_a)
        annotation (Line(points={{-180,230},{-180,210},{-180,188.8},{-180.1,188.8}},
            color={0,128,255}));
      connect(manifold_NS_1.enthalpyPort_a[2], temperature_TRC_8302.enthalpyPort_b)
        annotation (Line(points={{-240,240.5},{-240,224},{-240,209},{-240.1,209}},
            color={0,128,255}));
      connect(manifold_NS_1.enthalpyPort_a[1], threeWayValve_NS_1.enthalpyPort_a)
        annotation (Line(points={{-240,239.5},{-216,239.5},{-216,240},{-190,240}},
            color={0,128,255}));
      connect(temperature_TRC_8302.enthalpyPort_a, fluidSource4.enthalpyPort_b)
        annotation (Line(points={{-240.1,191.2},{-240.1,183.6},{-239,183.6},{-239,158}},
            color={0,128,255}));
      connect(const12.y, fluidSource4.T_fluid) annotation (Line(points={{-259,128},{
              -242.2,128},{-242.2,140}}, color={0,0,127}));
      connect(const13.y, threeWayValve_NS_1.opening) annotation (Line(points={{-161,
              260},{-180,260},{-180,249}}, color={0,0,127}));
      connect(massFlowRate3.enthalpyPort_b, vessel4.enthalpyPort_a) annotation (
          Line(points={{-179.9,113},{-179.9,106.5},{-180,106.5},{-180,101}}, color={
              0,128,255}));
      connect(temperature_TRC_8301.enthalpyPort_b, massFlowRate3.enthalpyPort_a)
        annotation (Line(points={{-180.1,171},{-180.1,150.5},{-179.9,150.5},{-179.9,
              130.8}}, color={0,128,255}));
      connect(massFlowRate3.dotm, fluidSource4.dotm) annotation (Line(points={{-189,
              121},{-235.4,121},{-235.4,140}}, color={0,0,127}));
      connect(manifold_NS_1.enthalpyPort_b, threeWayValve_NS_8106.enthalpyPort_ab)
        annotation (Line(points={{-260,240},{-520,240},{-520,370.2}}, color={0,128,255}));
      connect(dynamicPipe_HeatStorage_unload_FF.enthalpyPort_b1,
        temperature_HeatGrid_FF.enthalpyPort_a) annotation (Line(points={{179.8,300},
              {240,300},{240,300.1},{301.2,300.1}}, color={176,0,0}));
      connect(temperature_TRC_8205.enthalpyPort_b,
        dynamicPipe_HeatStorage_unload_FF.enthalpyPort_a1) annotation (Line(points={
              {9,300.1},{84.5,300.1},{84.5,300},{160.2,300}}, color={176,0,0}));
      connect(temperature_TRC_8206.enthalpyPort_a,
        dynamicPipe_HeatStorage_unload_RF.enthalpyPort_b1) annotation (Line(points={
              {28.8,239.9},{94.4,239.9},{94.4,240},{160.2,240}}, color={0,128,255}));
      connect(calc_mdot_production.y_mdot, pump_UP_5304.dotm_setValue) annotation (
          Line(points={{-1179,30},{-1160,30},{-1160,8}}, color={0,0,127}));
      connect(calc_mdot_production.u_TemperatureInput, temperature_TRC_5303.T)
        annotation (Line(points={{-1202,24},{-1219,24},{-1219,11}}, color={0,0,127}));
      connect(const3.y, calc_mdot_production.u_TemperatureOutput) annotation (Line(
            points={{-1229,36},{-1216,36},{-1216,35.8},{-1202,35.8}}, color={0,0,127}));
      connect(boiler_dotQ, calc_mdot_production.u_dotQ) annotation (Line(points={{-1308,
              32},{-1280,32},{-1280,52},{-1190,52},{-1190,42}}, color={0,0,127}));
      connect(booleanConstant1.y, boiler.onOff_boiler) annotation (Line(points={{-1309,
              90},{-1322.8,90},{-1322.8,56.8}}, color={255,0,255}));
      connect(const9.y, calc_Qdot.u_deltaT_setpoint) annotation (Line(points={{-1379,
              110},{-1370,110},{-1370,92}}, color={0,0,127}));
      connect(calc_Qdot.y_Qdot, boiler.dotQ_rel) annotation (Line(points={{-1359,80},
              {-1334.83,80},{-1334.83,56.83}}, color={0,0,127}));
      connect(const14.y, calc_Qdot.u_T_setpoint) annotation (Line(points={{-1419,60},
              {-1402,60},{-1402,74},{-1382,74}}, color={0,0,127}));
      connect(const15.y, threeWayValve_NS_7102_1.opening)
        annotation (Line(points={{-495,740},{-489,740}}, color={0,0,127}));
      connect(const16.y, threeWayValve_NS_7202_2.opening)
        annotation (Line(points={{-539,520},{-529,520}}, color={0,0,127}));
      connect(const17.y, pump_NS_7106_1.dotm_setValue) annotation (Line(points={{-179,
              960},{-140,960},{-140,888}}, color={0,0,127}));
      connect(const18.y, threeWayValve_NS_2211.opening) annotation (Line(points={{-1247,
              710},{-1240,710},{-1240,731}}, color={0,0,127}));
      connect(calc_mdot_production1.u_TemperatureInput, temperature_TRC_2202.T)
        annotation (Line(points={{-1332,754},{-1340,754},{-1340,751},{-1341,751}},
            color={0,0,127}));
      connect(calc_mdot_production1.u_dotQ, heatpump_dotQ) annotation (Line(points={
              {-1320,772},{-1320,780},{-1390,780}}, color={0,0,127}));
      connect(const19.y, calc_mdot_production1.u_TemperatureOutput) annotation (
          Line(points={{-1351,760},{-1340,760},{-1340,765.8},{-1332,765.8}}, color={
              0,0,127}));
      connect(calc_mdot_production1.y_mdot, pump_UP_2205.dotm_setValue) annotation (
         Line(points={{-1309,760},{-1300,760},{-1300,748}}, color={0,0,127}));
      connect(const20.y, heatPump.nSet) annotation (Line(points={{-1419,690},{
            -1405.67,690},{-1405.67,756.08}},
                                       color={0,0,127}));
      connect(TemperatureInput.enthalpyPort_b, sink.enthalpyPort_a1) annotation (
          Line(points={{729,659.9},{814.5,659.9},{814.5,660},{809.2,660}}, color={176,
              0,0}));
      connect(sink.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation (
          Line(points={{830.8,660},{850,660},{850,659.9},{871.2,659.9}}, color={176,
              0,0}));
      connect(gain2.y, sink.Load) annotation (Line(points={{820,719},{820,670.68},{819.88,
              670.68}}, color={0,0,127}));
      connect(calc_mdot_consumer.u_dotQ, gain2.y) annotation (Line(points={{700,712},
              {700,720},{820,720},{820,719}}, color={0,0,127}));
      connect(calc_mdot_consumer.u_TemperatureInput, TemperatureInput.T)
        annotation (Line(points={{712,694},{721,694},{721,671}}, color={0,0,127}));
      connect(add.y, calc_mdot_consumer.u_TemperatureOutput) annotation (Line(
            points={{739,700},{726,700},{726,705.8},{712,705.8}}, color={0,0,127}));
      connect(add.u2, TemperatureInput.T) annotation (Line(points={{762,694},{770,694},
              {770,680},{721,680},{721,671}}, color={0,0,127}));
      connect(ramp.y, add.u1) annotation (Line(points={{779,700},{772,700},{772,706},
              {762,706}}, color={0,0,127}));
      connect(uniformNoise.y, gain_DemandHeat_Houses.u)
        annotation (Line(points={{781,840},{820,840},{820,822}}, color={0,0,127}));
      connect(TemperatureOutput.enthalpyPort_b, dynamicPipe_HeatGrid_RF.enthalpyPort_a1)
        annotation (Line(points={{889,659.9},{900,659.9},{900,600},{680,600},{680,240},
              {399.8,240}}, color={0,128,255}));
      connect(const5.y, fluidSource3.T_fluid) annotation (Line(points={{-1519,804},{
              -1478,804},{-1478,804.2},{-1458,804.2}}, color={0,0,127}));
      connect(dynamicPipe_HeatGrid_FF.enthalpyPort_b1, TemperatureInput.enthalpyPort_a)
        annotation (Line(points={{399.8,300},{620,300},{620,659.9},{711.2,659.9}},
            color={176,0,0}));
      connect(manifold2.enthalpyPort_b, massFlowRate4.enthalpyPort_a) annotation (
          Line(points={{-820,900},{-814,900},{-814,899.9},{-808.8,899.9}}, color={176,
              0,0}));
      connect(massFlowRate4.enthalpyPort_b, temperature_TRC_8101.enthalpyPort_a)
        annotation (Line(points={{-791,899.9},{-780.5,899.9},{-780.5,900.1},{-768.8,
              900.1}}, color={176,0,0}));
      connect(calc_valve_ratio.y_valve, threeWayValve2.opening) annotation (Line(
            points={{-899,940},{-880,940},{-880,869}}, color={0,0,127}));
      connect(massFlowRate5.enthalpyPort_b, manifold2.enthalpyPort_a[1])
        annotation (Line(points={{-931,899.9},{-870.5,899.9},{-870.5,899.5},{
            -840,899.5}},
            color={176,0,0}));
      connect(manifold3.enthalpyPort_b, massFlowRate5.enthalpyPort_a) annotation (
          Line(points={{-1020,900},{-970,900},{-970,899.9},{-948.8,899.9}}, color={176,
              0,0}));
    connect(calc_Qdot.u_T_measurement, temperature_TRC_8104.T) annotation (Line(
          points={{-1382,85.8},{-1460,85.8},{-1460,-40},{-820,-40},{-820,459},{
            -491,459}}, color={0,0,127}));
    connect(calc_valve.u_T_source_input, temperature_TRC_8104.T) annotation (
        Line(points={{-630,392},{-630,459},{-491,459}}, color={0,0,127}));
    connect(calc_valve.u_T_consumer_input, const21.y) annotation (Line(points={
            {-642,385.8},{-650,385.8},{-650,400},{-659,400}}, color={0,0,127}));
    connect(threeWayValve2.enthalpyPort_ab, massFlowRate6.enthalpyPort_b)
      annotation (Line(points={{-870.2,860},{-866.6,860},{-866.6,859.9},{-863,
            859.9}}, color={0,128,255}));
    connect(massFlowRate6.enthalpyPort_a, temperature_TRC_8102.enthalpyPort_b)
      annotation (Line(points={{-845.2,859.9},{-830,860},{-830,859.9},{-789,
            859.9}}, color={0,128,255}));
    connect(massFlowRate6.dotm, calc_valve_ratio.u_dotm_in) annotation (Line(
          points={{-855,869},{-855,952},{-910,952}}, color={0,0,127}));
    connect(threeWayValve3.enthalpyPort_ab, massFlowRate7.enthalpyPort_b)
      annotation (Line(points={{-990.2,860},{-954.6,860},{-954.6,859.9},{-919,
            859.9}}, color={0,128,255}));
    connect(massFlowRate7.enthalpyPort_a, threeWayValve2.enthalpyPort_a)
      annotation (Line(points={{-901.2,859.9},{-895.6,859.9},{-895.6,860},{-890,
            860}}, color={0,128,255}));
    connect(massFlowRate5.dotm, calc_valve_ratio.u_dotm_out) annotation (Line(
          points={{-939,909},{-910,909},{-910,928}}, color={0,0,127}));
    connect(temperature_TRC_8103.enthalpyPort_a, threeWayValve_NS_8106.enthalpyPort_a)
      annotation (Line(points={{-519.9,431.2},{-519.9,410.6},{-520,410.6},{-520,
            390}}, color={0,128,255}));
    connect(calc_mdot_production1.y_mdot, add1.u1) annotation (Line(points={{
            -1309,760},{-1280,760},{-1280,600},{-686,600}}, color={0,0,127}));
    connect(add1.u2, calc_mdot_production.y_mdot) annotation (Line(points={{
            -686,588},{-1160,588},{-1160,30},{-1179,30}}, color={0,0,127}));
    connect(calc_valve.y_valve, threeWayValve_NS_8106.opening)
      annotation (Line(points={{-619,380},{-529,380}}, color={0,0,127}));
    connect(calc_valve.u_T_consumer_output, temperature_TRC_8206.T) annotation
      (Line(points={{-642,374},{-652,374},{-652,278},{19,278},{19,251}}, color=
            {0,0,127}));
    connect(pump_NP_8113.dotm_setValue, calc_mdot_consumer.y_mdot) annotation (
        Line(points={{-320,308},{-320,360},{576,360},{576,700},{689,700}},
          color={0,0,127}));
    connect(temperature_TRC_7104_2.enthalpyPort_a,
      heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation (Line(
          points={{-211.2,919.9},{38.4,919.9},{38.4,844}}, color={176,0,0}));
    connect(temperature_TRC_7103_2.enthalpyPort_b,
      heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation (Line(
          points={{-151,519.9},{38.4,519.9},{38.4,600}}, color={0,128,255}));
    connect(temperature_TRC_7103_1.enthalpyPort_a,
      heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation (Line(
          points={{-169.2,559.9},{-2.4,559.9},{-2.4,600}}, color={0,128,255}));
      annotation (
        Diagram(coordinateSystem(extent={{-1600,-1000},{1000,1000}}),                          graphics={  Line(origin = {688, 520}, points = {{0, 0}})}),
        Icon(coordinateSystem(extent={{-1600,-1000},{1000,1000}})),
        experiment(StopTime = 31536000, Interval = 3600, Tolerance = 1e-06, StartTime = 0));
    end PhyModel;
  annotation (
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
    Documentation(info = "<html>
      <p>Im package Simulations werden alle Modelle der unterschiedlichen Simulationen abgelegt.</p>
      <p>Erstellt wurden die Simulationsmodelle durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
end Simulations;
