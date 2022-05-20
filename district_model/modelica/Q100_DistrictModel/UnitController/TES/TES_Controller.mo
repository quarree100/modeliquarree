within Q100_DistrictModel.UnitController.TES;
model TES_Controller
  Modelica.Blocks.Interfaces.RealInput P_th_DH_demand annotation (Placement(
        transformation(extent={{-112,24},{-100,36}}),iconTransformation(extent={{-112,24},{-100,36}})));
  Modelica.Blocks.Interfaces.RealInput P_th_DH_supply annotation (Placement(
        transformation(extent={{-112,44},{-100,56}}),iconTransformation(extent={{-112,44},{-100,56}})));
  Modelica.Blocks.Interfaces.RealInput T_DH_RF annotation (Placement(
        transformation(extent={{-112,-16},{-100,-4}}),
                                                    iconTransformation(extent={{-112,-16},{-100,-4}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_load annotation (Placement(
        transformation(extent={{-112,-36},{-100,-24}}),
                                                      iconTransformation(extent={{-112,-36},{-100,-24}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_max_set annotation (Placement(
        transformation(extent={{-112,-56},{-100,-44}}),iconTransformation(
          extent={{-112,-56},{-100,-44}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_unload annotation (Placement(
        transformation(extent={{-112,4},{-100,16}}), iconTransformation(extent={{-112,4},{-100,16}})));
  Q100_DistrictModel.UnitController.TES.TES_StSp TES_StSp
    annotation (Placement(transformation(extent={{-50,-36},{22,36}})));
  Modelica.Blocks.Interfaces.RealOutput TES_unload_SI ">0 für load, <0 für unload, 0 undefined" annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealInput P_th_TES_load annotation (Placement(
        transformation(extent={{-112,-76},{-100,-64}}),iconTransformation(
          extent={{-112,-76},{-100,-64}})));
  Modelica.Blocks.Interfaces.RealInput P_th_TES_unload annotation (Placement(
        transformation(extent={{-112,-96},{-100,-84}}),iconTransformation(
          extent={{-112,-96},{-100,-84}})));
  Modelica.Blocks.Interfaces.RealOutput TES_load_SI ">0 für load, <0 für unload, 0 undefined" annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Components.TES_Switch tES_Switch annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  Modelica.Blocks.Interfaces.RealInput signal_TES_unload_prio_ext annotation (Placement(transformation(extent={{-110,66},{-100,76}}), iconTransformation(extent={{-112,64},{-100,76}})));
  Modelica.Blocks.Interfaces.RealInput signal_TES_load_prio_ext annotation (Placement(transformation(extent={{-112,84},{-100,96}}), iconTransformation(extent={{-112,84},{-100,96}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{72,32},{88,48}})));
  Modelica.Blocks.Logical.GreaterThreshold
                                        greaterThreshold1(threshold=-0.01)
                                                                        annotation (Placement(transformation(extent={{-34,66},{-20,80}})));
  Modelica.Blocks.Logical.GreaterThreshold
                                        greaterThreshold(threshold=-0.01)
                                                                         annotation (Placement(transformation(extent={{-34,-80},{-20,-66}})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(extent={{72,-32},{88,-48}})));
equation
  connect(P_th_DH_supply, TES_StSp.P_th_DH_supply) annotation (Line(points={{-106,50},{-90,50},{-90,36},{-52.16,36}},
                                                      color={0,0,127}));
  connect(P_th_DH_demand, TES_StSp.P_th_DH_demand) annotation (Line(points={{-106,30},{-94,30},{-94,25.2},{-52.16,25.2}},
                                                    color={0,0,127}));
  connect(T_TES_unload, TES_StSp.T_TES_unload) annotation (Line(points={{-106,10},{-80,10},{-80,14.4},{-52.16,14.4}},
                                               color={0,0,127}));
  connect(T_DH_RF, TES_StSp.T_DH_RF) annotation (Line(points={{-106,-10},{-94,-10},{-94,3.6},{-52.16,3.6}},
                                  color={0,0,127}));
  connect(T_TES_load, TES_StSp.T_TES_load) annotation (Line(points={{-106,-30},{-88,-30},{-88,-7.2},{-52.16,-7.2}},
                                            color={0,0,127}));
  connect(T_TES_max_set, TES_StSp.T_TES_max_set) annotation (Line(points={{-106,-50},{-80,-50},{-80,-16.56},{-52.16,-16.56}},
                                       color={0,0,127}));
  connect(P_th_TES_load, TES_StSp.P_th_TES_load) annotation (Line(points={{-106,-70},{-70,-70},{-70,-25.2},{-52.16,-25.2}},
                                                     color={0,0,127}));
  connect(P_th_TES_unload, TES_StSp.P_th_TES_unload) annotation (Line(points={{-106,-90},{-60,-90},{-60,-35.28},{-52.16,-35.28}},
                                                          color={0,0,127}));
  connect(TES_StSp.P_th_TES, tES_Switch.u) annotation (Line(points={{25.6,0},{34,0}}, color={0,0,127}));
  connect(switch1.y, TES_load_SI) annotation (Line(points={{88.8,40},{110,40}}, color={0,0,127}));
  connect(tES_Switch.y1, switch1.u3) annotation (Line(points={{57,6},{64,6},{64,34},{68,34},{68,33.6},{70.4,33.6}}, color={0,0,127}));
  connect(signal_TES_load_prio_ext, switch1.u1) annotation (Line(points={{-106,90},{60,90},{60,46.4},{70.4,46.4}}, color={0,0,127}));
  connect(signal_TES_load_prio_ext, greaterThreshold1.u) annotation (Line(points={{-106,90},{-40,90},{-40,73},{-35.4,73}}, color={0,0,127}));
  connect(greaterThreshold1.y, switch1.u2) annotation (Line(points={{-19.3,73},{40,73},{40,40},{70.4,40}}, color={255,0,255}));
  connect(signal_TES_unload_prio_ext, greaterThreshold.u) annotation (Line(points={{-105,71},{-66,71},{-66,-73},{-35.4,-73}}, color={0,0,127}));
  connect(switch2.y, TES_unload_SI) annotation (Line(points={{88.8,-40},{110,-40}}, color={0,0,127}));
  connect(switch2.u2, greaterThreshold.y) annotation (Line(points={{70.4,-40},{40,-40},{40,-73},{-19.3,-73}}, color={255,0,255}));
  connect(signal_TES_unload_prio_ext, switch2.u1) annotation (Line(points={{-105,71},{-66,71},{-66,-96},{48,-96},{48,-46},{70.4,-46},{70.4,-46.4}}, color={0,0,127}));
  connect(switch2.u3, tES_Switch.y2) annotation (Line(points={{70.4,-33.6},{64,-33.6},{64,-6},{57,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TES_Controller;
