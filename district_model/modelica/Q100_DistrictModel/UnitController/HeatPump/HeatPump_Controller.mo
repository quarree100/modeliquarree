within Q100_DistrictModel.UnitController.HeatPump;
model HeatPump_Controller
  HeatPump_StSp_priority_int heatPump_StSp_priority_int
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  HeatPump_StSp_priority_ext heatPump_StSp_priority_ext(
      stSp_priority_ext_OR_HP_prio_ext(greaterThreshold(threshold=0.001)))
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
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
          origin={90,-10},
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
  Modelica.Blocks.Sources.Constant const1(k=1)   annotation (
    Placement(visible = true, transformation(origin={-10,150},      extent={{-10,-10},
            {10,10}},                                                                                rotation = 0)));
    Modelica.Blocks.Math.Division division
      annotation (Placement(transformation(extent={{-20,100},{0,120}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{30,120},{50,140}})));
    MultiMax multiMax(nu=6)
      annotation (Placement(transformation(extent={{140,120},{160,140}})));
  HeatPump_StSp_HP_hysteresis heatPump_StSp_HP_hysteresis annotation (Placement(transformation(extent={{-60,-150},{-40,-130}})));
  Modelica.Blocks.Math.BooleanToReal
                                 booleanToReal
    annotation (Placement(transformation(extent={{80,-152},{100,-132}})));
  Modelica.Blocks.MathBoolean.Or or5(nu=6) annotation (Placement(transformation(extent={{160,-20},{180,0}})));
  Modelica.Blocks.Math.BooleanToReal
                                 booleanToReal1
    annotation (Placement(transformation(extent={{80,90},{100,110}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{80,-110},{100,-90}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  Modelica.Blocks.Math.BooleanToReal
                                 booleanToReal4
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Blocks.Interfaces.RealInput T_DH_FF_actual "Temperature heating grid" annotation (Placement(transformation(extent={{-164,-152},{-140,-128}}), iconTransformation(extent={{-164,-152},{-140,-128}})));
equation
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
    connect(const5.y, switch1.u3) annotation (Line(points={{1,-170},{236,-170},
            {236,-18},{258,-18}},       color={0,0,127}));
    connect(heatPump_StSp_excess_power_PV.Heatpump_Specification_StSp_excess_power_PV_SI,
      switch2.u2) annotation (Line(points={{-39,0},{44,0},{44,-10},{78,-10}},
          color={255,0,255}));
    connect(const5.y, switch2.u3) annotation (Line(points={{1,-170},{68,-170},{68,-18},{78,-18}},
                                      color={0,0,127}));
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
    connect(switch1.y, Heatpump_Specification_Value)
      annotation (Line(points={{281,-10},{310,-10}}, color={0,0,127}));
    connect(division.u1, P_el_renergy) annotation (Line(points={{-22,116},{
            -30,116},{-30,18},{-92,18},{-92,-20},{-152,-20}}, color={0,0,127}));
    connect(inputSignalCheck3.y, division.u2) annotation (Line(points={{-112,
            -40},{-90,-40},{-90,14},{-30,14},{-30,104},{-22,104}}, color={0,0,
            127}));
    connect(const1.y, min1.u1) annotation (Line(points={{1,150},{10,150},{10,
            136},{28,136}}, color={0,0,127}));
    connect(division.y, min1.u2) annotation (Line(points={{1,110},{10,110},{
            10,124},{28,124}}, color={0,0,127}));
    connect(min1.y, switch2.u1) annotation (Line(points={{51,130},{62,130},{62,-2},{78,-2}},
                             color={0,0,127}));
    connect(switch2.y, multiMax.u[1]) annotation (Line(points={{101,-10},{112,-10},{112,132},{126,132},{126,135.833},{140,135.833}},
                                                                 color={0,0,
            127}));
    connect(multiMax.y, switch1.u1) annotation (Line(points={{161.7,130},{248,
            130},{248,-2},{258,-2}}, color={0,0,127}));
  connect(heatPump_StSp_HP_hysteresis.Heatpump_Specification_StSp_HP_hysteresis_SI, booleanToReal.u) annotation (Line(points={{-39,-140},{74,-140},{74,-142},{78,-142}}, color={255,0,255}));
  connect(booleanToReal.y, multiMax.u[2]) annotation (Line(points={{101,-142},{112,-142},{112,128},{126,128},{126,133.5},{140,133.5}}, color={0,0,127}));
  connect(heatPump_StSp_HP_hysteresis.Heatpump_Specification_StSp_HP_hysteresis_SI, or5.u[1]) annotation (Line(points={{-39,-140},{74,-140},{74,-160},{156,-160},{156,-4.16667},{160,-4.16667}}, color={255,0,255}));
  connect(heatPump_StSp_priority_int.Heatpump_Specification_StSp_priority_int_SI, or5.u[2]) annotation (Line(points={{-39,-80},{56,-80},{56,-36},{152,-36},{152,-6.5},{160,-6.5}}, color={255,0,255}));
  connect(heatPump_StSp_priority_ext.Heatpump_Specification_StSp_priority_ext_SI, or5.u[3]) annotation (Line(points={{-39,-40},{46,-40},{46,-28},{146,-28},{146,-8.83333},{160,-8.83333}}, color={255,0,255}));
  connect(heatPump_StSp_excess_power_PV.Heatpump_Specification_StSp_excess_power_PV_SI, or5.u[4]) annotation (Line(points={{-39,0},{44,0},{44,20},{132,20},{132,-4},{146,-4},{146,-11.1667},{160,-11.1667}}, color={255,0,255}));
  connect(heatPump_StSp_excess_power_EES.Heatpump_Specification_StSp_excess_power_EES_SI, or5.u[5]) annotation (Line(points={{-39,40},{44,40},{44,28},{140,28},{140,0},{152,0},{152,-13.5},{160,-13.5}}, color={255,0,255}));
  connect(heatPump_StSp_CO2_intensity.Heatpump_Specification_StSp_CO2_intensity_SI, or5.u[6]) annotation (Line(points={{-39,80},{140,80},{140,40},{150,40},{150,4},{156,4},{156,-15.8333},{160,-15.8333}}, color={255,0,255}));
  connect(heatPump_StSp_CO2_intensity.Heatpump_Specification_StSp_CO2_intensity_SI, booleanToReal1.u) annotation (Line(points={{-39,80},{72,80},{72,100},{78,100}}, color={255,0,255}));
  connect(booleanToReal1.y, multiMax.u[3]) annotation (Line(points={{101,100},{112,100},{112,128},{126,128},{126,131.167},{140,131.167}}, color={0,0,127}));
  connect(switch3.y, multiMax.u[4]) annotation (Line(points={{101,-100},{112,-100},{112,128},{126,128},{126,128.833},{140,128.833}}, color={0,0,127}));
  connect(switch4.y, multiMax.u[5]) annotation (Line(points={{101,-60},{112,-60},{112,128},{126,128},{126,126.5},{140,126.5}}, color={0,0,127}));
  connect(heatPump_StSp_excess_power_EES.Heatpump_Specification_StSp_excess_power_EES_SI, booleanToReal4.u) annotation (Line(points={{-39,40},{44,40},{44,50},{78,50}}, color={255,0,255}));
  connect(booleanToReal4.y, multiMax.u[6]) annotation (Line(points={{101,50},{112,50},{112,128},{126,128},{126,124.167},{140,124.167}}, color={0,0,127}));
  connect(or5.y, switch1.u2) annotation (Line(points={{181.5,-10},{258,-10}}, color={255,0,255}));
  connect(or5.y, Heatpump_Specification_SI) annotation (Line(points={{181.5,-10},{212,-10},{212,-120},{310,-120}}, color={255,0,255}));
  connect(heatPump_StSp_HP_hysteresis.signal_HP_prio_int, signal_HP_prio_int) annotation (Line(points={{-62,-146},{-78,-146},{-78,-100},{-152,-100}}, color={0,0,127}));
  connect(signal_HP_prio_ext, heatPump_StSp_HP_hysteresis.signal_HP_prio_ext) annotation (Line(points={{-152,-120},{-96,-120},{-96,-149},{-62,-149}}, color={0,0,127}));
  connect(T_DH_FF_set, heatPump_StSp_HP_hysteresis.T_DH_FF_set) annotation (Line(points={{-152,0},{-74,0},{-74,-140},{-62,-140}}, color={0,0,127}));
  connect(heatPump_StSp_HP_hysteresis.T_DH_FF_actual, T_DH_FF_actual) annotation (Line(points={{-62,-132},{-134,-132},{-134,-140},{-152,-140}}, color={0,0,127}));
  connect(heatPump_StSp_priority_int.Heatpump_Specification_StSp_priority_int_SI, switch3.u2) annotation (Line(points={{-39,-80},{56,-80},{56,-100},{78,-100}}, color={255,0,255}));
  connect(const5.y, switch3.u3) annotation (Line(points={{1,-170},{68,-170},{68,-108},{78,-108}}, color={0,0,127}));
  connect(switch3.u1, signal_HP_prio_int) annotation (Line(points={{78,-92},{-78,-92},{-78,-100},{-152,-100}}, color={0,0,127}));
  connect(switch4.u3, const5.y) annotation (Line(points={{78,-68},{68,-68},{68,-170},{1,-170}}, color={0,0,127}));
  connect(heatPump_StSp_priority_ext.Heatpump_Specification_StSp_priority_ext_SI, switch4.u2) annotation (Line(points={{-39,-40},{46,-40},{46,-60},{78,-60}}, color={255,0,255}));
  connect(switch4.u1, signal_HP_prio_ext) annotation (Line(points={{78,-52},{-34,-52},{-34,-64},{-70,-64},{-70,-120},{-152,-120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
              -180},{300,160}})),                                Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-180},{300,
              160}})));
end HeatPump_Controller;
