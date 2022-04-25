within Q100_DistrictModel.Components;
model calc_Qdot_production "Callculation of heat production of all units"
  extends Modelica.Icons.Package;
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_Heatpump2 annotation (Placement(
      visible=true,
      transformation(
        origin={-110,60},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_Heatpump1 annotation (Placement(
      visible=true,
      transformation(
        origin={-110,100},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,100},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y_Qdot annotation (
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=6) annotation (Placement(transformation(extent={{-6,-6},{6,6}})));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_CHP annotation (Placement(
      visible=true,
      transformation(
        origin={-110,-20},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_Electrolyzer annotation (Placement(
      visible=true,
      transformation(
        origin={-110,20},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,20},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_Boiler annotation (Placement(
      visible=true,
      transformation(
        origin={-110,-60},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-60},
        extent={{-10,-10},{10,10}},
        rotation=0)));
  replaceable Modelica.Blocks.Interfaces.RealInput u_Qdot_StorageUnload annotation (Placement(
      visible=true,
      transformation(
        origin={-110,-100},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-110,-100},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(u_Qdot_Boiler, multiSum.u[1]) annotation (Line(points={{-110,-60},{-12,-60},{-12,3.5},{-6,3.5}}, color={0,0,127}));
  connect(u_Qdot_CHP, multiSum.u[2]) annotation (Line(points={{-110,-20},{-12,-20},{-12,2.1},{-6,2.1}}, color={0,0,127}));
  connect(u_Qdot_Electrolyzer, multiSum.u[3]) annotation (Line(points={{-110,20},{-64,20},{-64,0.7},{-6,0.7}}, color={0,0,127}));
  connect(u_Qdot_Heatpump2, multiSum.u[4]) annotation (Line(points={{-110,60},{-18,60},{-18,-0.7},{-6,-0.7}}, color={0,0,127}));
  connect(u_Qdot_Heatpump1, multiSum.u[5]) annotation (Line(points={{-110,100},{-18,100},{-18,-2.1},{-6,-2.1}}, color={0,0,127}));
  connect(multiSum.y, y_Qdot) annotation (Line(points={{7.02,0},{110,0}}, color={0,0,127}));
  connect(u_Qdot_StorageUnload, multiSum.u[6]) annotation (Line(points={{-110,-100},{-64,-100},{-64,-3.5},{-6,-3.5}}, color={0,0,127}));
  annotation (
    Documentation(info = "<html>
    <p>
    This component simiulate a basboiler with a simple control system. 
    
    <p>
    Parameter:  
    <p> 
    <strong>T_Out:</strong> Output temperature of the boiler. It regulates the mass flow of the pump 
    
    
    </html>"),
    Icon(coordinateSystem(initialScale = 0.1), graphics={  Text(origin = {-6, -124}, lineColor = {0, 0, 255}, extent = {{-150, 150}, {150, 110}}, textString = "%name")}),
    experiment(StartTime = 0, StopTime = 7200, Tolerance = 1e-06, Interval = 1));
end calc_Qdot_production;
