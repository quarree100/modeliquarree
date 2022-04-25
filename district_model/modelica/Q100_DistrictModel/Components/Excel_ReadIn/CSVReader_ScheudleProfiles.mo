within Q100_DistrictModel.Components.Excel_ReadIn;
model CSVReader_ScheudleProfiles "CSV file read in"
  extends Modelica.Icons.Record;
  parameter Integer firstCell[2]={2,1} "First upper left cell of data set (without header)";
  parameter Integer endRow = 8760 "Number of rows in data set (without header)";
  parameter Integer endColumne = 7 "Number of columns in data set (with time columne)";
  parameter Integer offset = 0 "Number of columns in data set befor Data(without time columne)";
  parameter Integer i = 3 + offset "Column number of heat pump profil in error data set (without time columne)";
  parameter Integer j = 2 + offset "Column number of electrolysis profil in error data set (without time columne)";
  parameter Integer k = 1 + offset "Column number of CHP profil in error data set (without time columne)";
  parameter Integer l = 4 + offset "Column number of boiler profil in error data set (without time columne)";
  parameter Integer m = 5 + offset "Column number of storage load profil in error data set (without time columne)";
  parameter Integer n = 6 + offset "Column number of storage unload profil in error data set (without time columne)";

  parameter ExternData.CSVFile  dataSource(fileName=
        Modelica.Utilities.Files.loadResource("modelica://Q100_DistrictModel/input/ScheduleProfiles_input.CSV"),
      delimiter=";")
    "XLSX file" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,70})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=
        dataSource.getRealArray2D(
        endRow,
        endColumne,
        firstCell))   annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-70,10})));
  Modelica.Blocks.Interfaces.RealOutput u_HeatPump_scheudle
    annotation (Placement(transformation(extent={{100,100},{120,120}})));
  Modelica.Blocks.Interfaces.RealOutput u_Electrolyzer_scheudle
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput u_CHP_scheudle
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput u_boiler_scheudle
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Interfaces.RealOutput u_StorageLoad_scheudle
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput u_StorageUnload_scheudle
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
equation
  connect(combiTimeTable.y[i], u_HeatPump_scheudle) annotation (Line(points={{-61.2,
          10},{96,10},{96,110},{110,110}}, color={0,0,127}));
  connect(combiTimeTable.y[j], u_Electrolyzer_scheudle) annotation (Line(points=
         {{-61.2,10},{96,10},{96,70},{110,70}}, color={0,0,127}));
  connect(combiTimeTable.y[k], u_CHP_scheudle) annotation (Line(points={{-61.2,10},
          {96,10},{96,30},{110,30}}, color={0,0,127}));
  connect(combiTimeTable.y[l], u_boiler_scheudle) annotation (Line(points={{-61.2,
          10},{96,10},{96,-10},{110,-10}}, color={0,0,127}));
  connect(combiTimeTable.y[m], u_StorageLoad_scheudle) annotation (Line(points={
          {-61.2,10},{96,10},{96,-50},{110,-50}}, color={0,0,127}));
  connect(combiTimeTable.y[n], u_StorageUnload_scheudle) annotation (Line(
        points={{-61.2,10},{96,10},{96,-90},{110,-90}}, color={0,0,127}));
  annotation(experiment(StopTime=1),
    Documentation(info="<html><p>This example model reads the gain parameters from different cells and sheets of the Excel XLSX file <a href=\"modelica://ExternData/Resources/Examples/test.xlsx\">test.xlsx</a>. For gain1 the gain parameter is read as Real value using the function <a href=\"modelica://ExternData.XLSXFile.getReal\">ExternData.XLSXFile.getReal</a>. For gain2 the String value is retrieved by function <a href=\"modelica://ExternData.XLSXFile.getString\">ExternData.XLSXFile.getString</a> and converted to a Real value (using the utility function <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">Modelica.Utilities.Strings.scanReal</a>). For timeTable the table parameter is read as Real array of dimension 3x2 by function <a href=\"modelica://ExternData.XLSXFile.getRealArray2D\">ExternData.XLSXFile.getRealArray2D</a>. The read parameters are assigned by parameter bindings to the appropriate model parameters.</p></html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,120}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,120}})));
end CSVReader_ScheudleProfiles;