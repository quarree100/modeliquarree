within Q100_DistrictModel.ElectrolysisSystem.Tools.Components;
model ThreeWayConnector "inverted three way valve"

  /* *******************************************************************
      Components
     ******************************************************************* */

  AixLib.FastHVAC.Interfaces.EnthalpyPort_a inlet1 annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}}), iconTransformation(extent=
           {{90,-10},{110,10}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b outlet annotation (Placement(
        transformation(extent={{82,-10},{102,10}}), iconTransformation(extent={
            {-108,-10},{-88,10}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a inlet2 annotation (Placement(
        transformation(extent={{-10,-102},{10,-82}}), iconTransformation(extent=
           {{-10,-110},{10,-90}})));

equation

  // mass balance
  outlet.m_flow = inlet1.m_flow + inlet2.m_flow;

  // enthalpy balance
  if noEvent(outlet.m_flow>0) then
    outlet.h*outlet.m_flow = inlet1.h*inlet1.m_flow + inlet2.h*inlet2.m_flow;
  else
    outlet.h = inlet1.h;
  end if;
  // temperature balance assuming c_p is constant
  outlet.T*outlet.m_flow = inlet1.T*inlet1.m_flow + inlet2.T*inlet2.m_flow;

  outlet.c = inlet1.c;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={Polygon(
                  points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},
            {-100,50}},
                  lineColor={0,0,0},
                  lineThickness=0.5),            Line(
                  points={{-50,0},{50,50},{50,-50},{-50,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  origin={0,-50},
                  rotation=270,
                  thickness=0.5),
        Line(points={{80,0},{36,0},{46,6}}, color={0,0,0}),
        Line(points={{36,0},{46,-6}}, color={0,0,0}),
        Line(points={{-36,0},{-80,0},{-70,6}}, color={0,0,0}),
        Line(points={{-80,0},{-70,-6}}, color={0,0,0}),
        Line(
          points={{23,-2},{-21,-2},{-11,4}},
          color={0,0,0},
          origin={2,-57},
          rotation=270),
        Line(
          points={{-5,3},{5,-3}},
          color={0,0,0},
          origin={-3,-41},
          rotation=270)}),
     Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a three way valve
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars2.png\" alt=\"\" />
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The instreaming flow can be divided into two flows. The ratio of the
  two flows is controlled by the external input.
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 22, 2014&#160;</i> by Markus Schumacher:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end ThreeWayConnector;
