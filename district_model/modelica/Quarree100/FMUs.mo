within Quarree100;

package FMUs
  extends Modelica.Icons.ExamplesPackage;

  model FMU_EinfachesModell
    extends Modelica.Icons.ExamplesPackage;
    Modelica.Blocks.Sources.Constant const1(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {-570, -170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts_central(T_start = fill(343.15, 7), data = AixLib.DataBase.Storage.Generic_New_2000l(hTank = 6.37, dTank = 4, sIns = 0.2, lambdaIns = 0.032), load_cycles = [7, 1; 7, 1; 7, 1], n = 7, n_load_cycles = 3, n_unload_cycles = 1, unload_cycles = [1, 7], use_heatingCoil1 = false, use_heatingCoil2 = false, use_heatingRod = false) annotation(
      Placement(visible = true, transformation(origin = {-165, -109}, extent = {{-25, -27}, {25, 27}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP1 annotation(
      Placement(visible = true, transformation(origin = {-450, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-394, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 293.15) annotation(
      Placement(visible = true, transformation(origin = {-120, -88}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO2 annotation(
      Placement(visible = true, transformation(origin = {-379, -51}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt CHP1(T0 = 363.15, T_Out = 363.15, capP_el = 140000, eta_el = 0.378, eta_th = 0.568, uHigh = 16, uLow = -18) annotation(
      Placement(visible = true, transformation(origin = {-362, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP2 annotation(
      Placement(visible = true, transformation(origin = {-460, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-384, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.BoundaryConditions.WeatherData.Bus controlBus_CHP3 annotation(
      Placement(visible = true, transformation(origin = {-470, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-374, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt CHP2(T0 = 363.15, T_Out = 363.15, capP_el = 140000, eta_el = 0.378, eta_th = 0.568, uHigh = 17, uLow = -17) annotation(
      Placement(visible = true, transformation(origin = {-322, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO1 annotation(
      Placement(visible = true, transformation(origin = {-339, -91}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.bus2SOBoolean_SO bus2SOBoolean_SO annotation(
      Placement(visible = true, transformation(origin = {-287, -131}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
    Simulationsumgebung.Components.Producer_CHP_opt CHP3(T0 = 363.15, T_Out = 363.15, capP_el = 140000, eta_el = 0.378, eta_th = 0.568, uHigh = 18, uLow = -16) annotation(
      Placement(visible = true, transformation(origin = {-270, -150}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.Manifold manifold(n = 2) annotation(
      Placement(visible = true, transformation(origin = {-48, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Valves.ThreeWayValve threeWayValve annotation(
      Placement(visible = true, transformation(origin = {-80, -160}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Continuous.LimPID PID(Ti = 0.01, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 1, yMin = 0, y_start = 0.8) annotation(
      Placement(visible = true, transformation(origin = {-10, -200}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Constant const3(k = 70 + 273.15) annotation(
      Placement(visible = true, transformation(origin = {30, -200}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Gain gain(k = 2.77777 * 1E-10) annotation(
      Placement(visible = true, transformation(origin = {-510, -250}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Product product annotation(
      Placement(visible = true, transformation(origin = {-324, -290}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.Integrator integrator annotation(
      Placement(visible = true, transformation(origin = {-324, -330}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add3 annotation(
      Placement(visible = true, transformation(origin = {-318, -230}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Continuous.LimPID PID_Pump(Ti = 0.1, controllerType = .Modelica.Blocks.Types.SimpleController.PI, initType = .Modelica.Blocks.Types.InitPID.InitialOutput, k = 0.01, limitsAtInit = true, yMax = 100, yMin = 0, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {22, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
    Modelica.Blocks.Sources.Ramp ramp(duration = 0, height = 20) annotation(
      Placement(visible = true, transformation(origin = {-30, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pumps.Pump pump_Demand annotation(
      Placement(visible = true, transformation(origin = {-4, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Simulationsumgebung.Components.Consumer_simple consumer_simple(T0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe(T_0 = 343.15) annotation(
      Placement(visible = true, transformation(origin = {-126, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe1(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {-124, -160}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    AixLib.FastHVAC.Components.Pipes.DynamicPipe dynamicPipe2(T_0 = 323.15) annotation(
      Placement(visible = true, transformation(origin = {-80, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    Modelica.Blocks.Math.Gain gain1(k = 1000) annotation(
      Placement(visible = true, transformation(origin = {62, 66}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add31 annotation(
      Placement(visible = true, transformation(origin = {-220, -230}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add32 annotation(
      Placement(visible = true, transformation(origin = {-180, -230}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Add3 add33 annotation(
      Placement(visible = true, transformation(origin = {-200, -272}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Math.Gain gain_HeatStorage_TempMean(k = 1 / 7) annotation(
      Placement(visible = true, transformation(origin = {-200, -310}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealInput u_CHP1 annotation(
      Placement(visible = true, transformation(origin = {-620, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-620, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_CHP2 annotation(
      Placement(visible = true, transformation(origin = {-620, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-620, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_CHP3 annotation(
      Placement(visible = true, transformation(origin = {-620, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-620, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_Spot annotation(
      Placement(visible = true, transformation(origin = {-620, -250}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-620, -250}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_DemandHeat annotation(
      Placement(visible = true, transformation(origin = {-620, 180}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-620, 180}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_PS_TempMean annotation(
      Placement(visible = true, transformation(origin = {210, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {210, -340}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_Spot annotation(
      Placement(visible = true, transformation(origin = {-550, -260}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-550, -260}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_CHP3 annotation(
      Placement(visible = true, transformation(origin = {-550, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-550, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_CHP2 annotation(
      Placement(visible = true, transformation(origin = {-550, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-550, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_CHP1 annotation(
      Placement(visible = true, transformation(origin = {-550, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-550, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_DemandHeat annotation(
      Placement(visible = true, transformation(origin = {-550, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-550, 170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_cost annotation(
      Placement(visible = true, transformation(origin = {210, -370}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {210, -370}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_P_CHP1 annotation(
      Placement(visible = true, transformation(origin = {-340, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-340, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_P_CHP2 annotation(
      Placement(visible = true, transformation(origin = {-300, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-300, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_P_CHP3 annotation(
      Placement(visible = true, transformation(origin = {-250, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-250, -190}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_sink_TempIn annotation(
      Placement(visible = true, transformation(origin = {210, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {210, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_sink_TempOut annotation(
      Placement(visible = true, transformation(origin = {210, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {210, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Math.Add add(k1 = -1) annotation(
      Placement(visible = true, transformation(origin = {176, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 0.1) annotation(
      Placement(visible = true, transformation(origin = {-510, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u_controlOn annotation(
      Placement(visible = true, transformation(origin = {-620, 140}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-620, 140}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y_controlOn annotation(
      Placement(visible = true, transformation(origin = {-550, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-550, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(fixedTemperature.port, heatStorageVariablePorts_central.out) annotation(
      Line(points = {{-130, -88}, {-140, -88}, {-140, -87.4}, {-150, -87.4}}, color = {191, 0, 0}));
    connect(bus2SOBoolean_SO2.y_control_value, CHP1.u_control_value) annotation(
      Line(points = {{-376, -52}, {-370, -52}, {-370, -58}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO2.y_control_boolean, CHP1.u_control_boolean) annotation(
      Line(points = {{-376, -50}, {-366, -50}, {-366, -58}}, color = {255, 0, 255}));
    connect(CHP1.u_T_setpoint_specification, const1.y) annotation(
      Line(points = {{-374, -76}, {-402, -76}, {-402, -170}, {-559, -170}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO2.controlBus, controlBus_CHP1) annotation(
      Line(points = {{-382, -51}, {-450, -51}, {-450, 98}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO1.controlBus, controlBus_CHP2) annotation(
      Line(points = {{-342, -91}, {-460, -91}, {-460, 60}}, color = {255, 204, 51}, thickness = 0.5));
    connect(bus2SOBoolean_SO.controlBus, controlBus_CHP3) annotation(
      Line(points = {{-290, -131}, {-470, -131}, {-470, 20}}, color = {255, 204, 51}, thickness = 0.5));
    connect(const1.y, CHP2.u_T_setpoint_specification) annotation(
      Line(points = {{-558, -170}, {-402, -170}, {-402, -116}, {-334, -116}}, color = {0, 0, 127}));
    connect(const1.y, CHP3.u_T_setpoint_specification) annotation(
      Line(points = {{-558, -170}, {-402, -170}, {-402, -156}, {-282, -156}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_value, CHP2.u_control_value) annotation(
      Line(points = {{-336, -92}, {-330, -92}, {-330, -98}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO1.y_control_boolean, CHP2.u_control_boolean) annotation(
      Line(points = {{-336, -90}, {-326, -90}, {-326, -98}}, color = {255, 0, 255}));
    connect(bus2SOBoolean_SO.y_control_value, CHP3.u_control_value) annotation(
      Line(points = {{-284, -132}, {-278, -132}, {-278, -138}}, color = {0, 0, 127}));
    connect(bus2SOBoolean_SO.y_control_boolean, CHP3.u_control_boolean) annotation(
      Line(points = {{-284, -130}, {-274, -130}, {-274, -138}}, color = {255, 0, 255}));
    connect(CHP1.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[1]) annotation(
      Line(points = {{-362, -59}, {-362, -40}, {-170, -40}, {-170, -82}}, color = {176, 0, 0}));
    connect(CHP2.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[2]) annotation(
      Line(points = {{-322, -99}, {-322, -40}, {-170, -40}, {-170, -82}}, color = {176, 0, 0}));
    connect(CHP3.enthalpyPort_b, heatStorageVariablePorts_central.LoadingCycle_In[3]) annotation(
      Line(points = {{-270, -139}, {-270, -40}, {-170, -40}, {-170, -82}}, color = {176, 0, 0}));
    connect(CHP1.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[1]) annotation(
      Line(points = {{-362, -81}, {-362, -180}, {-170, -180}, {-170, -136}}, color = {176, 0, 0}));
    connect(CHP2.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[2]) annotation(
      Line(points = {{-322, -121}, {-322, -180}, {-170, -180}, {-170, -136}}, color = {176, 0, 0}));
    connect(CHP3.enthalpyPort_a, heatStorageVariablePorts_central.LoadingCycle_Out[3]) annotation(
      Line(points = {{-270, -161}, {-270, -180}, {-170, -180}, {-170, -136}}, color = {176, 0, 0}));
    connect(const3.y, PID.u_s) annotation(
      Line(points = {{20, -200}, {2, -200}, {2, -200}, {2, -200}}, color = {0, 0, 127}));
    connect(PID.y, threeWayValve.opening) annotation(
      Line(points = {{-20, -200}, {-80, -200}, {-80, -168}, {-80, -168}}, color = {0, 0, 127}));
    connect(gain.y, product.u2) annotation(
      Line(points = {{-498, -250}, {-330, -250}, {-330, -278}}, color = {0, 0, 127}));
    connect(product.y, integrator.u) annotation(
      Line(points = {{-324, -301}, {-324, -318}}, color = {0, 0, 127}));
    connect(add3.y, product.u1) annotation(
      Line(points = {{-318, -241}, {-318, -278}}, color = {0, 0, 127}));
    connect(CHP3.y_P, add3.u1) annotation(
      Line(points = {{-266, -161}, {-266, -200}, {-310, -200}, {-310, -218}}, color = {0, 0, 127}));
    connect(CHP2.y_P, add3.u2) annotation(
      Line(points = {{-318, -121}, {-318, -218}}, color = {0, 0, 127}));
    connect(CHP1.y_P, add3.u3) annotation(
      Line(points = {{-358, -81}, {-358, -200}, {-326, -200}, {-326, -218}}, color = {0, 0, 127}));
    connect(ramp.y, PID_Pump.u_m) annotation(
      Line(points = {{-18, 30}, {22, 30}, {22, -10}, {22, -10}}, color = {0, 0, 127}));
    connect(manifold.enthalpyPort_b, pump_Demand.enthalpyPort_a) annotation(
      Line(points = {{-38, -60}, {-14, -60}, {-14, -60}, {-14, -60}}, color = {176, 0, 0}));
    connect(PID_Pump.y, pump_Demand.dotm_setValue) annotation(
      Line(points = {{11, -22}, {-4, -22}, {-4, -52}}, color = {0, 0, 127}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{6, -60}, {58, -60}, {58, -60}, {60, -60}}, color = {176, 0, 0}));
    connect(pump_Demand.enthalpyPort_b, consumer_simple.enthalpyPort_a) annotation(
      Line(points = {{6, -60}, {58, -60}, {58, -60}, {58, -60}}, color = {176, 0, 0}));
    connect(consumer_simple.y_deltaT, PID_Pump.u_s) annotation(
      Line(points = {{82, -52}, {152, -52}, {152, -22}, {34, -22}}, color = {0, 0, 127}));
    connect(dynamicPipe.enthalpyPort_a1, heatStorageVariablePorts_central.UnloadingCycle_Out[1]) annotation(
      Line(points = {{-136, -60}, {-160, -60}, {-160, -82}, {-160, -82}}, color = {176, 0, 0}));
    connect(dynamicPipe.enthalpyPort_b1, manifold.enthalpyPort_a[1]) annotation(
      Line(points = {{-116, -60}, {-58, -60}, {-58, -60}, {-58, -60}}, color = {176, 0, 0}));
    connect(dynamicPipe1.enthalpyPort_a1, threeWayValve.enthalpyPort_a) annotation(
      Line(points = {{-114, -160}, {-90, -160}, {-90, -160}, {-90, -160}}, color = {176, 0, 0}));
    connect(dynamicPipe1.enthalpyPort_b1, heatStorageVariablePorts_central.UnloadingCycle_In[1]) annotation(
      Line(points = {{-134, -160}, {-160, -160}, {-160, -136}, {-160, -136}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_a1, threeWayValve.enthalpyPort_b) annotation(
      Line(points = {{-80, -118}, {-80, -118}, {-80, -150}, {-80, -150}}, color = {176, 0, 0}));
    connect(dynamicPipe2.enthalpyPort_b1, manifold.enthalpyPort_a[2]) annotation(
      Line(points = {{-80, -98}, {-80, -98}, {-80, -60}, {-58, -60}, {-58, -60}}, color = {176, 0, 0}));
    connect(consumer_simple.enthalpyPort_b, threeWayValve.enthalpyPort_ab) annotation(
      Line(points = {{82, -60}, {100, -60}, {100, -160}, {-70, -160}, {-70, -160}}, color = {176, 0, 0}));
    connect(gain1.y, consumer_simple.u_sink) annotation(
      Line(points = {{62, 56}, {62, 56}, {62, -48}, {62, -48}}, color = {0, 0, 127}));
    connect(add31.y, add33.u3) annotation(
      Line(points = {{-220, -241}, {-220, -252}, {-208, -252}, {-208, -260}}, color = {0, 0, 127}));
    connect(add32.y, add33.u1) annotation(
      Line(points = {{-180, -241}, {-180, -249}, {-192, -249}, {-192, -260}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[4], add33.u2) annotation(
      Line(points = {{-188, -108}, {-200, -108}, {-200, -260}, {-200, -260}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[1], add31.u3) annotation(
      Line(points = {{-188, -108}, {-200, -108}, {-200, -200}, {-228, -200}, {-228, -218}, {-228, -218}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[2], add31.u2) annotation(
      Line(points = {{-188, -108}, {-200, -108}, {-200, -200}, {-220, -200}, {-220, -218}, {-220, -218}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[3], add31.u1) annotation(
      Line(points = {{-188, -108}, {-200, -108}, {-200, -200}, {-212, -200}, {-212, -218}, {-212, -218}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[5], add32.u3) annotation(
      Line(points = {{-188, -108}, {-200, -108}, {-200, -200}, {-188, -200}, {-188, -218}, {-188, -218}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[6], add32.u2) annotation(
      Line(points = {{-188, -108}, {-200, -108}, {-200, -200}, {-180, -200}, {-180, -218}, {-180, -218}}, color = {0, 0, 127}));
    connect(heatStorageVariablePorts_central.T_layers[7], add32.u1) annotation(
      Line(points = {{-188, -108}, {-200, -108}, {-200, -200}, {-172, -200}, {-172, -218}, {-172, -218}}, color = {0, 0, 127}));
    connect(add33.y, gain_HeatStorage_TempMean.u) annotation(
      Line(points = {{-200, -282}, {-200, -282}, {-200, -298}, {-200, -298}}, color = {0, 0, 127}));
    connect(u_CHP1, controlBus_CHP1.control_value) annotation(
      Line(points = {{-620, 100}, {-450, 100}, {-450, 98}, {-450, 98}}, color = {0, 0, 127}));
    connect(u_CHP2, controlBus_CHP2.control_value) annotation(
      Line(points = {{-620, 60}, {-460, 60}, {-460, 60}, {-460, 60}}, color = {0, 0, 127}));
    connect(u_CHP3, controlBus_CHP3.control_value) annotation(
      Line(points = {{-620, 20}, {-470, 20}, {-470, 20}, {-470, 20}}, color = {0, 0, 127}));
    connect(u_Spot, gain.u) annotation(
      Line(points = {{-620, -250}, {-522, -250}, {-522, -250}, {-522, -250}}, color = {0, 0, 127}));
    connect(u_DemandHeat, gain1.u) annotation(
      Line(points = {{-620, 180}, {62, 180}, {62, 78}, {62, 78}}, color = {0, 0, 127}));
    connect(y_PS_TempMean, gain_HeatStorage_TempMean.y) annotation(
      Line(points = {{210, -340}, {-200, -340}, {-200, -320}}, color = {0, 0, 127}));
    connect(y_Spot, u_Spot) annotation(
      Line(points = {{-550, -260}, {-580, -260}, {-580, -250}, {-620, -250}}, color = {0, 0, 127}));
    connect(y_CHP3, u_CHP3) annotation(
      Line(points = {{-550, 10}, {-580, 10}, {-580, 20}, {-620, 20}, {-620, 20}}, color = {0, 0, 127}));
    connect(y_CHP2, u_CHP2) annotation(
      Line(points = {{-550, 50}, {-580, 50}, {-580, 60}, {-620, 60}, {-620, 60}}, color = {0, 0, 127}));
    connect(y_CHP1, u_CHP1) annotation(
      Line(points = {{-550, 90}, {-580, 90}, {-580, 100}, {-620, 100}, {-620, 100}}, color = {0, 0, 127}));
    connect(y_DemandHeat, u_DemandHeat) annotation(
      Line(points = {{-550, 170}, {-580, 170}, {-580, 180}, {-620, 180}, {-620, 180}}, color = {0, 0, 127}));
    connect(y_cost, integrator.y) annotation(
      Line(points = {{210, -370}, {-324, -370}, {-324, -341}}, color = {0, 0, 127}));
    connect(y_P_CHP3, CHP3.y_P) annotation(
      Line(points = {{-250, -190}, {-266, -190}, {-266, -160}, {-266, -160}}, color = {0, 0, 127}));
    connect(y_P_CHP2, CHP2.y_P) annotation(
      Line(points = {{-300, -190}, {-318, -190}, {-318, -120}, {-318, -120}}, color = {0, 0, 127}));
    connect(y_P_CHP1, CHP1.y_P) annotation(
      Line(points = {{-340, -190}, {-358, -190}, {-358, -80}, {-358, -80}}, color = {0, 0, 127}));
    connect(y_sink_TempIn, consumer_simple.y_Tin) annotation(
      Line(points = {{210, -56}, {80, -56}, {80, -56}, {82, -56}}, color = {0, 0, 127}));
    connect(add.u1, consumer_simple.y_deltaT) annotation(
      Line(points = {{164, -70}, {152, -70}, {152, -52}, {82, -52}, {82, -52}}, color = {0, 0, 127}));
    connect(add.u2, consumer_simple.y_Tin) annotation(
      Line(points = {{164, -82}, {140, -82}, {140, -56}, {82, -56}, {82, -56}}, color = {0, 0, 127}));
    connect(add.y, y_sink_TempOut) annotation(
      Line(points = {{188, -76}, {200, -76}, {200, -76}, {210, -76}}, color = {0, 0, 127}));
    connect(u_controlOn, greaterThreshold.u) annotation(
      Line(points = {{-620, 140}, {-522, 140}}, color = {0, 0, 127}));
    connect(greaterThreshold.y, controlBus_CHP1.control_boolean) annotation(
      Line(points = {{-499, 140}, {-450, 140}, {-450, 98}}, color = {255, 0, 255}));
    connect(greaterThreshold.y, controlBus_CHP2.control_boolean) annotation(
      Line(points = {{-499, 140}, {-460, 140}, {-460, 60}}, color = {255, 0, 255}));
    connect(greaterThreshold.y, controlBus_CHP3.control_boolean) annotation(
      Line(points = {{-499, 140}, {-470, 140}, {-470, 20}}, color = {255, 0, 255}));
    connect(y_controlOn, u_controlOn) annotation(
      Line(points = {{-550, 130}, {-580, 130}, {-580, 140}, {-620, 140}, {-620, 140}}, color = {0, 0, 127}));
    connect(consumer_simple.y_Tin, PID.u_m) annotation(
      Line(points = {{82, -56}, {140, -56}, {140, -180}, {-10, -180}, {-10, -188}, {-10, -188}}, color = {0, 0, 127}));
    connect(CHP3.u_T_setpoint, gain_HeatStorage_TempMean.y) annotation(
      Line(points = {{-258, -156}, {-240, -156}, {-240, -340}, {-200, -340}, {-200, -320}, {-200, -320}}, color = {0, 0, 127}));
    connect(CHP2.u_T_setpoint, gain_HeatStorage_TempMean.y) annotation(
      Line(points = {{-310, -116}, {-240, -116}, {-240, -340}, {-200, -340}, {-200, -320}, {-200, -320}}, color = {0, 0, 127}));
    connect(CHP1.u_T_setpoint, gain_HeatStorage_TempMean.y) annotation(
      Line(points = {{-350, -76}, {-240, -76}, {-240, -340}, {-200, -340}, {-200, -320}, {-200, -320}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(extent = {{-600, -400}, {200, 200}}, initialScale = 0.1)),
      Icon(coordinateSystem(extent = {{-600, -400}, {200, 200}}, initialScale = 0.1), graphics = {Rectangle(origin = {-492, -72}, lineColor = {215, 215, 215}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-110, 152}, {404, 12}}), Rectangle(origin = {-490, -212}, lineColor = {215, 215, 215}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-110, 152}, {690, -188}}), Rectangle(origin = {-492, 46}, lineColor = {215, 215, 215}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-110, 152}, {692, 32}}), Rectangle(origin = {-492, 46}, lineColor = {215, 215, 215}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{-110, 152}, {692, 32}}), Rectangle(origin = {-204, -72}, lineColor = {215, 215, 215}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, extent = {{280, 154}, {404, 12}})}),
      experiment(StartTime = 0, StopTime = 604800, Tolerance = 1e-06, Interval = 3600));
  end FMU_EinfachesModell;
  annotation(
    uses(Modelica(version = "3.2.3"), AixLib(version = "0.9.1")),
    Documentation(info = "<html>
      <p>Im package FMUs werden alle Modelle der unterschiedlichen Simulationen abgelegt, welche mit entsprechenden Schnittstellen zu FMUs umgebaut worden sind.</p>
      <p>Erstellt wurden die Simulationsmodelle durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
end FMUs;
