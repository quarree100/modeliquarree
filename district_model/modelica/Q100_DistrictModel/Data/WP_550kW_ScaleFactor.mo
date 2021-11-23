within Q100_DistrictModel.Data;
record WP_550kW_ScaleFactor
  parameter Real SF = 1 "Scale factor";
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(tableP_ele = [0, -15, -10, -7, 2, 7, 10; 35, 176000*SF, 197500*SF, 146680*SF, 131150*SF, 906090*SF, 864530*SF; 45, 270000*SF, 272730*SF, 183660*SF, 184430*SF, 120000*SF, 120000*SF; 50, 282440*SF, 250000*SF, 179000*SF, 160000*SF, 128200*SF, 100000*SF; 55, 361520*SF, 390090*SF, 298000*SF, 249800*SF, 118420*SF, 110000*SF], tableQdot_con = [0, -15, -10, -7, 2, 7, 10; 35, 440000*SF, 452500*SF, 451800*SF, 554800*SF, 550000*SF, 600000*SF; 45, 420000*SF, 450000*SF, 446300*SF, 549600*SF, 550000*SF, 560000*SF; 50, 451900*SF, 500000*SF, 400000*SF, 450000*SF, 500000*SF, 550000*SF; 55, 451900*SF, 433000*SF, 450000*SF, 509600*SF, 450000*SF, 550000*SF], mFlow_conNom = 60000 / 4180 / 5, mFlow_evaNom = 1, tableUppBou = [-20, 50; -10, 60; 30, 60; 35, 55]);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(info = "<html><p>
<span style=
\"font-family: Courier New; color: #006400;\">Data&#160;record&#160;for&#160;type&#160;AWO-M/AWO-M-E-AC&#160;201.A04,
obtained from the technical guide in the UK.</span>
</p>
<ul>
<li>
<i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
First implementation (see issue <a href=
\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"));
end WP_550kW_ScaleFactor;
