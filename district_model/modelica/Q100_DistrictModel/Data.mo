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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info = "<html>
      <p>Im package Data werden alle Kennlinien, Daten, Datenblätter für die unterschiedlichen Simulationen abgelegt.</p>
      <p>Erstellt bzw. angepasst wurden die Daten durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
      <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
      <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
      </html>"));
end Data;
