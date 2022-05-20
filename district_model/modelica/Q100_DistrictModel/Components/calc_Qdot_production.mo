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
  Modelica.Blocks.Math.MultiSum multiSum(nu=5) annotation (Placement(transformation(extent={{-6,-6},{6,6}})));
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
  Modelica.Blocks.Math.MultiSum multiSum1(nu=3)
                                               annotation (Placement(transformation(extent={{-6,-86},{6,-74}})));
  Modelica.Blocks.Interfaces.RealOutput y_Qdot_reg annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
equation
  connect(u_Qdot_Boiler, multiSum.u[1]) annotation (Line(points={{-110,-60},{-12,-60},{-12,3.36},{-6,3.36}},
                                                                                                           color={0,0,127}));
  connect(u_Qdot_CHP, multiSum.u[2]) annotation (Line(points={{-110,-20},{-12,-20},{-12,1.68},{-6,1.68}},
                                                                                                        color={0,0,127}));
  connect(u_Qdot_Electrolyzer, multiSum.u[3]) annotation (Line(points={{-110,20},{-64,20},{-64,2},{-36,2},{-36,0},{-6,0}},
                                                                                                               color={0,0,127}));
  connect(u_Qdot_Heatpump2, multiSum.u[4]) annotation (Line(points={{-110,60},{-18,60},{-18,-1.68},{-6,-1.68}},
                                                                                                              color={0,0,127}));
  connect(u_Qdot_Heatpump1, multiSum.u[5]) annotation (Line(points={{-110,100},{-18,100},{-18,-3.36},{-6,-3.36}},
                                                                                                                color={0,0,127}));
  connect(multiSum.y, y_Qdot) annotation (Line(points={{7.02,0},{110,0}}, color={0,0,127}));
  connect(multiSum1.y, y_Qdot_reg) annotation (Line(points={{7.02,-80},{110,-80}}, color={0,0,127}));
  connect(u_Qdot_Heatpump1, multiSum1.u[1]) annotation (Line(points={{-110,100},{-32,100},{-32,-78},{-10,-78},{-10,-77.2},{-6,-77.2}}, color={0,0,127}));
  connect(u_Qdot_Heatpump2, multiSum1.u[2]) annotation (Line(points={{-110,60},{-50,60},{-50,-82},{-6,-82},{-6,-80}}, color={0,0,127}));
  connect(u_Qdot_Electrolyzer, multiSum1.u[3]) annotation (Line(points={{-110,20},{-64,20},{-64,2},{-42,2},{-42,-82.8},{-6,-82.8}}, color={0,0,127}));
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
