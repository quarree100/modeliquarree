within Q100_DistrictModel.Components;
model busbar_4consumer
  extends Modelica.Icons.Package;
  Modelica.Blocks.Interfaces.RealOutput y_DirectConsumptionCHP annotation (
    Placement(visible = true, transformation(origin = {210, 140}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_ProductionCHP annotation (
    Placement(visible = true, transformation(origin = {-80, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-60, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput uProductionPV annotation (
    Placement(visible = true, transformation(origin = {-20, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_DemandHeatPump annotation (
    Placement(visible = true, transformation(origin = {-220, 120}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u_DemandHouses annotation (
    Placement(visible = true, transformation(origin = {-220, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_FeedInCHP annotation (
    Placement(visible = true, transformation(origin = {210, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_DirectConsumptionPV annotation (
    Placement(visible = true, transformation(origin = {210, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_LoadToBattery annotation (
    Placement(visible = true, transformation(origin = {210, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput y_PVProductionToBattery annotation (
    Placement(visible = true, transformation(origin = {210, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Q100_DistrictModel.Components.busbar_1consumer Busbar_CHP annotation (
    Placement(visible = true, transformation(origin = {-71, 153}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
  Q100_DistrictModel.Components.busbar_1consumer Busbar_PV annotation (
    Placement(visible = true, transformation(origin = {-27, 91}, extent = {{-9, -9}, {9, 9}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput u_EMob annotation (
    Placement(visible = true, transformation(origin = {-220, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add3_1 annotation (
    Placement(transformation(extent = {{-178, 30}, {-158, 50}})));
  Modelica.Blocks.Math.Add add annotation (
    Placement(transformation(extent = {{-140, 100}, {-120, 120}})));
  Modelica.Blocks.Interfaces.RealInput u_DemandElectrolyser annotation (
    Placement(visible = true, transformation(origin = {-220, 180}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(Busbar_PV.y_GridLoad, y_LoadToBattery) annotation (
    Line(points = {{-27, 78.625}, {-27, -20}, {210, -20}}, color = {0, 0, 127}));
  connect(Busbar_PV.y_FeedIn, y_PVProductionToBattery) annotation (
    Line(points = {{-33.75, 78.625}, {-33.75, -40}, {210, -40}}, color = {0, 0, 127}));
  connect(uProductionPV, Busbar_PV.u_Production) annotation (
    Line(points = {{-20, 220}, {-20, 104.5}, {-20.25, 104.5}}, color = {0, 0, 127}));
  connect(Busbar_CHP.y_GridLoad, Busbar_PV.u_Demand) annotation (
    Line(points = {{-71, 140.625}, {-71, 128}, {-33.75, 128}, {-33.75, 104.5}}, color = {0, 0, 127}));
  connect(Busbar_PV.y_DirectConsumption, y_DirectConsumptionPV) annotation (
    Line(points = {{-20.25, 78.625}, {-20.25, 60}, {210, 60}}, color = {0, 0, 127}));
  connect(Busbar_CHP.y_FeedIn, y_FeedInCHP) annotation (
    Line(points = {{-77.75, 140.625}, {-77.75, 120}, {210, 120}}, color = {0, 0, 127}));
  connect(Busbar_CHP.y_DirectConsumption, y_DirectConsumptionCHP) annotation (
    Line(points = {{-64.25, 140.625}, {210, 140.625}, {210, 140}}, color = {0, 0, 127}));
  connect(u_ProductionCHP, Busbar_CHP.u_Production) annotation (
    Line(points = {{-80, 220}, {-80, 188}, {-64.25, 188}, {-64.25, 166.5}}, color = {0, 0, 127}));
  connect(u_DemandHeatPump, add3_1.u1) annotation (
    Line(points = {{-220, 120}, {-190, 120}, {-190, 48}, {-180, 48}}, color = {0, 0, 127}));
  connect(u_DemandHouses, add3_1.u2) annotation (
    Line(points = {{-220, 20}, {-200, 20}, {-200, 40}, {-180, 40}}, color = {0, 0, 127}));
  connect(u_EMob, add3_1.u3) annotation (
    Line(points = {{-220, -40}, {-190, -40}, {-190, 32}, {-180, 32}}, color = {0, 0, 127}));
  connect(add.y, Busbar_CHP.u_Demand) annotation (
    Line(points = {{-119, 110}, {-108, 110}, {-108, 180}, {-77.75, 180}, {-77.75, 166.5}}, color = {0, 0, 127}));
  connect(u_DemandElectrolyser, add.u1) annotation (
    Line(points = {{-220, 180}, {-142, 180}, {-142, 116}}, color = {0, 0, 127}));
  connect(add3_1.y, add.u2) annotation (
    Line(points = {{-157, 40}, {-150, 40}, {-150, 104}, {-142, 104}}, color = {0, 0, 127}));
  annotation (
    experiment(StartTime = 0, StopTime = 345600, Tolerance = 1e-06, Interval = 900),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", outputFormat = "mat", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(origin = {-2, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
    __OpenModelica_commandLineOptions = "");
end busbar_4consumer;
