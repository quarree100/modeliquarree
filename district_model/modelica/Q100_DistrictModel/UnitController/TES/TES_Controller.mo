within Q100_DistrictModel.UnitController.TES;
model TES_Controller
  Modelica.Blocks.Interfaces.RealInput P_th_DH_demand annotation (Placement(
        transformation(extent={{-112,40},{-100,52}}),iconTransformation(extent={{-112,40},
            {-100,52}})));
  Modelica.Blocks.Interfaces.RealInput P_th_DH_supply annotation (Placement(
        transformation(extent={{-112,62},{-100,74}}),iconTransformation(extent={{-112,62},
            {-100,74}})));
  Modelica.Blocks.Interfaces.RealInput T_DH_RF annotation (Placement(
        transformation(extent={{-112,-2},{-100,10}}),
                                                    iconTransformation(extent={{-112,-2},
            {-100,10}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_load annotation (Placement(
        transformation(extent={{-112,-18},{-100,-6}}),iconTransformation(extent={{-112,
            -18},{-100,-6}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_max_set annotation (Placement(
        transformation(extent={{-112,-36},{-100,-24}}),iconTransformation(
          extent={{-112,-36},{-100,-24}})));
  Modelica.Blocks.Interfaces.RealInput T_TES_unload annotation (Placement(
        transformation(extent={{-112,22},{-100,34}}),iconTransformation(extent={{-112,22},
            {-100,34}})));
  Q100_DistrictModel.UnitController.TES.TES_StSp TES_StSp
    annotation (Placement(transformation(extent={{-10,-36},{62,36}})));
  Modelica.Blocks.Interfaces.RealOutput TES_SI
    ">0 für load, <0 für unload, 0 undefined"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput P_th_TES_load annotation (Placement(
        transformation(extent={{-112,-54},{-100,-42}}),iconTransformation(
          extent={{-112,-54},{-100,-42}})));
  Modelica.Blocks.Interfaces.RealInput P_th_TES_unload annotation (Placement(
        transformation(extent={{-112,-68},{-100,-56}}),iconTransformation(
          extent={{-112,-68},{-100,-56}})));
equation
  connect(P_th_DH_supply, TES_StSp.P_th_DH_supply) annotation (Line(points={{-106,68},
          {-60,68},{-60,29.52},{-12.88,29.52}},       color={0,0,127}));
  connect(P_th_DH_demand, TES_StSp.P_th_DH_demand) annotation (Line(points={{-106,46},
          {-74,46},{-74,22},{-16,22},{-16,20.88},{-12.88,20.88}},
                                                    color={0,0,127}));
  connect(T_TES_unload, TES_StSp.T_TES_unload) annotation (Line(points={{-106,28},
          {-80,28},{-80,11.52},{-12.88,11.52}},color={0,0,127}));
  connect(T_DH_RF, TES_StSp.T_DH_RF) annotation (Line(points={{-106,4},{-18,4},
          {-18,2.88},{-12.88,2.88}},
                                  color={0,0,127}));
  connect(T_TES_load, TES_StSp.T_TES_load) annotation (Line(points={{-106,-12},
          {-18,-12},{-18,-7.2},{-12.88,-7.2}},
                                            color={0,0,127}));
  connect(T_TES_max_set, TES_StSp.T_TES_max_set) annotation (Line(points={{-106,
          -30},{-38,-30},{-38,-12.96},{-12.88,-12.96}},
                                       color={0,0,127}));
  connect(TES_StSp.P_th_TES, TES_SI)
    annotation (Line(points={{65.6,0},{110,0}}, color={0,0,127}));
  connect(P_th_TES_load, TES_StSp.P_th_TES_load) annotation (Line(points={{-106,
          -48},{-26,-48},{-26,-17.28},{-10,-17.28}}, color={0,0,127}));
  connect(P_th_TES_unload, TES_StSp.P_th_TES_unload) annotation (Line(points={{
          -106,-62},{-14,-62},{-14,-22.32},{-10,-22.32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TES_Controller;
