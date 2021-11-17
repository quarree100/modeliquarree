within Q100_DistrictModel.Components.ElectrolysisSystem.Tools.Boundaries;
model PowerSource
  // power boundary with either a prescribed power input or an input connector
  parameter SI.Power P=1e3 "Boundary Power in W"
    annotation (Dialog(enable=not usePowerInput));
  parameter Boolean usePowerInput = false "Use external power input" annotation (
    Evaluate = true,
    HideResult = true);
  Modelica.Blocks.Interfaces.RealInput powerInput(final unit = "W") if usePowerInput "Input for external power in W" annotation (
    Placement(visible = true, transformation(origin = {-72, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin={-25,63},    extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Connectors.PowerConnector powerConnector annotation (
      Placement(
      visible=true,
      transformation(
        origin={0,0},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-5.32907e-15,0},
        extent={{-30,-30},{30,30}},
        rotation=0)));
protected
  Modelica.Blocks.Interfaces.RealInput internalPowerInput(final unit = "W") "Only needed to connect to conditional connector";
equation
  if not usePowerInput then
    // overwrite input from connector
    internalPowerInput = P;
  end if;
  powerConnector.P = internalPowerInput;
  connect(powerInput, internalPowerInput);
  annotation (
    Icon(graphics={  Line(origin = {0, 0.79}, points = {{0, 99.5}, {0, -100.5}}),
                                        Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255})},                                                     coordinateSystem(initialScale = 0.1)));
end PowerSource;
