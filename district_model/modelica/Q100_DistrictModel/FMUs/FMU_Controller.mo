within Q100_DistrictModel.FMUs;
model FMU_Controller "Coltroller for fmu"
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_TempAmb_extern
    "Ambient temperature in °C"
    annotation (Dialog(tab = "External profiles",group = "Ambient Temperature",enable=not selectable), Placement(visible=true,transformation(extent={{-10,-10},{10,10}}, origin={-256,282}),
        iconTransformation(extent={{-266,272},{-246,292}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_co2_extern
    "CO2 intensity of the upstream electricity grid in g/kWh"
    annotation (Dialog(tab = "External profiles",group = "Electricity market properties",enable=not selectable), Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,240}),
        iconTransformation(extent={{-266,228},{-242,252}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_el_costs_extern
    "Electricity price intensity of the upstream electricity grid in €/kWh"
    annotation (Dialog(tab = "External profiles",group = "Electricity market properties",enable=not selectable),Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,200}),
        iconTransformation(extent={{-266,188},{-242,212}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_T_HeatGrid_FF_actual
    "Forward flow temperature of the heat grid in °C"
    annotation (Dialog(
      tab="System feedback",
      group="System properties",
      enable=not selectable), Placement(visible=true, transformation(extent={{1600,150},{1560,190}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput P_el_pv_district
    "photovoltaic production in the district in kW"
    annotation (Dialog(
      tab="External profiles",
      group="Load profiles",
      enable=not selectable), Placement(visible=true, transformation(extent={{1600,20},{1560,60}})));
  Modelica.Blocks.Logical.Switch switch_HP_extrernSchedule annotation (
      Placement(visible=true, transformation(
        origin={70,-310},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant const5(k=-1)  annotation (
    Placement(visible = true, transformation(origin={-70,-560},     extent={{-10,-10},
            {10,10}},                                                                                rotation = 0)));
  Modelica.Blocks.Logical.Switch switch_Electrolyzer_extrernSchedule
    annotation (Placement(visible=true, transformation(
        origin={70,-350},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch_CHP__extrernSchedule annotation (
      Placement(visible=true, transformation(
        origin={68,-390},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch_Boiler__extrernSchedule annotation (
      Placement(visible=true, transformation(
        origin={70,-430},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  AixLib.Controls.SetPoints.Table HeatingCurve_DistrictGrid(table=[-20,80; -15,
        80; 15,65; 20,65])
    annotation (Placement(transformation(extent={{438,270},{458,290}})));
  UnitController.HeatPump.HeatPump_Controller heatPump_Controller annotation (Placement(transformation(extent={{302,-316},{346,-282}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_HeatPump_scheudle
   annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable), Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-296}),
        iconTransformation(extent={{-276,-308},{-252,-284}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_Electrolyzer_scheudle
    annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable), Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-334}),
        iconTransformation(extent={{-272,-346},{-248,-322}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_Boiler_scheudle
   annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable), Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-382}),
        iconTransformation(extent={{-272,-394},{-248,-370}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_CHP_scheudle
   annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable), Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,144}),
        iconTransformation(extent={{-256,132},{-232,156}})));
  Modelica.Blocks.Interfaces.RealOutput u_Electrolyzer_controll
    annotation (Placement(visible=true,transformation(extent={{1560,-360},{1580,-340}})));
  Modelica.Blocks.Interfaces.RealOutput u_CHP_controll
    annotation (Placement(visible=true,transformation(extent={{1560,-400},{1580,-380}})));
  Modelica.Blocks.Interfaces.RealOutput u_Boiler_controll
    annotation (Placement(visible=true,transformation(extent={{1560,-440},{1580,-420}})));
  Modelica.Blocks.Interfaces.RealOutput u_T_HeatGrid_FF_set
    annotation (Placement(visible=true,transformation(extent={{1560,270},{1580,290}})));
  Modelica.Blocks.Sources.Constant const1(k=0)   annotation (
    Placement(visible = true, transformation(origin={-70,-520},     extent={{-10,-10},
            {10,10}},                                                                                rotation = 0)));
  replaceable
  Modelica.Blocks.Interfaces.RealInput E_el_EES
    "state of charge - electrical storage (in %)"
    annotation (Dialog(
      tab="System feedback",
      group="Units properties",
      enable=not selectable), Placement(visible=true, transformation(extent={{1600,-140},{1560,-100}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput P_inst_el_HP1 annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(visible=true,
        transformation(extent={{-12,-12},{12,12}}, origin={-254,80}),
                                                      iconTransformation(extent={{-260,114},{-236,138}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput P_inst_el_HP2 annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(visible=true,
        transformation(extent={{-12,-12},{12,12}}, origin={-254,46}),
                                                      iconTransformation(extent={{-260,72},{-236,96}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput P_inst_el_Electrolyzer annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),
      Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-2}),
        iconTransformation(extent={{-260,144},{-236,168}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput    u_heatpump1_OA
    "Heat pump one status signal as 0 (not running) and 1 (running) "
    annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-42}),
        iconTransformation(extent={{-266,-54},{-242,-30}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput    u_electrolyzer_OA
    "electrolyzer status signal as 0 (not running) and 1 (running) "
    annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-124}),
        iconTransformation(extent={{-266,-136},{-242,-112}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput    u_CHP_OA
    "CHP status signal as 0 (not running) and 1 (running) "
    annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-162}),
        iconTransformation(extent={{-266,-174},{-242,-150}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput    u_boiler_OA
    "Boiler status signal as 0 (not running) and 1 (running) "
    annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-204}),
        iconTransformation(extent={{-266,-216},{-242,-192}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput    u_heatpump2_OA
    "Heat pump two status signal as 0 (not running) and 1 (running) "
    annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-82}),
        iconTransformation(extent={{-266,-94},{-242,-70}})));
  Modelica.Blocks.Logical.Switch switch__HP1_InternControll annotation (
      Placement(visible=true, transformation(
        origin={70,-10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch__HP2_InternControll2 annotation (
      Placement(visible=true, transformation(
        origin={70,-50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Math.Add add_HP_Pel "Sum of Pel of HP1 and HP2"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=-0.001)
    annotation (Placement(transformation(extent={{-120,-20},{-100,0}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=-0.001)
    annotation (Placement(transformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealOutput u_HeatPump_controll
    annotation (Placement(transformation(extent={{1560,-314},{1580,-294}})));
  Modelica.Blocks.Logical.Switch switch__HP1_InternControll1
                                                            annotation (
      Placement(visible=true, transformation(
        origin={1052,-250},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch__HP2_InternControll1 annotation (
      Placement(visible=true, transformation(
        origin={1050,-320},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Math.Add add_HP_Pel1
                                      "Sum of Pel of HP1 and HP2"
    annotation (Placement(transformation(extent={{1160,-290},{1180,-270}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput P_el_CHP_district
    "electrical production chp in kW"
    annotation (Dialog(
      tab="System feedback",
      group="Units properties",
      enable=not selectable), Placement(transformation(extent={{1600,-20},{1560,20}})));
  Modelica.Blocks.Math.Add add_HP_Pel2
                                      "Sum of Pel of HP1 and HP2"
    annotation (Placement(transformation(extent={{1518,10},{1498,30}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{1100,-280},{1120,-260}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{1100,-300},{1120,-280}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{1300,-20},{1280,0}})));
  Modelica.Blocks.Sources.Constant Heatpump_Constants_carbon_intensity_threshold(k=100)
    annotation (Placement(visible=true, transformation(
        origin={-70,-620},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant Heatpump_Constants_storage_el_SOC_threshold(k=20)
    annotation (Placement(visible=true, transformation(
        origin={-70,-660},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant Heatpump_Constants_T_TES_max_set(k=95)
    annotation (Placement(visible=true, transformation(
        origin={-70,-700},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  UnitController.Electrolysis.Electrolysis_Controller electrolysis_Controller annotation (Placement(transformation(extent={{302,-366},{346,-332}})));
  Modelica.Blocks.Sources.Constant Electrolysis_Constants_carbon_intensity_threshold(k=100)
    annotation (Placement(visible=true, transformation(
        origin={-70,-740},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_T_TES_load
    "Forward flow temperature of the heat grid in °C"
    annotation (Dialog(
      tab="System feedback",
      group="System properties",
      enable=not selectable), Placement(transformation(extent={{1600,70},{1560,110}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput u_T_TES_unload
    "Forward flow temperature of the heat grid in °C"
    annotation (Dialog(
      tab="System feedback",
      group="System properties",
      enable=not selectable), Placement(transformation(extent={{1600,110},{1560,150}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput P_el_demand_district
    "electrical demand in the district in kW"
    annotation (Dialog(
      tab="External profiles",
      group="Load profiles",
      enable=not selectable), Placement(transformation(extent={{1600,-100},{1560,-60}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{1440,10},{1420,30}})));
  Modelica.Blocks.Logical.Pre pre_HeatPump "Previous state of the Heat Pump"
    annotation (Placement(transformation(extent={{364,-316},{376,-304}})));
  Modelica.Blocks.Logical.Pre pre_Electrolysis
    "Previous state of the Electrolysis"
    annotation (Placement(transformation(extent={{364,-366},{376,-354}})));
  Components.busbar_4consumer busbar_4consumer
    annotation (Placement(transformation(extent={{1364,-72},{1344,-52}})));
  replaceable
  Modelica.Blocks.Interfaces.RealInput P_el_demand_emobility "electrical demand in the district in kW"
    annotation (Dialog(
      tab="External profiles",
      group="Load profiles",
      enable=not selectable), Placement(transformation(extent={{1600,-70},{1560,-30}})));
  UnitController.CHP.CHP_controller cHP_controller annotation (Placement(transformation(extent={{302,-426},{346,-394}})));
  Modelica.Blocks.Logical.Pre pre_CHP "Previous state of the CHP"
    annotation (Placement(visible=true,transformation(extent={{364,-422},{376,-410}})));
  UnitController.Boiler.Boiler_Controller boiler_Controller annotation (Placement(visible=true,transformation(extent={{302,-472},{346,-440}})));
  Modelica.Blocks.Logical.Pre pre_Boiler "Previous state of the Boiler"
    annotation (Placement(transformation(extent={{364,-476},{376,-464}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{256,-470},{268,-458}})));
  Components.MultiMin multiMin(nu=5) annotation (Placement(transformation(extent={{-160,-460},{-140,-440}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2(threshold=-0.0001)
    annotation (Placement(transformation(extent={{-120,-460},{-100,-440}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(extent={{376,-334},{364,-322}})));
  Modelica.Blocks.Math.Min min1 annotation (Placement(transformation(extent={{-120,-128},{-100,-108}})));
  UnitController.TES.TES_Controller tES_Controller annotation (Placement(transformation(extent={{304,-574},{348,-532}})));
  replaceable Modelica.Blocks.Interfaces.RealInput u_TES_load_scheudle annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable), Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-426}),
        iconTransformation(extent={{-270,-438},{-246,-414}})));
  replaceable Modelica.Blocks.Interfaces.RealInput u_TES_unload_scheudle annotation (Dialog(tab = "External profiles",group = "Scheudle profiles",enable=not selectable), Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-482}),
        iconTransformation(extent={{-270,-494},{-246,-470}})));
  Modelica.Blocks.Logical.Switch switch_TES_load_extrernSchedule annotation (Placement(visible=true, transformation(
        origin={70,-474},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch_TES_unload_extrernSchedule annotation (Placement(visible=true, transformation(
        origin={70,-508},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Modelica.Blocks.Interfaces.RealInput P_inst_th_TES_unload annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(visible=true,transformation(extent={{-12,-12},{12,12}}, origin={-254,-592}),
                                                                                                                                                                                                        iconTransformation(extent={{-260,-8},{-236,16}})));
  replaceable Modelica.Blocks.Interfaces.RealInput P_inst_th_TES_load annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(visible=true,Placement(transformation(extent={{-260,-566},{-236,-542}}), iconTransformation(extent={{-260,42},{-236,66}}))));
  replaceable Modelica.Blocks.Interfaces.RealInput P_th_demand_district "electrical demand in the district in kW" annotation (Dialog(
      tab="External profiles",
      group="Load profiles",
      enable=not selectable), Placement(transformation(extent={{1600,-190},{1560,-150}})));
  replaceable Modelica.Blocks.Interfaces.RealInput u_T_HeatGrid_RF_actual "electrical demand in the district in kW" annotation (Dialog(
      tab="External profiles",
      group="Load profiles",
      enable=not selectable), Placement(transformation(extent={{1600,210},{1560,250}})));
  Components.calc_Qdot_production calc_Qdot_production annotation (Placement(transformation(extent={{-98,-860},{-60,-822}})));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_Heatpump1 annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(
      visible=true,
      transformation(
        origin={-256,-740},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-250,-560},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_Heatpump2 annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(
      visible=true,
      transformation(
        origin={-256,-780},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-250,-600},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_Electrolyzer annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(
      visible=true,
      transformation(
        origin={-256,-820},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-250,-640},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_CHP annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(
      visible=true,
      transformation(
        origin={-256,-860},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-250,-680},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_Boiler annotation (Dialog(tab = "System feedback",group = "Units properties",enable=not selectable),Placement(
      visible=true,
      transformation(
        origin={-256,-900},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-250,-720},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput u_TES_load_controll annotation (Placement(visible=true,transformation(extent={{1560,-470},{1580,-450}})));
  Modelica.Blocks.Interfaces.RealOutput u_TES_unload_controll annotation (Placement(visible=true,transformation(extent={{1560,-510},{1580,-490}})));
equation
  connect(const5.y, switch_HP_extrernSchedule.u3) annotation (Line(points={{-59,
          -560},{0,-560},{0,-318},{58,-318}},                          color={0,
          0,127}));
  connect(const5.y, switch_Electrolyzer_extrernSchedule.u3) annotation (Line(
        points={{-59,-560},{0,-560},{0,-358},{58,-358}},   color={0,0,127}));
  connect(const5.y, switch_CHP__extrernSchedule.u3) annotation (Line(points={{-59,-560},{0,-560},{0,-398},{56,-398}},
                                                    color={0,0,127}));
  connect(const5.y, switch_Boiler__extrernSchedule.u3) annotation (Line(points={{-59,
          -560},{0,-560},{0,-438},{58,-438}},         color={0,0,127}));
  connect(HeatingCurve_DistrictGrid.u, u_TempAmb_extern)
    annotation (Line(points={{436,280},{92,280},{92,282},{-256,282}},
                                                    color={0,0,127}));
  connect(switch_HP_extrernSchedule.y, heatPump_Controller.signal_HP_prio_ext)
    annotation (Line(points={{81,-310},{300.8,-310}},  color={0,0,127}));
  connect(switch_HP_extrernSchedule.u1, u_HeatPump_scheudle)
    annotation (Line(points={{58,-302},{24,-302},{24,-296},{-254,-296}},
                                                      color={0,0,127}));
  connect(u_Electrolyzer_scheudle, switch_Electrolyzer_extrernSchedule.u1)
    annotation (Line(points={{-254,-334},{24,-334},{24,-342},{58,-342}},
                                                     color={0,0,127}));
  connect(u_CHP_scheudle, switch_CHP__extrernSchedule.u1)
    annotation (Line(points={{-254,144},{40,144},{40,-382},{56,-382}},
                                                     color={0,0,127}));
  connect(u_Boiler_scheudle, switch_Boiler__extrernSchedule.u1)
    annotation (Line(points={{-254,-382},{24,-382},{24,-422},{58,-422}},
                                                     color={0,0,127}));
  connect(u_co2_extern, heatPump_Controller.carbon_intensity) annotation (
      Line(points={{-254,240},{168,240},{168,-232},{270,-232},{270,-288},{300.8,-288}},
                                                                color={0,0,
          127}));
  connect(HeatingCurve_DistrictGrid.y, u_T_HeatGrid_FF_set)
    annotation (Line(points={{459,280},{1570,280}}, color={0,0,127}));
  connect(const1.y,switch__HP1_InternControll. u3) annotation (Line(points={{-59,
          -520},{0,-520},{0,-18},{58,-18}},          color={0,0,127}));
  connect(switch__HP1_InternControll.u1, P_inst_el_HP1) annotation (Line(points={{58,-2},{-36,-2},{-36,80},{-254,80}},
                                                color={0,0,127}));
  connect(switch__HP2_InternControll2.u1, P_inst_el_HP2) annotation (Line(
        points={{58,-42},{-8,-42},{-8,46},{-254,46}},   color={0,0,127}));
  connect(const1.y, switch__HP2_InternControll2.u3) annotation (Line(points={{-59,
          -520},{0,-520},{0,-58},{58,-58}},     color={0,0,127}));
  connect(switch__HP1_InternControll.y, add_HP_Pel.u1)
    annotation (Line(points={{81,-10},{81,-24},{98,-24}}, color={0,0,127}));
  connect(switch__HP2_InternControll2.y, add_HP_Pel.u2)
    annotation (Line(points={{81,-50},{98,-50},{98,-36}}, color={0,0,127}));
  connect(heatPump_Controller.Heatpump_Constants_P_el_HP_min, add_HP_Pel.y)
    annotation (Line(points={{300.8,-302},{260,-302},{260,-30},{121,-30}},
        color={0,0,127}));
  connect(switch__HP1_InternControll.u2, greaterThreshold.y)
    annotation (Line(points={{58,-10},{-99,-10}}, color={255,0,255}));
  connect(greaterThreshold.u, u_heatpump1_OA) annotation (Line(points={{-122,-10},{-210,-10},{-210,-42},{-254,-42}},
                                                  color={0,0,127}));
  connect(switch__HP2_InternControll2.u2, greaterThreshold1.y)
    annotation (Line(points={{58,-50},{-99,-50}}, color={255,0,255}));
  connect(greaterThreshold1.u, u_heatpump2_OA) annotation (Line(points={{-122,-50},{-210,-50},{-210,-82},{-254,-82}},
                                                  color={0,0,127}));
  connect(u_heatpump1_OA, max1.u1) annotation (Line(points={{-254,-42},{-160,-42},{-160,-84},{-122,-84}},
                                       color={0,0,127}));
  connect(u_heatpump2_OA, max1.u2) annotation (Line(points={{-254,-82},{-170,-82},{-170,-96},{-122,-96}},
                                       color={0,0,127}));
  connect(max1.y, heatPump_Controller.signal_HP_prio_int) annotation (Line(
        points={{-99,-90},{250,-90},{250,-308},{300.8,-308}}, color={0,0,127}));
  connect(heatPump_Controller.Heatpump_Specification_Value,
    switch__HP2_InternControll1.u1) annotation (Line(points={{347,-299},{1020,
          -299},{1020,-312},{1038,-312}}, color={0,0,127}));
  connect(greaterThreshold.y, switch__HP1_InternControll1.u2) annotation (Line(
        points={{-99,-10},{38,-10},{38,-100},{1000,-100},{1000,-250},{1040,-250}},
        color={255,0,255}));
  connect(greaterThreshold1.y, switch__HP2_InternControll1.u2) annotation (Line(
        points={{-99,-50},{20,-50},{20,-120},{980,-120},{980,-320},{1038,-320}},
        color={255,0,255}));
  connect(heatPump_Controller.Heatpump_Specification_Value,
    switch__HP1_InternControll1.u1) annotation (Line(points={{347,-299},{1020,
          -299},{1020,-242},{1040,-242}}, color={0,0,127}));
  connect(const1.y, switch__HP1_InternControll1.u3) annotation (Line(points={{-59,
          -520},{490,-520},{490,-258},{1040,-258}},                       color=
         {0,0,127}));
  connect(const1.y, switch__HP2_InternControll1.u3) annotation (Line(points={{-59,
          -520},{490,-520},{490,-328},{1038,-328}},                       color=
         {0,0,127}));
  connect(add_HP_Pel2.u1, P_el_pv_district)
    annotation (Line(points={{1520,26},{1520,40},{1580,40}}, color={0,0,127}));
  connect(add_HP_Pel2.u2, P_el_CHP_district)
    annotation (Line(points={{1520,14},{1520,0},{1580,0}}, color={0,0,127}));
  connect(switch__HP1_InternControll1.y, product1.u2) annotation (Line(points={
          {1063,-250},{1080,-250},{1080,-276},{1098,-276}}, color={0,0,127}));
  connect(product1.y, add_HP_Pel1.u1) annotation (Line(points={{1121,-270},{
          1138,-270},{1138,-274},{1158,-274}}, color={0,0,127}));
  connect(switch__HP2_InternControll1.y, product2.u1) annotation (Line(points={
          {1061,-320},{1080,-320},{1080,-284},{1098,-284}}, color={0,0,127}));
  connect(product2.y, add_HP_Pel1.u2) annotation (Line(points={{1121,-290},{
          1139.5,-290},{1139.5,-286},{1158,-286}}, color={0,0,127}));
  connect(P_inst_el_HP1, product1.u1) annotation (Line(points={{-254,80},{1098,80},{1098,-264}},
                            color={0,0,127}));
  connect(P_inst_el_HP2, product2.u2) annotation (Line(points={{-254,46},{-8,46},{-8,-40},{48,-40},{48,-176},{1088,-176},{1088,-296},{1098,-296}},
                                        color={0,0,127}));
  connect(add_HP_Pel1.y, feedback.u2) annotation (Line(points={{1181,-280},{
          1290,-280},{1290,-18}}, color={0,0,127}));
  connect(heatPump_Controller.Heatpump_Constants_carbon_intensity_threshold,
    Heatpump_Constants_carbon_intensity_threshold.y) annotation (Line(points={{
          300.8,-290},{200,-290},{200,-620},{-59,-620}}, color={0,0,127}));
  connect(heatPump_Controller.Heatpump_Constants_storage_el_SOC_threshold,
    Heatpump_Constants_storage_el_SOC_threshold.y) annotation (Line(points={{
          300.8,-294},{220,-294},{220,-660},{-59,-660}}, color={0,0,127}));
  connect(heatPump_Controller.Heatpump_Constants_T_TES_max_set,
    Heatpump_Constants_T_TES_max_set.y) annotation (Line(points={{300.8,-306},{
          240,-306},{240,-700},{-59,-700}}, color={0,0,127}));
  connect(electrolysis_Controller.signal_Electrolysis_prio_ext,
    switch_Electrolyzer_extrernSchedule.y) annotation (Line(points={{300.8,-360},
          {104,-360},{104,-350},{81,-350}}, color={0,0,127}));
  connect(electrolysis_Controller.Electrolysis_Specification_Value,
    u_Electrolyzer_controll)
    annotation (Line(points={{347,-349},{1570,-350}}, color={0,0,127}));
  connect(electrolysis_Controller.carbon_intensity, u_co2_extern) annotation (
      Line(points={{300.8,-338},{184,-338},{184,-232},{168,-232},{168,240},{-254,240}},
                      color={0,0,127}));
  connect(Heatpump_Constants_T_TES_max_set.y, electrolysis_Controller.Electrolysis_Constants_T_TES_max_set)
    annotation (Line(points={{-59,-700},{290,-700},{290,-356},{300.8,-356}},
        color={0,0,127}));
  connect(Electrolysis_Constants_carbon_intensity_threshold.y,
    electrolysis_Controller.Electrolysis_Constants_carbon_intensity_threshold)
    annotation (Line(points={{-59,-740},{286,-740},{286,-340},{300.8,-340}},
        color={0,0,127}));
  connect(electrolysis_Controller.Electrolysis_Constants_storage_el_SOC_threshold,
    Heatpump_Constants_storage_el_SOC_threshold.y) annotation (Line(points={{
          300.8,-344},{280,-344},{280,-660},{-59,-660}}, color={0,0,127}));
  connect(u_T_TES_load, heatPump_Controller.T_TES_load) annotation (Line(points=
         {{1580,90},{290,90},{290,-304},{300.8,-304}}, color={0,0,127}));
  connect(u_T_TES_load, electrolysis_Controller.T_TES_load) annotation (Line(
        points={{1580,90},{290,90},{290,-354},{300.8,-354}}, color={0,0,127}));
  connect(u_T_TES_unload, heatPump_Controller.T_TES_unload) annotation (Line(
        points={{1580,130},{294,130},{294,-296},{300.8,-296}}, color={0,0,127}));
  connect(u_T_TES_unload, electrolysis_Controller.T_TES_unload) annotation (
      Line(points={{1580,130},{294,130},{294,-346},{300.8,-346}}, color={0,0,
          127}));
  connect(HeatingCurve_DistrictGrid.y, heatPump_Controller.T_DH_FF_set)
    annotation (Line(points={{459,280},{480,280},{480,-254},{296,-254},{296,
          -298},{300.8,-298}}, color={0,0,127}));
  connect(HeatingCurve_DistrictGrid.y, electrolysis_Controller.T_DH_FF_set)
    annotation (Line(points={{459,280},{480,280},{480,-254},{296,-254},{296,
          -348},{300.8,-348}}, color={0,0,127}));
  connect(E_el_EES, heatPump_Controller.SOC_EES) annotation (Line(points={{1580,-120},{298,-120},{298,-292},{300.8,-292}},
                                                     color={0,0,127}));
  connect(E_el_EES, electrolysis_Controller.SOC_EES) annotation (Line(points={{1580,-120},{298,-120},{298,-342},{300.8,-342}},
                                                          color={0,0,127}));
  connect(P_inst_el_Electrolyzer, electrolysis_Controller.Electrolysis_Constants_P_el_min)
    annotation (Line(points={{-254,-2},{-218,-2},{-218,-138},{120,-138},{120,-352},{300.8,-352}},
                         color={0,0,127}));
  connect(u_electrolyzer_OA, electrolysis_Controller.signal_Electrolysis_prio_int)
    annotation (Line(points={{-254,-124},{-220,-124},{-220,-204},{110,-204},{110,-358},{300.8,-358}},
                                   color={0,0,127}));
  connect(feedback.y, electrolysis_Controller.P_el_renergy) annotation (Line(
        points={{1281,-10},{270,-10},{270,-350},{300.8,-350}}, color={0,0,127}));
  connect(heatPump_Controller.P_el_renergy, feedback1.y) annotation (Line(
        points={{300.8,-300},{280,-300},{280,20},{1421,20}}, color={0,0,127}));
  connect(feedback1.y, feedback.u1) annotation (Line(points={{1421,20},{1320,20},
          {1320,-10},{1298,-10}}, color={0,0,127}));
  connect(add_HP_Pel2.y, feedback1.u1)
    annotation (Line(points={{1497,20},{1438,20}}, color={0,0,127}));
  connect(feedback1.u2, P_el_demand_district) annotation (Line(points={{1430,12},{1430,-80},{1580,-80}},
                                  color={0,0,127}));
  connect(heatPump_Controller.Heatpump_Specification_SI, pre_HeatPump.u)
    annotation (Line(points={{347,-310},{362.8,-310}}, color={255,0,255}));
  connect(electrolysis_Controller.Electrolysis_Specification_SI,
    pre_Electrolysis.u)
    annotation (Line(points={{347,-360},{362.8,-360}}, color={255,0,255}));
  connect(P_el_CHP_district, busbar_4consumer.u_ProductionCHP)
    annotation (Line(points={{1580,0},{1360,0},{1360,-50}}, color={0,0,127}));
  connect(P_el_pv_district, busbar_4consumer.uProductionPV) annotation (Line(
        points={{1580,40},{1528,40},{1528,-24},{1354,-24},{1354,-50}}, color={0,
          0,127}));
  connect(P_el_demand_district, busbar_4consumer.u_DemandHouses) annotation (
      Line(points={{1580,-80},{1430,-80},{1430,-64},{1366,-64},{1366,-65}},
        color={0,0,127}));
  connect(add_HP_Pel1.y, busbar_4consumer.u_DemandHeatPump) annotation (Line(
        points={{1181,-280},{1290,-280},{1290,-94},{1400,-94},{1400,-59},{1366,
          -59}}, color={0,0,127}));
  connect(electrolysis_Controller.Electrolysis_Specification_Value,
    busbar_4consumer.u_DemandElectrolyser) annotation (Line(points={{347,-349},
          {884,-349},{884,-350},{1420,-350},{1420,-54},{1366,-54}}, color={0,0,
          127}));
  connect(busbar_4consumer.u_EMob, P_el_demand_emobility) annotation (Line(
        points={{1366,-70},{1500,-70},{1500,-50},{1580,-50}}, color={0,0,127}));
  connect(switch_CHP__extrernSchedule.y, cHP_controller.signal_CHP_prio_ext)
    annotation (Line(points={{79,-390},{190,-390},{190,-413.2},{300.68,-413.2}},
        color={0,0,127}));
  connect(u_CHP_OA, cHP_controller.signal_CHP_prio_int) annotation (Line(points={{-254,-162},{288,-162},{288,-406.8},{300.68,-406.8}},
                                                                color={0,0,127}));
  connect(HeatingCurve_DistrictGrid.y, cHP_controller.T_DH_FF_set) annotation (
      Line(points={{459,280},{480,280},{480,-254},{298,-254},{298,-419.6},{300.68,-419.6}},
                           color={0,0,127}));
  connect(u_T_TES_load, cHP_controller.T_TES_FF) annotation (Line(points={{1580,90},{288,90},{288,-426},{300.68,-426}},
                                                      color={0,0,127}));
  connect(cHP_controller.CHP_Specification_Value, u_CHP_controll) annotation (
      Line(points={{347.32,-410},{1536,-410},{1536,-390},{1570,-390}}, color={0,
          0,127}));
  connect(cHP_controller.CHP_Specification_SI, pre_CHP.u) annotation (Line(
        points={{347.32,-416.4},{362.8,-416}}, color={255,0,255}));
  connect(HeatingCurve_DistrictGrid.y, boiler_Controller.T_DH_FF_set)
    annotation (Line(points={{459,280},{480,280},{480,-254},{296,-254},{296,
          -459.2},{300.24,-459.2}}, color={0,0,127}));
  connect(u_CHP_OA, boiler_Controller.u_chp_oa) annotation (Line(points={{-254,-162},{288,-162},{288,-472},{300.24,-472}},
                                                      color={0,0,127}));
  connect(u_T_HeatGrid_FF_actual, boiler_Controller.T_DH_FF) annotation (Line(
        points={{1580,170},{420,170},{420,-438},{294,-438},{294,-452},{300.24,
          -452},{300.24,-452.8}}, color={0,0,127}));
  connect(boiler_Controller.Boiler_Specification_SI, pre_Boiler.u) annotation (
      Line(points={{347.32,-468.8},{355.06,-468.8},{355.06,-470},{362.8,-470}},
        color={255,0,255}));
  connect(boiler_Controller.Boiler_Specification_Value, u_Boiler_controll)
    annotation (Line(points={{347.32,-456},{1480,-456},{1480,-430},{1570,-430}},
        color={0,0,127}));
  connect(switch_Boiler__extrernSchedule.y, boiler_Controller.signal_Boiler_prio_ext)
    annotation (Line(points={{81,-430},{288,-430},{288,-446.4},{300.24,-446.4}},
        color={0,0,127}));
  connect(u_boiler_OA, boiler_Controller.signal_Boiler_prio_int) annotation (
      Line(points={{-254,-204},{288,-204},{288,-440.64},{300.24,-440.64}},
        color={0,0,127}));
  connect(booleanToReal.y, boiler_Controller.staus_chp) annotation (Line(points=
         {{268.6,-464},{268.6,-465.6},{300.24,-465.6}}, color={0,0,127}));
  connect(pre_CHP.y, booleanToReal.u) annotation (Line(points={{376.6,-416},{
          382,-416},{382,-428},{248,-428},{248,-464},{254.8,-464}}, color={255,
          0,255}));
  connect(u_heatpump1_OA, multiMin.u[1]) annotation (Line(points={{-254,-42},{-188,-42},{-188,-456},{-184,-456},{-184,-444.4},{-160,-444.4}},
                                                                          color=
         {0,0,127}));
  connect(u_heatpump2_OA, multiMin.u[2]) annotation (Line(points={{-254,-82},{-196,-82},{-196,-456},{-184,-456},{-184,-447.2},{-160,-447.2}},
                                                                          color=
         {0,0,127}));
  connect(u_electrolyzer_OA, multiMin.u[3]) annotation (Line(points={{-254,-124},{-202,-124},{-202,-450},{-160,-450}},
                                                color={0,0,127}));
  connect(u_CHP_OA, multiMin.u[4]) annotation (Line(points={{-254,-162},{-206,-162},{-206,-452},{-170,-452},{-170,-452.8},{-160,-452.8}},
                                                                      color={0,
          0,127}));
  connect(multiMin.y, greaterThreshold2.u)
    annotation (Line(points={{-138.3,-450},{-122,-450}}, color={0,0,127}));
  connect(greaterThreshold2.y, switch_HP_extrernSchedule.u2) annotation (Line(
        points={{-99,-450},{16,-450},{16,-310},{58,-310}}, color={255,0,255}));
  connect(greaterThreshold2.y, switch_Electrolyzer_extrernSchedule.u2)
    annotation (Line(points={{-99,-450},{16,-450},{16,-350},{58,-350}}, color={
          255,0,255}));
  connect(greaterThreshold2.y, switch_CHP__extrernSchedule.u2) annotation (Line(
        points={{-99,-450},{16,-450},{16,-390},{56,-390}}, color={255,0,255}));
  connect(greaterThreshold2.y, switch_Boiler__extrernSchedule.u2) annotation (
      Line(points={{-99,-450},{16,-450},{16,-430},{58,-430}}, color={255,0,255}));
  connect(u_HeatPump_controll, heatPump_Controller.Heatpump_Specification_Value)
    annotation (Line(points={{1570,-304},{1020,-304},{1020,-299},{347,-299}},
        color={0,0,127}));
  connect(multiMin.u[5], u_boiler_OA) annotation (Line(points={{-160,-455.6},{-184,-455.6},{-184,-204},{-254,-204}},
                                                 color={0,0,127}));
  connect(u_T_HeatGrid_FF_actual, heatPump_Controller.T_DH_FF_actual) annotation (Line(points={{1580,170},{294,170},{294,-312},{300.8,-312}}, color={0,0,127}));
  connect(cHP_controller.u_status_Heatpump, booleanToReal1.y) annotation (Line(points={{300.68,-394},{300.68,-368},{352,-368},{352,-328},{363.4,-328}}, color={0,0,127}));
  connect(pre_HeatPump.y, booleanToReal1.u) annotation (Line(points={{376.6,-310},{400,-310},{400,-328},{377.2,-328}}, color={255,0,255}));
  connect(u_heatpump1_OA, min1.u1) annotation (Line(points={{-254,-42},{-184,-42},{-184,-112},{-122,-112}}, color={0,0,127}));
  connect(u_heatpump2_OA, min1.u2) annotation (Line(points={{-254,-82},{-168,-82},{-168,-124},{-122,-124}}, color={0,0,127}));
  connect(min1.y, cHP_controller.u_Heatpump_oa) annotation (Line(points={{-99,-118},{-88,-118},{-88,-208},{256,-208},{256,-400.4},{300.68,-400.4}}, color={0,0,127}));
  connect(u_TES_unload_scheudle, switch_TES_unload_extrernSchedule.u1) annotation (Line(points={{-254,-482},{24,-482},{24,-500},{58,-500}}, color={0,0,127}));
  connect(u_TES_load_scheudle, switch_TES_load_extrernSchedule.u1) annotation (Line(points={{-254,-426},{-208,-426},{-208,-466},{58,-466}},
                                                                                                                                        color={0,0,127}));
  connect(greaterThreshold2.y, switch_TES_unload_extrernSchedule.u2) annotation (Line(points={{-99,-450},{18,-450},{18,-508},{58,-508}}, color={255,0,255}));
  connect(greaterThreshold2.y, switch_TES_load_extrernSchedule.u2) annotation (Line(points={{-99,-450},{18,-450},{18,-474},{58,-474}}, color={255,0,255}));
  connect(const5.y, switch_TES_load_extrernSchedule.u3) annotation (Line(points={{-59,-560},{2,-560},{2,-482},{58,-482}}, color={0,0,127}));
  connect(const5.y, switch_TES_unload_extrernSchedule.u3) annotation (Line(points={{-59,-560},{2,-560},{2,-516},{58,-516}}, color={0,0,127}));
  connect(switch_TES_load_extrernSchedule.y, tES_Controller.signal_TES_load_prio_ext) annotation (Line(points={{81,-474},{192,-474},{192,-534.1},{302.68,-534.1}}, color={0,0,127}));
  connect(switch_TES_unload_extrernSchedule.y, tES_Controller.signal_TES_unload_prio_ext) annotation (Line(points={{81,-508},{180,-508},{180,-538.3},{302.68,-538.3}}, color={0,0,127}));
  connect(Heatpump_Constants_T_TES_max_set.y, tES_Controller.T_TES_max_set) annotation (Line(points={{-59,-700},{240,-700},{240,-564},{302.68,-564},{302.68,-563.5}}, color={0,0,127}));
  connect(P_inst_th_TES_load, tES_Controller.P_th_TES_load) annotation (Line(points={{0,0},{-88,0},{-88,-567.7},{302.68,-567.7}},          color={0,0,127}));
  connect(P_inst_th_TES_unload, tES_Controller.P_th_TES_unload) annotation (Line(points={{-254,-592},{272,-592},{272,-571.9},{302.68,-571.9}}, color={0,0,127}));
  connect(u_T_TES_unload, tES_Controller.T_TES_unload) annotation (Line(points={{1580,130},{294,130},{294,-550.9},{302.68,-550.9}}, color={0,0,127}));
  connect(u_T_TES_load, tES_Controller.T_TES_load) annotation (Line(points={{1580,90},{296,90},{296,-562},{300,-562},{300,-559.3},{302.68,-559.3}}, color={0,0,127}));
  connect(P_th_demand_district, tES_Controller.P_th_DH_demand) annotation (Line(points={{1580,-170},{288,-170},{288,-546.7},{302.68,-546.7}}, color={0,0,127}));
  connect(u_T_HeatGrid_RF_actual, tES_Controller.T_DH_RF) annotation (Line(points={{1580,230},{894,230},{894,226},{208,226},{208,-555.1},{302.68,-555.1}}, color={0,0,127}));
  connect(u_Qdot_Heatpump1, calc_Qdot_production.u_Qdot_Heatpump1) annotation (Line(points={{-256,-740},{-120,-740},{-120,-822},{-99.9,-822}}, color={0,0,127}));
  connect(u_Qdot_Heatpump2, calc_Qdot_production.u_Qdot_Heatpump2) annotation (Line(points={{-256,-780},{-128,-780},{-128,-829.6},{-99.9,-829.6}}, color={0,0,127}));
  connect(u_Qdot_Electrolyzer, calc_Qdot_production.u_Qdot_Electrolyzer) annotation (Line(points={{-256,-820},{-136,-820},{-136,-837.2},{-99.9,-837.2}}, color={0,0,127}));
  connect(u_Qdot_CHP, calc_Qdot_production.u_Qdot_CHP) annotation (Line(points={{-256,-860},{-134,-860},{-134,-844.8},{-99.9,-844.8}}, color={0,0,127}));
  connect(u_Qdot_Boiler, calc_Qdot_production.u_Qdot_Boiler) annotation (Line(points={{-256,-900},{-124,-900},{-124,-852},{-99.9,-852},{-99.9,-852.4}}, color={0,0,127}));
  connect(calc_Qdot_production.y_Qdot_reg, tES_Controller.P_th_DH_supply) annotation (Line(points={{-58.1,-856.2},{270,-856.2},{270,-542},{302.68,-542},{302.68,-542.5}}, color={0,0,127}));
  connect(tES_Controller.TES_load_SI, u_TES_load_controll) annotation (Line(points={{350.2,-544.6},{350.2,-544},{960,-544},{960,-460},{1570,-460}}, color={0,0,127}));
  connect(tES_Controller.TES_unload_SI, u_TES_unload_controll) annotation (Line(points={{350.2,-561.4},{1536,-561.4},{1536,-500},{1570,-500}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,-1020},{1560,300}}), graphics={Rectangle(
          extent={{-242,300},{1560,-1022}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Bitmap(
          extent={{-262,-1000},{1554,278}},
          imageSource="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i5a6NvD+DYVIQR0cqalxpKK2n5IaQypq+6mpcaSgtp2aGkcqavspqTGkorafmhpHCmrbqalxpKK2n5Iaw6Klrg28f0MhUlAHR2pqHKmo7aekxpCK2n5qahwpqG2npsaRitp+SmoMqajtp6bGkYLadmpqHKmo7aekxrBoqWsD799QiAAAgJLUtYH3byhEAABASerawPs3FCIAAKAkdW3g/RsKEQAAUJK6NvD+DYUIAAAoSV0beP+GQgQAAJSkrg28f0MhAgAASlLXBt6/oRABAAAlqWsD799QiAAAgJLUtYH3byhEAABASerawPs3FCIAAKAkdW3g/RsKEQAAUJK6NvD+DYUIAAAoSV0beP+GQgQAAJSkrg28f0MhAgAASlLXBt6/oRABAAAlqWsD799QiAAAgJLUtYH3byhEAABASerawPs3FCIAAKAkdW3g/RsKEQAAUJK6NvD+DYUIAAAoSV0beP+GQgQAAJSkrg28f0MhAgAASlLXBt6/oRABAAAlqWsD799QiAAAgJLUtYH3byhEAABASerawPs3FCIAAKAkdW3g/RsKEQAAUJK6NvD+DYUIAAAoSV0beP+GQgQAAJSkrg28f0MhAgAASlLXBt6/oRABAAAlqWsD799QiKyAQ+66EEtux4kvlY8dACxC6trA+zcUIgAAoCR1beD9GwoRAABQkro28P4NhQgAAChJXRt4/4ZCBAAAlKSuDbx/QyECAABKUtcG3r+hEAEAACWpawPv31CIAACAktS1gfdvKEQAAEBJ6trA+zcUIitAfYAWhm39iz+U9x8ArJrUtYH3byhEAABASerawPs3FCIAAKAkdW3g/RsKEQAAUJK6NvD+DYUIAAAoSV0beP+GQgQAAJSkrg28f0MhAgAASlLXBt6/oRABAAAlqWsD799QiKwA9ZkZmA11fwNA7lLXBt6/oRABAAAlqWsD799QiAAAgJLUtYH3byhEAABASerawPs3FCIAAKAkdW3g/RsKEQAAUJK6NvD+DYUIAAAoSV0beP+GQgQAAJSkrg28f0MhAgAASlLXBt6/oRABAAAlqWsD799QiAAAgJLUtYH3byhEAABASerawPs3FCIAAKAkdW3g/RsKEQBYFscc29t07hkD9m/ZBpiD1LWB928oRABgSfDtzlgWqWsD799QiGClbf/dt/Q27fvU0BNAE5su/Exv+zveKvsFJlE9xlQbYB5S1wbev6EQwUravPv0oUl/GlbMqO0AbVSPK9UGmIfUtYH3byhEsHKqk/0sqe0BTXE8YVmkrg28f0MhgpWy4Za9Q5P9LG24dZ/cLtBE9XhSbYB5SF0beP+GQgQr4/CXv2pook/BtqO2D4xTPZZUG2AeUtcG3r+hEMHKqE7yKantA8quZz5/8MJndRwZW7bzuBfIdYFUUtcG3r+hEMHKUJN8Kmr7QNXmL35EHj+KvcBa9QGkkLo28P4NhQhWhprcU1HbB6JD3/LmoeOl7t/G1vHbgJRS1wbev6EQwcrwyTyqWz7psupyQFHHS92/q22BlFLXBt6/oRDByoiTuZrUZ7WsuhxQ1PFS9+9qWyCl1LWB928oRLAy4mSuJvVZLasuBxR1vNT9u9oWSCl1beD9GwoRrIw4matJfVbLqssBRR03Tai+gFlLXRt4/4ZCBCtj3KQ+q2XV5YCijpsmVF/ArKWuDbx/QyGClaEm9VTU9oGBY46Vx0wbRzz5ON03MCOpawPv31CIYGWoCT0VtX3AqONlEqpvYFZS1wbev6EQwcoYN5nPall1OeDsW5rV8TIJvvEZKaWuDbx/QyGCpaUm31TU9urGUresuhxw6liZhtoGMAupawPv31CIYGmpiTcVtb26sdQtqy4HzKFveqM8VqZhfaptAdNKXRt4/4ZCBEtLTbypqO3VjaVuWXU5YDade4Y8Pqq3jfs53mZ9xtuBWUldG3j/hkIES8sn23lQ26sbS92y6vIcbD7rtKF9sC9kU20xmXjfqtub/hxvq96+0o45trftA+/tbbj+y73NZ3+sd+jJr9Pt0Ejq2sD7NxQiWFpxss2N2p9lpcYfqXXQ3qj7tHrbuJ/jbdXbV9XWD/1B6T6JVHuMl7o28P7NShUi6iCto/rA/KR8PHae8OKh/mdJbXORDnvlbwy+Rn7Drft6Gy/7fG/rX/xhb9fTjx/8X40/sjaqT7Sj7ttZUNtaJTtOfKm8X9bdvl+uh3qpawPv31CI1FB9YH6qj4cVD6rdJKp/irDb4s9+m2uzrLp8kaz4UONrS/WNdtT9OgtqW11yxFN/dlA8q33feM2Xehsv/4JcFql+US91beD9GwqRGqoPzI96TFJR26sbS92y6vJFUeOaBFdEZiPep+r2pj/H26q3d83W0/64tK+TUn2jXurawPs3FCI1VB+Y"
               + "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63o+9en/Nbjqpg62LlGTRNeo/e4Cta9do/Y7d2o/u0jte+7UfnaN2u8uUPvaNWq/c6f2s4vUvudO7WfXqP3uArWvXaP2u4ueftyLBue08Rz3+uuv7/zbauwFDnGfzdra2pWDiyH9H36kunDv3r3FqquXhx56qPfVr361dH/8t/f+Se+xT/qX8qDqIjVJdI3a7y5Q+9o1ar9zp/azi9S+507tZ9eo/e4Cta9do/Y7d2o/u0jte+7UfnaN2u8uUPvaNWq/u8zObd/+zv9ROue94IILBufCXc2+fftK+1v4Mbsg8prKjb0rrriiWG21Un1FiH0IqjqAuk5NEl2j9rsL1L52jdrv3Kn97CK177lT+9k1ar+7QO1r16j9zp3azy5S+547tZ9do/a7C9S+do3a71Xx/F98Vekc+LrrrivOjruVa665prSfhTfb22VOrS6wb05ZpdhLaOJ3FNsrQnL/YNRpqEmia9R+d4Ha165R+507tZ9dpPY9d2o/u0btdxeofe0atd+5U/vZRWrfc6f2s2vUfneB2teuUfu9auIrRnbv3t25zxi566671vfPra2tfdkuiPT/XV5g39e7KrFXw/h+2/up7OuM1AGyStQk0TVqv7tA7WvXqP3OndrPLlL7nju1n12j9rsL1L52jdrv3Kn97CK177lT+9k1ar+7QO1r16j9XkWPe9rPlz5j5NJLLy3OmvOPXePw/XJra2vn2wWRG6sL7KtpViHx63N/5+3vlgfFKlKTRNeo/e4Cta9do/Y7d2o/u0jte+7UfnaN2u8uUPvaNWq/c6f2s4vUvudO7WfXqP3uArWvXaP2e5W99rffsX6e/JWvfKU4e847I75+90b7DJGhBauQiy66aH1/7etz1YGwqtQk0TVqv7tA7WvXqP3OndrPLlL7nju1n12j9rsL1L52jdrv3Kn97CK177lT+9k1ar+7QO1r16j9XnW/dtKb1s+X9+/f34lvovH9iVbygsj555+/vq+/8h9fLw+AVaYmia5R+90Fal+7Ru137tR+dpHa99yp/ewatd9doPa1a9R+507tZxepfc+d2s+uUfvdBWpfu0btN36q96J/f9L6efN5553Xe/jhh4sz6jzj+xKt3AUR+9Rc3097KZB64FedmiS6Ru13F6h97Rq137lT+9lFat9zp/aza9R+d4Ha165R+507tZ9dpPY9d2o/u0btdxeofe0atd844JWv+Z318+errrqqOKvOM74f0UpdEPne9763vo+fOfOzK/1NMnXUJNE1ar+7QO1r16j9zp3azy5S+547tZ9do/a7C9S+do3a79yp/ewite+5U/vZNWq/u0Dta9eo/cZBn/jkp9fPo++5557i7Dq/+D5EK3VBxD4QxvfxhBf9unywwaSXM7WvXaP2O3dqP7tI7Xvu1H52jdrvLlD72jVqv3On9rOL1L7nTu1n16j97gK1r12j9hsH/cwvvHT9PNo+TyTX+D5EK3NB5M4771zfv/f+0Z/KBxoHqEmia9R+d4Ha165R+507tZ9dpPY9d2o/u0btdxeofe0atd+5U/vZRWrfc6f2s2vUfneB2teuUfuNsv/y3963fj79rW99qzjLzis+/mhlLohcffXV6/v3iy9/rXyQcYCaJLpG7XcXqH3tGrXfuVP72UVq33On9rNr1H53gdrXrlH7nTu1n12k9j13aj+7Ru13F6h97Rq13yh77r975fr59OWXX16cZecVH3+0MhdE4tfsPuEnfkE+yDhATRJdo/a7C9S+do3a79yp/ewite+5U/vZNWq/u0Dta9eo/c6d2s8uUvueO7WfXaP2uwvUvnaN2m+U2Tm0n0/bt7bmGB9/tDIXRPbu3bu+f0c/4VnyQcYBapLoGrXfXaD2tWvUfudO7WcXqX3PndrPrlH73QVqX7tG7Xfu1H52kdr33Kn97Bq1312g9rVr1H5jmJ9P79mzpzjLzis+/mhlLojE/VMPLg5Sk0TXqP3uArWvXaP2O3dqP7tI7Xvu1H52jdrvLlD72jVqv3On9rOL1L7nTu1n16j97gK1r12j9hvD4jl1jonjd1wQwRA1SXSN2u8uUPvaNWq/c6f2s4vUvudO7WfXqP3uArWvXaP2O3dqP7tI7Xvu1H52jdrvLlD72jVqvzEsnlPnmDh+xwURDFGTRNeo/e4Cta9do/Y7d2o/u0jte+7UfnaN2u8uUPvaNWq/c6f2s4vUvudO7WfXqP3uArWvXaP2G8PiOXWOieN3XBDBEDVJdI3a7y5Q+9o1ar9zp/azi9S+507tZ9eo/e4Cta9do/Y7d2o/u0jte+7UfnaN2u8uUPvaNWq/MSyeU+eYOH7HBREMUZNE16j97gK1r12j9jt3aj+7SO177tR+do3a7y5Q+9o1ar9zp/azi9S+507tZ9eo/e4Cta9do/Ybw+I5dY6J43dcEMEQNUl0jdrvLlD72jVqv3On9rOL1L7nTu1n16j97gK1r12j9jt3aj+7SO177tR+do3a7y5Q+9o1ar8xLJ5T55g4fscFEQxRk0TXqP3uArWvXaP2O3dqP7tI7Xvu1H52jdrvLlD72jVqv3On9rOL1L7nTu1n16j97gK1r12j9hvD4jl1jonjd1wQwRA1SXSN2u8uUPvaNWq/c6f2s4vUvudO7WfXqP3uArWvXaP2O3dqP7tI7Xvu1H52jdrvLlD72jVqvzEsnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBREAAAAAAFArnlPnmDh+xwURAAAAAABQK55T55g4fscFEQAAAAAAUCueU+eYOH7HBRGgIw6560IAU9px4kvl7xcAAMCqi+fUOSaO33FBBAAAAAAA1Irn1Dkmjt9xQQQAAAAAANSK59Q5Jo7fcUEEAAAAAADUiufUOSaO33FBBAAAAAAA1Irn1Dkmjt9xQQQAAAAAANSK59Q5Jo7fcUEEAAAAAADUiufUOSaO33FBBAAAAAAA1Irn1Dkmjt9xQQQAAAAAANSK59Q5Jo7fcUEE6IhD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"
               + "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",
          fileName="modelica://Q100_DistrictModel/../../../../../../../Pictures/Controller_icon.png")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-240,-1020},{1560,300}})));
end FMU_Controller;
