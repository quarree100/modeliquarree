within Q100_DistrictModel;
package FMUs
  extends Modelica.Icons.ExamplesPackage;

  model FMU_PhyModel
    parameter Real ScaleFactor = 1 "Scaling factor for heatpump";
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 8), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 3.2, dTank = 20, sIns = 0.2, lambdaIns = 0.032), load_cycles = [8, 1], n = 8, n_load_cycles = 1, n_unload_cycles = 1, unload_cycles = [1, 8], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation (
      Placement(visible = true, transformation(origin = {18, 584}, extent = {{-102, -122}, {102, 122}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF(selectable = false, T_0 = 343.15) annotation (
      Placement(visible = true, transformation(origin = {170, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_FF(selectable = true, T_0 = 343.15, nNodes = 10, diameter = 0.3, length = 5000, withConvection = true) annotation (
      Placement(visible = true, transformation(origin = {390, 160}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Math.Gain gain2(k = 1000) annotation (
      Placement(visible = true, transformation(origin = {820, 590}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_HeatGrid_FF annotation (
      Placement(visible = true, transformation(origin = {310, 160}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Sine sineGeo_T_amb(amplitude = 15, freqHz = 1 / (3600 * 24 * 365 * 2), offset = 3 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {90, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatGrid_RF(selectable = true, T_0 = 323.15, nNodes = 10, diameter = 0.3, length = 5000, withConvection = true) annotation (
      Placement(visible = true, transformation(origin = {390, 100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_RF(selectable = false, T_0 = 323.15) annotation (
      Placement(visible = true, transformation(origin = {170, 100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation (
      Placement(visible = true, transformation(origin = {176, 680}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (
      Placement(visible = true, transformation(origin = {350, 138}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_7104_TRC_load annotation (
      Placement(visible = true, transformation(origin = {-202, 740}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_7103_FRC_load annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 90, origin = {-220, 638})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_7104_TRC_unload annotation (
      Placement(visible = true, transformation(origin = {-220, 780}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_7103_FRC_unload annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {-240, 660})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_7203_TRC_load annotation (
      Placement(visible = true, transformation(origin = {-178, 440}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_7203_TRC_unload annotation (
      Placement(visible = true, transformation(origin = {-160, 380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_7102_1 annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {-480, 600})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_7102_2(n = 2) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-480, 530})));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_7202_2 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-520, 380})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_7202_1(n = 2) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-520, 450})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8101_TRC annotation (
      Placement(visible = true, transformation(origin = {-668, 760}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8102_TRC annotation (
      Placement(visible = true, transformation(origin = {-688, 720}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve2 annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-880, 720})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold2(n = 2) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-830, 760})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_5310_FRC annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1040, -140})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_5311_TRC annotation (
      Placement(visible = true, transformation(origin = {-1020, -80}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_5312_TRC annotation (
      Placement(visible = true, transformation(origin = {-968, -140}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_5304_UP annotation (
      Placement(transformation(extent = {{-1150, -150}, {-1170, -130}})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_5303_TRC annotation (
      Placement(visible = true, transformation(origin = {-1218, -140}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.HeatGenerators.Boiler.Boiler boiler(paramBoiler = AixLib.FastHVAC.Data.Boiler.General.Boiler_Vitocrossal200_311kW(Q_nom = 2000000, Q_min = 0, eta = [0.3, (0.973 + 0.989) / 2; 0.4, (0.960 + 0.981) / 2; 0.5, (0.942 + 0.975) / 2; 0.6, (0.924 + 0.968) / 2; 0.7, (0.907 + 0.962) / 2; 0.8, (0.889 + 0.957) / 2; 0.9, (0.872 + 0.953) / 2; 1.0, (0.857 + 0.952) / 2])) annotation (
      Placement(transformation(extent = {{-1354, -124}, {-1306, -76}})));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve3 annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1000, 720})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold3(n = 2) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-1030, 760})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate1 annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {-1198, 780})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource1 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-1170, 838})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel1 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-1226, 780})));
    Modelica.Blocks.Sources.Constant const2(k = 15 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-1270, 850}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const6(k = 0) annotation (
      Placement(visible = true, transformation(origin = {-974, 800}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve4 annotation (
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 90, origin = {-1000, 560})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold4(n = 2) annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-1040, 670})));
    Modelica.Blocks.Sources.Constant const7(k = 0) annotation (
      Placement(visible = true, transformation(origin = {-970, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2202_TRC annotation (
      Placement(visible = true, transformation(origin = {-1368, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_2205_UP annotation (
      Placement(transformation(extent = {{-1290, 550}, {-1310, 570}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_2214_FRC annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1132, 560})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2216_TRC annotation (
      Placement(visible = true, transformation(origin = {-1100, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2215_TRC annotation (
      Placement(visible = true, transformation(origin = {-1120, 660}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_2211 annotation (
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {-1230, 660})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_2211(n = 2) annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-1240, 560})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2213_TRC annotation (
      Placement(visible = true, transformation(origin = {-1168, 560}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.HeatGenerators.HeatPump.HeatPump heatPump(redeclare
        model PerDataHea =
          AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (                                                                                           dataTable = Q100_DistrictModel.Data.WP_550kW()), redeclare
        model PerDataChi =
          AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (                                                                                                                                                                                                        dataTable = Q100_DistrictModel.Data.WP_550kW()), scalingFactor = ScaleFactor, CCon = 100, CEva = 100, GCon = 5, GEva = 5, Q_useNominal = 0, TAmbCon_nominal = 288.15, TCon_start(displayUnit = "K") = 55 + 273.15, TEva_start(displayUnit = "K"), VCon = 0.04, VEva = 0.04, allowFlowReversalEva = true, deltaM_con = 0.1, deltaM_eva = 0.1, mFlow_conNominal = 0.5, mFlow_evaNominal = 0.5, refIneFre_constant = 1, transferHeat = true, use_ConCap = false, use_EvaCap = false, use_autoCalc = false, use_refIne = true, use_revHP = true) annotation (
      Placement(transformation(extent = {{-11.9997, 14}, {11.9999, -14}}, rotation = 90, origin = {-1468, 630})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_2204_TRC annotation (
      Placement(visible = true, transformation(origin = {-1348, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant annotation (
      Placement(transformation(extent = {{-1520, 530}, {-1500, 550}})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource3 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-1530, 660})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel3 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-1546, 560})));
    Modelica.Blocks.Sources.Constant const10(k = 1) annotation (
      Placement(visible = true, transformation(origin = {-1510, 622}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const11(k = 20) annotation (
      Placement(visible = true, transformation(origin = {-1570, 630}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_8106 annotation (
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 270, origin = {-520, 240})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_8106(n = 2) annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 90, origin = {-480, 230})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8104_TRC annotation (
      Placement(visible = true, transformation(origin = {-480, 302}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8103_TRC annotation (
      Placement(visible = true, transformation(origin = {-520, 288}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_8113_NP annotation (
      Placement(transformation(extent = {{-330, 150}, {-310, 170}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_8204_FRC annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-20, 100})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8206_TRC annotation (
      Placement(visible = true, transformation(origin = {20, 100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8205_TRC annotation (
      Placement(visible = true, transformation(origin = {0, 160}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve_NS_1 annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {-180, 100})));
    AixLib.FastHVAC.Components.Valves.Manifold manifold_NS_1(n = 2) annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-250, 100})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8301_TRC annotation (
      Placement(visible = true, transformation(origin = {-180, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_8302_TRC annotation (
      Placement(visible = true, transformation(origin = {-240, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate3 annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-180, -18})));
    AixLib.FastHVAC.Components.Sinks.Vessel vessel4 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-180, -46})));
    AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource4 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-238, 8})));
    Modelica.Blocks.Sources.Constant const12(k = 15 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-270, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const13(k = 1) annotation (
      Placement(visible = true, transformation(origin = {-150, 120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Components.calc_Qdot calc_Qdot annotation (
      Placement(transformation(extent = {{-1440, -70}, {-1420, -50}})));
    Components.calc_mdot_production calc_mdot_production annotation (
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {-1190, -110})));
    Modelica.Blocks.Sources.Constant const3(k = 90 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-1240, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.RealOutput_JW y_boiler_dotQ = boiler.heater.Q_flow / 1000 annotation (
      Placement(visible = true, transformation(extent = {{-1306, -112}, {-1298, -104}}, rotation = 0), iconTransformation(extent = {{-1312, 28}, {-1304, 36}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const9(k = 20) annotation (
      Placement(visible = true, transformation(origin = {-1450, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const14(k = 77 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-1490, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const16(k = 0) annotation (
      Placement(visible = true, transformation(origin = {-690, 350}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.RealOutput_JW y_heatpump_dotQ = heatPump.innerCycle.PerformanceDataHPHeating.QCon / 1000 annotation (
      Placement(transformation(extent = {{-1454, 636}, {-1446, 644}})));
    Q100_DistrictModel.Components.RealOutput_JW y_heatpump_Pel = heatPump.innerCycle.PerformanceDataHPHeating.Pel / 1000 annotation (
      Placement(visible = true, transformation(extent = {{-1454, 628}, {-1446, 636}}, rotation = 0), iconTransformation(extent = {{-1454, 628}, {-1446, 636}}, rotation = 0)));
    Components.calc_mdot_production calc_mdot_production1 annotation (
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin = {-1330, 590})));
    Modelica.Blocks.Sources.Constant const19(k = 5) annotation (
      Placement(visible = true, transformation(origin = {-1412, 606}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sinks.Sink sink annotation (
      Placement(visible = true, transformation(origin = {820, 520}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureInput annotation (
      Placement(visible = true, transformation(origin = {720, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor TemperatureOutput annotation (
      Placement(visible = true, transformation(origin = {880, 520}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate4 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-750, 760})));
    Components.calc_valve_ratio calc_valve_ratio annotation (
      Placement(transformation(extent = {{-920, 810}, {-900, 790}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate5 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-940, 760})));
    Q100_DistrictModel.Components.calc_valve calc_valve annotation (
      Placement(visible = true, transformation(extent = {{-578, 230}, {-558, 250}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const21(k = 70 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-610, 246}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate6 annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-780, 720})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate7 annotation (
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-938, 720})));
    Modelica.Blocks.Math.Max max annotation (
      Placement(transformation(extent = {{-1400, -64}, {-1380, -44}})));
    Modelica.Blocks.Sources.Constant const17(k = 0) annotation (
      Placement(visible = true, transformation(origin = {-832, 788}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate8 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-480, 710})));
    Modelica.Blocks.Math.Max max1 annotation (
      Placement(transformation(extent = {{-640, 370}, {-620, 390}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate9 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-480, 366})));
    Modelica.Blocks.Math.Min min annotation (
      Placement(transformation(extent = {{-700, 376}, {-680, 396}})));
    Modelica.Blocks.Sources.Constant const1(k=1)         annotation (
      Placement(visible = true, transformation(origin = {-730, 410}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF1(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-540, 535}, extent = {{-15, -4}, {15, 4}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF2(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-570, 545}, extent = {{-15, -4}, {15, 4}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF3(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-540, 441}, extent = {{-15, -4}, {15, 4}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF4(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-570, 447}, extent = {{-15, -4}, {15, 4}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF6(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-82.5, 379.5}, extent = {{-14.5, -10.5}, {14.5, 10.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF5(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-106.5, 439.5}, extent = {{14.5, -10.5}, {-14.5, 10.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF7(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-90.5, 779.5}, extent = {{14.5, -10.5}, {-14.5, 10.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF8(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-68.5, 739.5}, extent = {{-14.5, -10.5}, {14.5, 10.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF9(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-480, 470}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF10(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-480, 332}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF11(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-480, 190}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF12(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-480, 266}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF13(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-500.5, 240.5}, extent = {{-4.5, -11.5}, {4.5, 11.5}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF14(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-520, 264}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF15(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-520, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF16(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-520, 330}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF17(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-250, 440}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF18(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-250, 380}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF19(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-350, 600}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF20(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-352, 540}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF21(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-240, 710}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF22(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-220, 684}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF23(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-480, 650}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF24(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-570, 760}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF25(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-650, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF26(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-730, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF27(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-710, 760}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF28(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-794, 760}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF29(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-818, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF30(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-896, 760}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF31(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-910, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF32(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-970, 720}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF33(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-840, 670}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF34(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-880, 670}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF35(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-1008, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF36(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-1110, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF37(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-1102, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF38(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-1190, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF39(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-1290, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.HeatExchangers.DHWHeatExchanger dHWHeatExchanger(A_HE = 2000, k_HE = 10000000000, m_heater = 0.1, m_DHW = 0.1) annotation (
      Placement(transformation(extent = {{9, 10}, {-9, -10}}, rotation = 180, origin = {-555, 490})));
    Modelica.Blocks.Sources.Constant const4(k = 0) annotation (
      Placement(visible = true, transformation(origin = {-690, 570}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Max max2 annotation (
      Placement(transformation(extent = {{-640, 590}, {-620, 610}})));
    Modelica.Blocks.Math.Min min1 annotation (
      Placement(transformation(extent = {{-700, 596}, {-680, 616}})));
    Modelica.Blocks.Sources.Constant const20(k=1)         annotation (
      Placement(visible = true, transformation(origin = {-730, 630}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF40(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1000, 664}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF41(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1000, 510}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF42(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1040, 530}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF43(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1070, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF44(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1230, 630}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF45(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1198, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF46(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1270, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF47(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1336, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF48(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1410, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF49(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-1512, 560}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF50(selectable = false, length = 0.1) annotation (
      Placement(visible = true, transformation(origin = {-1494, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF51(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1430, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF52(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1270, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF53(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1190, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF54(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1090, 660}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF55(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1040, 710}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF56(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1150, 780}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF57(selectable = false, length = 0.01) annotation (
      Placement(visible = true, transformation(origin = {-1130, 840}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_boiler_0_1 annotation (
      Placement(transformation(extent = {{-1640, -20}, {-1600, 20}})));
    Modelica.Blocks.Interfaces.RealInput u_heatpump_0_1 annotation (
      Placement(transformation(extent = {{-1640, 480}, {-1600, 520}})));
    Modelica.Blocks.Interfaces.RealInput u_7202_NS annotation (
      Placement(transformation(extent = {{-1640, 360}, {-1600, 400}})));
    Modelica.Blocks.Interfaces.RealInput u_7102_NS annotation (
      Placement(transformation(extent = {{-1640, 410}, {-1600, 450}})));
    Components.RealOutput_JW y_5303_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_5303_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-1228, -136}, {-1240, -124}})));
    Components.RealOutput_JW y_5310_FRC = massFlowRate_5310_FRC.dotm * 3600 / 1000 annotation (
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-1050, -126})));
    Components.RealOutput_JW y_5312_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_5312_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-976, -134}, {-988, -122}})));
    Components.RealOutput_JW y_5311_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_5311_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 180, origin = {-1030, -92})));
    Components.RealOutput_JW y_5202_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = boiler.boilerFluid.enthalpyPort_a.T - 273.15 annotation (
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-1358, -80})));
    Q100_DistrictModel.Components.RealOutput_JW y_5201_FQ = boiler.enthalpyPort_a1.m_flow * 3600 / 1000 annotation (
      Placement(visible = true, transformation(origin = {-1358, -94}, extent={{-6,6},{
              6,-6}},                                                                              rotation = 180), iconTransformation(extent = {{-6, -6}, {6, 6}}, rotation = 180)));
    Components.RealOutput_JW y_2202_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2202_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-1374, 566}, {-1386, 578}})));
    Components.RealOutput_JW y_2204_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2204_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-1350, 668}, {-1362, 680}})));
    Components.RealOutput_JW y_2213_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2213_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-1174, 568}, {-1186, 580}})));
    Components.RealOutput_JW y_2216_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2216_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-1106, 568}, {-1118, 580}})));
    Components.RealOutput_JW y_2215_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_2215_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 180, origin = {-1130, 648})));
    Components.RealOutput_JW y_2214_FRC = massFlowRate_2214_FRC.dotm * 3600 / 1000 annotation (
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-1142, 574})));
    Components.RealOutput_JW y_8102_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8102_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-694, 726}, {-706, 738}})));
    Components.RealOutput_JW y_8101_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8101_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 180, origin = {-656, 750})));
    Components.RealOutput_JW y_7103_FRC_unload = massFlowRate_7103_FRC_unload.dotm * 3600 / 1000 annotation (
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-262, 660})));
    Components.RealOutput_JW y_7103_FRC_load = massFlowRate_7103_FRC_load.dotm * 3600 / 1000 annotation (
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 180, origin = {-198, 638})));
    Components.RealOutput_JW y_7103_FRC = (massFlowRate_7103_FRC_load.dotm + massFlowRate_7103_FRC_unload.dotm) * 3600 / 1000 annotation (
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-260, 634})));
    Components.RealOutput_JW y_7104_TRC_unload(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_7104_TRC_unload.T - 273.15 annotation (
      Placement(transformation(extent = {{-226, 786}, {-238, 798}})));
    Components.RealOutput_JW y_7104_TRC_load(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_7104_TRC_load.T - 273.15 annotation (
      Placement(transformation(extent = {{-204, 746}, {-216, 758}})));
    Components.RealOutput_JW y_7203_TRC_load(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_7203_TRC_load.T - 273.15 annotation (
      Placement(transformation(extent = {{-184, 446}, {-196, 458}})));
    Components.RealOutput_JW y_7203_TRC_unload(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_7203_TRC_unload.T - 273.15 annotation (
      Placement(transformation(extent = {{-162, 386}, {-174, 398}})));
    Components.RealOutput_JW y_7302_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[8] - 273.15 annotation (
      Placement(transformation(extent = {{140, 634}, {152, 646}})));
    Q100_DistrictModel.Components.RealOutput_JW y_7303_TRC = heatStorageVariablePorts_central.T_layers[7] - 273.15 annotation (
      Placement(visible = true, transformation(extent = {{140, 614}, {152, 626}}, rotation = 0), iconTransformation(extent = {{140, 614}, {152, 626}}, rotation = 0)));
    Components.RealOutput_JW y_7304_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[6] - 273.15 annotation (
      Placement(transformation(extent = {{140, 594}, {152, 606}})));
    Components.RealOutput_JW y_7305_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[5] - 273.15 annotation (
      Placement(transformation(extent = {{140, 574}, {152, 586}})));
    Components.RealOutput_JW y_7306_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[4] - 273.15 annotation (
      Placement(transformation(extent = {{140, 554}, {152, 566}})));
    Components.RealOutput_JW y_7307_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[3] - 273.15 annotation (
      Placement(transformation(extent = {{140, 534}, {152, 546}})));
    Components.RealOutput_JW y_7308_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[2] - 273.15 annotation (
      Placement(transformation(extent = {{140, 514}, {152, 526}})));
    Components.RealOutput_JW y_7309_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = heatStorageVariablePorts_central.T_layers[1] - 273.15 annotation (
      Placement(transformation(extent = {{140, 494}, {152, 506}})));
    Components.RealOutput_JW y_8104_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8104_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-492, 302}, {-504, 314}})));
    Components.RealOutput_JW y_8103_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8103_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-540, 284}, {-552, 296}})));
    Components.RealOutput_JW y_8206_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8206_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{12, 106}, {0, 118}})));
    Components.RealOutput_JW y_8205_TRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = temperature_8205_TRC.T - 273.15 annotation (
      Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 180, origin = {-10, 148})));
    Components.RealOutput_JW y_8204_FRC(final quantity = "ThermodynamicTemperature", final unit = "degC", displayUnit = "degC", min = 0) = massFlowRate_8204_FRC.dotm * 3600 / 1000 annotation (
      Placement(transformation(extent = {{6, -6}, {-6, 6}}, rotation = 0, origin = {-34, 114})));
    Modelica.Blocks.Math.Add add1(k1 = -1) annotation (
      Placement(transformation(extent = {{-80, 34}, {-60, 54}})));
    Modelica.Blocks.Math.Gain gain(k = 4187 / 1000 / 3.6) annotation (
      Placement(transformation(extent = {{0, 40}, {20, 60}})));
    Modelica.Blocks.Math.Product product annotation (
      Placement(transformation(extent = {{-40, 40}, {-20, 60}})));
    Components.RealOutput_JW y_WMZ_heatingGrid annotation (
      Placement(transformation(extent = {{40, 44}, {52, 56}})));
    Components.RealOutput_JW y_WMZ_Houses = sink.Load / 1000 annotation (
      Placement(transformation(extent = {{834, 534}, {846, 546}})));
    Modelica.Blocks.Sources.Sine sineGeo_T_amb1(amplitude = 15, freqHz = 1 / (3600 * 24 * 365 * 2), offset = 3 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-1570, 664}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Switch switch_2102_ZA annotation (
      Placement(visible = true, transformation(origin = {-1466, 520}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
    Modelica.Blocks.Sources.Constant const5(k = 0) annotation (
      Placement(visible = true, transformation(origin = {-1430, 500}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Hysteresis hysteresis(uLow = -77, uHigh = -72, pre_y_start = true) annotation (
      Placement(visible = true, transformation(extent = {{-1390, 460}, {-1410, 480}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain3(k = -1) annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {-1380, 510})));
    Modelica.Blocks.Math.Gain gain4(k = 1000) annotation (
      Placement(visible = true, transformation(origin = {-1276, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.BooleanOutput_JW y_5203_OA = boiler.onOff_boiler annotation (
      Placement(visible = true, transformation(origin = {-1358, -110}, extent = {{6, -6}, {-6, 6}}, rotation = 0), iconTransformation(origin = {-1362, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.BooleanOutput_JW y_5204_ZA = logicalSwitch_5204_ZA.u2 annotation (
      Placement(visible = true, transformation(origin = {-1358, -124}, extent = {{6, -6}, {-6, 6}}, rotation = 0), iconTransformation(origin = {-1352, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.LogicalSwitch logicalSwitch_5204_ZA annotation (
      Placement(visible = true, transformation(origin = {-1322, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation (
      Placement(visible = true, transformation(origin = {-1350, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k = false) annotation (
      Placement(visible = true, transformation(origin = {-1290, -10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.BooleanOutput_JW y_2102_ZA = switch_2102_ZA.u2 annotation (
      Placement(visible = true, transformation(origin = {-1450, 616}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-1342, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Not not1 annotation (
      Placement(visible = true, transformation(origin = {-1430, 470}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold_2101_OA annotation (
      Placement(visible = true, transformation(origin = {-1440, 540}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Q100_DistrictModel.Components.BooleanOutput_JW y_2101_OA = greaterThreshold_2101_OA.y annotation (
      Placement(visible = true, transformation(origin = {-1450, 624}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-1332, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain5(k = 1000) annotation (
      Placement(visible = true, transformation(origin = {-1330, 620}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
    Modelica.Blocks.Interfaces.BooleanInput u_Stoerung_Tino_boiler annotation (
      Placement(transformation(extent = {{-1640, 20}, {-1600, 60}})));
    Modelica.Blocks.Interfaces.BooleanInput u_Stoerung_Tino_heatpump annotation (
      Placement(transformation(extent = {{-1640, 440}, {-1600, 480}})));
    Modelica.Blocks.Logical.Or or1 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-1466, 484})));
    Modelica.Blocks.Interfaces.RealInput u_loadProfile_kW
      annotation (Placement(transformation(extent={{-1640,970},{-1600,1010}})));
    Modelica.Blocks.Math.Gain gain8(k = 1) annotation (
      Placement(visible = true, transformation(origin = {-1570, 990}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add5 annotation (
      Placement(transformation(extent = {{-1380, 590}, {-1360, 610}})));
    Modelica.Blocks.Continuous.LimPID PID(k = 0.01, Ti = 3600, yMax = 1, yMin = 0.01, initType = Modelica.Blocks.Types.InitPID.InitialOutput, y_start = 0.5) annotation (
      Placement(transformation(extent = {{-1180, 720}, {-1200, 740}})));
    Modelica.Blocks.Sources.Constant const18(k = 80 + 273.15) annotation (
      Placement(visible = true, transformation(origin = {-1170, 700}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Components.calc_mdot_consumer calc_mdot_consumer annotation (
      Placement(transformation(extent = {{-280, 200}, {-300, 220}})));
    Modelica.Blocks.Sources.Constant const22(k = 20) annotation (
      Placement(visible = true, transformation(origin = {-198, 224}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add6(k1 = -1) annotation (
      Placement(transformation(extent = {{-240, 206}, {-260, 226}})));
    AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate_4516_FRC
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-1180,180})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4517_TRC
      annotation (Placement(visible=true, transformation(
          origin={-1160,240},
          extent={{-10,10},{10,-10}},
          rotation=0)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4518_TRC
      annotation (Placement(visible=true, transformation(
          origin={-1108,180},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF58(
        selectable=false, length=0.1)                                                                                  annotation (
      Placement(visible = true, transformation(origin={-1148,180},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Components.RealOutput_JW y_4516_FRC=massFlowRate_4516_FRC.dotm*3600/1000
      annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-1190,194})));
    Components.RealOutput_JW y_4518_TRC(
      final quantity="ThermodynamicTemperature",
      final unit="degC",
      displayUnit="degC",
      min=0)=temperature_4518_TRC.T - 273.15
      annotation (Placement(transformation(extent={{-1116,186},{-1128,198}})));
    Components.RealOutput_JW y_4517_TRC(
      final quantity="ThermodynamicTemperature",
      final unit="degC",
      displayUnit="degC",
      min=0)=temperature_4517_TRC.T - 273.15 annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={-1170,228})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4515_TRC
      annotation (Placement(visible=true, transformation(
          origin={-1248,180},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    Components.RealOutput_JW y_4515_TRC(
      final quantity="ThermodynamicTemperature",
      final unit="degC",
      displayUnit="degC",
      min=0)=temperature_4515_TRC.T - 273.15
      annotation (Placement(transformation(extent={{-1256,186},{-1268,198}})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF59(
        selectable=false, length=0.1)                                                                                  annotation (
      Placement(visible = true, transformation(origin={-1216,180},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-1320,180})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF60(
        selectable=false, length=0.1)                                                                                  annotation (
      Placement(visible = true, transformation(origin={-1290,180},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n=2)
      annotation (Placement(transformation(extent={{-1320,230},{-1300,250}})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF61(
        selectable=false, length=0.1)                                                                                  annotation (
      Placement(visible = true, transformation(origin={-1250,240},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF62(
        selectable=false, length=0.1)                                                                                  annotation (
      Placement(visible = true, transformation(origin={-1320,210},     extent = {{-10, -10}, {10, 10}}, rotation=90)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_4507_up annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-1410,180})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF63(
        selectable=false, length=0.1)                                                                                  annotation (
      Placement(visible = true, transformation(origin={-1348,180},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4504_TRC
      annotation (Placement(visible=true, transformation(
          origin={-1446,180},
          extent={{10,-10},{-10,10}},
          rotation=0)));
    Components.RealOutput_JW y_4504_TRC(
      final quantity="ThermodynamicTemperature",
      final unit="degC",
      displayUnit="degC",
      min=0)=temperature_4504_TRC.T - 273.15
      annotation (Placement(transformation(extent={{-1454,186},{-1466,198}})));
    Components.RealOutput_JW y_4506_TRC(
      final quantity="ThermodynamicTemperature",
      final unit="degC",
      displayUnit="degC",
      min=0)=temperature_4506_TRC.T - 273.15 annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={-1388,228})));
    AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature_4506_TRC
      annotation (Placement(visible=true, transformation(
          origin={-1378,240},
          extent={{-10,10},{10,-10}},
          rotation=0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF64(
        selectable=false, length=0.1)                                                                                  annotation (
      Placement(visible = true, transformation(origin={-1350,240},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
    AixLib.FastHVAC.Components.HeatGenerators.CHP.CHP_PT1 CHP(
      selectable=false,
      eta_el=0.38095,
      eta_th=0.55238,
      capP_el=400000)
      annotation (Placement(transformation(extent={{-1550,200},{-1530,220}})));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF66(
        selectable=false, length=0.1)                                                                                  annotation (
      Placement(visible = true, transformation(origin={-1510,180},     extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe_HeatStorage_unload_FF67(
        selectable=false, length=0.1)                                                                                  annotation (
      Placement(visible = true, transformation(origin={-1406,240},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
    Modelica.Blocks.Logical.Not not2 annotation (
      Placement(visible = true, transformation(origin={-1510,460},    extent={{-10,-10},
              {10,10}},                                                                                rotation = 0)));
    Modelica.Blocks.Logical.Not not3 annotation (
      Placement(visible = true, transformation(origin={-1350,40},     extent={{-10,-10},
              {10,10}},                                                                                rotation = 0)));
    Modelica.Blocks.Math.Gain gain1(k=-1)   annotation (
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation=90,    origin={-1460,
              270})));
    Modelica.Blocks.Logical.Hysteresis hysteresis1(
      uLow=-85,
      uHigh=-80,
      pre_y_start=true)                                                                        annotation (
      Placement(visible = true, transformation(extent={{-1470,320},{-1490,340}},      rotation = 0)));
    Modelica.Blocks.Logical.Not not4 annotation (
      Placement(visible = true, transformation(origin={-1510,330},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant const8(k=0)   annotation (
      Placement(visible = true, transformation(origin={-1500,290},    extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.Or or2 annotation (
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation=270,  origin={-1534,
              310})));
    Modelica.Blocks.Logical.Switch switch_4202_ZA annotation (Placement(visible=true,
          transformation(
          origin={-1534,270},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Blocks.Logical.Not not5 annotation (
      Placement(visible = true, transformation(origin={-1570,330},    extent={{-10,-10},
              {10,10}},                                                                                rotation = 0)));
    Modelica.Blocks.Interfaces.BooleanInput u_Stoerung_Tino_CHP
      annotation (Placement(transformation(extent={{-1640,310},{-1600,350}})));
    Modelica.Blocks.Interfaces.RealInput u_CHP_0_1
      annotation (Placement(transformation(extent={{-1640,270},{-1600,310}})));
    Modelica.Blocks.Math.RealToBoolean realToBoolean annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-1560,240})));
    Components.calc_mdot_production calc_mdot_production2
                                                         annotation (
      Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 180, origin={-1430,
              210})));
    Modelica.Blocks.Sources.Constant const15(k=95 + 273.15)  annotation (
      Placement(visible = true, transformation(origin={-1490,216},     extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Components.BooleanOutput_JW y_4202_ZA=switch_4202_ZA.u2 annotation (
        Placement(
        visible=true,
        transformation(
          origin={-1580,182},
          extent={{6,-6},{-6,6}},
          rotation=0),
        iconTransformation(
          origin={-1352,-10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Components.BooleanOutput_JW y_4201_OA=CHP.onOff annotation (
        Placement(
        visible=true,
        transformation(
          origin={-1580,196},
          extent={{6,-6},{-6,6}},
          rotation=0),
        iconTransformation(
          origin={-1362,-20},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    Components.RealOutput_JW y_4203_FQ=CHP.enthalpyPort_a.m_flow*3600/1000
      annotation (Placement(
        visible=true,
        transformation(
          origin={-1580,212},
          extent={{-6,6},{6,-6}},
          rotation=180),
        iconTransformation(extent={{-6,-6},{6,6}}, rotation=180)));
    Components.calc_valve calc_valve1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-1290,138})));
    Modelica.Blocks.Sources.Constant const23(k=90)           annotation (
      Placement(visible = true, transformation(origin={-1250,132},     extent={{10,-10},
              {-10,10}},                                                                                rotation = 0)));
    Components.RealOutput_JW y_CHP_dotQ=CHP.Capacity[2]/1000 annotation (
        Placement(
        visible=true,
        transformation(extent={{-1540,184},{-1532,192}}, rotation=0),
        iconTransformation(extent={{-1312,28},{-1304,36}}, rotation=0)));
  equation
    connect(dynamicPipe_HeatGrid_RF.enthalpyPort_b1, dynamicPipe_HeatStorage_unload_RF.enthalpyPort_a1) annotation (
      Line(points = {{380.2, 100}, {179.8, 100}}, color = {0, 128, 255}));
    connect(temperature_HeatGrid_FF.enthalpyPort_b, dynamicPipe_HeatGrid_FF.enthalpyPort_a1) annotation (
      Line(points = {{319, 160.1}, {350.2, 160.1}, {350.2, 160}, {380.2, 160}}, color = {176, 0, 0}));
    connect(prescribedTemperature.port, dynamicPipe_HeatGrid_RF.heatPort_outside) annotation (
      Line(points = {{360, 138}, {398, 138}, {398, 105.2}, {398.8, 105.2}}, color = {191, 0, 0}));
    connect(prescribedTemperature.port, dynamicPipe_HeatGrid_FF.heatPort_outside) annotation (
      Line(points = {{360, 138}, {382, 138}, {382, 154.8}, {381.2, 154.8}}, color = {191, 0, 0}));
    connect(prescribedTemperature.T, sineGeo_T_amb.y) annotation (
      Line(points = {{338, 138}, {278, 138}, {278, 140}, {101, 140}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.out, fixedTemperature.port) annotation (
      Line(points = {{79.2, 681.6}, {121.6, 681.6}, {121.6, 680}, {166, 680}}, color = {191, 0, 0}));
    connect(const2.y, fluidSource1.T_fluid) annotation (
      Line(points = {{-1259, 850}, {-1248, 850}, {-1248, 842}, {-1178, 842}, {-1178, 842.2}}, color = {0, 0, 127}));
    connect(vessel1.enthalpyPort_a, massFlowRate1.enthalpyPort_b) annotation (
      Line(points = {{-1219, 780}, {-1212, 780}, {-1212, 779.9}, {-1207, 779.9}}, color = {0, 128, 255}));
    connect(fluidSource1.dotm, massFlowRate1.dotm) annotation (
      Line(points = {{-1178, 835.4}, {-1199, 835.4}, {-1199, 789}}, color = {0, 0, 127}));
    connect(const6.y, threeWayValve3.opening) annotation (
      Line(points = {{-985, 800}, {-1000, 800}, {-1000, 729}}, color = {0, 0, 127}));
    connect(threeWayValve4.opening, const7.y) annotation (
      Line(points = {{-991, 560}, {-981, 560}}, color = {0, 0, 127}));
    connect(massFlowRate_2214_FRC.enthalpyPort_a, temperature_2216_TRC.enthalpyPort_b) annotation (
      Line(points = {{-1123.2, 559.9}, {-1109, 559.9}}, color = {0, 128, 255}));
    connect(temperature_2213_TRC.enthalpyPort_a, massFlowRate_2214_FRC.enthalpyPort_b) annotation (
      Line(points = {{-1159.2, 559.9}, {-1141, 559.9}}, color = {0, 128, 255}));
    connect(booleanConstant.y, heatPump.modeSet) annotation (
      Line(points={{-1499,540},{-1470,540},{-1470,542},{-1470.1,542},{-1470.1,
            616.08}},                                                                              color = {255, 0, 255}));
    connect(const10.y, heatPump.iceFac_in) annotation (
      Line(points={{-1499,622},{-1492,622},{-1492,620.88},{-1483.87,620.88}},          color = {0, 0, 127}));
    connect(const11.y, fluidSource3.dotm) annotation (
      Line(points = {{-1559, 630}, {-1550, 630}, {-1550, 657.4}, {-1538, 657.4}}, color = {0, 0, 127}));
    connect(pump_8113_NP.enthalpyPort_b, temperature_8205_TRC.enthalpyPort_a) annotation (
      Line(points = {{-310.4, 160}, {-160, 160}, {-160, 160.1}, {-8.8, 160.1}}, color = {176, 0, 0}));
    connect(massFlowRate_8204_FRC.enthalpyPort_a, temperature_8206_TRC.enthalpyPort_b) annotation (
      Line(points = {{-11.2, 99.9}, {11, 99.9}}, color = {0, 128, 255}));
    connect(threeWayValve_NS_1.enthalpyPort_ab, massFlowRate_8204_FRC.enthalpyPort_b) annotation (
      Line(points = {{-170.2, 100}, {-100, 100}, {-100, 99.9}, {-29, 99.9}}, color = {0, 128, 255}));
    connect(threeWayValve_NS_1.enthalpyPort_b, temperature_8301_TRC.enthalpyPort_a) annotation (
      Line(points = {{-180, 90}, {-180, 48.8}, {-180.1, 48.8}}, color = {0, 128, 255}));
    connect(manifold_NS_1.enthalpyPort_a[2], temperature_8302_TRC.enthalpyPort_b) annotation (
      Line(points = {{-240, 100.5}, {-240, 69}, {-240.1, 69}}, color = {0, 128, 255}));
    connect(manifold_NS_1.enthalpyPort_a[1], threeWayValve_NS_1.enthalpyPort_a) annotation (
      Line(points = {{-240, 99.5}, {-216, 99.5}, {-216, 100}, {-190, 100}}, color = {0, 128, 255}));
    connect(temperature_8302_TRC.enthalpyPort_a, fluidSource4.enthalpyPort_b) annotation (
      Line(points = {{-240.1, 51.2}, {-240.1, 43.6}, {-239, 43.6}, {-239, 18}}, color = {0, 128, 255}));
    connect(const12.y, fluidSource4.T_fluid) annotation (
      Line(points = {{-259, -12}, {-242.2, -12}, {-242.2, 0}}, color = {0, 0, 127}));
    connect(const13.y, threeWayValve_NS_1.opening) annotation (
      Line(points = {{-161, 120}, {-180, 120}, {-180, 109}}, color = {0, 0, 127}));
    connect(massFlowRate3.enthalpyPort_b, vessel4.enthalpyPort_a) annotation (
      Line(points = {{-179.9, -27}, {-179.9, -33.5}, {-180, -33.5}, {-180, -39}}, color = {0, 128, 255}));
    connect(temperature_8301_TRC.enthalpyPort_b, massFlowRate3.enthalpyPort_a) annotation (
      Line(points = {{-180.1, 31}, {-180.1, 10.5}, {-179.9, 10.5}, {-179.9, -9.2}}, color = {0, 128, 255}));
    connect(massFlowRate3.dotm, fluidSource4.dotm) annotation (
      Line(points = {{-189, -19}, {-235.4, -19}, {-235.4, 0}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF.enthalpyPort_b1, temperature_HeatGrid_FF.enthalpyPort_a) annotation (
      Line(points = {{179.8, 160}, {240, 160}, {240, 160.1}, {301.2, 160.1}}, color = {176, 0, 0}));
    connect(temperature_8205_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF.enthalpyPort_a1) annotation (
      Line(points = {{9, 160.1}, {84.5, 160.1}, {84.5, 160}, {160.2, 160}}, color = {176, 0, 0}));
    connect(temperature_8206_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_RF.enthalpyPort_b1) annotation (
      Line(points = {{28.8, 99.9}, {94.4, 99.9}, {94.4, 100}, {160.2, 100}}, color = {0, 128, 255}));
    connect(calc_mdot_production.y_mdot, pump_5304_UP.dotm_setValue) annotation (
      Line(points = {{-1179, -110}, {-1160, -110}, {-1160, -132}}, color = {0, 0, 127}));
    connect(calc_mdot_production.u_TemperatureInput, temperature_5303_TRC.T) annotation (
      Line(points = {{-1202, -116}, {-1219, -116}, {-1219, -129}}, color = {0, 0, 127}));
    connect(const3.y, calc_mdot_production.u_TemperatureOutput) annotation (
      Line(points = {{-1229, -104}, {-1216, -104}, {-1216, -104.2}, {-1202, -104.2}}, color = {0, 0, 127}));
    connect(const9.y, calc_Qdot.u_deltaT_setpoint) annotation (
      Line(points = {{-1439, -30}, {-1430, -30}, {-1430, -48}}, color = {0, 0, 127}));
    connect(const14.y, calc_Qdot.u_T_setpoint) annotation (
      Line(points = {{-1479, -80}, {-1462, -80}, {-1462, -66}, {-1442, -66}}, color = {0, 0, 127}));
    connect(calc_mdot_production1.u_TemperatureInput, temperature_2202_TRC.T) annotation (
      Line(points = {{-1342, 584}, {-1368, 584}, {-1368, 571}, {-1369, 571}}, color = {0, 0, 127}));
    connect(calc_mdot_production1.y_mdot, pump_2205_UP.dotm_setValue) annotation (
      Line(points = {{-1319, 590}, {-1300, 590}, {-1300, 568}}, color = {0, 0, 127}));
    connect(TemperatureInput.enthalpyPort_b, sink.enthalpyPort_a1) annotation (
      Line(points = {{729, 519.9}, {814.5, 519.9}, {814.5, 520}, {809.2, 520}}, color = {176, 0, 0}));
    connect(sink.enthalpyPort_b1, TemperatureOutput.enthalpyPort_a) annotation (
      Line(points = {{830.8, 520}, {850, 520}, {850, 519.9}, {871.2, 519.9}}, color = {176, 0, 0}));
    connect(gain2.y, sink.Load) annotation (
      Line(points = {{820, 579}, {820, 530.68}, {819.88, 530.68}}, color = {0, 0, 127}));
    connect(TemperatureOutput.enthalpyPort_b, dynamicPipe_HeatGrid_RF.enthalpyPort_a1) annotation (
      Line(points = {{889, 519.9}, {900, 519.9}, {900, 460}, {680, 460}, {680, 100}, {399.8, 100}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatGrid_FF.enthalpyPort_b1, TemperatureInput.enthalpyPort_a) annotation (
      Line(points = {{399.8, 160}, {620, 160}, {620, 519.9}, {711.2, 519.9}}, color = {176, 0, 0}));
    connect(manifold3.enthalpyPort_b, massFlowRate5.enthalpyPort_a) annotation (
      Line(points = {{-1020, 760}, {-970, 760}, {-970, 759.9}, {-948.8, 759.9}}, color = {176, 0, 0}));
    connect(calc_Qdot.u_T_measurement, temperature_8104_TRC.T) annotation (
      Line(points = {{-1442, -54.2}, {-1520, -54.2}, {-1520, -180}, {-860, -180}, {-860, 302}, {-670, 302}, {-670, 301}, {-491, 301}}, color = {0, 0, 127}));
    connect(calc_valve.u_T_source_input, temperature_8104_TRC.T) annotation (
      Line(points = {{-568, 252}, {-568, 301}, {-491, 301}}, color = {0, 0, 127}));
    connect(calc_valve.u_T_consumer_input, const21.y) annotation (
      Line(points = {{-580, 245.8}, {-590, 245.8}, {-590, 246}, {-599, 246}}, color = {0, 0, 127}));
    connect(massFlowRate6.dotm, calc_valve_ratio.u_dotm_in) annotation (
      Line(points = {{-781, 729}, {-781, 812}, {-910, 812}}, color = {0, 0, 127}));
    connect(massFlowRate5.dotm, calc_valve_ratio.u_dotm_out) annotation (
      Line(points = {{-939, 769}, {-910, 769}, {-910, 788}}, color = {0, 0, 127}));
    connect(calc_valve.u_T_consumer_output, temperature_8206_TRC.T) annotation (
      Line(points = {{-580, 234}, {-588, 234}, {-588, 140}, {19, 140}, {19, 111}}, color = {0, 0, 127}));
    connect(calc_Qdot.y_Qdot, max.u2) annotation (
      Line(points = {{-1419, -60}, {-1402, -60}}, color = {0, 0, 127}));
    connect(max.y, boiler.dotQ_rel) annotation (
      Line(points = {{-1379, -54}, {-1334.83, -54}, {-1334.83, -83.17}}, color = {0, 0, 127}));
    connect(max1.y, threeWayValve_NS_7202_2.opening) annotation (
      Line(points = {{-619, 380}, {-529, 380}}, color = {0, 0, 127}));
    connect(const16.y, max1.u2) annotation (
      Line(points = {{-679, 350}, {-662, 350}, {-662, 374}, {-642, 374}}, color = {0, 0, 127}));
    connect(calc_valve_ratio.y_valve, threeWayValve2.opening) annotation (
      Line(points = {{-899, 800}, {-880, 800}, {-880, 729}}, color = {0, 0, 127}));
    connect(min.y, max1.u1) annotation (
      Line(points = {{-679, 386}, {-642, 386}}, color = {0, 0, 127}));
    connect(const1.y, min.u1) annotation (
      Line(points = {{-719, 410}, {-710, 410}, {-710, 392}, {-702, 392}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF2.enthalpyPort_a1, threeWayValve_NS_7102_1.enthalpyPort_a) annotation (
      Line(points = {{-570, 559.7}, {-570, 564}, {-480, 564}, {-480, 590}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF3.enthalpyPort_a1, threeWayValve_NS_7202_2.enthalpyPort_a) annotation (
      Line(points = {{-540, 426.3}, {-540, 416}, {-520, 416}, {-520, 390}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF4.enthalpyPort_b1, manifold_NS_7202_1.enthalpyPort_a[1]) annotation (
      Line(points = {{-570, 432.3}, {-570, 420}, {-519.5, 420}, {-519.5, 440}}, color = {0, 128, 255}));
    connect(temperature_7203_TRC_unload.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF6.enthalpyPort_a1) annotation (
      Line(points = {{-151, 379.9}, {-123.5, 379.9}, {-123.5, 379.5}, {-96.71, 379.5}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF6.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation (
      Line(points = {{-68.29, 379.5}, {38.4, 379.5}, {38.4, 462}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF5.enthalpyPort_b1, temperature_7203_TRC_load.enthalpyPort_a) annotation (
      Line(points = {{-120.71, 439.5}, {-144.355, 439.5}, {-144.355, 439.9}, {-169.2, 439.9}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF5.enthalpyPort_a1, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation (
      Line(points = {{-92.29, 439.5}, {-2.4, 439.5}, {-2.4, 462}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF8.enthalpyPort_b1, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation (
      Line(points = {{-54.29, 739.5}, {-2.4, 739.5}, {-2.4, 706}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF7.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation (
      Line(points = {{-76.29, 779.5}, {38.4, 779.5}, {38.4, 706}}, color = {176, 0, 0}));
    connect(temperature_7104_TRC_load.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF8.enthalpyPort_a1) annotation (
      Line(points = {{-193, 739.9}, {-137.5, 739.9}, {-137.5, 739.5}, {-82.71, 739.5}}, color = {176, 0, 0}));
    connect(temperature_7104_TRC_unload.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF7.enthalpyPort_b1) annotation (
      Line(points = {{-211.2, 779.9}, {-158.6, 779.9}, {-158.6, 779.5}, {-104.71, 779.5}}, color = {176, 0, 0}));
    connect(manifold_NS_7102_2.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF9.enthalpyPort_a1) annotation (
      Line(points = {{-480, 520}, {-480, 479.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF9.enthalpyPort_b1, massFlowRate9.enthalpyPort_a) annotation (
      Line(points = {{-480, 460.2}, {-480, 444.4}, {-480.1, 444.4}, {-480.1, 374.8}}, color = {176, 0, 0}));
    connect(massFlowRate9.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF10.enthalpyPort_a1) annotation (
      Line(points = {{-480.1, 357}, {-480.1, 349.4}, {-480, 349.4}, {-480, 341.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF10.enthalpyPort_b1, temperature_8104_TRC.enthalpyPort_a) annotation (
      Line(points = {{-480, 322.2}, {-480.1, 310.8}, {-479.9, 310.8}}, color = {176, 0, 0}));
    connect(pump_8113_NP.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF11.enthalpyPort_b1) annotation (
      Line(points = {{-329.6, 160}, {-480, 160}, {-480, 180.2}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF11.enthalpyPort_a1, manifold_NS_8106.enthalpyPort_b) annotation (
      Line(points = {{-480, 199.8}, {-480, 220}}, color = {176, 0, 0}));
    connect(temperature_8104_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF12.enthalpyPort_a1) annotation (
      Line(points = {{-479.9, 293}, {-479.9, 284.5}, {-480, 284.5}, {-480, 275.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF12.enthalpyPort_b1, manifold_NS_8106.enthalpyPort_a[1]) annotation (
      Line(points = {{-480, 256.2}, {-480, 240}, {-479.5, 240}}, color = {176, 0, 0}));
    connect(threeWayValve_NS_8106.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF13.enthalpyPort_a1) annotation (
      Line(points = {{-510, 240}, {-508, 240}, {-508, 240.5}, {-504.91, 240.5}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF13.enthalpyPort_b1, manifold_NS_8106.enthalpyPort_a[2]) annotation (
      Line(points = {{-496.09, 240.5}, {-488.045, 240.5}, {-488.045, 240}, {-480.5, 240}}, color = {0, 128, 255}));
    connect(temperature_8103_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF14.enthalpyPort_b1) annotation (
      Line(points = {{-519.9, 279.2}, {-519.9, 276.6}, {-520, 276.6}, {-520, 273.8}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF14.enthalpyPort_a1, threeWayValve_NS_8106.enthalpyPort_a) annotation (
      Line(points = {{-520, 254.2}, {-520, 250}}, color = {0, 128, 255}));
    connect(manifold_NS_1.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF15.enthalpyPort_a1) annotation (
      Line(points = {{-260, 100}, {-520, 100}, {-520, 190.2}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF15.enthalpyPort_b1, threeWayValve_NS_8106.enthalpyPort_ab) annotation (
      Line(points = {{-520, 209.8}, {-520, 230.2}}, color = {0, 128, 255}));
    connect(threeWayValve_NS_7202_2.enthalpyPort_ab, dynamicPipe_HeatStorage_unload_FF16.enthalpyPort_b1) annotation (
      Line(points = {{-520, 370.2}, {-520, 339.8}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF16.enthalpyPort_a1, temperature_8103_TRC.enthalpyPort_b) annotation (
      Line(points = {{-520, 320.2}, {-520, 297}, {-519.9, 297}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF17.enthalpyPort_a1, temperature_7203_TRC_load.enthalpyPort_b) annotation (
      Line(points = {{-240.2, 440}, {-214, 440}, {-214, 439.9}, {-187, 439.9}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF17.enthalpyPort_b1, manifold_NS_7202_1.enthalpyPort_a[2]) annotation (
      Line(points = {{-259.8, 440}, {-520.5, 440}}, color = {0, 128, 255}));
    connect(temperature_7203_TRC_unload.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF18.enthalpyPort_b1) annotation (
      Line(points = {{-168.8, 379.9}, {-204.5, 379.9}, {-204.5, 380}, {-240.2, 380}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF18.enthalpyPort_a1, threeWayValve_NS_7202_2.enthalpyPort_b) annotation (
      Line(points = {{-259.8, 380}, {-349.4, 379.9}, {-349.4, 380}, {-510, 380}}, color = {0, 128, 255}));
    connect(threeWayValve_NS_7102_1.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF19.enthalpyPort_a1) annotation (
      Line(points = {{-470, 600}, {-359.8, 600}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF19.enthalpyPort_b1, massFlowRate_7103_FRC_load.enthalpyPort_a) annotation (
      Line(points = {{-340.2, 600}, {-220.1, 600}, {-220.1, 629.2}}, color = {176, 0, 0}));
    connect(manifold_NS_7102_2.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF20.enthalpyPort_b1) annotation (
      Line(points = {{-479.5, 540}, {-361.8, 540}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF20.enthalpyPort_a1, massFlowRate_7103_FRC_unload.enthalpyPort_b) annotation (
      Line(points = {{-342.2, 540}, {-239.9, 540}, {-239.9, 651}}, color = {176, 0, 0}));
    connect(massFlowRate8.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF23.enthalpyPort_a1) annotation (
      Line(points = {{-480.1, 701}, {-480.1, 680.5}, {-480, 680.5}, {-480, 659.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF23.enthalpyPort_b1, threeWayValve_NS_7102_1.enthalpyPort_ab) annotation (
      Line(points = {{-480, 640.2}, {-480, 609.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF24.enthalpyPort_b1, massFlowRate8.enthalpyPort_a) annotation (
      Line(points = {{-560.2, 760}, {-480.1, 760}, {-480.1, 718.8}}, color = {176, 0, 0}));
    connect(temperature_8101_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF24.enthalpyPort_a1) annotation (
      Line(points = {{-659, 760.1}, {-656, 760.1}, {-656, 760}, {-579.8, 760}}, color = {176, 0, 0}));
    connect(temperature_8102_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF25.enthalpyPort_b1) annotation (
      Line(points = {{-679.2, 719.9}, {-668, 719.9}, {-668, 720}, {-659.8, 720}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF25.enthalpyPort_a1, manifold_NS_7202_1.enthalpyPort_b) annotation (
      Line(points = {{-640.2, 720}, {-520, 719.9}, {-520, 460}}, color = {0, 128, 255}));
    connect(massFlowRate6.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF26.enthalpyPort_b1) annotation (
      Line(points = {{-771.2, 719.9}, {-762, 719.9}, {-762, 720}, {-739.8, 720}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF26.enthalpyPort_a1, temperature_8102_TRC.enthalpyPort_b) annotation (
      Line(points = {{-720.2, 720}, {-708.6, 720}, {-708.6, 719.9}, {-697, 719.9}}, color = {0, 128, 255}));
    connect(massFlowRate4.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF27.enthalpyPort_a1) annotation (
      Line(points = {{-741, 759.9}, {-730.5, 759.9}, {-730.5, 760.1}, {-719.8, 760}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF27.enthalpyPort_b1, temperature_8101_TRC.enthalpyPort_a) annotation (
      Line(points = {{-700.2, 760}, {-688.5, 760}, {-688.5, 760.1}, {-676.8, 760.1}}, color = {176, 0, 0}));
    connect(manifold2.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF28.enthalpyPort_a1) annotation (
      Line(points = {{-820, 760}, {-814, 760}, {-814, 759.9}, {-803.8, 760}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF28.enthalpyPort_b1, massFlowRate4.enthalpyPort_a) annotation (
      Line(points = {{-784.2, 760}, {-771.5, 760}, {-771.5, 759.9}, {-758.8, 759.9}}, color = {176, 0, 0}));
    connect(threeWayValve2.enthalpyPort_ab, dynamicPipe_HeatStorage_unload_FF29.enthalpyPort_b1) annotation (
      Line(points = {{-870.2, 720}, {-866.6, 720}, {-866.6, 719.9}, {-827.8, 720}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF29.enthalpyPort_a1, massFlowRate6.enthalpyPort_b) annotation (
      Line(points = {{-808.2, 720}, {-798.6, 720}, {-798.6, 719.9}, {-789, 719.9}}, color = {0, 128, 255}));
    connect(massFlowRate5.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF30.enthalpyPort_a1) annotation (
      Line(points = {{-931, 759.9}, {-918.5, 759.9}, {-918.5, 760}, {-905.8, 760}}, color = {176, 0, 0}));
    connect(massFlowRate7.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF31.enthalpyPort_b1) annotation (
      Line(points = {{-929.2, 719.9}, {-924.5, 719.9}, {-924.5, 720}, {-919.8, 720}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF31.enthalpyPort_a1, threeWayValve2.enthalpyPort_a) annotation (
      Line(points = {{-900.2, 720}, {-895.6, 719.9}, {-895.6, 720}, {-890, 720}}, color = {0, 128, 255}));
    connect(threeWayValve3.enthalpyPort_ab, dynamicPipe_HeatStorage_unload_FF32.enthalpyPort_b1) annotation (
      Line(points = {{-990.2, 720}, {-979.8, 720}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF32.enthalpyPort_a1, massFlowRate7.enthalpyPort_b) annotation (
      Line(points = {{-960.2, 720}, {-954.6, 720}, {-954.6, 719.9}, {-947, 719.9}}, color = {176, 0, 0}));
    connect(manifold2.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF33.enthalpyPort_b1) annotation (
      Line(points = {{-840, 760.5}, {-840, 679.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF33.enthalpyPort_a1, temperature_5311_TRC.enthalpyPort_b) annotation (
      Line(points = {{-840, 660.2}, {-840, -79.9}, {-1011, -79.9}}, color = {176, 0, 0}));
    connect(temperature_5312_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF34.enthalpyPort_b1) annotation (
      Line(points = {{-959.2, -140.1}, {-880, -140.1}, {-880, 660.2}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF34.enthalpyPort_a1, threeWayValve2.enthalpyPort_b) annotation (
      Line(points = {{-880, 679.8}, {-880, 710}}, color = {0, 128, 255}));
    connect(massFlowRate_5310_FRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF35.enthalpyPort_b1) annotation (
      Line(points = {{-1031.2, -140.1}, {-1024.5, -140.1}, {-1024.5, -140}, {-1017.8, -140}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF35.enthalpyPort_a1, temperature_5312_TRC.enthalpyPort_b) annotation (
      Line(points = {{-998.2, -140}, {-987.6, -140}, {-987.6, -140.1}, {-977, -140.1}}, color = {0, 128, 255}));
    connect(boiler.enthalpyPort_b1, dynamicPipe_HeatStorage_unload_FF36.enthalpyPort_a1) annotation (
      Line(points = {{-1318, -100}, {-1300, -100}, {-1300, -79.9}, {-1119.8, -80}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF36.enthalpyPort_b1, temperature_5311_TRC.enthalpyPort_a) annotation (
      Line(points = {{-1100.2, -80}, {-1064.5, -80}, {-1064.5, -79.9}, {-1028.8, -79.9}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF37.enthalpyPort_a1, massFlowRate_5310_FRC.enthalpyPort_b) annotation (
      Line(points = {{-1092.2, -140}, {-1070, -140}, {-1070, -140.1}, {-1049, -140.1}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF37.enthalpyPort_b1, pump_5304_UP.enthalpyPort_a) annotation (
      Line(points = {{-1111.8, -140}, {-1150.4, -140}}, color = {0, 128, 255}));
    connect(temperature_5303_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF38.enthalpyPort_b1) annotation (
      Line(points = {{-1209.2, -140.1}, {-1204.6, -140.1}, {-1204.6, -140}, {-1199.8, -140}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF38.enthalpyPort_a1, pump_5304_UP.enthalpyPort_b) annotation (
      Line(points = {{-1180.2, -140}, {-1169.6, -140}}, color = {0, 128, 255}));
    connect(temperature_5303_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF39.enthalpyPort_a1) annotation (
      Line(points = {{-1227, -140.1}, {-1234, -140.1}, {-1234, -140}, {-1280.2, -140}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF39.enthalpyPort_b1, boiler.enthalpyPort_a1) annotation (
      Line(points = {{-1299.8, -140}, {-1360, -140}, {-1360, -100.48}, {-1342, -100.48}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF30.enthalpyPort_b1, manifold2.enthalpyPort_a[1]) annotation (
      Line(points = {{-886.2, 760}, {-864, 760}, {-864, 759.5}, {-840, 759.5}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF1.enthalpyPort_b1, manifold_NS_7102_2.enthalpyPort_a[1]) annotation (
      Line(points = {{-540, 549.7}, {-540, 556}, {-480.5, 556}, {-480.5, 540}}, color = {176, 0, 0}));
    connect(temperature_7104_TRC_unload.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF21.enthalpyPort_a1) annotation (
      Line(points = {{-229, 779.9}, {-240, 779.9}, {-240, 719.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF21.enthalpyPort_b1, massFlowRate_7103_FRC_unload.enthalpyPort_a) annotation (
      Line(points = {{-240, 700.2}, {-240, 668.8}, {-239.9, 668.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF22.enthalpyPort_a1, massFlowRate_7103_FRC_load.enthalpyPort_b) annotation (
      Line(points = {{-220, 674.2}, {-220, 647}, {-220.1, 647}}, color = {176, 0, 0}));
    connect(temperature_7104_TRC_load.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF22.enthalpyPort_b1) annotation (
      Line(points = {{-210.8, 739.9}, {-220, 739.9}, {-220, 693.8}}, color = {176, 0, 0}));
    connect(calc_valve.y_valve, threeWayValve_NS_8106.opening) annotation (
      Line(points = {{-557, 240}, {-529, 240}}, color = {0, 0, 127}));
    connect(dHWHeatExchanger.enthalpyPort_dHWIn, dynamicPipe_HeatStorage_unload_FF3.enthalpyPort_b1) annotation (
      Line(points = {{-546.2, 482.8}, {-540, 482.8}, {-540, 455.7}}, color = {176, 0, 0}));
    connect(dHWHeatExchanger.enthalpyPort_dHWOut, dynamicPipe_HeatStorage_unload_FF1.enthalpyPort_a1) annotation (
      Line(points = {{-546, 492.8}, {-540, 492.8}, {-540, 520.3}}, color = {176, 0, 0}));
    connect(dHWHeatExchanger.enthalpyPort_heaterOut, dynamicPipe_HeatStorage_unload_FF4.enthalpyPort_a1) annotation (
      Line(points = {{-563.8, 482.8}, {-570, 482.8}, {-570, 461.7}}, color = {176, 0, 0}));
    connect(dHWHeatExchanger.enthalpyPort_heaterIn, dynamicPipe_HeatStorage_unload_FF2.enthalpyPort_b1) annotation (
      Line(points = {{-563.6, 492.8}, {-570, 492.8}, {-570, 530.3}}, color = {176, 0, 0}));
    connect(const4.y, max2.u2) annotation (
      Line(points = {{-679, 570}, {-662, 570}, {-662, 594}, {-642, 594}}, color = {0, 0, 127}));
    connect(min1.y, max2.u1) annotation (
      Line(points = {{-679, 606}, {-642, 606}}, color = {0, 0, 127}));
    connect(const20.y, min1.u1) annotation (
      Line(points = {{-719, 630}, {-710, 630}, {-710, 612}, {-702, 612}}, color = {0, 0, 127}));
    connect(max2.y, threeWayValve_NS_7102_1.opening) annotation (
      Line(points = {{-619, 600}, {-489, 600}}, color = {0, 0, 127}));
    connect(threeWayValve3.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF40.enthalpyPort_a1) annotation (
      Line(points = {{-1000, 710}, {-1000, 673.8}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF40.enthalpyPort_b1, threeWayValve4.enthalpyPort_ab) annotation (
      Line(points = {{-1000, 654.2}, {-1000, 569.8}}, color = {0, 128, 255}));
    connect(threeWayValve4.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF41.enthalpyPort_a1) annotation (
      Line(points = {{-1000, 550}, {-1000, 519.8}}, color = {0, 128, 255}));
    connect(manifold4.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF42.enthalpyPort_b1) annotation (
      Line(points = {{-1040.5, 660}, {-1040.5, 579.8}, {-1040, 579.8}, {-1040, 539.8}}, color = {176, 0, 0}));
    connect(temperature_2216_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF43.enthalpyPort_b1) annotation (
      Line(points = {{-1091.2, 559.9}, {-1085.5, 559.9}, {-1085.5, 560}, {-1079.8, 560}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF43.enthalpyPort_a1, threeWayValve4.enthalpyPort_b) annotation (
      Line(points = {{-1060.2, 560}, {-1050.6, 559.9}, {-1050.6, 560}, {-1010, 560}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF45.enthalpyPort_a1, temperature_2213_TRC.enthalpyPort_b) annotation (
      Line(points = {{-1188.2, 560}, {-1172, 560}, {-1172, 559.9}, {-1177, 559.9}}, color = {0, 128, 255}));
    connect(pump_2205_UP.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF46.enthalpyPort_b1) annotation (
      Line(points = {{-1290.4, 560}, {-1279.8, 560}}, color = {0, 128, 255}));
    connect(temperature_2202_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF47.enthalpyPort_b1) annotation (
      Line(points = {{-1359.2, 559.9}, {-1352.5, 559.9}, {-1352.5, 560}, {-1345.8, 560}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF47.enthalpyPort_a1, pump_2205_UP.enthalpyPort_b) annotation (
      Line(points = {{-1326.2, 560}, {-1308.6, 559.9}, {-1308.6, 560}, {-1309.6, 560}}, color = {0, 128, 255}));
    connect(temperature_2202_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF48.enthalpyPort_a1) annotation (
      Line(points = {{-1377, 559.9}, {-1398.6, 559.9}, {-1398.6, 560}, {-1400.2, 560}}, color = {0, 128, 255}));
    connect(vessel3.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF49.enthalpyPort_b1) annotation (
      Line(points = {{-1539, 560}, {-1521.8, 560}}, color = {176, 0, 0}));
    connect(fluidSource3.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF50.enthalpyPort_a1) annotation (
      Line(points = {{-1520, 661}, {-1515.9, 661}, {-1515.9, 660}, {-1503.8, 660}}, color = {176, 0, 0}));
    connect(temperature_2204_TRC.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF51.enthalpyPort_b1) annotation (
      Line(points = {{-1356.8, 659.9}, {-1354.5, 659.9}, {-1354.5, 660}, {-1420.2, 660}}, color = {176, 0, 0}));
    connect(temperature_2204_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF52.enthalpyPort_a1) annotation (
      Line(points = {{-1339, 659.9}, {-1289.5, 659.9}, {-1289.5, 660}, {-1279.8, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF53.enthalpyPort_b1, temperature_2215_TRC.enthalpyPort_a) annotation (
      Line(points = {{-1180.2, 660}, {-1154, 660}, {-1154, 660.1}, {-1128.8, 660.1}}, color = {176, 0, 0}));
    connect(temperature_2215_TRC.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF54.enthalpyPort_a1) annotation (
      Line(points = {{-1111, 660.1}, {-1105.5, 660.1}, {-1105.5, 660}, {-1099.8, 660}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF54.enthalpyPort_b1, manifold4.enthalpyPort_a[1]) annotation (
      Line(points = {{-1080.2, 660}, {-1039.5, 660}}, color = {176, 0, 0}));
    connect(manifold3.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF55.enthalpyPort_b1) annotation (
      Line(points = {{-1040, 760.5}, {-1040, 719.8}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF55.enthalpyPort_a1, manifold4.enthalpyPort_b) annotation (
      Line(points = {{-1040, 700.2}, {-1040, 680}}, color = {176, 0, 0}));
    connect(massFlowRate1.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF56.enthalpyPort_b1) annotation (
      Line(points = {{-1189.2, 779.9}, {-1174.5, 779.9}, {-1174.5, 780}, {-1159.8, 780}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF56.enthalpyPort_a1, threeWayValve3.enthalpyPort_a) annotation (
      Line(points = {{-1140.2, 780}, {-1010, 779.9}, {-1010, 720}}, color = {0, 128, 255}));
    connect(fluidSource1.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF57.enthalpyPort_a1) annotation (
      Line(points = {{-1160, 839}, {-1150, 839}, {-1150, 840}, {-1139.8, 840}}, color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF57.enthalpyPort_b1, manifold3.enthalpyPort_a[1]) annotation (
      Line(points = {{-1120.2, 840}, {-1040, 840}, {-1040, 759.5}}, color = {176, 0, 0}));
    connect(u_boiler_0_1, max.u1) annotation (
      Line(points = {{-1620, 0}, {-1412, 0}, {-1412, -48}, {-1402, -48}}, color = {0, 0, 127}));
    connect(u_7102_NS, min1.u2) annotation (
      Line(points = {{-1620, 430}, {-710, 430}, {-710, 598}, {-702, 598}, {-702, 600}}, color = {0, 0, 127}));
    connect(u_7202_NS, min.u2) annotation (
      Line(points = {{-1620, 380}, {-702, 380}}, color = {0, 0, 127}));
    connect(product.y, gain.u) annotation (
      Line(points = {{-19, 50}, {-2, 50}}, color = {0, 0, 127}));
    connect(y_8204_FRC, product.u1) annotation (
      Line(points = {{-34, 114}, {-50, 114}, {-50, 56}, {-42, 56}}, color = {0, 0, 127}));
    connect(add1.y, product.u2) annotation (
      Line(points = {{-59, 44}, {-42, 44}}, color = {0, 0, 127}));
    connect(add1.u1, y_8206_TRC) annotation (
      Line(points = {{-82, 50}, {-88, 50}, {-88, 124}, {6, 124}, {6, 112}}, color = {0, 0, 127}));
    connect(y_8205_TRC, add1.u2) annotation (
      Line(points = {{-10, 148}, {-92, 148}, {-92, 38}, {-82, 38}}, color = {0, 0, 127}));
    connect(gain.y, y_WMZ_heatingGrid) annotation (
      Line(points = {{21, 50}, {46, 50}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF48.enthalpyPort_b1, heatPump.enthalpyPort_a) annotation (
      Line(points={{-1419.8,560},{-1461,560},{-1461,618}},        color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF51.enthalpyPort_a1, heatPump.enthalpyPort_b) annotation (
      Line(points={{-1439.8,660},{-1461,660},{-1461,642}},        color = {176, 0, 0}));
    connect(dynamicPipe_HeatStorage_unload_FF50.enthalpyPort_b1, heatPump.enthalpyPort_a1) annotation (
      Line(points={{-1484.2,660},{-1475,660},{-1475,642}},        color = {176, 0, 0}));
    connect(heatPump.enthalpyPort_b1, dynamicPipe_HeatStorage_unload_FF49.enthalpyPort_a1) annotation (
      Line(points={{-1475,618},{-1476,618},{-1476,560},{-1502.2,560}},          color = {176, 0, 0}));
    connect(sineGeo_T_amb1.y, fluidSource3.T_fluid) annotation (
      Line(points = {{-1559, 664}, {-1560, 664}, {-1560, 664.2}, {-1538, 664.2}}, color = {0, 0, 127}));
    connect(heatPump.nSet, switch_2102_ZA.y) annotation (
      Line(points={{-1465.67,616.08},{-1465.67,548.04},{-1466,548.04},{-1466,
            531}},                                                                           color = {0, 0, 127}));
    connect(gain3.y, hysteresis.u) annotation (
      Line(points = {{-1380, 499}, {-1380, 470}, {-1388, 470}}, color = {0, 0, 127}));
    connect(y_boiler_dotQ, gain4.u) annotation (
      Line(points = {{-1302, -108}, {-1288, -108}}, color = {0, 0, 127}));
    connect(gain4.y, calc_mdot_production.u_dotQ) annotation (
      Line(points = {{-1265, -108}, {-1260, -108}, {-1260, -86}, {-1190, -86}, {-1190, -98}}, color = {0, 0, 127}));
    connect(greaterThreshold.y, logicalSwitch_5204_ZA.u3) annotation (
      Line(points = {{-1339, -10}, {-1330, -10}, {-1330, -18}}, color = {255, 0, 255}));
    connect(greaterThreshold.u, max.y) annotation (
      Line(points = {{-1362, -10}, {-1370, -10}, {-1370, -54}, {-1379, -54}}, color = {0, 0, 127}));
    connect(booleanConstant2.y, logicalSwitch_5204_ZA.u1) annotation (
      Line(points = {{-1301, -10}, {-1314, -10}, {-1314, -18}}, color = {255, 0, 255}));
    connect(not1.u, hysteresis.y) annotation (
      Line(points = {{-1418, 470}, {-1411, 470}}, color = {255, 0, 255}));
    connect(const5.y, switch_2102_ZA.u1) annotation (
      Line(points = {{-1441, 500}, {-1458, 500}, {-1458, 508}}, color = {0, 0, 127}));
    connect(u_heatpump_0_1, switch_2102_ZA.u3) annotation (
      Line(points = {{-1620, 500}, {-1474, 500}, {-1474, 508}}, color = {0, 0, 127}));
    connect(greaterThreshold_2101_OA.u, switch_2102_ZA.y) annotation (
      Line(points = {{-1452, 540}, {-1466, 540}, {-1466, 531}}, color = {0, 0, 127}));
    connect(logicalSwitch_5204_ZA.y, boiler.onOff_boiler) annotation (
      Line(points = {{-1322, -41}, {-1322, -83.2}, {-1322.8, -83.2}}, color = {255, 0, 255}));
    connect(calc_mdot_production1.u_dotQ, gain5.y) annotation (
      Line(points = {{-1330, 602}, {-1330, 609}}, color = {0, 0, 127}));
    connect(gain5.u, y_heatpump_dotQ) annotation (
      Line(points = {{-1330, 632}, {-1330, 640}, {-1450, 640}}, color = {0, 0, 127}));
    connect(switch_2102_ZA.u2, or1.y) annotation (
      Line(points = {{-1466, 508}, {-1466, 495}}, color = {255, 0, 255}));
    connect(not1.y, or1.u2) annotation (
      Line(points = {{-1441, 470}, {-1458, 470}, {-1458, 472}}, color = {255, 0, 255}));
    connect(u_loadProfile_kW, gain8.u)
      annotation (Line(points={{-1620,990},{-1582,990}}, color={0,0,127}));
    connect(add5.y, calc_mdot_production1.u_TemperatureOutput) annotation (
      Line(points = {{-1359, 600}, {-1350, 600}, {-1350, 595.8}, {-1342, 595.8}}, color = {0, 0, 127}));
    connect(add5.u2, temperature_2202_TRC.T) annotation (
      Line(points = {{-1382, 594}, {-1388, 594}, {-1388, 584}, {-1369, 584}, {-1369, 571}}, color = {0, 0, 127}));
    connect(const19.y, add5.u1) annotation (
      Line(points = {{-1401, 606}, {-1382, 606}}, color = {0, 0, 127}));
    connect(dynamicPipe_HeatStorage_unload_FF52.enthalpyPort_b1, threeWayValve_NS_2211.enthalpyPort_ab) annotation (
      Line(points = {{-1260.2, 660}, {-1239.8, 660}}, color = {176, 0, 0}));
    connect(threeWayValve_NS_2211.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF53.enthalpyPort_a1) annotation (
      Line(points = {{-1220, 660}, {-1199.8, 660}}, color = {176, 0, 0}));
    connect(threeWayValve_NS_2211.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF44.enthalpyPort_a1) annotation (
      Line(points = {{-1230, 650}, {-1230, 639.8}}, color = {176, 0, 0}));
    connect(manifold_NS_2211.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF46.enthalpyPort_a1) annotation (
      Line(points = {{-1250, 560}, {-1260.2, 560}}, color = {0, 128, 255}));
    connect(dynamicPipe_HeatStorage_unload_FF44.enthalpyPort_b1, manifold_NS_2211.enthalpyPort_a[2]) annotation (
      Line(points = {{-1230, 620.2}, {-1230, 560.5}, {-1230, 560.5}}, color = {0, 128, 255}));
    connect(manifold_NS_2211.enthalpyPort_a[1], dynamicPipe_HeatStorage_unload_FF45.enthalpyPort_b1) annotation (
      Line(points = {{-1230, 559.5}, {-1219.8, 559.5}, {-1219.8, 560}, {-1207.8, 560}}, color = {0, 128, 255}));
    connect(PID.y, threeWayValve_NS_2211.opening) annotation (
      Line(points = {{-1201, 730}, {-1230, 730}, {-1230, 669}}, color = {0, 0, 127}));
    connect(const18.y, PID.u_m) annotation (
      Line(points = {{-1181, 700}, {-1190, 700}, {-1190, 718}}, color = {0, 0, 127}));
    connect(PID.u_s, temperature_2215_TRC.T) annotation (
      Line(points = {{-1178, 730}, {-1104, 730}, {-1104, 649}, {-1119, 649}}, color = {0, 0, 127}));
    connect(gain3.u, y_2202_TRC) annotation (
      Line(points = {{-1380, 522}, {-1380, 572}, {-1380, 572}}, color = {0, 0, 127}));
    connect(calc_mdot_consumer.y_mdot, pump_8113_NP.dotm_setValue) annotation (
      Line(points = {{-301, 210}, {-320, 210}, {-320, 168}}, color = {0, 0, 127}));
    connect(calc_mdot_consumer.u_TemperatureInput, temperature_8205_TRC.T) annotation (
      Line(points = {{-278, 204}, {-272, 204}, {-272, 180}, {20, 180}, {20, 149}, {1, 149}}, color = {0, 0, 127}));
    connect(calc_mdot_consumer.u_dotQ, gain2.y) annotation (
      Line(points = {{-290, 222}, {-290, 240}, {580, 240}, {580, 568}, {820, 568}, {820, 579}}, color = {0, 0, 127}));
    connect(calc_mdot_consumer.u_TemperatureOutput, add6.y) annotation (
      Line(points = {{-278, 215.8}, {-270, 215.8}, {-270, 216}, {-261, 216}}, color = {0, 0, 127}));
    connect(add6.u1, const22.y) annotation (
      Line(points = {{-238, 222}, {-220, 222}, {-220, 224}, {-209, 224}}, color = {0, 0, 127}));
    connect(add6.u2, temperature_8205_TRC.T) annotation (
      Line(points = {{-238, 210}, {-220, 210}, {-220, 180}, {20, 180}, {20, 150}, {10, 150}, {10, 149}, {1, 149}}, color = {0, 0, 127}));
    connect(gain2.u, gain8.y) annotation (Line(points={{820,602},{820,990},{-1559,
            990}}, color={0,0,127}));
    connect(massFlowRate_4516_FRC.enthalpyPort_a,
      dynamicPipe_HeatStorage_unload_FF58.enthalpyPort_b1) annotation (Line(
          points={{-1171.2,179.9},{-1164.5,179.9},{-1164.5,180},{-1157.8,180}},
          color={0,128,255}));
    connect(dynamicPipe_HeatStorage_unload_FF58.enthalpyPort_a1,
      temperature_4518_TRC.enthalpyPort_b) annotation (Line(points={{-1138.2,180},
            {-1127.6,180},{-1127.6,179.9},{-1117,179.9}}, color={0,128,255}));
    connect(temperature_4518_TRC.enthalpyPort_a,
      dynamicPipe_HeatStorage_unload_FF41.enthalpyPort_b1) annotation (Line(
          points={{-1099.2,179.9},{-1000,179.9},{-1000,500.2}}, color={0,128,255}));
    connect(temperature_4517_TRC.enthalpyPort_b,
      dynamicPipe_HeatStorage_unload_FF42.enthalpyPort_a1) annotation (Line(
          points={{-1151,240.1},{-1040,240.1},{-1040,520.2}}, color={176,0,0}));
    connect(temperature_4515_TRC.enthalpyPort_a,
      dynamicPipe_HeatStorage_unload_FF59.enthalpyPort_b1) annotation (Line(
          points={{-1239.2,179.9},{-1240,179.9},{-1240,180},{-1225.8,180}}, color=
           {0,128,255}));
    connect(dynamicPipe_HeatStorage_unload_FF59.enthalpyPort_a1,
      massFlowRate_4516_FRC.enthalpyPort_b) annotation (Line(points={{-1206.2,180},
            {-1204.6,180},{-1204.6,179.9},{-1189,179.9}}, color={0,128,255}));
    connect(manifold.enthalpyPort_b, dynamicPipe_HeatStorage_unload_FF61.enthalpyPort_a1)
      annotation (Line(points={{-1300,240},{-1259.8,240}}, color={176,0,0}));
    connect(dynamicPipe_HeatStorage_unload_FF61.enthalpyPort_b1,
      temperature_4517_TRC.enthalpyPort_a) annotation (Line(points={{-1240.2,240},
            {-1204,240},{-1204,240.1},{-1168.8,240.1}}, color={176,0,0}));
    connect(manifold.enthalpyPort_a[2], dynamicPipe_HeatStorage_unload_FF62.enthalpyPort_b1)
      annotation (Line(points={{-1320,240.5},{-1320,219.8}}, color={0,128,255}));
    connect(dynamicPipe_HeatStorage_unload_FF62.enthalpyPort_a1, threeWayValve.enthalpyPort_b)
      annotation (Line(points={{-1320,200.2},{-1320,190}}, color={0,128,255}));
    connect(threeWayValve.enthalpyPort_ab, dynamicPipe_HeatStorage_unload_FF60.enthalpyPort_b1)
      annotation (Line(points={{-1310.2,180},{-1299.8,180}}, color={0,128,255}));
    connect(dynamicPipe_HeatStorage_unload_FF60.enthalpyPort_a1,
      temperature_4515_TRC.enthalpyPort_b) annotation (Line(points={{-1280.2,180},
            {-1268,180},{-1268,179.9},{-1257,179.9}}, color={0,128,255}));
    connect(pump_4507_up.enthalpyPort_a, dynamicPipe_HeatStorage_unload_FF63.enthalpyPort_b1)
      annotation (Line(points={{-1400.4,180},{-1357.8,180}}, color={0,128,255}));
    connect(dynamicPipe_HeatStorage_unload_FF63.enthalpyPort_a1, threeWayValve.enthalpyPort_a)
      annotation (Line(points={{-1338.2,180},{-1330,180}}, color={0,128,255}));
    connect(temperature_4504_TRC.enthalpyPort_a, pump_4507_up.enthalpyPort_b)
      annotation (Line(points={{-1437.2,179.9},{-1419.6,179.9},{-1419.6,180}},
                   color={0,128,255}));
    connect(dynamicPipe_HeatStorage_unload_FF64.enthalpyPort_b1, manifold.enthalpyPort_a[
      1]) annotation (Line(points={{-1340.2,240},{-1330,240},{-1330,239.5},{-1320,
            239.5}}, color={176,0,0}));
    connect(dynamicPipe_HeatStorage_unload_FF66.enthalpyPort_a1,
      temperature_4504_TRC.enthalpyPort_b) annotation (Line(points={{-1500.2,180},
            {-1462,180},{-1462,179.9},{-1455,179.9}}, color={0,128,255}));
    connect(dynamicPipe_HeatStorage_unload_FF66.enthalpyPort_b1, CHP.enthalpyPort_a)
      annotation (Line(points={{-1519.8,180},{-1560,180},{-1560,210},{-1550,210}},
          color={176,0,0}));
    connect(or1.u1, not2.y) annotation (Line(points={{-1466,472},{-1466,460},{-1499,
            460}}, color={255,0,255}));
    connect(not2.u, u_Stoerung_Tino_heatpump)
      annotation (Line(points={{-1522,460},{-1620,460}}, color={255,0,255}));
    connect(u_Stoerung_Tino_boiler, not3.u)
      annotation (Line(points={{-1620,40},{-1362,40}}, color={255,0,255}));
    connect(not3.y, logicalSwitch_5204_ZA.u2) annotation (Line(points={{-1339,40},
            {-1322,40},{-1322,-18}}, color={255,0,255}));
    connect(gain1.u, y_4504_TRC)
      annotation (Line(points={{-1460,258},{-1460,192}}, color={0,0,127}));
    connect(hysteresis1.u, gain1.y) annotation (Line(points={{-1468,330},{-1460,330},
            {-1460,281}}, color={0,0,127}));
    connect(not4.u, hysteresis1.y)
      annotation (Line(points={{-1498,330},{-1491,330}}, color={255,0,255}));
    connect(or2.y, switch_4202_ZA.u2)
      annotation (Line(points={{-1534,299},{-1534,282}}, color={255,0,255}));
    connect(switch_4202_ZA.y, CHP.P_elRel) annotation (Line(points={{-1534,259},{-1534,
            219.2},{-1535,219.2}}, color={0,0,127}));
    connect(not4.y, or2.u1) annotation (Line(points={{-1521,330},{-1534,330},{-1534,
            322}}, color={255,0,255}));
    connect(const8.y, switch_4202_ZA.u1) annotation (Line(points={{-1511,290},{-1526,
            290},{-1526,282}}, color={0,0,127}));
    connect(u_CHP_0_1, switch_4202_ZA.u3) annotation (Line(points={{-1620,290},{-1542,
            290},{-1542,282}}, color={0,0,127}));
    connect(not5.y, or2.u2) annotation (Line(points={{-1559,330},{-1542,330},{-1542,
            322}}, color={255,0,255}));
    connect(u_Stoerung_Tino_CHP, not5.u)
      annotation (Line(points={{-1620,330},{-1582,330}}, color={255,0,255}));
    connect(realToBoolean.y, CHP.onOff) annotation (Line(points={{-1560,229},{-1560,
            226},{-1544,226},{-1544,219.2}}, color={255,0,255}));
    connect(switch_4202_ZA.y, realToBoolean.u) annotation (Line(points={{-1534,259},
            {-1534,252},{-1560,252}}, color={0,0,127}));
    connect(calc_mdot_production2.u_TemperatureInput, temperature_4504_TRC.T)
      annotation (Line(points={{-1442,204},{-1444,204},{-1444,191},{-1447,191}},
          color={0,0,127}));
    connect(calc_mdot_production2.y_mdot, pump_4507_up.dotm_setValue) annotation (
       Line(points={{-1419,210},{-1410,210},{-1410,188}}, color={0,0,127}));
    connect(temperature_4506_TRC.enthalpyPort_b,
      dynamicPipe_HeatStorage_unload_FF64.enthalpyPort_a1) annotation (Line(
          points={{-1369,240.1},{-1365.5,240.1},{-1365.5,240},{-1359.8,240}},
          color={176,0,0}));
    connect(dynamicPipe_HeatStorage_unload_FF67.enthalpyPort_b1,
      temperature_4506_TRC.enthalpyPort_a) annotation (Line(points={{-1396.2,240},
            {-1392,240},{-1392,240.1},{-1386.8,240.1}}, color={176,0,0}));
    connect(dynamicPipe_HeatStorage_unload_FF67.enthalpyPort_a1, CHP.enthalpyPort_b)
      annotation (Line(points={{-1415.8,240},{-1520,240},{-1520,210},{-1530,210}},
          color={176,0,0}));
    connect(const15.y, calc_mdot_production2.u_TemperatureOutput) annotation (
        Line(points={{-1479,216},{-1446,216},{-1446,215.8},{-1442,215.8}}, color={
            0,0,127}));
    connect(calc_mdot_production2.u_dotQ, CHP.Capacity[2]) annotation (Line(
          points={{-1430,222},{-1430,236},{-1512,236},{-1512,215.6},{-1529.8,215.6}},
          color={0,0,127}));
    connect(calc_valve1.y_valve, threeWayValve.opening) annotation (Line(points={{
            -1301,138},{-1320,138},{-1320,171}}, color={0,0,127}));
    connect(calc_valve1.u_T_consumer_output, y_4515_TRC) annotation (Line(points={
            {-1278,144},{-1270,144},{-1270,192},{-1262,192}}, color={0,0,127}));
    connect(calc_valve1.u_T_source_input, y_4506_TRC) annotation (Line(points={{-1290,
            126},{-1290,120},{-1388,120},{-1388,228}}, color={0,0,127}));
    connect(calc_valve1.u_T_consumer_input, const23.y) annotation (Line(points={{-1278,
            132.2},{-1269,132.2},{-1269,132},{-1261,132}}, color={0,0,127}));
    annotation (
      Diagram(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}}), graphics={  Line(origin = {688, 380}, points = {{0, 0}})}),
      Icon(coordinateSystem(extent = {{-1600, -1000}, {1000, 1000}})),
      experiment(StopTime = 31536000, Interval = 900, Tolerance = 0.01, __Dymola_Algorithm = "Dassl"));
  end FMU_PhyModel;
  annotation (
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.10.7")),
    Documentation(info = "<html>
      <p>Im package FMUs werden alle Modelle der unterschiedlichen Simulationen abgelegt, welche mit entsprechenden Schnittstellen zu FMUs umgebaut worden sind.</p>
      <p>Erstellt wurden die Simulationsmodelle durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
end FMUs;
