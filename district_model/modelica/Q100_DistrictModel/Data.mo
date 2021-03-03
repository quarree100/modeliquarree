within Q100_DistrictModel;
package Data
    extends Modelica.Icons.RecordsPackage;

    record inputData
      extends Modelica.Icons.Record;
      parameter String Pfad = "./";
      parameter String inputFileNameWeatherData = Pfad + "TRY2015_541957091051_Jahr.mos";
      parameter String inputFileNameCHP_P = Pfad + "Fahrplan_optCHP_P.txt";
      parameter String inputFileNameCHP_OP = Pfad + "Fahrplan_optCHP_OP.txt";
      parameter String inputFileNameElectrolyser_P = Pfad + "Fahrplan_optElectrolyser_P.txt";
      parameter String inputFileNameElectrolyser_OP = Pfad + "Fahrplan_optElectrolyser_OP.txt";
      parameter String inputFileNameBoiler = Pfad + "Fahrplan_optBoiler.txt";
      parameter String inputFileNameHeatPump = Pfad + "Fahrplan_optHeatPump.txt";
      parameter String inputFileNameHeatSword = Pfad + "Fahrplan_optHeatSword.txt";
      parameter String inputFileNameBat = Pfad + "Fahrplan_optBat.txt";
      parameter String inputFileNameDemandThermal = Pfad + "Waermebedarf_normiert.txt";
      parameter String inputFileNameDemandPower = Pfad + "Strombedarf_normiert.txt";
      parameter String inputFileNameEMob = Pfad + "EMobilitaet_normiert.txt";
      parameter String inputFileNameH2Mob = Pfad + "H2Mobilitaet_normiert.txt";
      parameter String inputFileNameSpot = Pfad + "SpotPreis.txt";
    end inputData;

    record inputData_jzimmer
      extends Q100_DistrictModel.Data.inputData(
        Pfad = "C:/Users/Nettelstroth/code_projects/quarree100/modeliquarree/district_model/modelica/Q100_DistrictModel/input/");
    end inputData_jzimmer;

    record inputData_jwalbrunn
      extends Q100_DistrictModel.Data.inputData(
        Pfad = "Z:/owncloud/Consolinno/Projekte/Quarree100_Consolinno/Simulation_Modelica/input/");
    end inputData_jwalbrunn;

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

    record HeatDemand
      extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(tableP_ele = [0, -15, -10, -7, 2, 7, 10; 35, 17600, 19750, 14668, 13115, 90609, 86453; 45, 27000, 27273, 18366, 18443, 12000, 12000; 50, 28244, 25000, 17900, 16000, 12820, 10000; 55, 36152, 39009, 29800, 24980, 11842, 11000], tableQdot_con = [0, -15, -10, -7, 2, 7, 10; 35, 44000, 45250, 45180, 55480, 55000, 60000; 45, 42000, 45000, 44630, 54960, 55000, 56000; 50, 45190, 50000, 40000, 45000, 50000, 55000; 55, 45190, 43300, 45000, 50960, 45000, 55000], mFlow_conNom = 60000 / 4180 / 5, mFlow_evaNom = 1, tableUppBou = [-20, 50; -10, 60; 30, 60; 35, 55]);
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
    end HeatDemand;

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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info = "<html>
      <p>Im package Data werden alle Kennlinien, Daten, Datenblätter für die unterschiedlichen Simulationen abgelegt.</p>
      <p>Erstellt bzw. angepasst wurden die Daten durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
end Data;
