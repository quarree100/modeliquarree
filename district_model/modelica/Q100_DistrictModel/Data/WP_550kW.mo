within Q100_DistrictModel.Data;
record WP_550kW
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(tableP_ele = [0, -15, -10, -7, 2, 7, 10; 35, 176000, 197500, 146680, 131150, 906090, 864530; 45, 270000, 272730, 183660, 184430, 120000, 120000; 50, 282440, 250000, 179000, 160000, 128200, 100000; 55, 361520, 390090, 298000, 249800, 118420, 110000], tableQdot_con = [0, -15, -10, -7, 2, 7, 10; 35, 440000, 452500, 451800, 554800, 550000, 600000; 45, 420000, 450000, 446300, 549600, 550000, 560000; 50, 451900, 500000, 400000, 450000, 500000, 550000; 55, 451900, 433000, 450000, 509600, 450000, 550000], mFlow_conNom = 60000 / 4180 / 5, mFlow_evaNom = 1, tableUppBou = [-20, 50; -10, 60; 30, 60; 35, 55]);
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
end WP_550kW;
