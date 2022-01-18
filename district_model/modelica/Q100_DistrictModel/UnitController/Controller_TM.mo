within Q100_DistrictModel.UnitController;
model Controller_TM "Coltroller for fmu"
  Modelica.Blocks.Interfaces.RealInput u_TempAmp_extern
    "Ambient temperature in °C"
    annotation (Placement(transformation(extent={{-264,268},{-240,292}}),
        iconTransformation(extent={{-264,268},{-240,292}})));
  Modelica.Blocks.Interfaces.RealInput u_co2_extern
    "CO2 intensity of the upstream electricity grid in g/kWh"
    annotation (Placement(transformation(extent={{-264,228},{-240,252}}),
        iconTransformation(extent={{-264,228},{-240,252}})));
  Modelica.Blocks.Interfaces.RealInput u_el_costs_extern
    "Electricity price intensity of the upstream electricity grid in €/kWh"
    annotation (Placement(transformation(extent={{-264,188},{-240,212}}),
        iconTransformation(extent={{-264,188},{-240,212}})));
  Modelica.Blocks.Interfaces.RealInput u_T_HeatGrid_RF_actual
    "Return flow temperature of the heat grid in °C"
    annotation (Placement(transformation(extent={{1600,230},{1560,270}})));
  Modelica.Blocks.Interfaces.RealInput u_T_HeatGrid_FF_actual
    "Forward flow temperature of the heat grid in °C"
    annotation (Placement(transformation(extent={{1600,150},{1560,190}})));
  Modelica.Blocks.Interfaces.RealInput u_mdot_HeatGrid_RF_actual
    "Return mass flow of the heat grid in kg/s"
    annotation (Placement(transformation(extent={{1600,190},{1560,230}})));
  Modelica.Blocks.Interfaces.RealInput P_el_pv_district
    "photovoltaic production in the district in kW"
    annotation (Placement(transformation(extent={{1600,20},{1560,60}})));
  Modelica.Blocks.Logical.Switch switch_HP_extrernSchedule annotation (
      Placement(visible=true, transformation(
        origin={70,-310},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant const5(k=-1)  annotation (
    Placement(visible = true, transformation(origin={-70,-560},     extent={{-10,-10},
            {10,10}},                                                                                rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant boolean_extrernSchedule(k=false)
    "True if extrern schedule should be used"                    annotation (
      Placement(visible=true, transformation(
        origin={-70,-480},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch_Electrolyzer_extrernSchedule
    annotation (Placement(visible=true, transformation(
        origin={70,-350},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch_CHP__extrernSchedule annotation (
      Placement(visible=true, transformation(
        origin={70,-390},
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
  HeatPump.HeatPump_Controller heatPump_Controller
    annotation (Placement(transformation(extent={{302,-316},{346,-282}})));
  Modelica.Blocks.Interfaces.RealInput u_HeatPump_scheudle
    annotation (Placement(transformation(extent={{-264,-312},{-240,-288}}),
        iconTransformation(extent={{-264,-312},{-240,-288}})));
  Modelica.Blocks.Interfaces.RealInput u_Electrolyzer_scheudle
    annotation (Placement(transformation(extent={{-264,-352},{-240,-328}}),
        iconTransformation(extent={{-264,-352},{-240,-328}})));
  Modelica.Blocks.Interfaces.RealInput u_Boiler_scheudle
    annotation (Placement(transformation(extent={{-264,-432},{-240,-408}}),
        iconTransformation(extent={{-264,-432},{-240,-408}})));
  Modelica.Blocks.Interfaces.RealInput u_CHP_scheudle
    annotation (Placement(transformation(extent={{-264,-392},{-240,-368}}),
        iconTransformation(extent={{-264,-392},{-240,-368}})));
  Modelica.Blocks.Interfaces.RealOutput u_HP2_controll
    annotation (Placement(transformation(extent={{1560,-330},{1580,-310}})));
  Modelica.Blocks.Interfaces.RealOutput u_Electrolyzer_controll
    annotation (Placement(transformation(extent={{1560,-360},{1580,-340}})));
  Modelica.Blocks.Interfaces.RealOutput u_CHP_controll
    annotation (Placement(transformation(extent={{1560,-400},{1580,-380}})));
  Modelica.Blocks.Interfaces.RealOutput u_Boiler_controll
    annotation (Placement(transformation(extent={{1560,-440},{1580,-420}})));
  Modelica.Blocks.Interfaces.RealOutput u_T_HeatGrid_FF_set
    annotation (Placement(transformation(extent={{1560,270},{1580,290}})));
  Modelica.Blocks.Sources.Constant const1(k=0)   annotation (
    Placement(visible = true, transformation(origin={-70,-520},     extent={{-10,-10},
            {10,10}},                                                                                rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput E_el_EES
    "state of charge - electrical storage (in %)"
    annotation (Placement(transformation(extent={{1600,-140},{1560,-100}})));
  Modelica.Blocks.Interfaces.RealInput P_inst_el_HP1 annotation (Placement(
        transformation(extent={{-264,68},{-240,92}}), iconTransformation(extent=
           {{-164,-52},{-140,-28}})));
  Modelica.Blocks.Interfaces.RealInput P_inst_el_HP2 annotation (Placement(
        transformation(extent={{-264,28},{-240,52}}), iconTransformation(extent=
           {{-164,-52},{-140,-28}})));
  Modelica.Blocks.Interfaces.RealInput P_inst_el_Electrolyzer annotation (
      Placement(transformation(extent={{-264,-12},{-240,12}}),
        iconTransformation(extent={{-164,-52},{-140,-28}})));
  Modelica.Blocks.Interfaces.RealInput    u_heatpump1_OA
    "Heat pump one status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{-264,-52},{-240,-28}}),
        iconTransformation(extent={{-264,-52},{-240,-28}})));
  Modelica.Blocks.Interfaces.RealInput    u_electrolyzer_OA
    "electrolyzer status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{-264,-132},{-240,-108}}),
        iconTransformation(extent={{-264,-132},{-240,-108}})));
  Modelica.Blocks.Interfaces.RealInput    u_CHP_OA
    "CHP status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{-264,-172},{-240,-148}}),
        iconTransformation(extent={{-264,-172},{-240,-148}})));
  Modelica.Blocks.Interfaces.RealInput    u_boiler_OA
    "Boiler status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{-264,-212},{-240,-188}}),
        iconTransformation(extent={{-264,-212},{-240,-188}})));
  Modelica.Blocks.Interfaces.RealInput    u_heatpump2_OA
    "Heat pump two status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{-264,-92},{-240,-68}}),
        iconTransformation(extent={{-264,-92},{-240,-68}})));
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
  Modelica.Blocks.Interfaces.RealOutput u_HP1_controll
    annotation (Placement(transformation(extent={{1560,-290},{1580,-270}})));
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
  Modelica.Blocks.Interfaces.RealInput P_el_CHP_district
    "electrical production chp in kW"
    annotation (Placement(transformation(extent={{1600,-20},{1560,20}})));
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
  Electrolysis.Electrolysis_Controller electrolysis_Controller
    annotation (Placement(transformation(extent={{302,-366},{346,-332}})));
  Modelica.Blocks.Sources.Constant Electrolysis_Constants_carbon_intensity_threshold(k=100)
    annotation (Placement(visible=true, transformation(
        origin={-70,-740},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u_T_TES_load
    "Forward flow temperature of the heat grid in °C"
    annotation (Placement(transformation(extent={{1600,70},{1560,110}})));
  Modelica.Blocks.Interfaces.RealInput u_T_TES_unload
    "Forward flow temperature of the heat grid in °C"
    annotation (Placement(transformation(extent={{1600,110},{1560,150}})));
  Modelica.Blocks.Interfaces.RealInput u_el_EES
    "state of use - electrical storage (-1=unloading; 0=nothing; 1=loading)"
    annotation (Placement(transformation(extent={{1600,-180},{1560,-140}})));
  Modelica.Blocks.Interfaces.RealInput P_el_demand_district
    "electrical demand in the district in kW"
    annotation (Placement(transformation(extent={{1600,-100},{1560,-60}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{1440,10},{1420,30}})));
  Modelica.Blocks.Logical.Pre pre_HeatPump "Previous state of the Heat Pump"
    annotation (Placement(transformation(extent={{364,-316},{376,-304}})));
  Modelica.Blocks.Logical.Pre pre_Electrolysis
    "Previous state of the Electrolysis"
    annotation (Placement(transformation(extent={{364,-366},{376,-354}})));
  MultiMax multiMax
    annotation (Placement(transformation(extent={{-518,-670},{-506,-658}})));
equation
  connect(const5.y, switch_HP_extrernSchedule.u3) annotation (Line(points={{-59,
          -560},{0,-560},{0,-318},{58,-318}},                          color={0,
          0,127}));
  connect(const5.y, switch_Electrolyzer_extrernSchedule.u3) annotation (Line(
        points={{-59,-560},{0,-560},{0,-358},{58,-358}},   color={0,0,127}));
  connect(const5.y, switch_CHP__extrernSchedule.u3) annotation (Line(points={{-59,
          -560},{40,-560},{40,-398},{58,-398}},     color={0,0,127}));
  connect(const5.y, switch_Boiler__extrernSchedule.u3) annotation (Line(points={{-59,
          -560},{0,-560},{0,-438},{58,-438}},         color={0,0,127}));
  connect(HeatingCurve_DistrictGrid.u, u_TempAmp_extern)
    annotation (Line(points={{436,280},{-252,280}}, color={0,0,127}));
  connect(boolean_extrernSchedule.y, switch_HP_extrernSchedule.u2) annotation (
      Line(points={{-59,-480},{20,-480},{20,-310},{58,-310}},  color={255,0,255}));
  connect(boolean_extrernSchedule.y, switch_Electrolyzer_extrernSchedule.u2)
    annotation (Line(points={{-59,-480},{20,-480},{20,-350},{58,-350}}, color={
          255,0,255}));
  connect(boolean_extrernSchedule.y, switch_CHP__extrernSchedule.u2)
    annotation (Line(points={{-59,-480},{20,-480},{20,-390},{58,-390}}, color={
          255,0,255}));
  connect(boolean_extrernSchedule.y, switch_Boiler__extrernSchedule.u2)
    annotation (Line(points={{-59,-480},{20,-480},{20,-430},{58,-430}}, color={
          255,0,255}));
  connect(switch_HP_extrernSchedule.y, heatPump_Controller.signal_HP_prio_ext)
    annotation (Line(points={{81,-310},{300.8,-310}},  color={0,0,127}));
  connect(switch_HP_extrernSchedule.u1, u_HeatPump_scheudle)
    annotation (Line(points={{58,-302},{30,-302},{30,-300},{-252,-300}},
                                                      color={0,0,127}));
  connect(u_Electrolyzer_scheudle, switch_Electrolyzer_extrernSchedule.u1)
    annotation (Line(points={{-252,-340},{32,-340},{32,-342},{58,-342}},
                                                     color={0,0,127}));
  connect(u_CHP_scheudle, switch_CHP__extrernSchedule.u1)
    annotation (Line(points={{-252,-380},{32,-380},{32,-382},{58,-382}},
                                                     color={0,0,127}));
  connect(u_Boiler_scheudle, switch_Boiler__extrernSchedule.u1)
    annotation (Line(points={{-252,-420},{32,-420},{32,-422},{58,-422}},
                                                     color={0,0,127}));
  connect(u_HP2_controll, u_HP2_controll)
    annotation (Line(points={{1570,-320},{1570,-320}}, color={0,0,127}));
  connect(switch_CHP__extrernSchedule.y, u_CHP_controll)
    annotation (Line(points={{81,-390},{1570,-390}}, color={0,0,127}));
  connect(switch_Boiler__extrernSchedule.y, u_Boiler_controll)
    annotation (Line(points={{81,-430},{1570,-430}}, color={0,0,127}));
  connect(u_co2_extern, heatPump_Controller.carbon_intensity) annotation (
      Line(points={{-252,240},{168,240},{168,-232},{270,-232},{270,-288},{300.8,
          -288}},                                               color={0,0,
          127}));
  connect(HeatingCurve_DistrictGrid.y, u_T_HeatGrid_FF_set)
    annotation (Line(points={{459,280},{1570,280}}, color={0,0,127}));
  connect(const1.y,switch__HP1_InternControll. u3) annotation (Line(points={{-59,
          -520},{0,-520},{0,-18},{58,-18}},          color={0,0,127}));
  connect(switch__HP1_InternControll.u1, P_inst_el_HP1) annotation (Line(points=
         {{58,-2},{-36,-2},{-36,80},{-252,80}}, color={0,0,127}));
  connect(switch__HP2_InternControll2.u1, P_inst_el_HP2) annotation (Line(
        points={{58,-42},{-76,-42},{-76,40},{-252,40}}, color={0,0,127}));
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
  connect(greaterThreshold.u, u_heatpump1_OA) annotation (Line(points={{-122,
          -10},{-210,-10},{-210,-40},{-252,-40}}, color={0,0,127}));
  connect(switch__HP2_InternControll2.u2, greaterThreshold1.y)
    annotation (Line(points={{58,-50},{-99,-50}}, color={255,0,255}));
  connect(greaterThreshold1.u, u_heatpump2_OA) annotation (Line(points={{-122,
          -50},{-210,-50},{-210,-80},{-252,-80}}, color={0,0,127}));
  connect(u_heatpump1_OA, max1.u1) annotation (Line(points={{-252,-40},{-160,
          -40},{-160,-84},{-122,-84}}, color={0,0,127}));
  connect(u_heatpump2_OA, max1.u2) annotation (Line(points={{-252,-80},{-170,
          -80},{-170,-96},{-122,-96}}, color={0,0,127}));
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
  connect(switch__HP1_InternControll1.y, u_HP1_controll) annotation (Line(
        points={{1063,-250},{1480,-250},{1480,-280},{1570,-280}}, color={0,0,
          127}));
  connect(switch__HP2_InternControll1.y, u_HP2_controll)
    annotation (Line(points={{1061,-320},{1570,-320}}, color={0,0,127}));
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
  connect(P_inst_el_HP1, product1.u1) annotation (Line(points={{-252,80},{1098,
          80},{1098,-264}}, color={0,0,127}));
  connect(P_inst_el_HP2, product2.u2) annotation (Line(points={{-252,40},{1090,
          40},{1090,-296},{1098,-296}}, color={0,0,127}));
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
      Line(points={{300.8,-338},{184,-338},{184,-232},{168,-232},{168,240},{
          -252,240}}, color={0,0,127}));
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
  connect(E_el_EES, heatPump_Controller.SOC_EES) annotation (Line(points={{1580,
          -120},{298,-120},{298,-292},{300.8,-292}}, color={0,0,127}));
  connect(E_el_EES, electrolysis_Controller.SOC_EES) annotation (Line(points={{
          1580,-120},{298,-120},{298,-342},{300.8,-342}}, color={0,0,127}));
  connect(P_inst_el_Electrolyzer, electrolysis_Controller.Electrolysis_Constants_P_el_min)
    annotation (Line(points={{-252,0},{-218,0},{-218,-138},{120,-138},{120,-352},
          {300.8,-352}}, color={0,0,127}));
  connect(u_electrolyzer_OA, electrolysis_Controller.signal_Electrolysis_prio_int)
    annotation (Line(points={{-252,-120},{-220,-120},{-220,-204},{110,-204},{
          110,-358},{300.8,-358}}, color={0,0,127}));
  connect(feedback.y, electrolysis_Controller.P_el_renergy) annotation (Line(
        points={{1281,-10},{270,-10},{270,-350},{300.8,-350}}, color={0,0,127}));
  connect(heatPump_Controller.P_el_renergy, feedback1.y) annotation (Line(
        points={{300.8,-300},{280,-300},{280,20},{1421,20}}, color={0,0,127}));
  connect(feedback1.y, feedback.u1) annotation (Line(points={{1421,20},{1320,20},
          {1320,-10},{1298,-10}}, color={0,0,127}));
  connect(add_HP_Pel2.y, feedback1.u1)
    annotation (Line(points={{1497,20},{1438,20}}, color={0,0,127}));
  connect(feedback1.u2, P_el_demand_district) annotation (Line(points={{1430,12},
          {1430,-80},{1580,-80}}, color={0,0,127}));
  connect(heatPump_Controller.Heatpump_Specification_SI, pre_HeatPump.u)
    annotation (Line(points={{347,-310},{362.8,-310}}, color={255,0,255}));
  connect(electrolysis_Controller.Electrolysis_Specification_SI,
    pre_Electrolysis.u)
    annotation (Line(points={{347,-360},{362.8,-360}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,
            -1020},{1560,300}})), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-240,-1020},{1560,300}})));
end Controller_TM;
