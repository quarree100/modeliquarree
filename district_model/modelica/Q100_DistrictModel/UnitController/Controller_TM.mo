within Q100_DistrictModel.UnitController;
model Controller_TM "Coltroller for fmu"
  Modelica.Blocks.Interfaces.RealInput u_TempAmp_extern
    "Ambient temperature in °C"
    annotation (Placement(transformation(extent={{-280,260},{-240,300}})));
  Modelica.Blocks.Interfaces.RealInput u_co2_extern
    "CO2 intensity of the upstream electricity grid in g/kWh"
    annotation (Placement(transformation(extent={{-280,220},{-240,260}})));
  Modelica.Blocks.Interfaces.RealInput u_el_costs_extern
    "Electricity price intensity of the upstream electricity grid in €/kWh"
    annotation (Placement(transformation(extent={{-280,180},{-240,220}})));
  Modelica.Blocks.Interfaces.RealInput u_heatpump1_status
    "Heat pump one status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{1600,50},{1560,90}})));
  Modelica.Blocks.Interfaces.RealInput u_electrolyzer_status
    "electrolyzer status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{1600,-30},{1560,10}})));
  Modelica.Blocks.Interfaces.RealInput u_CHP_status
    "CHP status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{1600,-70},{1560,-30}})));
  Modelica.Blocks.Interfaces.RealInput u_boiler_status
    "Boiler status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{1600,-110},{1560,-70}})));
  Modelica.Blocks.Interfaces.RealInput u_Temp_HeatGrid_RF_actual
    "Return flow temperature of the heat grid in °C"
    annotation (Placement(transformation(extent={{1600,190},{1560,230}})));
  Modelica.Blocks.Interfaces.RealInput u_Temp_HeatGrid_FF_actual
    "Forward flow temperature of the heat grid in °C"
    annotation (Placement(transformation(extent={{1600,110},{1560,150}})));
  Modelica.Blocks.Interfaces.RealInput u_heatpump2_status
    "Heat pump two status signal as 0 (not running) and 1 (running) "
    annotation (Placement(transformation(extent={{1600,10},{1560,50}})));
  Modelica.Blocks.Interfaces.RealInput u_mdot_HeatGrid_RF_actual
    "Return mass flow of the heat grid in kg/s"
    annotation (Placement(transformation(extent={{1600,150},{1560,190}})));
  Modelica.Blocks.Interfaces.RealInput u_el_pv_district
    "photovoltaic production in the district in kW"
    annotation (Placement(transformation(extent={{1600,-150},{1560,-110}})));
  Modelica.Blocks.Logical.Switch switch annotation (Placement(visible=true,
        transformation(
        origin={210,-310},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant const5(k=-1)  annotation (
    Placement(visible = true, transformation(origin={-30,-240},     extent={{-10,-10},
            {10,10}},                                                                                rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant boolean_extrernSchedule(k=false)
    "True if extrern schedule should be used"                    annotation (
      Placement(visible=true, transformation(
        origin={-30,-160},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(visible=true,
        transformation(
        origin={70,-352},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch3 annotation (Placement(visible=true,
        transformation(
        origin={68,-392},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch4 annotation (Placement(visible=true,
        transformation(
        origin={70,-432},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  AixLib.Controls.SetPoints.Table HeatingCurve_DistrictGrid(table=[-20,80; -15,
        80; 15,65; 20,65])
    annotation (Placement(transformation(extent={{438,270},{458,290}})));
  HeatPump.HeatPump_Controller heatPump_Controller
    annotation (Placement(transformation(extent={{302,-316},{346,-282}})));
  Modelica.Blocks.Interfaces.RealInput u_HeatPump_scheudle
    annotation (Placement(transformation(extent={{-280,-322},{-240,-282}})));
  Modelica.Blocks.Interfaces.RealInput u_Electrolyzer_scheudle
    annotation (Placement(transformation(extent={{-280,-360},{-240,-320}})));
  Modelica.Blocks.Interfaces.RealInput u_Boiler_scheudle
    annotation (Placement(transformation(extent={{-280,-442},{-240,-402}})));
  Modelica.Blocks.Interfaces.RealInput u_CHP_scheudle
    annotation (Placement(transformation(extent={{-280,-400},{-240,-360}})));
  Modelica.Blocks.Interfaces.RealOutput u_HeatPump_controll
    annotation (Placement(transformation(extent={{1560,-310},{1580,-290}})));
  Modelica.Blocks.Interfaces.RealOutput u_Electrolyzer_controll
    annotation (Placement(transformation(extent={{1560,-362},{1580,-342}})));
  Modelica.Blocks.Interfaces.RealOutput u_CHP_controll
    annotation (Placement(transformation(extent={{1560,-404},{1580,-384}})));
  Modelica.Blocks.Interfaces.RealOutput u_Boiler_controll
    annotation (Placement(transformation(extent={{1560,-442},{1580,-422}})));
  Modelica.Blocks.Interfaces.RealOutput u_Temp_HeatGrid_FF_set
    annotation (Placement(transformation(extent={{1560,270},{1580,290}})));
  Modelica.Blocks.Sources.BooleanConstant boolean_InternControll(k=false)
    "True if intern controll blocks Controller" annotation (Placement(visible=
         true, transformation(
        origin={-30,-120},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(visible=true,
        transformation(
        origin={210,-270},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant const1(k=0)   annotation (
    Placement(visible = true, transformation(origin={-30,-200},     extent={{-10,-10},
            {10,10}},                                                                                rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_el_EES
    "state of charge - electrical storage"
    annotation (Placement(transformation(extent={{1600,-190},{1560,-150}})));
equation
  connect(const5.y, switch.u3) annotation (Line(points={{-19,-240},{24,-240},
          {24,-312},{184,-312},{184,-318},{198,-318}}, color={0,0,127}));
  connect(const5.y, switch2.u3) annotation (Line(points={{-19,-240},{24,-240},
          {24,-360},{58,-360}}, color={0,0,127}));
  connect(const5.y, switch3.u3) annotation (Line(points={{-19,-240},{24,-240},
          {24,-400},{56,-400}}, color={0,0,127}));
  connect(const5.y, switch4.u3) annotation (Line(points={{-19,-240},{24,-240},
          {24,-464},{58,-464},{58,-440}}, color={0,0,127}));
  connect(HeatingCurve_DistrictGrid.u, u_TempAmp_extern)
    annotation (Line(points={{436,280},{-260,280}}, color={0,0,127}));
  connect(boolean_extrernSchedule.y, switch.u2) annotation (Line(points={{-19,
          -160},{40,-160},{40,-310},{198,-310}}, color={255,0,255}));
  connect(boolean_extrernSchedule.y, switch2.u2) annotation (Line(points={{-19,
          -160},{40,-160},{40,-352},{58,-352}}, color={255,0,255}));
  connect(boolean_extrernSchedule.y, switch3.u2) annotation (Line(points={{
          -19,-160},{40,-160},{40,-392},{56,-392}}, color={255,0,255}));
  connect(boolean_extrernSchedule.y, switch4.u2) annotation (Line(points={{-19,
          -160},{40,-160},{40,-432},{58,-432}}, color={255,0,255}));
  connect(switch.y, heatPump_Controller.signal_HP_prio_ext)
    annotation (Line(points={{221,-310},{300.8,-310}}, color={0,0,127}));
  connect(switch.u1, u_HeatPump_scheudle)
    annotation (Line(points={{198,-302},{-260,-302}}, color={0,0,127}));
  connect(u_Electrolyzer_scheudle, switch2.u1) annotation (Line(points={{-260,
          -340},{32,-340},{32,-344},{58,-344}}, color={0,0,127}));
  connect(u_CHP_scheudle, switch3.u1) annotation (Line(points={{-260,-380},{
          32,-380},{32,-384},{56,-384}}, color={0,0,127}));
  connect(u_Boiler_scheudle, switch4.u1)
    annotation (Line(points={{-260,-422},{58,-424}}, color={0,0,127}));
  connect(u_HeatPump_controll, u_HeatPump_controll)
    annotation (Line(points={{1570,-300},{1570,-300}}, color={0,0,127}));
  connect(heatPump_Controller.Heatpump_Specification_Value,
    u_HeatPump_controll) annotation (Line(points={{347,-299},{347,-300},{1570,
          -300}}, color={0,0,127}));
  connect(switch2.y, u_Electrolyzer_controll)
    annotation (Line(points={{81,-352},{1570,-352}}, color={0,0,127}));
  connect(switch3.y, u_CHP_controll)
    annotation (Line(points={{79,-392},{1570,-394}}, color={0,0,127}));
  connect(switch4.y, u_Boiler_controll)
    annotation (Line(points={{81,-432},{1570,-432}}, color={0,0,127}));
  connect(u_co2_extern, heatPump_Controller.carbon_intensity) annotation (
      Line(points={{-260,240},{30,240},{30,-288},{300.8,-288}}, color={0,0,
          127}));
  connect(HeatingCurve_DistrictGrid.y, u_Temp_HeatGrid_FF_set)
    annotation (Line(points={{459,280},{1570,280}}, color={0,0,127}));
  connect(const5.y, switch1.u3) annotation (Line(points={{-19,-240},{24,-240},
          {24,-312},{184,-312},{184,-278},{198,-278}}, color={0,0,127}));
  connect(boolean_InternControll.y, switch1.u2) annotation (Line(points={{-19,
          -120},{90,-120},{90,-270},{198,-270}}, color={255,0,255}));
  connect(const1.y, switch1.u1) annotation (Line(points={{-19,-200},{100,-200},
          {100,-262},{198,-262}}, color={0,0,127}));
  connect(switch1.y, heatPump_Controller.signal_HP_prio_int) annotation (Line(
        points={{221,-270},{228,-270},{228,-308},{300.8,-308}}, color={0,0,
          127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,
            -1020},{1560,300}})), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-240,-1020},{1560,300}})));
end Controller_TM;
