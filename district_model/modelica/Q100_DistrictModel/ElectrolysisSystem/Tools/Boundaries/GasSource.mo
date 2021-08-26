within Q100_DistrictModel.ElectrolysisSystem.Tools.Boundaries;
model GasSource

  replaceable package Gas = Media.Gases.H2andWaterVapor
    constrainedby Modelica.Media.Interfaces.PartialMedium;

  //  parameter
  parameter SI.Temperature T=298.15 "temperature of gas";
  parameter SI.AbsolutePressure p=1e5 "pressure of gas";
  parameter SI.MolarFlowRate n_dot_gas=0.9
    "molar flow rate of gas";
  parameter SI.MolarFlowRate n_dot_h2o=0.1
    "molar flow rate of water vapor";

  Connectors.GasConnector gasConnector(redeclare package Gas =
                    Gas) annotation (Placement(transformation(extent={{-20,-20},
            {20,20}}), iconTransformation(extent={{-30,-30},{30,30}})));

protected
  Real X[2];
equation

  X[1] = n_dot_gas/(n_dot_gas+n_dot_h2o);
  X[2] = 1-X[1];

  gasConnector.p = p;
  gasConnector.X = X;
  gasConnector.n_flow = (n_dot_gas + n_dot_h2o);
  gasConnector.h = Gas.specificEnthalpy(Gas.setState_pTX(
    p,
    T,
    X));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
            points={{0,100},{0,-100}},
                                     color={0,0,0}),
                                        Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})}),                        Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end GasSource;
