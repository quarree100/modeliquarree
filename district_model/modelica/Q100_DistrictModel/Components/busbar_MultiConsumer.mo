within Q100_DistrictModel.Components;
model busbar_MultiConsumer
  extends Modelica.Icons.Package;
  Modelica.Blocks.Interfaces.RealOutput y_DirectConsumption annotation (
      Placement(
      visible=true,
      transformation(
        origin={70,150},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,80},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u_ProductionCHP annotation (
    Placement(visible = true, transformation(origin = {-80, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput uProductionPV annotation (
    Placement(visible = true, transformation(origin={-20,220},    extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_Demand_HeatPump annotation (Placement(
      visible=true,
      transformation(
        origin={-220,120},
        extent={{-20,-20},{20,20}},
        rotation=0),
      iconTransformation(
        origin={-120,30},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u_Demand_Houses annotation (Placement(
      visible=true,
      transformation(
        origin={-220,20},
        extent={{-20,-20},{20,20}},
        rotation=0),
      iconTransformation(
        origin={-120,-30},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y_GridLoad annotation (Placement(
      visible=true,
      transformation(
        origin={70,70},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,50},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y_FeedIn annotation (Placement(
      visible=true,
      transformation(
        origin={70,-10},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={110,-70},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Q100_DistrictModel.Components.busbar_1consumer Busbar annotation (Placement(
        visible=true, transformation(
        origin={-19,101},
        extent={{-9,-9},{9,9}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u_Demand_EMob annotation (Placement(
      visible=true,
      transformation(
        origin={-220,-40},
        extent={{-20,-20},{20,20}},
        rotation=0),
      iconTransformation(
        origin={-120,-80},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u_Demand_Electrolyser annotation (
      Placement(
      visible=true,
      transformation(
        origin={-220,180},
        extent={{-20,-20},{20,20}},
        rotation=0),
      iconTransformation(
        origin={-120,80},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  Modelica.Blocks.Math.MultiSum multiSum_Demand(nu=4)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
  Modelica.Blocks.Math.MultiSum multiSum_Production(nu=2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,170})));
equation
  connect(Busbar.y_FeedIn, y_FeedIn) annotation (Line(points={{-6.625,94.25},{
          -6,94.25},{-6,94},{20,94},{20,-10},{70,-10}}, color={0,0,127}));
  connect(multiSum_Demand.u[1], u_Demand_Electrolyser) annotation (Line(points=
          {{-160,95.25},{-180,95.25},{-180,180},{-220,180}}, color={0,0,127}));
  connect(multiSum_Demand.u[2], u_Demand_HeatPump) annotation (Line(points={{
          -160,91.75},{-190,91.75},{-190,120},{-220,120}}, color={0,0,127}));
  connect(u_Demand_Houses, multiSum_Demand.u[3]) annotation (Line(points={{-220,
          20},{-190,20},{-190,88.25},{-160,88.25}}, color={0,0,127}));
  connect(u_Demand_EMob, multiSum_Demand.u[4]) annotation (Line(points={{-220,
          -40},{-178,-40},{-178,86},{-160,86},{-160,84.75}}, color={0,0,127}));
  connect(uProductionPV, multiSum_Production.u[1]) annotation (Line(points={{
          -20,220},{-20,190},{-44,190},{-44,180},{-46.5,180}}, color={0,0,127}));
  connect(u_ProductionCHP, multiSum_Production.u[2]) annotation (Line(points={{
          -80,220},{-80,190},{-56,190},{-56,180},{-53.5,180}}, color={0,0,127}));
  connect(multiSum_Demand.y, Busbar.u_Demand) annotation (Line(points={{-138.3,
          90},{-48,90},{-48,94.25},{-32.5,94.25}}, color={0,0,127}));
  connect(multiSum_Production.y, Busbar.u_Production) annotation (Line(points={
          {-50,158.3},{-50,107.75},{-32.5,107.75}}, color={0,0,127}));
  connect(Busbar.y_DirectConsumption, y_DirectConsumption) annotation (Line(
        points={{-6.625,107.75},{10,107.75},{10,108},{30,108},{30,150},{70,150}},
        color={0,0,127}));
  connect(Busbar.y_GridLoad, y_GridLoad) annotation (Line(points={{-6.625,101},
          {10,101},{10,100},{30,100},{30,70},{70,70}}, color={0,0,127}));
  annotation (
    experiment(StartTime = 0, StopTime = 345600, Tolerance = 1e-06, Interval = 900),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Diagram(coordinateSystem(extent={{-200,-60},{60,200}})),
    Icon(coordinateSystem(initialScale = 0.1, extent={{-200,-60},{60,200}}),
                                               graphics={  Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
    __OpenModelica_commandLineOptions = "");
end busbar_MultiConsumer;
