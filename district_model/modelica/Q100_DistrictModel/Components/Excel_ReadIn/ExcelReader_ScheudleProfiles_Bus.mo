within Q100_DistrictModel.Components.Excel_ReadIn;
model ExcelReader_ScheudleProfiles_Bus "Excel XLSX file read in"
  extends Modelica.Icons.Record;
  parameter String sheetName="input_test_final" "Excel sheet name" annotation(choices(choice="set1" "First Excel sheet", choice="set2" "Second Excel sheet"));
  parameter String firstCell="A2" "First upper left cell of data set (without header)";
  parameter Integer endRow = 8760 "Number of rows in data set (without header)";
  parameter Integer endColumne = 8 "Number of columns in data set (with time columne)";
  parameter Integer i = 4 "Column number of heat pump profil in error data set (without time columne)";
  parameter Integer j = 3 "Column number of electrolysis profil in error data set (without time columne)";
  parameter Integer k = 2 "Column number of CHP profil in error data set (without time columne)";
  parameter Integer l = 5 "Column number of boiler profil in error data set (without time columne)";
  parameter Integer m = 6 "Column number of storage load profil in error data set (without time columne)";
  parameter Integer n = 7 "Column number of storage unload profil in error data set (without time columne)";

  parameter ExternData.XLSXFile dataSource(fileName=
        Modelica.Utilities.Files.loadResource("C:/Users/Tino Mitzinger/ownCloud/FhG-owncloud-Quarree-AB3/AB-1.3/Versorgungssystem Sim oemof/Kataster_v45_Variante-3A/export_modelica/2018-PE-no-ely_Ekonzept02-min-no-excess_techdata5.xlsx"))
    "XLSX file" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,68})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=
        dataSource.getRealArray2D(
        firstCell,
        sheetName,
        endRow,
        endColumne))  annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-70,0})));
  DataBus datalBus annotation (Placement(transformation(extent={{90,-20},{130,
            20}}), iconTransformation(extent={{102,-14},{126,16}})));
equation
  connect(combiTimeTable.y[i], datalBus.u_HeatPump_scheudle) annotation (
      Line(points={{-61.2,0},{110,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable.y[j], datalBus.u_Electrolyzer_scheudle)
    annotation (Line(points={{-61.2,0},{110,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable.y[k], datalBus.u_CHP_scheudle) annotation (Line(
        points={{-61.2,0},{110,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable.y[l], datalBus.u_boiler_scheudle) annotation (Line(
        points={{-61.2,0},{110,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable.y[m], datalBus.u_StorageLoad_scheudle) annotation (
     Line(points={{-61.2,0},{110,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable.y[n], datalBus.u_StorageUnload_scheudle)
    annotation (Line(points={{-61.2,0},{110,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation(experiment(StopTime=1),
    Documentation(info="<html><p>This example model reads the gain parameters from different cells and sheets of the Excel XLSX file <a href=\"modelica://ExternData/Resources/Examples/test.xlsx\">test.xlsx</a>. For gain1 the gain parameter is read as Real value using the function <a href=\"modelica://ExternData.XLSXFile.getReal\">ExternData.XLSXFile.getReal</a>. For gain2 the String value is retrieved by function <a href=\"modelica://ExternData.XLSXFile.getString\">ExternData.XLSXFile.getString</a> and converted to a Real value (using the utility function <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">Modelica.Utilities.Strings.scanReal</a>). For timeTable the table parameter is read as Real array of dimension 3x2 by function <a href=\"modelica://ExternData.XLSXFile.getRealArray2D\">ExternData.XLSXFile.getRealArray2D</a>. The read parameters are assigned by parameter bindings to the appropriate model parameters.</p></html>"));
end ExcelReader_ScheudleProfiles_Bus;
