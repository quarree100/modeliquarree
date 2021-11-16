within Q100_DistrictModel.Components.ElectrolysisSystem.Pump;
model Pump "FastHVAC pump with power consumption and efficiency"

  replaceable package H2O = Modelica.Media.Water.WaterIF97_R1pT; //R1 is liquid, R2 is vapor
  H2O.ThermodynamicState stateH2O;

  //parameters
  parameter SI.VolumeFlowRate param_Q_min=param_Q_max*0.001
    "minimal volume flow rate of pump at 25°C [m³/s]";
  parameter SI.VolumeFlowRate param_Q_max=5e-3
    "maximal volume flow rate of pump at 25°C [m³/s]";
  parameter SI.Pressure param_p_loss=2e5
    "system pressure loss at maximum volume flow rate [Pa]";
  parameter SI.Efficiency param_eta=0.6
    "cooling pump efficiency at operating condition";

  parameter SI.Distance param_l=100
    "estimated total pipe length [m]";
  parameter SI.Distance param_k=100e-6
    "pipe surface roughness";
  parameter SI.Temperature param_T_init=55+273.15
    "temperature at which param_p_loss was measured";
  parameter SI.Temperature param_T_op=55+273.15
    "assumed constant temperature for property calculation";

  parameter SI.Distance param_d(start=0.05, fixed=false) "hydraulic diameter (be careful with start value)";

  // variables
  SI.Energy var_P_cons(start=0.0, fixed=true)
    "integrated power consumption";
  Real var_P_cons_kWh = SI.Conversions.to_kWh(var_P_cons)
    "integrated power consumption in kWh";
  SI.Pressure var_dp "current pressure loss";
  SI.KinematicViscosity var_my "kinematic viscosity water";
  SI.Density var_dens "density of water";

  // components
  Modelica.Blocks.Interfaces.RealInput inp_Q "input volume flow" annotation (
      Placement(transformation(extent={{-22,82},{18,122}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,110})));
  Tools.Connectors.PowerConnector port_P_el annotation (Placement(transformation(extent={{-100,-100},
            {-80,-80}}), iconTransformation(extent={{-120,-120},{-80,-80}})));
  AixLib.FastHVAC.Components.Pumps.Pump comp_pump annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a port_inlet annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={
            {-110,-10},{-90,10}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b port_outlet annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,
            -10},{110,10}})));
  SI.VolumeFlowRate var_Q=min(max(inp_Q,param_Q_min),param_Q_max);
    // 'variables' to calculate only once
  parameter SI.Velocity param_w_max(fixed=false) "max flow velocity";
  parameter SI.ReynoldsNumber param_Re_max(fixed=false) "max Reynolds number";
  parameter Real param_lambda_max(start=0.02, fixed=false) "maximum friction coefficient";
  parameter Real var_a_init(fixed=false);
  parameter Real var_b_init(fixed=false);
  parameter Real var_c_init(fixed=false);

  SI.Velocity var_w "mean flow velocity";
  Real var_lambda(start=0.002, fixed=false);
  SI.ReynoldsNumber var_Re;

  Real var_a(fixed=false);
  Real var_b(fixed=false);
  Real var_c(fixed=false);

initial equation

  // solve only once for hydraulic diameter param_d
  param_w_max = param_Q_max/(Const.pi/4*param_d^2);
  param_Re_max = param_w_max*param_d/(H2O.dynamicViscosity(H2O.setState_pT(1+param_p_loss/2, param_T_init))/H2O.density(H2O.setState_pT(1+param_p_loss/2, param_T_init)));

  // meet boundary condition maximum pressure loss for pipe diameter
  param_p_loss = param_lambda_max*param_l/param_d*H2O.density(H2O.setState_pT(1+param_p_loss/2, param_T_init))*param_w_max^2/2;

  // implicit formulation of lambda
  // 1/sqrt(param_lambda_max) = -2*log10(2.51/(param_Re_max*sqrt(param_lambda_max))+param_k/(3.71*param_d));

  // explicit formulation of lambda with Lambert W-function
  var_a_init = 2.51/param_Re_max;
  var_b_init = param_k/(3.71*param_d);
  var_c_init = Modelica.Fluid.Dissipation.Utilities.Functions.General.LambertW(log(10)/(2*var_a_init)*10^(var_b_init/(2*var_a_init)));
  param_lambda_max = 1/(2*var_c_init/log(10)-var_b_init/var_a_init)^2;

equation

  assert(
    port_P_el.P >= -Const.eps,
    "power input is below zero",
    AssertionLevel.error);

    // kinematic viscosity at atmospheric pressure + 0.5*pressure increase
    stateH2O = H2O.setState_pT(1e5+param_p_loss/2, param_T_op);
    // min value is triple point density
    var_dens = max(H2O.density(stateH2O), 0.0048546);
    var_my= H2O.dynamicViscosity(stateH2O)/var_dens;

    // calculation of velocity and reynolds number
    var_w = var_Q/(Const.pi/4*param_d^2);
    var_Re = var_w*param_d/var_my;

    if noEvent(var_Re>1000) then
      // explicit formulation of lambda with Lambert W-function
      var_a = 2.51/var_Re;
      var_b = param_k/(3.71*param_d);
      // term for lambert w function
      var_c = Modelica.Fluid.Dissipation.Utilities.Functions.General.LambertW(log(10)/(2*var_a)*10^(var_b/(2*var_a)));
      var_lambda = 1/(2*var_c/log(10)-var_b/var_a)^2;
    else
      var_a=0;
      var_b=0;
      var_c=0;
      var_lambda=0.1;
    end if;

    // pressure loss at current operating point
    var_dp = var_lambda*param_l/param_d*var_dens*var_w^2/2;

    // power consumption via pressure loss
    port_P_el.P = var_Q*var_dp/param_eta;
    der(var_P_cons) = port_P_el.P;

    // input for pump component
    comp_pump.dotm_setValue = var_Q*var_dens;
  connect(comp_pump.enthalpyPort_b, port_outlet) annotation (Line(points={{6.66134e-16,
          9.6},{6.66134e-16,30},{100,30},{100,0}}, color={176,0,0}));
  connect(port_inlet, comp_pump.enthalpyPort_a) annotation (Line(points={{-100,0},
          {-100,-28},{-6.66134e-16,-28},{-6.66134e-16,-9.6}}, color={176,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(points={{-20,98},{100,0},{-20,-98}},
            color={0,0,0})}),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pump;
