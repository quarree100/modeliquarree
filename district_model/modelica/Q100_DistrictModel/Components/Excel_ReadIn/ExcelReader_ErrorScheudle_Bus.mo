within Q100_DistrictModel.Components.Excel_ReadIn;
model ExcelReader_ErrorScheudle_Bus "Excel XLSX file read in"
  extends Modelica.Icons.Record;
  parameter String sheetName="error_signal" "Excel sheet name" annotation(choices(choice="set1" "First Excel sheet", choice="set2" "Second Excel sheet"));
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
        Modelica.Utilities.Files.loadResource("C:/Users/Tino Mitzinger/ownCloud/FhG-owncloud-Quarree-AB3/AB-1.3/Versorgungssystem Sim oemof/Kataster_v45_Variante-3A/export_modelica/Failsignal.xlsx"))
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
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation (
    Placement(visible = true, transformation(origin={10,90},        extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1
                                                            annotation (
    Placement(visible = true, transformation(origin={10,50},        extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2
                                                            annotation (
    Placement(visible = true, transformation(origin={10,10},        extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold3
                                                            annotation (
    Placement(visible = true, transformation(origin={10,-30},       extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold4
                                                            annotation (
    Placement(visible = true, transformation(origin={10,-70},       extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold5
                                                            annotation (
    Placement(visible = true, transformation(origin={10,-110},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  DataBus datalBus annotation (Placement(transformation(extent={{170,-20},{
            210,20}}), iconTransformation(extent={{102,-16},{132,16}})));
equation
  connect(combiTimeTable.y[i], greaterThreshold.u) annotation (Line(points={{-61.2,0},
          {-8,0},{-8,90},{-2,90}},            color={0,0,127}));
  connect(combiTimeTable.y[j], greaterThreshold1.u) annotation (Line(points={{-61.2,0},
          {-8,0},{-8,50},{-2,50}},           color={0,0,127}));
  connect(combiTimeTable.y[k], greaterThreshold2.u) annotation (Line(points={{-61.2,0},
          {-8,0},{-8,10},{-2,10}},             color={0,0,127}));
  connect(combiTimeTable.y[l], greaterThreshold3.u) annotation (Line(points={{-61.2,0},
          {-8,0},{-8,-30},{-2,-30}},           color={0,0,127}));
  connect(combiTimeTable.y[m],greaterThreshold4. u) annotation (Line(points={{-61.2,0},
          {-8,0},{-8,-70},{-2,-70}},           color={0,0,127}));
  connect(combiTimeTable.y[n],greaterThreshold5. u) annotation (Line(points={{-61.2,0},
          {-8,0},{-8,-110},{-2,-110}},         color={0,0,127}));

  connect(greaterThreshold.y, datalBus.u_HeatPumo_ErrorScheudle)
    annotation (Line(points={{21,90},{166,90},{166,0},{190,0}},   color={
          255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold1.y, datalBus.u_Electrolyzer_ErrorScheudle)
    annotation (Line(points={{21,50},{166,50},{166,0},{190,0}},   color={
          255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold2.y, datalBus.u_CHP_ErrorScheudle) annotation (
      Line(points={{21,10},{166,10},{166,0},{190,0}},   color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold3.y, datalBus.u_Boiler_ErrorScheudle) annotation (
     Line(points={{21,-30},{166,-30},{166,0},{190,0}},   color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold4.y, datalBus.u_StorageLoad_ErrorScheudle)
    annotation (Line(points={{21,-70},{166,-70},{166,0},{190,0}},   color={
          255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold5.y, datalBus.u_StorageUnload_ErrorScheudle)
    annotation (Line(points={{21,-110},{166,-110},{166,0},{190,0}},   color=
         {255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation(experiment(
      StopTime=21600,
      Interval=3600,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html><p>This example model reads the gain parameters from different cells and sheets of the Excel XLSX file <a href=\"modelica://ExternData/Resources/Examples/test.xlsx\">test.xlsx</a>. For gain1 the gain parameter is read as Real value using the function <a href=\"modelica://ExternData.XLSXFile.getReal\">ExternData.XLSXFile.getReal</a>. For gain2 the String value is retrieved by function <a href=\"modelica://ExternData.XLSXFile.getString\">ExternData.XLSXFile.getString</a> and converted to a Real value (using the utility function <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">Modelica.Utilities.Strings.scanReal</a>). For timeTable the table parameter is read as Real array of dimension 3x2 by function <a href=\"modelica://ExternData.XLSXFile.getRealArray2D\">ExternData.XLSXFile.getRealArray2D</a>. The read parameters are assigned by parameter bindings to the appropriate model parameters.</p></html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end ExcelReader_ErrorScheudle_Bus;
