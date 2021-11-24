within Q100_DistrictModel.Components.ElectrolysisSystem.Heater;
model Check
  extends Modelica.Icons.Example;

    // components

    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor comp_heatCapacity(C=1250000,
        T(fixed=true, start=30 + 273.15))
      "heat capacity of electrolyser and water inside electrolyser"    annotation (Placement(transformation(extent={{-10,-10},
              {10,10}},
          rotation=0,
          origin={58,-2})));
    Heater heater(
      param_P_el_max=30000,
      param_eta=0.99)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=comp_heatCapacity.T)
      annotation (Placement(transformation(extent={{-80,14},{-60,34}})));
    Modelica.Blocks.Sources.RealExpression exp_const_cool(y=-250)
      annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=250e3,
      duration=1e8,
      offset=0)
      annotation (Placement(transformation(extent={{-110,-8},{-90,12}})));
protected
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_wasteHeat(alpha=0)
      "waste heat" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={10,0})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatflow_cooling(alpha=0)
      "waste heat" annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={10,-40})));
equation

    connect(heatflow_wasteHeat.port, comp_heatCapacity.port) annotation (Line(
          points={{20,-1.33227e-15},{32,-1.33227e-15},{32,-22},{58,-22},{58,-12}},
          color={191,0,0}));
    connect(realExpression.y, heater.inp_T_is) annotation (Line(points={{-59,24},
            {-52,24},{-52,0},{-42,0}}, color={0,0,127}));
    connect(heater.out_P_heat, heatflow_wasteHeat.Q_flow) annotation (Line(
          points={{-19,0},{-12,0},{-12,1.11022e-15},{0,1.11022e-15}}, color={0,
            0,127}));
    connect(heatflow_cooling.port, comp_heatCapacity.port)
      annotation (Line(points={{20,-40},{58,-40},{58,-12}}, color={191,0,0}));
    connect(exp_const_cool.y, heatflow_cooling.Q_flow)
      annotation (Line(points={{-19,-40},{0,-40}}, color={0,0,127}));
    connect(ramp.y, heater.inp_P_av) annotation (Line(points={{-89,2},{-66,2},{
            -66,8},{-42,8}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=100000000, __Dymola_NumberOfIntervals=10000));
end Check;
