within Q100_DistrictModel;

package FMUs
  extends Modelica.Icons.ExamplesPackage;

  model FMU_PhyModel
    parameter Real ScaleFactor_heatPump1 = 0.8 "Scaling factor for heatpump1";
    parameter Real ScaleFactor_heatPump2 = 0.2 "Scaling factor for heatpump2";
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 8), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 3.2, dTank = 20, sIns = 0.2, lambdaIns = 0.032), load_cycles = [8, 1], n = 8, n_load_cycles = 1, n_unload_cycles = 1, unload_cycles = [1, 8], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {18, 584}, extent = {{-102, -122}, {102, 122}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF(selectable = false, T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {170, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_FF(selectable = true, T_0 = 343.15, nNodes = 10, diameter = 0.3, length = 5000, withConvection = true) annotation(
      Placement(visible = true, transformation(origin = {390, 160}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {820, 590}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_HeatGrid_FF annotation(
      Placement(visible = true, transformation(origin = {310, 160}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Sine sineGeo_T_amb(amplitude = 15, freqHz = 1 / (3600 * 24 * 365 * 2), offset = 3 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {90, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_RF(selectable = true, T_0 = 323.15, nNodes = 10, diameter = 0.3, length = 5000, withConvection = true) annotation(
      Placement(visible = true, transformation(origin = {390, 100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_RF(selectable = false, T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {170, 100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {176, 680}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation(
      Placement(visible = true, transformation(origin = {350, 138}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_7104_TRC_load annotation(
      Placement(visible = true, transformation(origin = {-202, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_7103_FRC_load annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 90, origin = {-220, 638})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_7104_TRC_unload annotation(
      Placement(visible = true, transformation(origin = {-220, 780}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_7103_FRC_unload annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {-240, 660})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_7203_TRC_load annotation(
      Placement(visible = true, transformation(origin = {-178, 440}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_7203_TRC_unload annotation(
      Placement(visible = true, transformation(origin = {-160, 380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_7102_1 annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {-480, 600})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_7102_2(n = 2) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-480, 530})));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_7202_2 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-520, 380})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_7202_1(n = 2) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-520, 450})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8101_TRC annotation(
      Placement(visible = true, transformation(origin = {-668, 760}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8102_TRC annotation(
      Placement(visible = true, transformation(origin = {-688, 720}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve2 annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-880, 720})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold2(n = 2) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-830, 760})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_5310_FRC annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1040, -140})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_5311_TRC annotation(
      Placement(visible = true, transformation(origin = {-1020, -80}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_5312_TRC annotation(
      Placement(visible = true, transformation(origin = {-968, -140}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_5304_UP annotation(
      Placement(transformation(extent = {{-1150, -150}, {-1170, -130}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_5303_TRC annotation(
      Placement(visible = true, transformation(origin = {-1218, -140}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.HeatGenerators.Boiler.Boiler boiler(paramBoiler = AixLib.FastHVAC.Data.Boiler.General.Boiler_Vitocrossal200_311kW(Q_nom = 2000000, Q_min = 0, eta = [0.3, (0.973 + 0.989) / 2; 0.4, (0.960 + 0.981) / 2; 0.5, (0.942 + 0.975) / 2; 0.6, (0.924 + 0.968) / 2; 0.7, (0.907 + 0.962) / 2; 0.8, (0.889 + 0.957) / 2; 0.9, (0.872 + 0.953) / 2; 1.0, (0.857 + 0.952) / 2])) annotation(
      Placement(transformation(extent = {{-1354, -124}, {-1306, -76}})));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve3 annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1000, 720})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold3(n = 2) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-1030, 760})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate1 annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {-1198, 780})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource1 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-1170, 838})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel1 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-1226, 780})));
    Modelica.Blocks.Sources.Constant const2(k = 15 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-1270, 850}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const6(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-974, 800}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve4 annotation(
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 90, origin = {-1000, 530})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold4(n = 2) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-1040, 670})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2202_TRC_2 annotation(
      Placement(visible = true, transformation(origin = {-1440, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_2205_UP_2 annotation(
      Placement(transformation(extent = {{-1362, 550}, {-1382, 570}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_2214_FRC annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1132, 530})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2216_TRC annotation(
      Placement(visible = true, transformation(origin = {-1100, 530}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2215_TRC annotation(
      Placement(visible = true, transformation(origin = {-1120, 660}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_2211 annotation(
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {-1302, 660})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_2211(n = 2) annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1312, 560})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2213_TRC annotation(
      Placement(visible = true, transformation(origin = {-1168, 530}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump2(redeclare model PerDataHea = AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D(dataTable = Q100_DistrictModel.Data.WP_550kW()), redeclare model PerDataChi = AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D(dataTable = Q100_DistrictModel.Data.WP_550kW()), CCon = 100, CEva = 100, GCon = 5, GEva = 5, Q_useNominal = 0, TAmbCon_nominal = 288.15, TCon_start(displayUnit = "K") = 55 + 273.15, TEva_start(displayUnit = "K"), VCon = 0.04, VEva = 0.04, allowFlowReversalEva = true, deltaM_con = 0.1, deltaM_eva = 0.1, mFlow_conNominal = 0.5, mFlow_evaNominal = 0.5, refIneFre_constant = 1, scalingFactor = ScaleFactor_heatPump2, transferHeat = true, use_ConCap = false, use_EvaCap = false, use_autoCalc = false, use_refIne = true, use_revHP = true) annotation(
      Placement(transformation(extent = {{-11.9997, 14}, {11.9999, -14}}, rotation = 90, origin = {-1540, 630})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2204_TRC_2 annotation(
      Placement(visible = true, transformation(origin = {-1420, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant annotation(
      Placement(transformation(extent = {{-1592, 570}, {-1572, 590}})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource3 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-1602, 860})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel3 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-1640, 800})));
    Modelica.Blocks.Sources.Constant const10(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-1575, 621}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const11(k = 20) annotation(
      Placement(visible = true, transformation(origin = {-1642, 830}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_8106 annotation(
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 270, origin = {-520, 240})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_8106(n = 2) annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {-480, 230})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8104_TRC annotation(
      Placement(visible = true, transformation(origin = {-480, 302}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8103_TRC annotation(
      Placement(visible = true, transformation(origin = {-520, 288}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_8113_NP annotation(
      Placement(transformation(extent = {{-330, 150}, {-310, 170}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_8204_FRC annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-20, 100})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8206_TRC annotation(
      Placement(visible = true, transformation(origin = {20, 100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8205_TRC annotation(
      Placement(visible = true, transformation(origin = {0, 160}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_1 annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {-180, 100})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_1(n = 2) annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-250, 100})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8301_TRC annotation(
      Placement(visible = true, transformation(origin = {-180, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8302_TRC annotation(
      Placement(visible = true, transformation(origin = {-240, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate3 annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-180, -18})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel4 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-180, -46})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource4 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-238, 8})));
    Modelica.Blocks.Sources.Constant const12(k = 15 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-270, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const13(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-150, 120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Components.calc_Qdot calc_Qdot annotation(
      Placement(transformation(extent = {{-1440, -70}, {-1420, -50}})));
    Components.calc_mdot_production calc_mdot_production annotation(
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {-1190, -110})));
    Modelica.Blocks.Sources.Constant const3(k = 90 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-1240, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.RealOutput_JW y_boiler_dotQ = boiler.heater.Q_flow / 1000 annotation(
      Placement(visible = true, transformation(extent = {{-1306, -112}, {-1298, -104}}, rotation = 0), iconTransformation(extent = {{-1312, 28}, {-1304, 36}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const9(k = 20) annotation(
      Placement(visible = true, transformation(origin = {-1450, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const14(k = 77 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-1490, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const16(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-630, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.RealOutput_JW y_heatpump2_dotQ = heatPump2.innerCycle.PerformanceDataHPHeating.QCon / 1000 annotation(
      Placement(transformation(extent = {{-1526, 636}, {-1518, 644}})));
    Q100_DistrictModel.Components.RealOutput_JW y_heatpump2_Pel = heatPump2.innerCycle.PerformanceDataHPHeating.Pel / 1000 annotation(
      Placement(visible = true, transformation(extent = {{-1526, 628}, {-1518, 636}}, rotation = 0), iconTransformation(extent = {{-1526, 628}, {-1518, 636}}, rotation = 0)));
    Components.calc_mdot_production calc_mdot_production1 annotation(
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {-1402, 590})));
    Modelica.Blocks.Sources.Constant const19(k = 5) annotation(
      Placement(visible = true, transformation(origin = {-1484, 606}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sinks.Sink sink annotation(
      Placement(visible = true, transformation(origin = {820, 520}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation(
      Placement(visible = true, transformation(origin = {720, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation(
      Placement(visible = true, transformation(origin = {880, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate4 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-750, 760})));
    Components.calc_valve_ratio calc_valve_ratio annotation(
      Placement(transformation(extent = {{-920, 810}, {-900, 790}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate5 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-940, 760})));
    Q100_DistrictModel.Components.calc_valve calc_valve annotation(
      Placement(visible = true, transformation(extent = {{-578, 230}, {-558, 250}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const21(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-610, 246}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate6 annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-780, 720})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate7 annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-938, 720})));
    Modelica.Blocks.Math.Max max annotation(
      Placement(transformation(extent = {{-1400, -64}, {-1380, -44}})));
    Modelica.Blocks.Sources.Constant const17(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-832, 788}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate8 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-480, 710})));
    Modelica.Blocks.Math.Max max1 annotation(
      Placement(transformation(extent = {{-580, 370}, {-560, 390}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate9 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-480, 366})));
    Modelica.Blocks.Math.Min min annotation(
      Placement(transformation(extent = {{-640, 376}, {-620, 396}})));
    Modelica.Blocks.Sources.Constant const1(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-680, 410}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF1(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-540, 535}, extent = {{-15, -4}, {15, 4}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF2(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-570, 545}, extent = {{-15, -4}, {15, 4}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF3(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-540, 441}, extent = {{-15, -4}, {15, 4}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF4(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-570, 447}, extent = {{-15, -4}, {15, 4}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF6(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-82.5, 379.5}, extent = {{-14.5, -10.5}, {14.5, 10.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF5(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-106.5, 439.5}, extent = {{14.5, -10.5}, {-14.5, 10.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF7(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-90.5, 779.5}, extent = {{14.5, -10.5}, {-14.5, 10.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF8(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-68.5, 739.5}, extent = {{-14.5, -10.5}, {14.5, 10.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF9(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-480, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF10(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-480, 332}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF11(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-480, 190}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF12(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-480, 266}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF13(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-500.5, 240.5}, extent = {{-4.5, -11.5}, {4.5, 11.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF14(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-520, 264}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF15(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-520, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF16(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-520, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF17(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-250, 440}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF18(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-250, 380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF19(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-350, 600}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF20(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-352, 540}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF21(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-240, 710}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF22(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-220, 684}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF23(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-480, 650}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF24(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-570, 760}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF25(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-650, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF26(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-730, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF27(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-710, 760}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF28(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-794, 760}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF29(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-818, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF30(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-896, 760}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF31(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-910, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF32(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-970, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF33(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-840, 670}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF34(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-880, 670}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF35(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1008, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF36(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1110, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF37(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1102, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF38(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1190, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF39(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1290, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.HeatExchangers.DHWHeatExchanger dHWHeatExchanger(A_HE = 2000, k_HE = 10000000000, m_heater = 0.1, m_DHW = 0.1) annotation(
      Placement(transformation(extent = {{9, 10}, {-9, -10}}, rotation = 180, origin = {-555, 490})));
    Modelica.Blocks.Sources.Constant const4(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-690, 570}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Max max2 annotation(
      Placement(transformation(extent = {{-640, 590}, {-620, 610}})));
    Modelica.Blocks.Math.Min min1 annotation(
      Placement(transformation(extent = {{-700, 596}, {-680, 616}})));
    Modelica.Blocks.Sources.Constant const20(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-730, 630}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF40(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1000, 690}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF41(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1000, 496}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF42(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1040, 510}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF43(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1070, 530}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF44(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1302, 630}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF45(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1270, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF46(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1342, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF47(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1408, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF48(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1482, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF49(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1584, 800}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF50(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1566, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF51(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1502, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF52(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1342, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF53(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1262, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF54(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1090, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF55(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1040, 710}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF56(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1150, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF57(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1130, 840}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_boiler_0_1 annotation(
      Placement(transformation(extent = {{-2240, -20}, {-2200, 20}})));
    Modelica.Blocks.Interfaces.RealInput u_heatpump_0_1 annotation(
      Placement(transformation(extent = {{-2240, 446}, {-2200, 486}})));
    Modelica.Blocks.Interfaces.RealInput u_7202_NS annotation(
      Placement(transformation(extent = {{-2240, 340}, {-2200, 380}})));
    Modelica.Blocks.Interfaces.RealInput u_7102_NS annotation(
      Placement(transformation(extent = {{-2240, 370}, {-2200, 410}})));
    Components.RealOutput_JW y_5303_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_5303_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-1228, -136}, {-1240, -124}})));
    Components.RealOutput_JW y_5310_FRC(final quantity = "VolumeFlowRate", final unit = "m3/h", displayUnit = "m3/h", min = 0) = massFlowRate_5310_FRC.dotm * 3600 / 1000 annotation(
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-1050, -126})));
    Components.RealOutput_JW y_5312_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_5312_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-976, -134}, {-988, -122}})));
    Components.RealOutput_JW y_5311_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_5311_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 180, origin = {-1030, -92})));
    Components.RealOutput_JW y_5202_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = boiler.boilerFluid.enthalpyPort_a.T - 273.15 annotation(
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-1358, -80})));
    Components.RealOutput_JW y_5201_FQ(final quantity = "VolumeFlowRate", final unit = "m3/h", displayUnit = "m3/h", min = 0) = boiler.enthalpyPort_a1.m_flow * 3600 / 1000 annotation(
      Placement(visible = true, transformation(origin = {-1358, -94}, extent = {{-6, 6}, {6, -6}}, rotation = 180), iconTransformation(extent = {{-6, -6}, {6, 6}}, rotation = 180)));
    Components.RealOutput_JW y_2202_TRC_2(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2202_TRC_2.T - 273.15 annotation(
      Placement(transformation(extent = {{-1446, 566}, {-1458, 578}})));
    Components.RealOutput_JW y_2204_TRC_2(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2204_TRC_2.T - 273.15 annotation(
      Placement(transformation(extent = {{-1422, 668}, {-1434, 680}})));
    Components.RealOutput_JW y_2213_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2213_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-1174, 538}, {-1186, 550}})));
    Components.RealOutput_JW y_2216_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2216_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-1106, 538}, {-1118, 550}})));
    Components.RealOutput_JW y_2215_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2215_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 180, origin = {-1130, 648})));
    Components.RealOutput_JW y_2214_FRC(final quantity = "VolumeFlowRate", final unit = "m3/h", displayUnit = "m3/h", min = 0) = massFlowRate_2214_FRC.dotm * 3600 / 1000 annotation(
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-1142, 544})));
    Components.RealOutput_JW y_8102_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8102_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-694, 726}, {-706, 738}})));
    Components.RealOutput_JW y_8101_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8101_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 180, origin = {-656, 750})));
    Components.RealOutput_JW y_7103_FRC_unload(final quantity = "VolumeFlowRate", final unit = "m3/h", displayUnit = "m3/h", min = 0) = massFlowRate_7103_FRC_unload.dotm * 3600 / 1000 annotation(
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-262, 660})));
    Components.RealOutput_JW y_7103_FRC_load(final quantity = "VolumeFlowRate", final unit = "m3/h", displayUnit = "m3/h", min = 0) = massFlowRate_7103_FRC_load.dotm * 3600 / 1000 annotation(
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 180, origin = {-198, 638})));
    Components.RealOutput_JW y_7103_FRC(final quantity = "VolumeFlowRate", final unit = "m3/h", displayUnit = "m3/h", min = 0) = (massFlowRate_7103_FRC_load.dotm + massFlowRate_7103_FRC_unload.dotm) * 3600 / 1000 annotation(
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-260, 634})));
    Components.RealOutput_JW y_7104_TRC_unload(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_7104_TRC_unload.T - 273.15 annotation(
      Placement(transformation(extent = {{-226, 786}, {-238, 798}})));
    Components.RealOutput_JW y_7104_TRC_load(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_7104_TRC_load.T - 273.15 annotation(
      Placement(transformation(extent = {{-204, 746}, {-216, 758}})));
    Components.RealOutput_JW y_7203_TRC_load(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_7203_TRC_load.T - 273.15 annotation(
      Placement(transformation(extent = {{-184, 446}, {-196, 458}})));
    Components.RealOutput_JW y_7203_TRC_unload(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_7203_TRC_unload.T - 273.15 annotation(
      Placement(transformation(extent = {{-162, 386}, {-174, 398}})));
    Components.RealOutput_JW y_7302_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[8] - 273.15 annotation(
      Placement(transformation(extent = {{140, 634}, {152, 646}})));
    Components.RealOutput_JW y_7303_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[7] - 273.15 annotation(
      Placement(visible = true, transformation(extent = {{140, 614}, {152, 626}}, rotation = 0), iconTransformation(extent = {{140, 614}, {152, 626}}, rotation = 0)));
    Components.RealOutput_JW y_7304_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[6] - 273.15 annotation(
      Placement(transformation(extent = {{140, 594}, {152, 606}})));
    Components.RealOutput_JW y_7305_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[5] - 273.15 annotation(
      Placement(transformation(extent = {{140, 574}, {152, 586}})));
    Components.RealOutput_JW y_7306_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[4] - 273.15 annotation(
      Placement(transformation(extent = {{140, 554}, {152, 566}})));
    Components.RealOutput_JW y_7307_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[3] - 273.15 annotation(
      Placement(transformation(extent = {{140, 534}, {152, 546}})));
    Components.RealOutput_JW y_7308_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[2] - 273.15 annotation(
      Placement(transformation(extent = {{140, 514}, {152, 526}})));
    Components.RealOutput_JW y_7309_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[1] - 273.15 annotation(
      Placement(transformation(extent = {{140, 494}, {152, 506}})));
    Components.RealOutput_JW y_8104_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8104_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-492, 302}, {-504, 314}})));
    Components.RealOutput_JW y_8103_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8103_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-540, 284}, {-552, 296}})));
    Components.RealOutput_JW y_8206_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8206_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{12, 106}, {0, 118}})));
    Components.RealOutput_JW y_8205_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8205_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 180, origin = {-10, 148})));
    Components.RealOutput_JW y_8204_FRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = massFlowRate_8204_FRC.dotm * 3600 / 1000 annotation(
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-34, 114})));
    Modelica.Blocks.Math.Add add1(k1 = -1) annotation(
      Placement(transformation(extent = {{-80, 34}, {-60, 54}})));
    Modelica.Blocks.Math.Gain gain(k = 4187 / 1000 / 3.6) annotation(
      Placement(transformation(extent = {{0, 40}, {20, 60}})));
    Modelica.Blocks.Math.Product product annotation(
      Placement(transformation(extent = {{-40, 40}, {-20, 60}})));
    Components.RealOutput_JW y_WMZ_heatingGrid annotation(
      Placement(transformation(extent = {{40, 44}, {52, 56}})));
    Components.RealOutput_JW y_WMZ_Houses = sink.Load / 1000 annotation(
      Placement(transformation(extent = {{834, 534}, {846, 546}})));
    Modelica.Blocks.Sources.Sine sineGeo_T_amb1(amplitude = 15, freqHz = 1 / (3600 * 24 * 365 * 2), offset = 3 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-1642, 864}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch_2102_ZA_2 annotation(
      Placement(visible = true, transformation(origin = {-1538, 480}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    Modelica.Blocks.Sources.Constant const5(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-1502, 460}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow = -77, uHigh = -72, pre_y_start = true) annotation(
      Placement(visible = true, transformation(extent = {{-1462, 420}, {-1482, 440}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain3(k = -1) annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-1452, 470})));
    Modelica.Blocks.Math.Gain gain4(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {-1276, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.BooleanOutput_JW y_5203_OA = boiler.onOff_boiler annotation(
      Placement(visible = true, transformation(origin = {-1358, -110}, extent = {{6, -6}, {-6, 6}}, rotation = 0), iconTransformation(origin = {-1362, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.BooleanOutput_JW y_5204_ZA = logicalSwitch_5204_ZA.u2 annotation(
      Placement(visible = true, transformation(origin = {-1358, -124}, extent = {{6, -6}, {-6, 6}}, rotation = 0), iconTransformation(origin = {-1352, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.LogicalSwitch logicalSwitch_5204_ZA annotation(
      Placement(visible = true, transformation(origin = {-1322, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation(
      Placement(visible = true, transformation(origin = {-1350, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k = false) annotation(
      Placement(visible = true, transformation(origin = {-1290, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.BooleanOutput_JW y_2102_ZA_2 = switch_2102_ZA_2.u2 annotation(
      Placement(visible = true, transformation(origin = {-1522, 616}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-1342, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Not not1 annotation(
      Placement(visible = true, transformation(origin = {-1502, 430}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold_2101_OA_2 annotation(
      Placement(visible = true, transformation(origin = {-1512, 540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.BooleanOutput_JW y_2101_OA_2 = greaterThreshold_2101_OA_2.y annotation(
      Placement(visible = true, transformation(origin = {-1522, 624}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-1332, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain5(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {-1402, 620}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Blocks.Interfaces.BooleanInput u_disturb_boiler annotation(
      Placement(transformation(extent = {{-2240, 20}, {-2200, 60}})));
    Modelica.Blocks.Interfaces.BooleanInput u_disturb_heatpump2 annotation(
      Placement(transformation(extent = {{-2240, 400}, {-2200, 440}})));
    Modelica.Blocks.Logical.Or or1 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-1538, 444})));
    Modelica.Blocks.Interfaces.RealInput u_loadProfile_kW annotation(
      Placement(transformation(extent = {{-2240, 1340}, {-2200, 1380}})));
    Modelica.Blocks.Math.Gain gain8(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-1570, 1360}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add5 annotation(
      Placement(transformation(extent = {{-1452, 590}, {-1432, 610}})));
    Modelica.Blocks.Continuous.LimPID PID(k = 0.01, Ti = 3600, yMax = 1, yMin = 0.01, initType = Modelica.Blocks.Types.InitPID.InitialOutput, y_start = 0.5) annotation(
      Placement(transformation(extent = {{-1252, 730}, {-1272, 750}})));
    Modelica.Blocks.Sources.Constant const18(k = 80 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-1230, 720}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Components.calc_mdot_consumer calc_mdot_consumer annotation(
      Placement(transformation(extent = {{-280, 200}, {-300, 220}})));
    Modelica.Blocks.Sources.Constant const22(k = 20) annotation(
      Placement(visible = true, transformation(origin = {-198, 224}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add6(k1 = -1) annotation(
      Placement(transformation(extent = {{-240, 206}, {-260, 226}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_4516_FRC annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1180, 180})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4517_TRC annotation(
      Placement(visible = true, transformation(origin = {-1160, 240}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4518_TRC annotation(
      Placement(visible = true, transformation(origin = {-1108, 180}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF58(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1148, 180}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Components.RealOutput_JW y_4516_FRC(final quantity = "VolumeFlowRate", final unit = "m3/h", displayUnit = "m3/h", min = 0) = massFlowRate_4516_FRC.dotm * 3600 / 1000 annotation(
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-1190, 194})));
    Components.RealOutput_JW y_4518_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_4518_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-1116, 186}, {-1128, 198}})));
    Components.RealOutput_JW y_4517_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_4517_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 180, origin = {-1170, 228})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4515_TRC annotation(
      Placement(visible = true, transformation(origin = {-1248, 180}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Components.RealOutput_JW y_4515_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_4515_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-1256, 186}, {-1268, 198}})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF59(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1216, 180}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-1320, 180})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF60(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1290, 180}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(transformation(extent = {{-1320, 230}, {-1300, 250}})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF61(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1250, 240}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF62(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1320, 210}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_4507_up annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1410, 180})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF63(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1348, 180}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4504_TRC annotation(
      Placement(visible = true, transformation(origin = {-1446, 180}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Components.RealOutput_JW y_4504_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_4504_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-1454, 186}, {-1466, 198}})));
    Components.RealOutput_JW y_4506_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_4506_TRC.T - 273.15 annotation(
      Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 180, origin = {-1388, 228})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4506_TRC annotation(
      Placement(visible = true, transformation(origin = {-1378, 240}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF64(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1350, 240}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.HeatGenerators.CHP.CHP_PT1 CHP(selectable = false, eta_el = 0.38095, eta_th = 0.55238, capP_el = 400000) annotation(
      Placement(transformation(extent = {{-1550, 200}, {-1530, 220}})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF66(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1510, 180}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF67(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1406, 240}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Not not2 annotation(
      Placement(visible = true, transformation(origin = {-2130, 420}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Not not3 annotation(
      Placement(visible = true, transformation(origin = {-1350, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k = -1) annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 90, origin = {-1460, 270})));
    Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow = -85, uHigh = -80, pre_y_start = true) annotation(
      Placement(visible = true, transformation(extent = {{-1470, 320}, {-1490, 340}}, rotation = 0)));
    Modelica.Blocks.Logical.Not not4 annotation(
      Placement(visible = true, transformation(origin = {-1510, 330}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const8(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-1500, 290}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Or or2 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-1534, 310})));
    Modelica.Blocks.Logical.Switch switch_4202_ZA annotation(
      Placement(visible = true, transformation(origin = {-1534, 270}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Blocks.Logical.Not not5 annotation(
      Placement(visible = true, transformation(origin = {-1570, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanInput u_disturb_CHP annotation(
      Placement(transformation(extent = {{-2240, 310}, {-2200, 350}})));
    Modelica.Blocks.Interfaces.RealInput u_CHP_0_1 annotation(
      Placement(transformation(extent = {{-2240, 270}, {-2200, 310}})));
    Modelica.Blocks.Math.RealToBoolean realToBoolean annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-1560, 240})));
    Components.calc_mdot_production calc_mdot_production2 annotation(
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {-1430, 210})));
    Modelica.Blocks.Sources.Constant const15(k = 95 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-1490, 216}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.BooleanOutput_JW y_4202_ZA = switch_4202_ZA.u2 annotation(
      Placement(visible = true, transformation(origin = {-1580, 182}, extent = {{6, -6}, {-6, 6}}, rotation = 0), iconTransformation(origin = {-1352, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.BooleanOutput_JW y_4201_OA = CHP.onOff annotation(
      Placement(visible = true, transformation(origin = {-1580, 196}, extent = {{6, -6}, {-6, 6}}, rotation = 0), iconTransformation(origin = {-1362, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.RealOutput_JW y_4203_FQ(final quantity = "VolumeFlowRate", final unit = "m3/h", displayUnit = "m3/h", min = 0) = CHP.enthalpyPort_a.m_flow * 3600 / 1000 annotation(
      Placement(visible = true, transformation(origin = {-1580, 212}, extent = {{-6, 6}, {6, -6}}, rotation = 180), iconTransformation(extent = {{-6, -6}, {6, 6}}, rotation = 180)));
    Components.calc_valve calc_valve1 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-1290, 138})));
    Modelica.Blocks.Sources.Constant const23(k = 90) annotation(
      Placement(visible = true, transformation(origin = {-1250, 132}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Components.RealOutput_JW y_CHP_dotQ = CHP.Capacity[2] / 1000 annotation(
      Placement(visible = true, transformation(extent = {{-1540, 184}, {-1532, 192}}, rotation = 0), iconTransformation(extent = {{-1312, 28}, {-1304, 36}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate2 annotation(
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 90, origin = {-1000, 650})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF65(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1000, 610}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF68(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1040, 452}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate10 annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 270, origin = {-1040, 478})));
    Components.calc_valve_ratio calc_valve_ratio1 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-960, 530})));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_2 annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 270, origin = {-1240, 540})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF69(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1210, 530}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF70(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1270, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_2(n = 2) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-1190, 660})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF71(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1150, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF72(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1262, 700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2202_TRC_1 annotation(
      Placement(visible = true, transformation(origin = {-1778, 520}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_2205_UP_1 annotation(
      Placement(transformation(extent = {{-1700, 510}, {-1720, 530}})));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_3 annotation(
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {-1640, 700})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_3(n = 2) annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1650, 520})));
    AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump1(redeclare model PerDataHea = AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D(dataTable = Q100_DistrictModel.Data.WP_550kW()), redeclare model PerDataChi = AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D(dataTable = Q100_DistrictModel.Data.WP_550kW()), CCon = 100, CEva = 100, GCon = 5, GEva = 5, Q_useNominal = 0, TAmbCon_nominal = 288.15, TCon_start(displayUnit = "K") = 55 + 273.15, TEva_start(displayUnit = "K"), VCon = 0.04, VEva = 0.04, allowFlowReversalEva = true, deltaM_con = 0.1, deltaM_eva = 0.1, mFlow_conNominal = 0.5, mFlow_evaNominal = 0.5, refIneFre_constant = 1, scalingFactor = ScaleFactor_heatPump1, transferHeat = true, use_ConCap = false, use_EvaCap = false, use_autoCalc = false, use_refIne = true, use_revHP = true) annotation(
      Placement(transformation(extent = {{-11.9997, 14}, {11.9999, -14}}, rotation = 90, origin = {-1878, 630})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2204_TRC_1 annotation(
      Placement(visible = true, transformation(origin = {-1758, 700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const7(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-1913, 621}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
    Components.calc_mdot_production calc_mdot_production3 annotation(
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {-1740, 590})));
    Modelica.Blocks.Sources.Constant const24(k = 5) annotation(
      Placement(visible = true, transformation(origin = {-1822, 606}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF73(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1640, 630}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF75(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1680, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF76(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1746, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF77(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1820, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF78(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1840, 700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF79(selectable = false, length = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-1680, 700}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain6(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {-1740, 620}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Blocks.Math.Add add2 annotation(
      Placement(transformation(extent = {{-1790, 590}, {-1770, 610}})));
    Components.RealOutput_JW y_heatpump1_dotQ = heatPump1.innerCycle.PerformanceDataHPHeating.QCon / 1000 annotation(
      Placement(transformation(extent = {{-1864, 636}, {-1856, 644}})));
    Components.RealOutput_JW y_heatpump1_Pel = heatPump1.innerCycle.PerformanceDataHPHeating.Pel / 1000 annotation(
      Placement(visible = true, transformation(extent = {{-1864, 628}, {-1856, 636}}, rotation = 0), iconTransformation(extent = {{-1526, 628}, {-1518, 636}}, rotation = 0)));
    Components.RealOutput_JW y_2202_TRC_1(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2202_TRC_1.T - 273.15 annotation(
      Placement(transformation(extent = {{-1784, 526}, {-1796, 538}})));
    Components.RealOutput_JW y_2204_TRC_1(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2204_TRC_1.T - 273.15 annotation(
      Placement(transformation(extent = {{-1760, 708}, {-1772, 720}})));
    Components.BooleanOutput_JW y_2102_ZA_1 = switch_2102_ZA_1.u2 annotation(
      Placement(visible = true, transformation(origin = {-1860, 616}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-1342, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.BooleanOutput_JW y_2101_OA_1 = greaterThreshold_2101_OA_1.y annotation(
      Placement(visible = true, transformation(origin = {-1860, 624}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-1332, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource2 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-1940, 860})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel2 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-1978, 800})));
    Modelica.Blocks.Sources.Constant const25(k = 20) annotation(
      Placement(visible = true, transformation(origin = {-1980, 830}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF81(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1922, 800}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF82(selectable = false, length = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-1904, 860}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Sine sineGeo_T_amb2(amplitude = 15, freqHz = 1 / (3600 * 24 * 365 * 2), offset = 3 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-1980, 864}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant1 annotation(
      Placement(transformation(extent = {{-1920, 570}, {-1900, 590}})));
    Modelica.Blocks.Logical.Switch switch_2102_ZA_1 annotation(
      Placement(visible = true, transformation(origin = {-1908, 510}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold_2101_OA_1 annotation(
      Placement(visible = true, transformation(origin = {-1910, 540}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const26(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-1950, 530}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain7(k = -1) annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {-1820, 490})));
    Modelica.Blocks.Logical.Not not6 annotation(
      Placement(visible = true, transformation(origin = {-1880, 490}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow = -77, uHigh = -72, pre_y_start = true) annotation(
      Placement(visible = true, transformation(extent = {{-1840, 480}, {-1860, 500}}, rotation = 0)));
    Modelica.Blocks.Logical.Or or3 annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-1990, 510})));
    Modelica.Blocks.Logical.Not not7 annotation(
      Placement(visible = true, transformation(origin = {-2130, 510}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const27(k = 80 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-1588, 720}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Continuous.LimPID PID1(k = 0.01, Ti = 3600, yMax = 1, yMin = 0.01, initType = Modelica.Blocks.Types.InitPID.InitialOutput, y_start = 0.5) annotation(
      Placement(transformation(extent = {{-1610, 730}, {-1630, 750}})));
    Modelica.Blocks.Sources.Constant const28(k = 0.5) annotation(
      Placement(visible = true, transformation(origin = {-1210, 580}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanInput u_disturb_heatpump1 annotation(
      Placement(transformation(extent = {{-2240, 490}, {-2200, 530}})));
  equation
    connect(dynamicPipe_HeatGrid_RF.enthalpyPort_b1, dynamicPipe_HeatStorage_unload_RF.enthalpyPort_a1) annotation(
      Line(points = {{380.2, 100}, {179.8, 100}}, color = {0, 128, 255}));
    connect(temperature_HeatGrid_FF.enthalpyPort_b, dynamicPipe_HeatGrid_FF.enthalpyPort_a1) annotation(
      Line(points = {{319, 160.1}, {350.2, 160.1}, {350.2, 160}, {380.2, 160}}, color = {176, 0, 0}));
    connect(prescribedTemperature.port, dynamicPipe_HeatGrid_RF.heatPort_outside) annotation(
      Line(points = {{360, 138}, {398, 138}, {398, 105.2}, {398.8, 105.2}}, color = {191, 0, 0}));
    connect(prescribedTemperature.port, dynamicPipe_HeatGrid_FF.heatPort_outside) annotation(
      Line(points = {{360, 138}, {382, 138}, {382, 154.8}, {381.2, 154.8}}, color = {191, 0, 0}));
    connect(prescribedTemperature.T, sineGeo_T_amb.y) annotation(
      Line(points = {{338, 138}, {278, 138}, {278, 140}, {101, 140}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.out, fixedTemperature.port) annotation(
      Line(points = {{79.2, 681.6}, {121.6, 681.6}, {121.6, 680}, {166, 680}}, color = {191, 0, 0}));
    connect(const2.y, fluidSource1.T_fluid) annotation(
      Line(points = {{-1259, 850}, {-1248, 850}, {-1248, 842}, {-1178, 842}, {-1178, 842.2}}, color = {0, 0, 127}));
    connect(vessel1.enthalpyPort_a, massFlowRate1.enthalpyPort_b) annotation(
      Line(points = {{-1219, 780}, {-1212, 780}, {-1212, 779.9}, {-1207, 779.9}}, color = {0, 128, 255}));
    connect(fluidSource1.dotm, massFlowRate1.dotm) annotation(
      Line(points = {{-1178, 835.4}, {-1199, 835.4}, {-1199, 789}}, color = {0, 0, 127}));
    connect(const6.y, threeWayValve3.opening) annotation(
      Line(points = {{-985, 800}, {-1000, 800}, {-1000, 729}}, color = {0, 0, 127}));
    connect(massFlowRate_2214_FRC.enthalpyPort_a, temperature_2216_TRC.enthalpyPort_b) annotation(
      Line(points = {{-1123.2, 529.9}, {-1109, 529.9}}, color = {0, 128, 255}));
    connect(temperature_2213_TRC.enthalpyPort_a, massFlowRate_2214_FRC.enthalpyPort_b) annotation(
      Line(points = {{-1159.2, 529.9}, {-1141, 529.9}}, color = {0, 128, 255}));
    connect(const10.y, heatPump2.iceFac_in) annotation(
      Line(points = {{-1569.5, 621}, {-1564, 621}, {-1564, 620.88}, {-1555.87, 620.88}}, color = {0, 0, 127}));
    connect(const11.y, fluidSource3.dotm) annotation(
      Line(points = {{-1631, 830}, {-1622, 830}, {-1622, 857.4}, {-1610, 857.4}}, color = {0, 0, 127}));
    connect(pump_8113_NP.enthalpyPort_b, temperature_8205_TRC.enthalpyPort_a) annotation(
      Line(points = {{-310.4, 160}, {-160, 160}, {-160, 160.1}, {-8.8, 160.1}}, color = {176, 0, 0}));
    connect(massFlowRate_8204_FRC.enthalpyPort_a, temperature_8206_TRC.enthalpyPort_b) annotation(
      Line(points = {{-11.2, 99.9}, {11, 99.9}}, color = {0, 128, 255}));
    connect(threeWayValve_NS_1.enthalpyPort_ab, massFlowRate_8204_FRC.enthalpyPort_b) annotation(
      Line(points = {{-170.2, 100}, {-100, 100}, {-100, 99.9}, {-29, 99.9}}, color = {0, 128, 255}));
    connect(threeWayValve_NS_1.enthalpyPort_b, temperature_8301_TRC.enthalpyPort_a) annotation(
      Line(points = {{-180, 90}, {-180, 48.8}, {-180.1, 48.8}}, color = {0, 128, 255}));
    connect(manifold_NS_1.enthalpyPort_a[2], temperature_8302_TRC.enthalpyPort_b) annotation(
      Line(points = {{-240, 100.5}, {-240, 69}, {-240.1, 69}}, color = {0, 128, 255}));
    connect(manifold_NS_1.enthalpyPort_a[1], threeWayValve_NS_1.enthalpyPort_a) annotation(
      Line(points = {{-240, 99.5}, {-216, 99.5}, {-216, 100}, {-190, 100}}, color = {0, 128, 255}));
    connect(temperature_8302_TRC.enthalpyPort_a, fluidSource4.enthalpyPort_b) annotation(
      Line(points = {{-240.1, 51.2}, {-240.1, 43.6}, {-239, 43.6}, {-239, 18}}, color = {0, 128, 255}));
    connect(const12.y, fluidSource4.T_fluid) annotation(
      Line(points = {{-259, -12}, {-242.2, -12}, {-242.2, 0}}, color = {0, 0, 127}));
    connect(const13.y, threeWayValve_NS_1.opening) annotation(
      Line(points = {{-161, 120}, {-180, 120}, {-180, 109}}, color = {0, 0, 127}));
    connect(massFlowRate3.enthalpyPort_b, vessel4.enthalpyPort_a) annotation(
      Line(points = {{-179.9, -27}, {-179.9, -33.5}, {-180, -33.5}, {-180, -39}}, color = {0, 128, 255}));
    connect(temperature_8301_TRC.enthalpyPort_b, massFlowRate3.enthalpyPort_a) annotation(
      Line(points = {{-180.1, 31}, {-180.1, 10.5}, {-179.9, 10.5}, {-179.9, -9.2}}, color = {0, 128, 255}));
    connect(massFlowRate3.dotm, fluidSource4.dotm) annotation(
      Line(points = {{-189, -19}, {-235.4, -19}, {-235.4, 0}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF.enthalpyPort_b1, temperature_HeatGrid_FF.enthalpyPort_a) annotation(
      Line(points = {{179.8, 160}, {240, 160}, {240, 160.1}, {301.2, 160.1}}, color = {176, 0, 0}));
    connect(temperature_8205_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF.enthalpyPort_a1) annotation(
      Line(points = {{9, 160.1}, {84.5, 160.1}, {84.5, 160}, {160.2, 160}}, color = {176, 0, 0}));
    connect(temperature_8206_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_RF.enthalpyPort_b1) annotation(
      Line(points = {{28.8, 99.9}, {94.4, 99.9}, {94.4, 100}, {160.2, 100}}, color = {0, 128, 255}));
    connect(calc_mdot_production.y_mdot, pump_5304_UP.dotm_setValue) annotation(
      Line(points = {{-1179, -110}, {-1160, -110}, {-1160, -132}}, color = {0, 0, 127}));
    connect(calc_mdot_production.u_TemperatureInput, temperature_5303_TRC.T) annotation(
      Line(points = {{-1202, -116}, {-1219, -116}, {-1219, -129}}, color = {0, 0, 127}));
    connect(const3.y, calc_mdot_production.u_TemperatureOutput) annotation(
      Line(points = {{-1229, -104}, {-1216, -104}, {-1216, -104.2}, {-1202, -104.2}}, color = {0, 0, 127}));
    connect(const9.y, calc_Qdot.u_deltaT_setpoint) annotation(
      Line(points = {{-1439, -30}, {-1430, -30}, {-1430, -48}}, color = {0, 0, 127}));
    connect(const14.y, calc_Qdot.u_T_setpoint) annotation(
      Line(points = {{-1479, -80}, {-1462, -80}, {-1462, -66}, {-1442, -66}}, color = {0, 0, 127}));
    connect(calc_mdot_production1.u_TemperatureInput, temperature_2202_TRC_2.T) annotation(
      Line(points = {{-1414, 584}, {-1440, 584}, {-1440, 571}, {-1441, 571}}, color = {0, 0, 127}));
    connect(calc_mdot_production1.y_mdot, pump_2205_UP_2.dotm_setValue) annotation(
      Line(points = {{-1391, 590}, {-1372, 590}, {-1372, 568}}, color = {0, 0, 127}));
    connect(TemperatureInput.enthalpyPort_b, sink.enthalpyPort_a1) annotation(
      Line(points = {{729, 519.9}, {814.5, 519.9}, {814.5, 520}, {809.2, 520}}, color = {176, 0, 0}));
    connect(sink.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation(
      Line(points = {{830.8, 520}, {850, 520}, {850, 519.9}, {871.2, 519.9}}, color = {176, 0, 0}));
    connect(gain2.y, sink.Load) annotation(
      Line(points = {{820, 579}, {820, 530.68}, {819.88, 530.68}}, color = {0, 0, 127}));
    connect(TemperatureOutput.enthalpyPort_b, dynamicPipe_HeatGrid_RF.enthalpyPort_a1) annotation(
      Line(points = {{889, 519.9}, {900, 519.9}, {900, 460}, {680, 460}, {680, 100}, {399.8, 100}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatGrid_FF.enthalpyPort_b1, TemperatureInput.enthalpyPort_a) annotation(
      Line(points = {{399.8, 160}, {620, 160}, {620, 519.9}, {711.2, 519.9}}, color = {176, 0, 0}));
    connect(manifold3.enthalpyPort_b, massFlowRate5.enthalpyPort_a) annotation(
      Line(points = {{-1020, 760}, {-970, 760}, {-970, 759.9}, {-948.8, 759.9}}, color = {176, 0, 0}));
    connect(calc_Qdot.u_T_measurement, temperature_8104_TRC.T) annotation(
      Line(points = {{-1442, -54.2}, {-1520, -54.2}, {-1520, -180}, {-860, -180}, {-860, 302}, {-670, 302}, {-670, 301}, {-491, 301}}, color = {0, 0, 127}));
    connect(calc_valve.u_T_source_input, temperature_8104_TRC.T) annotation(
      Line(points = {{-568, 252}, {-568, 301}, {-491, 301}}, color = {0, 0, 127}));
    connect(calc_valve.u_T_consumer_input, const21.y) annotation(
      Line(points = {{-580, 245.8}, {-590, 245.8}, {-590, 246}, {-599, 246}}, color = {0, 0, 127}));
    connect(massFlowRate6.dotm, calc_valve_ratio.u_dotm_in) annotation(
      Line(points = {{-781, 729}, {-781, 812}, {-910, 812}}, color = {0, 0, 127}));
    connect(massFlowRate5.dotm, calc_valve_ratio.u_dotm_out) annotation(
      Line(points = {{-939, 769}, {-910, 769}, {-910, 788}}, color = {0, 0, 127}));
    connect(calc_valve.u_T_consumer_output, temperature_8206_TRC.T) annotation(
      Line(points = {{-580, 234}, {-588, 234}, {-588, 140}, {19, 140}, {19, 111}}, color = {0, 0, 127}));
    connect(calc_Qdot.y_Qdot, max.u2) annotation(
      Line(points = {{-1419, -60}, {-1402, -60}}, color = {0, 0, 127}));
    connect(max.y, boiler.dotQ_rel) annotation(
      Line(points = {{-1379, -54}, {-1334.83, -54}, {-1334.83, -83.17}}, color = {0, 0, 127}));
    connect(max1.y, threeWayValve_NS_7202_2.opening) annotation(
      Line(points = {{-559, 380}, {-529, 380}}, color = {0, 0, 127}));
    connect(const16.y, max1.u2) annotation(
      Line(points = {{-619, 350}, {-602, 350}, {-602, 374}, {-582, 374}}, color = {0, 0, 127}));
    connect(calc_valve_ratio.y_valve, threeWayValve2.opening) annotation(
      Line(points = {{-899, 800}, {-880, 800}, {-880, 729}}, color = {0, 0, 127}));
    connect(min.y, max1.u1) annotation(
      Line(points = {{-619, 386}, {-582, 386}}, color = {0, 0, 127}));
    connect(const1.y, min.u1) annotation(
      Line(points = {{-669, 410}, {-660, 410}, {-660, 392}, {-642, 392}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF2.enthalpyPort_a1, threeWayValve_NS_7102_1.enthalpyPort_a) annotation(
      Line(points = {{-570, 559.7}, {-570, 564}, {-480, 564}, {-480, 590}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF3.enthalpyPort_a1, threeWayValve_NS_7202_2.enthalpyPort_a) annotation(
      Line(points = {{-540, 426.3}, {-540, 416}, {-520, 416}, {-520, 390}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF4.enthalpyPort_b1, manifold_NS_7202_1.enthalpyPort_a[1]) annotation(
      Line(points = {{-570, 432.3}, {-570, 420}, {-519.5, 420}, {-519.5, 440}}, color = {0, 128, 255}));
    connect(temperature_7203_TRC_unload.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF6.enthalpyPort_a1) annotation(
      Line(points = {{-151, 379.9}, {-123.5, 379.9}, {-123.5, 379.5}, {-96.71, 379.5}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF6.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{-68.29, 379.5}, {38.4, 379.5}, {38.4, 462}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF5.enthalpyPort_b1, temperature_7203_TRC_load.enthalpyPort_a) annotation(
      Line(points = {{-120.71, 439.5}, {-144.355, 439.5}, {-144.355, 439.9}, {-169.2, 439.9}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF5.enthalpyPort_a1, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-92.29, 439.5}, {-2.4, 439.5}, {-2.4, 462}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF8.enthalpyPort_b1, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-54.29, 739.5}, {-2.4, 739.5}, {-2.4, 706}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF7.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{-76.29, 779.5}, {38.4, 779.5}, {38.4, 706}}, color = {176, 0, 0}));
    connect(temperature_7104_TRC_load.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF8.enthalpyPort_a1) annotation(
      Line(points = {{-193, 739.9}, {-137.5, 739.9}, {-137.5, 739.5}, {-82.71, 739.5}}, color = {176, 0, 0}));
    connect(temperature_7104_TRC_unload.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF7.enthalpyPort_b1) annotation(
      Line(points = {{-211.2, 779.9}, {-158.6, 779.9}, {-158.6, 779.5}, {-104.71, 779.5}}, color = {176, 0, 0}));
    connect(manifold_NS_7102_2.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF9.enthalpyPort_a1) annotation(
      Line(points = {{-480, 520}, {-480, 479.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF9.enthalpyPort_b1, massFlowRate9.enthalpyPort_a) annotation(
      Line(points = {{-480, 460.2}, {-480, 444.4}, {-480.1, 444.4}, {-480.1, 374.8}}, color = {176, 0, 0}));
    connect(massFlowRate9.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF10.enthalpyPort_a1) annotation(
      Line(points = {{-480.1, 357}, {-480.1, 349.4}, {-480, 349.4}, {-480, 341.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF10.enthalpyPort_b1, temperature_8104_TRC.enthalpyPort_a) annotation(
      Line(points = {{-480, 322.2}, {-480.1, 310.8}, {-479.9, 310.8}}, color = {176, 0, 0}));
    connect(pump_8113_NP.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF11.enthalpyPort_b1) annotation(
      Line(points = {{-329.6, 160}, {-480, 160}, {-480, 180.2}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF11.enthalpyPort_a1, manifold_NS_8106.enthalpyPort_b) annotation(
      Line(points = {{-480, 199.8}, {-480, 220}}, color = {176, 0, 0}));
    connect(temperature_8104_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF12.enthalpyPort_a1) annotation(
      Line(points = {{-479.9, 293}, {-479.9, 284.5}, {-480, 284.5}, {-480, 275.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF12.enthalpyPort_b1, manifold_NS_8106.enthalpyPort_a[1]) annotation(
      Line(points = {{-480, 256.2}, {-480, 240}, {-479.5, 240}}, color = {176, 0, 0}));
    connect(threeWayValve_NS_8106.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF13.enthalpyPort_a1) annotation(
      Line(points = {{-510, 240}, {-508, 240}, {-508, 240.5}, {-504.91, 240.5}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF13.enthalpyPort_b1, manifold_NS_8106.enthalpyPort_a[2]) annotation(
      Line(points = {{-496.09, 240.5}, {-488.045, 240.5}, {-488.045, 240}, {-480.5, 240}}, color = {0, 128, 255}));
    connect(temperature_8103_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF14.enthalpyPort_b1) annotation(
      Line(points = {{-519.9, 279.2}, {-519.9, 276.6}, {-520, 276.6}, {-520, 273.8}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF14.enthalpyPort_a1, threeWayValve_NS_8106.enthalpyPort_a) annotation(
      Line(points = {{-520, 254.2}, {-520, 250}}, color = {0, 128, 255}));
    connect(manifold_NS_1.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF15.enthalpyPort_a1) annotation(
      Line(points = {{-260, 100}, {-520, 100}, {-520, 190.2}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF15.enthalpyPort_b1, threeWayValve_NS_8106.enthalpyPort_ab) annotation(
      Line(points = {{-520, 209.8}, {-520, 230.2}}, color = {0, 128, 255}));
    connect(threeWayValve_NS_7202_2.enthalpyPort_ab, dynamicPipe_HeatStorage_unload_FF16.enthalpyPort_b1) annotation(
      Line(points = {{-520, 370.2}, {-520, 339.8}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF16.enthalpyPort_a1, temperature_8103_TRC.enthalpyPort_b) annotation(
      Line(points = {{-520, 320.2}, {-520, 297}, {-519.9, 297}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF17.enthalpyPort_a1, temperature_7203_TRC_load.enthalpyPort_b) annotation(
      Line(points = {{-240.2, 440}, {-214, 440}, {-214, 439.9}, {-187, 439.9}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF17.enthalpyPort_b1, manifold_NS_7202_1.enthalpyPort_a[2]) annotation(
      Line(points = {{-259.8, 440}, {-520.5, 440}}, color = {0, 128, 255}));
    connect(temperature_7203_TRC_unload.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF18.enthalpyPort_b1) annotation(
      Line(points = {{-168.8, 379.9}, {-204.5, 379.9}, {-204.5, 380}, {-240.2, 380}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF18.enthalpyPort_a1, threeWayValve_NS_7202_2.enthalpyPort_b) annotation(
      Line(points = {{-259.8, 380}, {-349.4, 379.9}, {-349.4, 380}, {-510, 380}}, color = {0, 128, 255}));
    connect(threeWayValve_NS_7102_1.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF19.enthalpyPort_a1) annotation(
      Line(points = {{-470, 600}, {-359.8, 600}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF19.enthalpyPort_b1, massFlowRate_7103_FRC_load.enthalpyPort_a) annotation(
      Line(points = {{-340.2, 600}, {-220.1, 600}, {-220.1, 629.2}}, color = {176, 0, 0}));
    connect(manifold_NS_7102_2.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF20.enthalpyPort_b1) annotation(
      Line(points = {{-479.5, 540}, {-361.8, 540}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF20.enthalpyPort_a1, massFlowRate_7103_FRC_unload.enthalpyPort_b) annotation(
      Line(points = {{-342.2, 540}, {-239.9, 540}, {-239.9, 651}}, color = {176, 0, 0}));
    connect(massFlowRate8.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF23.enthalpyPort_a1) annotation(
      Line(points = {{-480.1, 701}, {-480.1, 680.5}, {-480, 680.5}, {-480, 659.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF23.enthalpyPort_b1, threeWayValve_NS_7102_1.enthalpyPort_ab) annotation(
      Line(points = {{-480, 640.2}, {-480, 609.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF24.enthalpyPort_b1, massFlowRate8.enthalpyPort_a) annotation(
      Line(points = {{-560.2, 760}, {-480.1, 760}, {-480.1, 718.8}}, color = {176, 0, 0}));
    connect(temperature_8101_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF24.enthalpyPort_a1) annotation(
      Line(points = {{-659, 760.1}, {-656, 760.1}, {-656, 760}, {-579.8, 760}}, color = {176, 0, 0}));
    connect(temperature_8102_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF25.enthalpyPort_b1) annotation(
      Line(points = {{-679.2, 719.9}, {-668, 719.9}, {-668, 720}, {-659.8, 720}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF25.enthalpyPort_a1, manifold_NS_7202_1.enthalpyPort_b) annotation(
      Line(points = {{-640.2, 720}, {-520, 719.9}, {-520, 460}}, color = {0, 128, 255}));
    connect(massFlowRate6.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF26.enthalpyPort_b1) annotation(
      Line(points = {{-771.2, 719.9}, {-762, 719.9}, {-762, 720}, {-739.8, 720}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF26.enthalpyPort_a1, temperature_8102_TRC.enthalpyPort_b) annotation(
      Line(points = {{-720.2, 720}, {-708.6, 720}, {-708.6, 719.9}, {-697, 719.9}}, color = {0, 128, 255}));
    connect(massFlowRate4.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF27.enthalpyPort_a1) annotation(
      Line(points = {{-741, 759.9}, {-730.5, 759.9}, {-730.5, 760.1}, {-719.8, 760}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF27.enthalpyPort_b1, temperature_8101_TRC.enthalpyPort_a) annotation(
      Line(points = {{-700.2, 760}, {-688.5, 760}, {-688.5, 760.1}, {-676.8, 760.1}}, color = {176, 0, 0}));
    connect(manifold2.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF28.enthalpyPort_a1) annotation(
      Line(points = {{-820, 760}, {-814, 760}, {-814, 759.9}, {-803.8, 760}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF28.enthalpyPort_b1, massFlowRate4.enthalpyPort_a) annotation(
      Line(points = {{-784.2, 760}, {-771.5, 760}, {-771.5, 759.9}, {-758.8, 759.9}}, color = {176, 0, 0}));
    connect(threeWayValve2.enthalpyPort_ab, dynamicPipe_HeatStorage_unload_FF29.enthalpyPort_b1) annotation(
      Line(points = {{-870.2, 720}, {-866.6, 720}, {-866.6, 719.9}, {-827.8, 720}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF29.enthalpyPort_a1, massFlowRate6.enthalpyPort_b) annotation(
      Line(points = {{-808.2, 720}, {-798.6, 720}, {-798.6, 719.9}, {-789, 719.9}}, color = {0, 128, 255}));
    connect(massFlowRate5.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF30.enthalpyPort_a1) annotation(
      Line(points = {{-931, 759.9}, {-918.5, 759.9}, {-918.5, 760}, {-905.8, 760}}, color = {176, 0, 0}));
    connect(massFlowRate7.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF31.enthalpyPort_b1) annotation(
      Line(points = {{-929.2, 719.9}, {-924.5, 719.9}, {-924.5, 720}, {-919.8, 720}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF31.enthalpyPort_a1, threeWayValve2.enthalpyPort_a) annotation(
      Line(points = {{-900.2, 720}, {-895.6, 719.9}, {-895.6, 720}, {-890, 720}}, color = {0, 128, 255}));
    connect(threeWayValve3.enthalpyPort_ab, dynamicPipe_HeatStorage_unload_FF32.enthalpyPort_b1) annotation(
      Line(points = {{-990.2, 720}, {-979.8, 720}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF32.enthalpyPort_a1, massFlowRate7.enthalpyPort_b) annotation(
      Line(points = {{-960.2, 720}, {-954.6, 720}, {-954.6, 719.9}, {-947, 719.9}}, color = {176, 0, 0}));
    connect(manifold2.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF33.enthalpyPort_b1) annotation(
      Line(points = {{-840, 760.5}, {-840, 679.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF33.enthalpyPort_a1, temperature_5311_TRC.enthalpyPort_b) annotation(
      Line(points = {{-840, 660.2}, {-840, -79.9}, {-1011, -79.9}}, color = {176, 0, 0}));
    connect(temperature_5312_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF34.enthalpyPort_b1) annotation(
      Line(points = {{-959.2, -140.1}, {-880, -140.1}, {-880, 660.2}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF34.enthalpyPort_a1, threeWayValve2.enthalpyPort_b) annotation(
      Line(points = {{-880, 679.8}, {-880, 710}}, color = {0, 128, 255}));
    connect(massFlowRate_5310_FRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF35.enthalpyPort_b1) annotation(
      Line(points = {{-1031.2, -140.1}, {-1024.5, -140.1}, {-1024.5, -140}, {-1017.8, -140}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF35.enthalpyPort_a1, temperature_5312_TRC.enthalpyPort_b) annotation(
      Line(points = {{-998.2, -140}, {-987.6, -140}, {-987.6, -140.1}, {-977, -140.1}}, color = {0, 128, 255}));
    connect(boiler.enthalpyPort_b1, dynamicPipe_HeatStorage_unload_FF36.enthalpyPort_a1) annotation(
      Line(points = {{-1318, -100}, {-1300, -100}, {-1300, -79.9}, {-1119.8, -80}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF36.enthalpyPort_b1, temperature_5311_TRC.enthalpyPort_a) annotation(
      Line(points = {{-1100.2, -80}, {-1064.5, -80}, {-1064.5, -79.9}, {-1028.8, -79.9}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF37.enthalpyPort_a1, massFlowRate_5310_FRC.enthalpyPort_b) annotation(
      Line(points = {{-1092.2, -140}, {-1070, -140}, {-1070, -140.1}, {-1049, -140.1}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF37.enthalpyPort_b1, pump_5304_UP.enthalpyPort_a) annotation(
      Line(points = {{-1111.8, -140}, {-1150.4, -140}}, color = {0, 128, 255}));
    connect(temperature_5303_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF38.enthalpyPort_b1) annotation(
      Line(points = {{-1209.2, -140.1}, {-1204.6, -140.1}, {-1204.6, -140}, {-1199.8, -140}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF38.enthalpyPort_a1, pump_5304_UP.enthalpyPort_b) annotation(
      Line(points = {{-1180.2, -140}, {-1169.6, -140}}, color = {0, 128, 255}));
    connect(temperature_5303_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF39.enthalpyPort_a1) annotation(
      Line(points = {{-1227, -140.1}, {-1234, -140.1}, {-1234, -140}, {-1280.2, -140}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF39.enthalpyPort_b1, boiler.enthalpyPort_a1) annotation(
      Line(points = {{-1299.8, -140}, {-1360, -140}, {-1360, -100.48}, {-1342, -100.48}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF30.enthalpyPort_b1, manifold2.enthalpyPort_a[1]) annotation(
      Line(points = {{-886.2, 760}, {-864, 760}, {-864, 759.5}, {-840, 759.5}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF1.enthalpyPort_b1, manifold_NS_7102_2.enthalpyPort_a[1]) annotation(
      Line(points = {{-540, 549.7}, {-540, 556}, {-480.5, 556}, {-480.5, 540}}, color = {176, 0, 0}));
    connect(temperature_7104_TRC_unload.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF21.enthalpyPort_a1) annotation(
      Line(points = {{-229, 779.9}, {-240, 779.9}, {-240, 719.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF21.enthalpyPort_b1, massFlowRate_7103_FRC_unload.enthalpyPort_a) annotation(
      Line(points = {{-240, 700.2}, {-240, 668.8}, {-239.9, 668.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF22.enthalpyPort_a1, massFlowRate_7103_FRC_load.enthalpyPort_b) annotation(
      Line(points = {{-220, 674.2}, {-220, 647}, {-220.1, 647}}, color = {176, 0, 0}));
    connect(temperature_7104_TRC_load.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF22.enthalpyPort_b1) annotation(
      Line(points = {{-210.8, 739.9}, {-220, 739.9}, {-220, 693.8}}, color = {176, 0, 0}));
    connect(calc_valve.y_valve, threeWayValve_NS_8106.opening) annotation(
      Line(points = {{-557, 240}, {-529, 240}}, color = {0, 0, 127}));
    connect(dHWHeatExchanger.enthalpyPort_dHWIn, dynamicPipe_HeatStorage_unload_FF3.enthalpyPort_b1) annotation(
      Line(points = {{-546.2, 482.8}, {-540, 482.8}, {-540, 455.7}}, color = {176, 0, 0}));
    connect(dHWHeatExchanger.enthalpyPort_dHWOut, dynamicPipe_HeatStorage_unload_FF1.enthalpyPort_a1) annotation(
      Line(points = {{-546, 492.8}, {-540, 492.8}, {-540, 520.3}}, color = {176, 0, 0}));
    connect(dHWHeatExchanger.enthalpyPort_heaterOut, dynamicPipe_HeatStorage_unload_FF4.enthalpyPort_a1) annotation(
      Line(points = {{-563.8, 482.8}, {-570, 482.8}, {-570, 461.7}}, color = {176, 0, 0}));
    connect(dHWHeatExchanger.enthalpyPort_heaterIn, dynamicPipe_HeatStorage_unload_FF2.enthalpyPort_b1) annotation(
      Line(points = {{-563.6, 492.8}, {-570, 492.8}, {-570, 530.3}}, color = {176, 0, 0}));
    connect(const4.y, max2.u2) annotation(
      Line(points = {{-679, 570}, {-662, 570}, {-662, 594}, {-642, 594}}, color = {0, 0, 127}));
    connect(min1.y, max2.u1) annotation(
      Line(points = {{-679, 606}, {-642, 606}}, color = {0, 0, 127}));
    connect(const20.y, min1.u1) annotation(
      Line(points = {{-719, 630}, {-710, 630}, {-710, 612}, {-702, 612}}, color = {0, 0, 127}));
    connect(max2.y, threeWayValve_NS_7102_1.opening) annotation(
      Line(points = {{-619, 600}, {-489, 600}}, color = {0, 0, 127}));
    connect(threeWayValve3.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF40.enthalpyPort_a1) annotation(
      Line(points = {{-1000, 710}, {-1000, 699.8}}, color = {0, 128, 255}));
    connect(threeWayValve4.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF41.enthalpyPort_a1) annotation(
      Line(points = {{-1000, 520}, {-1000, 505.8}}, color = {0, 128, 255}));
    connect(manifold4.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF42.enthalpyPort_b1) annotation(
      Line(points = {{-1040.5, 660}, {-1040.5, 549.8}, {-1040, 549.8}, {-1040, 519.8}}, color = {176, 0, 0}));
    connect(temperature_2216_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF43.enthalpyPort_b1) annotation(
      Line(points = {{-1091.2, 529.9}, {-1085.5, 529.9}, {-1085.5, 530}, {-1079.8, 530}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF43.enthalpyPort_a1, threeWayValve4.enthalpyPort_b) annotation(
      Line(points = {{-1060.2, 530}, {-1050.6, 529.9}, {-1050.6, 530}, {-1010, 530}}, color = {0, 128, 255}));
    connect(pump_2205_UP_2.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF46.enthalpyPort_b1) annotation(
      Line(points = {{-1362.4, 560}, {-1351.8, 560}}, color = {0, 128, 255}));
    connect(temperature_2202_TRC_2.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF47.enthalpyPort_b1) annotation(
      Line(points = {{-1431.2, 559.9}, {-1424.5, 559.9}, {-1424.5, 560}, {-1417.8, 560}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF47.enthalpyPort_a1, pump_2205_UP_2.enthalpyPort_b) annotation(
      Line(points = {{-1398.2, 560}, {-1380.6, 559.9}, {-1380.6, 560}, {-1381.6, 560}}, color = {0, 128, 255}));
    connect(temperature_2202_TRC_2.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF48.enthalpyPort_a1) annotation(
      Line(points = {{-1449, 559.9}, {-1470.6, 559.9}, {-1470.6, 560}, {-1472.2, 560}}, color = {0, 128, 255}));
    connect(fluidSource3.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF50.enthalpyPort_a1) annotation(
      Line(points = {{-1592, 861}, {-1587.9, 861}, {-1587.9, 860}, {-1575.8, 860}}, color = {176, 0, 0}));
    connect(temperature_2204_TRC_2.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF51.enthalpyPort_b1) annotation(
      Line(points = {{-1428.8, 659.9}, {-1426.5, 659.9}, {-1426.5, 660}, {-1492.2, 660}}, color = {176, 0, 0}));
    connect(temperature_2204_TRC_2.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF52.enthalpyPort_a1) annotation(
      Line(points = {{-1411, 659.9}, {-1361.5, 659.9}, {-1361.5, 660}, {-1351.8, 660}}, color = {176, 0, 0}));
    connect(temperature_2215_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF54.enthalpyPort_a1) annotation(
      Line(points = {{-1111, 660.1}, {-1105.5, 660.1}, {-1105.5, 660}, {-1099.8, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF54.enthalpyPort_b1, manifold4.enthalpyPort_a[1]) annotation(
      Line(points = {{-1080.2, 660}, {-1039.5, 660}}, color = {176, 0, 0}));
    connect(manifold3.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF55.enthalpyPort_b1) annotation(
      Line(points = {{-1040, 760.5}, {-1040, 719.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF55.enthalpyPort_a1, manifold4.enthalpyPort_b) annotation(
      Line(points = {{-1040, 700.2}, {-1040, 680}}, color = {176, 0, 0}));
    connect(massFlowRate1.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF56.enthalpyPort_b1) annotation(
      Line(points = {{-1189.2, 779.9}, {-1174.5, 779.9}, {-1174.5, 780}, {-1159.8, 780}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF56.enthalpyPort_a1, threeWayValve3.enthalpyPort_a) annotation(
      Line(points = {{-1140.2, 780}, {-1010, 779.9}, {-1010, 720}}, color = {0, 128, 255}));
    connect(fluidSource1.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF57.enthalpyPort_a1) annotation(
      Line(points = {{-1160, 839}, {-1150, 839}, {-1150, 840}, {-1139.8, 840}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF57.enthalpyPort_b1, manifold3.enthalpyPort_a[1]) annotation(
      Line(points = {{-1120.2, 840}, {-1040, 840}, {-1040, 759.5}}, color = {176, 0, 0}));
    connect(product.y, gain.u) annotation(
      Line(points = {{-19, 50}, {-2, 50}}, color = {0, 0, 127}));
    connect(y_8204_FRC, product.u1) annotation(
      Line(points = {{-34, 114}, {-50, 114}, {-50, 56}, {-42, 56}}, color = {0, 0, 127}));
    connect(add1.y, product.u2) annotation(
      Line(points = {{-59, 44}, {-42, 44}}, color = {0, 0, 127}));
    connect(add1.u1, y_8206_TRC) annotation(
      Line(points = {{-82, 50}, {-88, 50}, {-88, 124}, {6, 124}, {6, 112}}, color = {0, 0, 127}));
    connect(y_8205_TRC, add1.u2) annotation(
      Line(points = {{-10, 148}, {-92, 148}, {-92, 38}, {-82, 38}}, color = {0, 0, 127}));
    connect(gain.y, y_WMZ_heatingGrid) annotation(
      Line(points = {{21, 50}, {46, 50}}, color = {0, 0, 127}));
    connect(sineGeo_T_amb1.y, fluidSource3.T_fluid) annotation(
      Line(points = {{-1631, 864}, {-1632, 864}, {-1632, 864.2}, {-1610, 864.2}}, color = {0, 0, 127}));
    connect(gain3.y, hysteresis.u) annotation(
      Line(points = {{-1452, 459}, {-1452, 430}, {-1460, 430}}, color = {0, 0, 127}));
    connect(y_boiler_dotQ, gain4.u) annotation(
      Line(points = {{-1302, -108}, {-1288, -108}}, color = {0, 0, 127}));
    connect(gain4.y, calc_mdot_production.u_dotQ) annotation(
      Line(points = {{-1265, -108}, {-1260, -108}, {-1260, -86}, {-1190, -86}, {-1190, -98}}, color = {0, 0, 127}));
    connect(greaterThreshold.y, logicalSwitch_5204_ZA.u3) annotation(
      Line(points = {{-1339, -10}, {-1330, -10}, {-1330, -18}}, color = {255, 0, 255}));
    connect(greaterThreshold.u, max.y) annotation(
      Line(points = {{-1362, -10}, {-1370, -10}, {-1370, -54}, {-1379, -54}}, color = {0, 0, 127}));
    connect(booleanConstant2.y, logicalSwitch_5204_ZA.u1) annotation(
      Line(points = {{-1301, -10}, {-1314, -10}, {-1314, -18}}, color = {255, 0, 255}));
    connect(not1.u, hysteresis.y) annotation(
      Line(points = {{-1490, 430}, {-1483, 430}}, color = {255, 0, 255}));
    connect(const5.y, switch_2102_ZA_2.u1) annotation(
      Line(points = {{-1513, 460}, {-1530, 460}, {-1530, 468}}, color = {0, 0, 127}));
    connect(logicalSwitch_5204_ZA.y, boiler.onOff_boiler) annotation(
      Line(points = {{-1322, -41}, {-1322, -83.2}, {-1322.8, -83.2}}, color = {255, 0, 255}));
    connect(calc_mdot_production1.u_dotQ, gain5.y) annotation(
      Line(points = {{-1402, 602}, {-1402, 609}}, color = {0, 0, 127}));
    connect(gain5.u, y_heatpump2_dotQ) annotation(
      Line(points = {{-1402, 632}, {-1402, 640}, {-1522, 640}}, color = {0, 0, 127}));
    connect(switch_2102_ZA_2.u2, or1.y) annotation(
      Line(points = {{-1538, 468}, {-1538, 455}}, color = {255, 0, 255}));
    connect(not1.y, or1.u2) annotation(
      Line(points = {{-1513, 430}, {-1530, 430}, {-1530, 432}}, color = {255, 0, 255}));
    connect(add5.y, calc_mdot_production1.u_TemperatureOutput) annotation(
      Line(points = {{-1431, 600}, {-1422, 600}, {-1422, 595.8}, {-1414, 595.8}}, color = {0, 0, 127}));
    connect(add5.u2, temperature_2202_TRC_2.T) annotation(
      Line(points = {{-1454, 594}, {-1460, 594}, {-1460, 584}, {-1441, 584}, {-1441, 571}}, color = {0, 0, 127}));
    connect(const19.y, add5.u1) annotation(
      Line(points = {{-1473, 606}, {-1454, 606}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF52.enthalpyPort_b1, threeWayValve_NS_2211.enthalpyPort_ab) annotation(
      Line(points = {{-1332.2, 660}, {-1311.8, 660}}, color = {176, 0, 0}));
    connect(threeWayValve_NS_2211.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF53.enthalpyPort_a1) annotation(
      Line(points = {{-1292, 660}, {-1271.8, 660}}, color = {176, 0, 0}));
    connect(threeWayValve_NS_2211.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF44.enthalpyPort_a1) annotation(
      Line(points = {{-1302, 650}, {-1302, 639.8}}, color = {176, 0, 0}));
    connect(manifold_NS_2211.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF46.enthalpyPort_a1) annotation(
      Line(points = {{-1322, 560}, {-1332.2, 560}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF44.enthalpyPort_b1, manifold_NS_2211.enthalpyPort_a[2]) annotation(
      Line(points = {{-1302, 620.2}, {-1302, 560.5}}, color = {0, 128, 255}));
    connect(manifold_NS_2211.enthalpyPort_a[1], dynamicPipe_HeatStorage_unload_FF45.enthalpyPort_b1) annotation(
      Line(points = {{-1302, 559.5}, {-1291.8, 559.5}, {-1291.8, 560}, {-1279.8, 560}}, color = {0, 128, 255}));
    connect(PID.y, threeWayValve_NS_2211.opening) annotation(
      Line(points = {{-1273, 740}, {-1302, 740}, {-1302, 669}}, color = {0, 0, 127}));
    connect(const18.y, PID.u_m) annotation(
      Line(points = {{-1241, 720}, {-1262, 720}, {-1262, 728}}, color = {0, 0, 127}));
    connect(PID.u_s, temperature_2215_TRC.T) annotation(
      Line(points = {{-1250, 740}, {-1104, 740}, {-1104, 649}, {-1119, 649}}, color = {0, 0, 127}));
    connect(gain3.u, y_2202_TRC_2) annotation(
      Line(points = {{-1452, 482}, {-1452, 572}}, color = {0, 0, 127}));
    connect(calc_mdot_consumer.y_mdot, pump_8113_NP.dotm_setValue) annotation(
      Line(points = {{-301, 210}, {-320, 210}, {-320, 168}}, color = {0, 0, 127}));
    connect(calc_mdot_consumer.u_TemperatureInput, temperature_8205_TRC.T) annotation(
      Line(points = {{-278, 204}, {-272, 204}, {-272, 180}, {20, 180}, {20, 149}, {1, 149}}, color = {0, 0, 127}));
    connect(calc_mdot_consumer.u_dotQ, gain2.y) annotation(
      Line(points = {{-290, 222}, {-290, 240}, {580, 240}, {580, 568}, {820, 568}, {820, 579}}, color = {0, 0, 127}));
    connect(calc_mdot_consumer.u_TemperatureOutput, add6.y) annotation(
      Line(points = {{-278, 215.8}, {-270, 215.8}, {-270, 216}, {-261, 216}}, color = {0, 0, 127}));
    connect(add6.u1, const22.y) annotation(
      Line(points = {{-238, 222}, {-220, 222}, {-220, 224}, {-209, 224}}, color = {0, 0, 127}));
    connect(add6.u2, temperature_8205_TRC.T) annotation(
      Line(points = {{-238, 210}, {-220, 210}, {-220, 180}, {20, 180}, {20, 150}, {10, 150}, {10, 149}, {1, 149}}, color = {0, 0, 127}));
    connect(gain2.u, gain8.y) annotation(
      Line(points = {{820, 602}, {820, 1360}, {-1559, 1360}}, color = {0, 0, 127}));
    connect(massFlowRate_4516_FRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF58.enthalpyPort_b1) annotation(
      Line(points = {{-1171.2, 179.9}, {-1164.5, 179.9}, {-1164.5, 180}, {-1157.8, 180}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF58.enthalpyPort_a1, temperature_4518_TRC.enthalpyPort_b) annotation(
      Line(points = {{-1138.2, 180}, {-1127.6, 180}, {-1127.6, 179.9}, {-1117, 179.9}}, color = {0, 128, 255}));
    connect(temperature_4518_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF41.enthalpyPort_b1) annotation(
      Line(points = {{-1099.2, 179.9}, {-1000, 179.9}, {-1000, 486.2}}, color = {0, 128, 255}));
    connect(temperature_4515_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF59.enthalpyPort_b1) annotation(
      Line(points = {{-1239.2, 179.9}, {-1240, 179.9}, {-1240, 180}, {-1225.8, 180}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF59.enthalpyPort_a1, massFlowRate_4516_FRC.enthalpyPort_b) annotation(
      Line(points = {{-1206.2, 180}, {-1204.6, 180}, {-1204.6, 179.9}, {-1189, 179.9}}, color = {0, 128, 255}));
    connect(manifold.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF61.enthalpyPort_a1) annotation(
      Line(points = {{-1300, 240}, {-1259.8, 240}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF61.enthalpyPort_b1, temperature_4517_TRC.enthalpyPort_a) annotation(
      Line(points = {{-1240.2, 240}, {-1204, 240}, {-1204, 240.1}, {-1168.8, 240.1}}, color = {0, 128, 255}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF62.enthalpyPort_b1) annotation(
      Line(points = {{-1320, 240.5}, {-1320, 219.8}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF62.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{-1320, 200.2}, {-1320, 190}}, color = {0, 128, 255}));
    connect(threeWayValve.enthalpyPort_ab, dynamicPipe_HeatStorage_unload_FF60.enthalpyPort_b1) annotation(
      Line(points = {{-1310.2, 180}, {-1299.8, 180}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF60.enthalpyPort_a1, temperature_4515_TRC.enthalpyPort_b) annotation(
      Line(points = {{-1280.2, 180}, {-1268, 180}, {-1268, 179.9}, {-1257, 179.9}}, color = {0, 128, 255}));
    connect(pump_4507_up.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF63.enthalpyPort_b1) annotation(
      Line(points = {{-1400.4, 180}, {-1357.8, 180}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF63.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{-1338.2, 180}, {-1330, 180}}, color = {0, 128, 255}));
    connect(temperature_4504_TRC.enthalpyPort_a, pump_4507_up.enthalpyPort_b) annotation(
      Line(points = {{-1437.2, 179.9}, {-1419.6, 179.9}, {-1419.6, 180}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF64.enthalpyPort_b1, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{-1340.2, 240}, {-1330, 240}, {-1330, 239.5}, {-1320, 239.5}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF66.enthalpyPort_a1, temperature_4504_TRC.enthalpyPort_b) annotation(
      Line(points = {{-1500.2, 180}, {-1462, 180}, {-1462, 179.9}, {-1455, 179.9}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF66.enthalpyPort_b1, CHP.enthalpyPort_a) annotation(
      Line(points = {{-1519.8, 180}, {-1560, 180}, {-1560, 210}, {-1550, 210}}, color = {176, 0, 0}));
    connect(or1.u1, not2.y) annotation(
      Line(points = {{-1538, 432}, {-1538, 420}, {-2119, 420}}, color = {255, 0, 255}));
    connect(not3.y, logicalSwitch_5204_ZA.u2) annotation(
      Line(points = {{-1339, 40}, {-1322, 40}, {-1322, -18}}, color = {255, 0, 255}));
    connect(gain1.u, y_4504_TRC) annotation(
      Line(points = {{-1460, 258}, {-1460, 192}}, color = {0, 0, 127}));
    connect(hysteresis1.u, gain1.y) annotation(
      Line(points = {{-1468, 330}, {-1460, 330}, {-1460, 281}}, color = {0, 0, 127}));
    connect(not4.u, hysteresis1.y) annotation(
      Line(points = {{-1498, 330}, {-1491, 330}}, color = {255, 0, 255}));
    connect(or2.y, switch_4202_ZA.u2) annotation(
      Line(points = {{-1534, 299}, {-1534, 282}}, color = {255, 0, 255}));
    connect(switch_4202_ZA.y, CHP.P_elRel) annotation(
      Line(points = {{-1534, 259}, {-1534, 219.2}, {-1535, 219.2}}, color = {0, 0, 127}));
    connect(not4.y, or2.u1) annotation(
      Line(points = {{-1521, 330}, {-1534, 330}, {-1534, 322}}, color = {255, 0, 255}));
    connect(const8.y, switch_4202_ZA.u1) annotation(
      Line(points = {{-1511, 290}, {-1526, 290}, {-1526, 282}}, color = {0, 0, 127}));
    connect(not5.y, or2.u2) annotation(
      Line(points = {{-1559, 330}, {-1542, 330}, {-1542, 322}}, color = {255, 0, 255}));
    connect(realToBoolean.y, CHP.onOff) annotation(
      Line(points = {{-1560, 229}, {-1560, 226}, {-1544, 226}, {-1544, 219.2}}, color = {255, 0, 255}));
    connect(switch_4202_ZA.y, realToBoolean.u) annotation(
      Line(points = {{-1534, 259}, {-1534, 252}, {-1560, 252}}, color = {0, 0, 127}));
    connect(calc_mdot_production2.u_TemperatureInput, temperature_4504_TRC.T) annotation(
      Line(points = {{-1442, 204}, {-1444, 204}, {-1444, 191}, {-1447, 191}}, color = {0, 0, 127}));
    connect(calc_mdot_production2.y_mdot, pump_4507_up.dotm_setValue) annotation(
      Line(points = {{-1419, 210}, {-1410, 210}, {-1410, 188}}, color = {0, 0, 127}));
    connect(temperature_4506_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF64.enthalpyPort_a1) annotation(
      Line(points = {{-1369, 240.1}, {-1365.5, 240.1}, {-1365.5, 240}, {-1359.8, 240}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF67.enthalpyPort_b1, temperature_4506_TRC.enthalpyPort_a) annotation(
      Line(points = {{-1396.2, 240}, {-1392, 240}, {-1392, 240.1}, {-1386.8, 240.1}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF67.enthalpyPort_a1, CHP.enthalpyPort_b) annotation(
      Line(points = {{-1415.8, 240}, {-1520, 240}, {-1520, 210}, {-1530, 210}}, color = {176, 0, 0}));
    connect(const15.y, calc_mdot_production2.u_TemperatureOutput) annotation(
      Line(points = {{-1479, 216}, {-1446, 216}, {-1446, 215.8}, {-1442, 215.8}}, color = {0, 0, 127}));
    connect(calc_mdot_production2.u_dotQ, CHP.Capacity[2]) annotation(
      Line(points = {{-1430, 222}, {-1430, 236}, {-1512, 236}, {-1512, 215.6}, {-1529.8, 215.6}}, color = {0, 0, 127}));
    connect(calc_valve1.y_valve, threeWayValve.opening) annotation(
      Line(points = {{-1301, 138}, {-1320, 138}, {-1320, 171}}, color = {0, 0, 127}));
    connect(calc_valve1.u_T_consumer_output, y_4515_TRC) annotation(
      Line(points = {{-1278, 144}, {-1270, 144}, {-1270, 192}, {-1262, 192}}, color = {0, 0, 127}));
    connect(calc_valve1.u_T_source_input, y_4506_TRC) annotation(
      Line(points = {{-1290, 126}, {-1290, 120}, {-1388, 120}, {-1388, 228}}, color = {0, 0, 127}));
    connect(calc_valve1.u_T_consumer_input, const23.y) annotation(
      Line(points = {{-1278, 132.2}, {-1269, 132.2}, {-1269, 132}, {-1261, 132}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF40.enthalpyPort_b1, massFlowRate2.enthalpyPort_a) annotation(
      Line(points = {{-1000, 680.2}, {-1000, 670}, {-1000, 658.8}, {-1000.1, 658.8}}, color = {0, 128, 255}));
    connect(massFlowRate2.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF65.enthalpyPort_a1) annotation(
      Line(points = {{-1000.1, 641}, {-1000.1, 629.5}, {-1000, 629.5}, {-1000, 619.8}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF65.enthalpyPort_b1, threeWayValve4.enthalpyPort_ab) annotation(
      Line(points = {{-1000, 600.2}, {-1000, 539.8}}, color = {0, 128, 255}));
    connect(temperature_4517_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF68.enthalpyPort_a1) annotation(
      Line(points = {{-1151, 240.1}, {-1040, 240.1}, {-1040, 442.2}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF68.enthalpyPort_b1, massFlowRate10.enthalpyPort_a) annotation(
      Line(points = {{-1040, 461.8}, {-1040, 465.5}, {-1040.1, 465.5}, {-1040.1, 469.2}}, color = {176, 0, 0}));
    connect(massFlowRate10.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF42.enthalpyPort_a1) annotation(
      Line(points = {{-1040.1, 487}, {-1040.1, 483.6}, {-1040, 483.6}, {-1040, 500.2}}, color = {176, 0, 0}));
    connect(calc_valve_ratio1.u_dotm_out, massFlowRate10.dotm) annotation(
      Line(points = {{-960, 518}, {-960, 479}, {-1031, 479}}, color = {0, 0, 127}));
    connect(threeWayValve4.opening, calc_valve_ratio1.y_valve) annotation(
      Line(points = {{-991, 530}, {-971, 530}}, color = {0, 0, 127}));
    connect(massFlowRate2.dotm, calc_valve_ratio1.u_dotm_in) annotation(
      Line(points = {{-991, 649}, {-960, 649}, {-960, 542}}, color = {0, 0, 127}));
    connect(threeWayValve_NS_2.enthalpyPort_ab, dynamicPipe_HeatStorage_unload_FF69.enthalpyPort_b1) annotation(
      Line(points = {{-1240, 530.2}, {-1230, 530.2}, {-1230, 530}, {-1219.8, 530}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF69.enthalpyPort_a1, temperature_2213_TRC.enthalpyPort_b) annotation(
      Line(points = {{-1200.2, 530}, {-1188, 530}, {-1188, 529.9}, {-1177, 529.9}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF45.enthalpyPort_a1, threeWayValve_NS_2.enthalpyPort_a) annotation(
      Line(points = {{-1260.2, 560}, {-1240, 560}, {-1240, 550}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF70.enthalpyPort_a1, threeWayValve_NS_2.enthalpyPort_b) annotation(
      Line(points = {{-1260.2, 520}, {-1256, 520}, {-1256, 540}, {-1250, 540}}, color = {0, 128, 255}));
    connect(manifold_NS_2.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF71.enthalpyPort_a1) annotation(
      Line(points = {{-1180, 660}, {-1159.8, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF71.enthalpyPort_b1, temperature_2215_TRC.enthalpyPort_a) annotation(
      Line(points = {{-1140.2, 660}, {-1134, 660}, {-1134, 660.1}, {-1128.8, 660.1}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF53.enthalpyPort_b1, manifold_NS_2.enthalpyPort_a[2]) annotation(
      Line(points = {{-1252.2, 660}, {-1226, 660}, {-1226, 660.5}, {-1200, 660.5}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF72.enthalpyPort_b1, manifold_NS_2.enthalpyPort_a[1]) annotation(
      Line(points = {{-1252.2, 700}, {-1220, 700}, {-1220, 659.5}, {-1200, 659.5}}, color = {176, 0, 0}));
    connect(const7.y, heatPump1.iceFac_in) annotation(
      Line(points = {{-1907.5, 621}, {-1902, 621}, {-1902, 620.88}, {-1893.87, 620.88}}, color = {0, 0, 127}));
    connect(calc_mdot_production3.u_TemperatureInput, temperature_2202_TRC_1.T) annotation(
      Line(points = {{-1752, 584}, {-1778, 584}, {-1778, 531}, {-1779, 531}}, color = {0, 0, 127}));
    connect(calc_mdot_production3.y_mdot, pump_2205_UP_1.dotm_setValue) annotation(
      Line(points = {{-1729, 590}, {-1710, 590}, {-1710, 528}}, color = {0, 0, 127}));
    connect(pump_2205_UP_1.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF75.enthalpyPort_b1) annotation(
      Line(points = {{-1700.4, 520}, {-1689.8, 520}}, color = {0, 128, 255}));
    connect(temperature_2202_TRC_1.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF76.enthalpyPort_b1) annotation(
      Line(points = {{-1769.2, 519.9}, {-1762.5, 519.9}, {-1762.5, 520}, {-1755.8, 520}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF76.enthalpyPort_a1, pump_2205_UP_1.enthalpyPort_b) annotation(
      Line(points = {{-1736.2, 520}, {-1718.6, 519.9}, {-1718.6, 520}, {-1719.6, 520}}, color = {0, 128, 255}));
    connect(temperature_2202_TRC_1.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF77.enthalpyPort_a1) annotation(
      Line(points = {{-1787, 519.9}, {-1808.6, 519.9}, {-1808.6, 520}, {-1810.2, 520}}, color = {0, 128, 255}));
    connect(temperature_2204_TRC_1.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF78.enthalpyPort_b1) annotation(
      Line(points = {{-1766.8, 699.9}, {-1764.5, 699.9}, {-1764.5, 700}, {-1830.2, 700}}, color = {176, 0, 0}));
    connect(temperature_2204_TRC_1.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF79.enthalpyPort_a1) annotation(
      Line(points = {{-1749, 699.9}, {-1699.5, 699.9}, {-1699.5, 700}, {-1689.8, 700}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF77.enthalpyPort_b1, heatPump1.enthalpyPort_a) annotation(
      Line(points = {{-1829.8, 520}, {-1871, 520}, {-1871, 618}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF78.enthalpyPort_a1, heatPump1.enthalpyPort_b) annotation(
      Line(points = {{-1849.8, 700}, {-1871, 700}, {-1871, 642}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF82.enthalpyPort_b1, heatPump1.enthalpyPort_a1) annotation(
      Line(points = {{-1894.2, 860}, {-1885, 860}, {-1885, 642}}, color = {176, 0, 0}));
    connect(heatPump1.enthalpyPort_b1, dynamicPipe_HeatStorage_unload_FF81.enthalpyPort_a1) annotation(
      Line(points = {{-1885, 618}, {-1886, 618}, {-1886, 600}, {-1900, 600}, {-1900, 800}, {-1912.2, 800}}, color = {176, 0, 0}));
    connect(calc_mdot_production3.u_dotQ, gain6.y) annotation(
      Line(points = {{-1740, 602}, {-1740, 609}}, color = {0, 0, 127}));
    connect(add2.y, calc_mdot_production3.u_TemperatureOutput) annotation(
      Line(points = {{-1769, 600}, {-1760, 600}, {-1760, 595.8}, {-1752, 595.8}}, color = {0, 0, 127}));
    connect(add2.u2, temperature_2202_TRC_1.T) annotation(
      Line(points = {{-1792, 594}, {-1798, 594}, {-1798, 584}, {-1779, 584}, {-1779, 531}}, color = {0, 0, 127}));
    connect(const24.y, add2.u1) annotation(
      Line(points = {{-1811, 606}, {-1792, 606}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF79.enthalpyPort_b1, threeWayValve_NS_3.enthalpyPort_ab) annotation(
      Line(points = {{-1670.2, 700}, {-1649.8, 700}}, color = {176, 0, 0}));
    connect(threeWayValve_NS_3.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF73.enthalpyPort_a1) annotation(
      Line(points = {{-1640, 690}, {-1640, 639.8}}, color = {176, 0, 0}));
    connect(manifold_NS_3.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF75.enthalpyPort_a1) annotation(
      Line(points = {{-1660, 520}, {-1670.2, 520}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF73.enthalpyPort_b1, manifold_NS_3.enthalpyPort_a[2]) annotation(
      Line(points = {{-1640, 620.2}, {-1640, 520.5}}, color = {0, 128, 255}));
    connect(const25.y, fluidSource2.dotm) annotation(
      Line(points = {{-1969, 830}, {-1960, 830}, {-1960, 857.4}, {-1948, 857.4}}, color = {0, 0, 127}));
    connect(vessel2.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF81.enthalpyPort_b1) annotation(
      Line(points = {{-1971, 800}, {-1931.8, 800}}, color = {176, 0, 0}));
    connect(fluidSource2.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF82.enthalpyPort_a1) annotation(
      Line(points = {{-1930, 861}, {-1925.9, 861}, {-1925.9, 860}, {-1913.8, 860}}, color = {176, 0, 0}));
    connect(sineGeo_T_amb2.y, fluidSource2.T_fluid) annotation(
      Line(points = {{-1969, 864}, {-1970, 864}, {-1970, 864.2}, {-1948, 864.2}}, color = {0, 0, 127}));
    connect(manifold_NS_3.enthalpyPort_a[1], dynamicPipe_HeatStorage_unload_FF70.enthalpyPort_b1) annotation(
      Line(points = {{-1640, 519.5}, {-1459.8, 519.5}, {-1459.8, 520}, {-1279.8, 520}}, color = {0, 128, 255}));
    connect(threeWayValve_NS_3.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF72.enthalpyPort_a1) annotation(
      Line(points = {{-1630, 700}, {-1271.8, 700}}, color = {176, 0, 0}));
    connect(booleanConstant1.y, heatPump1.modeSet) annotation(
      Line(points = {{-1899, 580}, {-1880.1, 580}, {-1880.1, 616.08}}, color = {255, 0, 255}));
    connect(u_7102_NS, min1.u2) annotation(
      Line(points = {{-2220, 390}, {-722, 390}, {-722, 600}, {-702, 600}}, color = {0, 0, 127}));
    connect(u_7202_NS, min.u2) annotation(
      Line(points = {{-2220, 360}, {-664, 360}, {-664, 380}, {-642, 380}}, color = {0, 0, 127}));
    connect(u_disturb_CHP, not5.u) annotation(
      Line(points = {{-2220, 330}, {-1582, 330}}, color = {255, 0, 255}));
    connect(u_CHP_0_1, switch_4202_ZA.u3) annotation(
      Line(points = {{-2220, 290}, {-1542, 290}, {-1542, 282}}, color = {0, 0, 127}));
    connect(u_disturb_boiler, not3.u) annotation(
      Line(points = {{-2220, 40}, {-1362, 40}}, color = {255, 0, 255}));
    connect(u_boiler_0_1, max.u1) annotation(
      Line(points = {{-2220, 0}, {-1410, 0}, {-1410, -48}, {-1402, -48}}, color = {0, 0, 127}));
    connect(u_loadProfile_kW, gain8.u) annotation(
      Line(points = {{-2220, 1360}, {-1582, 1360}}, color = {0, 0, 127}));
    connect(u_heatpump_0_1, switch_2102_ZA_2.u3) annotation(
      Line(points = {{-2220, 466}, {-1546, 466}, {-1546, 468}}, color = {0, 0, 127}));
    connect(u_disturb_heatpump2, not2.u) annotation(
      Line(points = {{-2220, 420}, {-2142, 420}}, color = {255, 0, 255}));
    connect(greaterThreshold_2101_OA_2.u, switch_2102_ZA_2.y) annotation(
      Line(points = {{-1524, 540}, {-1538, 540}, {-1538, 491}}, color = {0, 0, 127}));
    connect(hysteresis2.u, gain7.y) annotation(
      Line(points = {{-1838, 490}, {-1831, 490}}, color = {0, 0, 127}));
    connect(not6.u, hysteresis2.y) annotation(
      Line(points = {{-1868, 490}, {-1861, 490}}, color = {255, 0, 255}));
    connect(y_2202_TRC_1, gain7.u) annotation(
      Line(points = {{-1790, 532}, {-1800, 532}, {-1800, 490}, {-1808, 490}}, color = {0, 0, 127}));
    connect(switch_2102_ZA_1.y, heatPump1.nSet) annotation(
      Line(points = {{-1897, 510}, {-1876, 510}, {-1876, 578}, {-1875.67, 578}, {-1875.67, 616.08}}, color = {0, 0, 127}));
    connect(greaterThreshold_2101_OA_1.u, switch_2102_ZA_1.y) annotation(
      Line(points = {{-1898, 540}, {-1876, 540}, {-1876, 510}, {-1897, 510}}, color = {0, 0, 127}));
    connect(const26.y, switch_2102_ZA_1.u1) annotation(
      Line(points = {{-1939, 530}, {-1930, 530}, {-1930, 518}, {-1920, 518}}, color = {0, 0, 127}));
    connect(or3.y, switch_2102_ZA_1.u2) annotation(
      Line(points = {{-1979, 510}, {-1950, 510}, {-1950, 510}, {-1920, 510}}, color = {255, 0, 255}));
    connect(not6.y, or3.u2) annotation(
      Line(points = {{-1891, 490}, {-2020, 490}, {-2020, 502}, {-2002, 502}}, color = {255, 0, 255}));
    connect(not7.y, or3.u1) annotation(
      Line(points = {{-2119, 510}, {-2002, 510}}, color = {255, 0, 255}));
    connect(vessel3.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF49.enthalpyPort_b1) annotation(
      Line(points = {{-1633, 800}, {-1593.8, 800}}, color = {176, 0, 0}));
    connect(const27.y, PID1.u_m) annotation(
      Line(points = {{-1599, 720}, {-1620, 720}, {-1620, 728}}, color = {0, 0, 127}));
    connect(PID1.y, threeWayValve_NS_3.opening) annotation(
      Line(points = {{-1631, 740}, {-1640, 740}, {-1640, 709}}, color = {0, 0, 127}));
    connect(PID1.u_s, temperature_2215_TRC.T) annotation(
      Line(points = {{-1608, 740}, {-1580, 740}, {-1580, 760}, {-1104, 760}, {-1104, 649}, {-1119, 649}}, color = {0, 0, 127}));
    connect(const28.y, threeWayValve_NS_2.opening) annotation(
      Line(points = {{-1221, 580}, {-1231, 580}, {-1231, 540}}, color = {0, 0, 127}));
    connect(y_heatpump1_dotQ, gain6.u) annotation(
      Line(points = {{-1860, 640}, {-1740, 640}, {-1740, 632}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF51.enthalpyPort_a1, heatPump2.enthalpyPort_b) annotation(
      Line(points = {{-1511.8, 660}, {-1533, 660}, {-1533, 642}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF49.enthalpyPort_a1, heatPump2.enthalpyPort_b1) annotation(
      Line(points = {{-1574.2, 800}, {-1560, 800}, {-1560, 600}, {-1547, 600}, {-1547, 618}}, color = {176, 0, 0}));
    connect(booleanConstant.y, heatPump2.modeSet) annotation(
      Line(points = {{-1571, 580}, {-1542.1, 580}, {-1542.1, 616.08}}, color = {255, 0, 255}));
    connect(heatPump2.nSet, switch_2102_ZA_2.y) annotation(
      Line(points = {{-1537.67, 616.08}, {-1537.67, 564}, {-1538, 564}, {-1538, 491}}, color = {0, 0, 127}));
    connect(heatPump2.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF48.enthalpyPort_b1) annotation(
      Line(points = {{-1533, 618}, {-1534, 618}, {-1534, 560}, {-1491.8, 560}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF50.enthalpyPort_b1, heatPump2.enthalpyPort_a1) annotation(
      Line(points = {{-1556.2, 860}, {-1548, 860}, {-1548, 642}, {-1547, 642}}, color = {176, 0, 0}));
    connect(u_heatpump_0_1, switch_2102_ZA_1.u3) annotation(
      Line(points = {{-2220, 466}, {-1930, 466}, {-1930, 502}, {-1920, 502}}, color = {0, 0, 127}));
    connect(u_disturb_heatpump1, not7.u) annotation(
      Line(points = {{-2220, 510}, {-2181, 510}, {-2181, 510}, {-2142, 510}}, color = {255, 0, 255}));
    annotation(
      Diagram(coordinateSystem(extent = {{-2200, -1000}, {1000, 1400}}), graphics = {Line(origin = {688, 380}, points = {{0, 0}})}),
      Icon(coordinateSystem(extent = {{-2200, -1000}, {1000, 1400}})),
      experiment(StopTime = 31536000, Interval = 900, Tolerance = 0.01, __Dymola_Algorithm = "Dassl"));
  end FMU_PhyModel;
  annotation(
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.10.7")),
    Documentation(info = "<html>
      <p>Im package FMUs werden alle Modelle der unterschiedlichen Simulationen abgelegt, welche mit entsprechenden Schnittstellen zu FMUs umgebaut worden sind.</p>
      <p>Erstellt wurden die Simulationsmodelle durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
end FMUs;
