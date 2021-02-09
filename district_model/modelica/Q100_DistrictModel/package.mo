﻿package Q100_DistrictModel
  extends Modelica.Icons.Package;

  annotation (
    uses(Modelica(version = "3.2.3"),                            BuildingSystems,
    AixLib(version="0.10.2")),
    Documentation(info = "<html>
    <p>Q100_DistrictModel dient als package, in welchem alle wichtigen Komponenten und Simulationsmodelle abgelegt werden.</p>
    <p>Erstellt wurde das Modell durch die Consolinno Energy GmbH im Rahmen des Forschungsprojektes EnStadtQuarree100.</p>
    <p>Ansprechpartner für das Projekt bei Consolinno ist Fabian Eckert. Die Arbeiten in Modelica wurde durch Johannes Walbrunn durchgeführt.</p>
    <p>Consolinno Energy GmbH, Regensburg 24. März 2020</p>
    </html>"),
  version="1",
  conversion(from(version="", script="ConvertFromQ100_DistrictModel_.mos")));
end Q100_DistrictModel;
