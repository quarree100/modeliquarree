within Q100_DistrictModel.Components;
block MultiMin "Min of Reals: y = min(u[])"
  extends Modelica.Blocks.Interfaces.PartialRealMISO;
  parameter Real k[nu]=fill(1, nu) "Input gains";
equation
  if size(u, 1) > 0 then
    y = min(u);
  else
    y = 0;
  end if;

  annotation (Icon(graphics={Text(
          extent={{-200,-110},{200,-140}},
          textString="%k"), Text(
          extent={{-72,68},{92,-68}},
          textString="max()",
          lineColor={0,0,0})}),
                             Documentation(info="<html>
</html>"));
end MultiMin;
