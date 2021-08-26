within Q100_DistrictModel.ElectrolysisSystem.Tools.Connectors;
connector PowerConnector
  SI.Power P "Power in W";
  annotation (
    Icon(graphics={  Ellipse(origin = {-17, -51}, fillColor = {255, 255, 255},
            fillPattern =                                                                    FillPattern.Solid, extent = {{-83, 151}, {117, -49}}, endAngle = 360), Text(origin = {-22, 35}, extent = {{-30, 35}, {74, -95}}, textString = "P"), Text(origin = {9, -5}, extent = {{-15, -7}, {27, -59}}, textString = "el")}, coordinateSystem(initialScale = 0.1)));
end PowerConnector;
