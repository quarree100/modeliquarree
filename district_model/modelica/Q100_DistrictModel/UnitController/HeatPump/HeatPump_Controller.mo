within Q100_DistrictModel.UnitController.HeatPump;
model HeatPump_Controller
  HeatPump_StSp_priority_int heatPump_StSp_priority_int
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  HeatPump_StSp_priority_ext heatPump_StSp_priority_ext(
      stSp_priority_ext_OR_HP_prio_ext(greaterThreshold(threshold=0.001)))
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{130,-70},{150,-50}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{170,-30},{190,-10}})));
  Modelica.Blocks.Logical.Or or3
    annotation (Placement(transformation(extent={{130,10},{150,30}})));
  Modelica.Blocks.Logical.Or or4
    annotation (Placement(transformation(extent={{210,-20},{230,0}})));
  HeatPump_StSp_excess_power_PV heatPump_StSp_excess_power_PV
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  HeatPump_StSp_excess_power_EES heatPump_StSp_excess_power_EES
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput Heatpump_Specification_SI
    annotation (Placement(transformation(extent={{300,-130},{320,-110}})));
  HeatPump_StSp_CO2_intensity heatPump_StSp_CO2_intensity
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_int
    annotation (Placement(transformation(extent={{-164,-112},{-140,-88}}),
        iconTransformation(extent={{-164,-112},{-140,-88}})));
  Modelica.Blocks.Interfaces.RealInput signal_HP_prio_ext annotation (
      Placement(transformation(extent={{-164,-132},{-140,-108}}),
        iconTransformation(extent={{-164,-132},{-140,-108}})));
  Modelica.Blocks.Interfaces.RealInput carbon_intensity
    "carbon intensity of electrical power" annotation (Placement(
        transformation(extent={{-164,88},{-140,112}}), iconTransformation(
          extent={{-164,88},{-140,112}})));
  Modelica.Blocks.Interfaces.RealInput Heatpump_Constants_carbon_intensity_threshold
    "carbon intensity threshold" annotation (Placement(transformation(
          extent={{-164,68},{-140,92}}), iconTransformation(extent={{-164,68},
              {-140,92}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_unload
      "Temperature heat storage " annotation (Placement(transformation(extent=
             {{-164,8},{-140,32}}), iconTransformation(extent={{-164,8},{-140,
              32}})));
  Modelica.Blocks.Interfaces.RealInput T_DH_FF_set "Temperature heating grid"
      annotation (Placement(transformation(extent={{-164,-12},{-140,12}}),
          iconTransformation(extent={{-164,-12},{-140,12}})));
  Modelica.Blocks.Interfaces.RealInput SOC_EES
    "state of charge - electrical storage" annotation (Placement(
        transformation(extent={{-164,48},{-140,72}}), iconTransformation(
          extent={{-164,48},{-140,72}})));
  Modelica.Blocks.Interfaces.RealInput Heatpump_Constants_storage_el_SOC_threshold
    "Electrical storage charge status threshold" annotation (Placement(
        transformation(extent={{-164,28},{-140,52}}), iconTransformation(
          extent={{-164,28},{-140,52}})));
  Modelica.Blocks.Interfaces.RealInput P_el_renergy
    "electrical power - renewable energy (PV, BHKW)" annotation (
      Placement(transformation(extent={{-164,-32},{-140,-8}}),
        iconTransformation(extent={{-164,-32},{-140,-8}})));
  Modelica.Blocks.Interfaces.RealInput Heatpump_Constants_P_el_HP_min
    annotation (Placement(transformation(extent={{-164,-52},{-140,-28}}),
        iconTransformation(extent={{-164,-52},{-140,-28}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_load annotation (Placement(
          transformation(extent={{-164,-72},{-140,-48}}), iconTransformation(
            extent={{-164,-72},{-140,-48}})));
  Modelica.Blocks.Interfaces.RealInput Heatpump_Constants_T_TES_max_set
      annotation (Placement(transformation(extent={{-164,-92},{-140,-68}}),
          iconTransformation(extent={{-164,-92},{-140,-68}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(visible=true,
          transformation(
          origin={270,-10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
  Modelica.Blocks.Sources.Constant const5(k=0)   annotation (
    Placement(visible = true, transformation(origin={-10,-170},     extent={{-10,-10},
            {10,10}},                                                                                rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(visible=true,
          transformation(
          origin={94,-10},
          extent={{-10,-10},{10,10}},
          rotation=0)));
  Modelica.Blocks.Logical.Switch switch3 annotation (Placement(visible=true,
          transformation(
          origin={94,50},
          extent={{-10,-10},{10,10}},
          rotation=0)));
    InputSignalCheck inputSignalCheck(d=100)
      annotation (Placement(transformation(extent={{-126,74},{-114,86}})));
    InputSignalCheck inputSignalCheck1(d=20)
      annotation (Placement(transformation(extent={{-126,34},{-114,46}})));
    InputSignalCheck inputSignalCheck2(d=95)
      annotation (Placement(transformation(extent={{-126,-86},{-114,-74}})));
    InputSignalCheck inputSignalCheck3(d=300)
      annotation (Placement(transformation(extent={{-126,-46},{-114,-34}})));
    Modelica.Blocks.Interfaces.RealOutput Heatpump_Specification_Value
    "utilization factor between 0 and 1"
      annotation (Placement(transformation(extent={{300,-20},{320,0}})));
  Modelica.Blocks.Logical.Switch switch4 annotation (Placement(visible=true,
          transformation(
          origin={94,-90},
          extent={{-10,-10},{10,10}},
          rotation=0)));
  Modelica.Blocks.Logical.Switch switch5 annotation (Placement(visible=true,
          transformation(
          origin={94,-130},
          extent={{-10,-10},{10,10}},
          rotation=0)));
  Modelica.Blocks.Sources.Constant const1(k=1)   annotation (
    Placement(visible = true, transformation(origin={-10,150},      extent={{-10,-10},
            {10,10}},                                                                                rotation = 0)));
    Modelica.Blocks.Math.Division division
      annotation (Placement(transformation(extent={{-20,100},{0,120}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{30,120},{50,140}})));
    MultiMax multiMax(nu=4)
      annotation (Placement(transformation(extent={{140,120},{160,140}})));
equation
  connect(heatPump_StSp_priority_ext.Heatpump_Specification_StSp_priority_ext_SI,
    or1.u1) annotation (Line(points={{-39,-40},{44,-40},{44,-60},{128,-60}},
        color={255,0,255}));
  connect(heatPump_StSp_priority_int.Heatpump_Specification_StSp_priority_int_SI,
    or1.u2) annotation (Line(points={{-39,-80},{44,-80},{44,-68},{128,-68}},
        color={255,0,255}));
  connect(or3.y, or2.u1) annotation (Line(points={{151,20},{162,20},{162,-20},
            {168,-20}},
                     color={255,0,255}));
  connect(or1.y, or2.u2) annotation (Line(points={{151,-60},{162,-60},{162,
            -28},{168,-28}},
                          color={255,0,255}));
  connect(or2.y, or4.u2) annotation (Line(points={{191,-20},{202,-20},{202,
            -18},{208,-18}},
                        color={255,0,255}));
  connect(heatPump_StSp_excess_power_PV.Heatpump_Specification_StSp_excess_power_PV_SI,
    or3.u2) annotation (Line(points={{-39,0},{44,0},{44,12},{128,12}},
        color={255,0,255}));
  connect(heatPump_StSp_excess_power_EES.Heatpump_Specification_StSp_excess_power_EES_SI,
    or3.u1) annotation (Line(points={{-39,40},{44,40},{44,20},{128,20}},
        color={255,0,255}));
  connect(or4.y, Heatpump_Specification_SI)
    annotation (Line(points={{231,-10},{250,-10},{250,-120},{310,-120}},
                                              color={255,0,255}));
  connect(heatPump_StSp_CO2_intensity.Heatpump_Specification_StSp_CO2_intensity_SI,
    or4.u1) annotation (Line(points={{-39,80},{202,80},{202,-10},{208,-10}},
        color={255,0,255}));
  connect(heatPump_StSp_priority_int.signal_HP_prio_int,
    signal_HP_prio_int) annotation (Line(points={{-62,-80},{-78,-80},{-78,
            -100},{-152,-100}},
                              color={0,0,127}));
  connect(heatPump_StSp_priority_ext.signal_HP_prio_ext,
    signal_HP_prio_ext) annotation (Line(points={{-62,-45},{-70,-45},{-70,
          -120},{-152,-120}}, color={0,0,127}));
  connect(heatPump_StSp_priority_ext.signal_HP_prio_int,
    signal_HP_prio_int) annotation (Line(points={{-62,-35},{-78,-35},{-78,
            -100},{-152,-100}},
                              color={0,0,127}));
  connect(heatPump_StSp_excess_power_PV.signal_HP_prio_int,
    signal_HP_prio_int) annotation (Line(points={{-62,-6},{-78,-6},{-78,-100},
            {-152,-100}},     color={0,0,127}));
  connect(heatPump_StSp_excess_power_EES.signal_HP_prio_int,
    signal_HP_prio_int) annotation (Line(points={{-62,34},{-78,34},{-78,-100},
            {-152,-100}},     color={0,0,127}));
  connect(heatPump_StSp_CO2_intensity.signal_HP_prio_int,
    signal_HP_prio_int) annotation (Line(points={{-62,74},{-78,74},{-78,-100},
            {-152,-100}},     color={0,0,127}));
  connect(heatPump_StSp_excess_power_EES.signal_HP_prio_ext,
    signal_HP_prio_ext) annotation (Line(points={{-62,31},{-70,31},{-70,
          -120},{-152,-120}}, color={0,0,127}));
  connect(heatPump_StSp_CO2_intensity.signal_HP_prio_ext,
    signal_HP_prio_ext) annotation (Line(points={{-62,71},{-70,71},{-70,
          -120},{-152,-120}}, color={0,0,127}));
  connect(heatPump_StSp_CO2_intensity.carbon_intensity, carbon_intensity)
    annotation (Line(points={{-62,89},{-62,90},{-106,90},{-106,100},{-152,
          100}}, color={0,0,127}));
    connect(heatPump_StSp_CO2_intensity.T_TES_unload, T_TES_unload)
      annotation (Line(points={{-62,82},{-102,82},{-102,20},{-152,20}}, color=
           {0,0,127}));
    connect(heatPump_StSp_CO2_intensity.T_DH_FF_set, T_DH_FF_set) annotation (
       Line(points={{-62,78},{-98,78},{-98,0},{-152,0}}, color={0,0,127}));
    connect(heatPump_StSp_excess_power_EES.T_DH_FF_set, T_DH_FF_set)
      annotation (Line(points={{-62,38},{-98,38},{-98,0},{-152,0}}, color={0,
            0,127}));
    connect(heatPump_StSp_excess_power_EES.T_TES_unload, T_TES_unload)
      annotation (Line(points={{-62,42},{-102,42},{-102,20},{-152,20}}, color=
           {0,0,127}));
  connect(heatPump_StSp_excess_power_EES.SOC_EES, SOC_EES) annotation (
      Line(points={{-62,49},{-62,48},{-106,48},{-106,60},{-152,60}},
        color={0,0,127}));
  connect(heatPump_StSp_excess_power_PV.P_el_renergy, P_el_renergy)
    annotation (Line(points={{-62,9},{-92,9},{-92,-20},{-152,-20}}, color=
         {0,0,127}));
    connect(heatPump_StSp_excess_power_PV.T_TES_load, T_TES_load) annotation (
       Line(points={{-62,2},{-86,2},{-86,-60},{-152,-60}}, color={0,0,127}));
  connect(heatPump_StSp_excess_power_PV.signal_HP_prio_ext,
    signal_HP_prio_ext) annotation (Line(points={{-62,-9},{-62,-10},{-70,
          -10},{-70,-120},{-152,-120}}, color={0,0,127}));
    connect(Heatpump_Specification_SI, Heatpump_Specification_SI)
      annotation (Line(points={{310,-120},{310,-120}}, color={255,0,255}));
    connect(or4.y, switch1.u2)
      annotation (Line(points={{231,-10},{258,-10}}, color={255,0,255}));
    connect(const5.y, switch1.u3) annotation (Line(points={{1,-170},{236,-170},
            {236,-18},{258,-18}},       color={0,0,127}));
    connect(heatPump_StSp_excess_power_PV.Heatpump_Specification_StSp_excess_power_PV_SI,
      switch2.u2) annotation (Line(points={{-39,0},{44,0},{44,-10},{82,-10}},
          color={255,0,255}));
    connect(const5.y, switch2.u3) annotation (Line(points={{1,-170},{68,-170},
            {68,-18},{82,-18}},       color={0,0,127}));
    connect(heatPump_StSp_excess_power_EES.Heatpump_Specification_StSp_excess_power_EES_SI,
      switch3.u2) annotation (Line(points={{-39,40},{44,40},{44,50},{82,50}},
          color={255,0,255}));
    connect(inputSignalCheck.u, Heatpump_Constants_carbon_intensity_threshold)
      annotation (Line(points={{-128,80},{-152,80}}, color={0,0,127}));
    connect(inputSignalCheck.y, heatPump_StSp_CO2_intensity.Heatpump_Constants_carbon_intensity_threshold)
      annotation (Line(points={{-112,80},{-104,80},{-104,86},{-62,86}}, color=
           {0,0,127}));
    connect(heatPump_StSp_excess_power_EES.Heatpump_Constants_storage_el_SOC_threshold,
      inputSignalCheck1.y) annotation (Line(points={{-62,46},{-106,46},{-106,
            40},{-112,40}}, color={0,0,127}));
    connect(inputSignalCheck1.u, Heatpump_Constants_storage_el_SOC_threshold)
      annotation (Line(points={{-128,40},{-152,40}}, color={0,0,127}));
    connect(heatPump_StSp_excess_power_PV.Heatpump_Constants_tp_TES_max_set,
      inputSignalCheck2.y) annotation (Line(points={{-62,-2},{-82,-2},{-82,
            -80},{-112,-80}}, color={0,0,127}));
    connect(inputSignalCheck2.u, Heatpump_Constants_T_TES_max_set)
      annotation (Line(points={{-128,-80},{-152,-80}}, color={0,0,127}));
    connect(heatPump_StSp_excess_power_PV.Heatpump_Constants_P_el_HP_min,
      inputSignalCheck3.y) annotation (Line(points={{-62,6},{-90,6},{-90,-40},
            {-112,-40}}, color={0,0,127}));
    connect(inputSignalCheck3.u, Heatpump_Constants_P_el_HP_min)
      annotation (Line(points={{-128,-40},{-152,-40}}, color={0,0,127}));
    connect(const5.y, switch3.u3) annotation (Line(points={{1,-170},{68,-170},
            {68,42},{82,42}}, color={0,0,127}));
    connect(switch1.y, Heatpump_Specification_Value)
      annotation (Line(points={{281,-10},{310,-10}}, color={0,0,127}));
    connect(heatPump_StSp_priority_int.Heatpump_Specification_StSp_priority_int_SI,
      switch4.u2) annotation (Line(points={{-39,-80},{44,-80},{44,-90},{82,
            -90}}, color={255,0,255}));
    connect(const5.y, switch4.u3) annotation (Line(points={{1,-170},{68,-170},
            {68,-98},{82,-98}}, color={0,0,127}));
    connect(switch4.u1, signal_HP_prio_int) annotation (Line(points={{82,-82},
            {-30,-82},{-30,-100},{-152,-100}}, color={0,0,127}));
    connect(const5.y, switch5.u3) annotation (Line(points={{1,-170},{68,-170},
            {68,-138},{82,-138}}, color={0,0,127}));
    connect(heatPump_StSp_priority_ext.Heatpump_Specification_StSp_priority_ext_SI,
      switch5.u2) annotation (Line(points={{-39,-40},{44,-40},{44,-130},{82,
            -130}}, color={255,0,255}));
    connect(switch5.u1, signal_HP_prio_ext) annotation (Line(points={{82,-122},
            {-30,-122},{-30,-120},{-152,-120}}, color={0,0,127}));
    connect(const1.y, switch3.u1) annotation (Line(points={{1,150},{68,150},{
            68,58},{82,58}}, color={0,0,127}));
    connect(division.u1, P_el_renergy) annotation (Line(points={{-22,116},{
            -30,116},{-30,18},{-92,18},{-92,-20},{-152,-20}}, color={0,0,127}));
    connect(inputSignalCheck3.y, division.u2) annotation (Line(points={{-112,
            -40},{-90,-40},{-90,14},{-30,14},{-30,104},{-22,104}}, color={0,0,
            127}));
    connect(const1.y, min1.u1) annotation (Line(points={{1,150},{10,150},{10,
            136},{28,136}}, color={0,0,127}));
    connect(division.y, min1.u2) annotation (Line(points={{1,110},{10,110},{
            10,124},{28,124}}, color={0,0,127}));
    connect(min1.y, switch2.u1) annotation (Line(points={{51,130},{62,130},{
            62,-2},{82,-2}}, color={0,0,127}));
    connect(switch3.y, multiMax.u[1]) annotation (Line(points={{105,50},{112,
            50},{112,136},{134,136},{134,135.25},{140,135.25}}, color={0,0,
            127}));
    connect(switch2.y, multiMax.u[2]) annotation (Line(points={{105,-10},{112,
            -10},{112,132},{126,132},{126,131.75},{140,131.75}}, color={0,0,
            127}));
    connect(switch4.y, multiMax.u[3]) annotation (Line(points={{105,-90},{112,
            -90},{112,128},{126,128},{126,128.25},{140,128.25}}, color={0,0,
            127}));
    connect(switch5.y, multiMax.u[4]) annotation (Line(points={{105,-130},{
            112,-130},{112,124.75},{140,124.75}}, color={0,0,127}));
    connect(multiMax.y, switch1.u1) annotation (Line(points={{161.7,130},{248,
            130},{248,-2},{258,-2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
              -180},{300,160}})),                                Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-180},{300,
              160}})));
end HeatPump_Controller;
