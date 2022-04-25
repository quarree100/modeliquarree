within Q100_DistrictModel.Components.Excel_ReadIn;
model CSVReader_ErrorProfiles "CSV file read in"
  parameter Integer firstCell[2]={2,1} "First upper left cell of data set (without header)";
  parameter Integer endRow = 8760 "Number of rows in data set (without header)";
  parameter Integer endColumne = 8 "Number of columns in data set (with time columne)";
  parameter Integer offset = 0 "Number of columns in data set befor Data(without time columne)";
  parameter Integer h = 3 + offset "Column number of heat pump 1 profil in error data set (without time columne)";
  parameter Integer i = 4 + offset "Column number of heat pump 2 profil in error data set (without time columne)";
  parameter Integer j = 2 + offset "Column number of electrolysis profil in error data set (without time columne)";
  parameter Integer k = 1 + offset "Column number of CHP profil in error data set (without time columne)";
  parameter Integer l = 5 + offset "Column number of boiler profil in error data set (without time columne)";
  parameter Integer m = 6 + offset "Column number of storage load profil in error data set (without time columne)";
  parameter Integer n = 7 + offset "Column number of storage unload profil in error data set (without time columne)";

  replaceable parameter
            ExternData.CSVFile  dataSource(fileName=
        Modelica.Utilities.Files.loadResource("modelica://Q100_DistrictModel/input/ErrorProfiles_input.CSV"),
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
        origin={-72,-10})));
  Modelica.Blocks.Interfaces.RealOutput    u_HeatPump2_ErrorScheudle
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput    u_Electrolyzer_ErrorScheudle
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput    u_CHP_ErrorScheudle
    annotation (Placement(transformation(extent={{100,0},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput    u_Boiler_ErrorScheudle
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput    u_StorageLoad_ErrorScheudle
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Interfaces.RealOutput    u_StorageUnload_ErrorScheudle
    annotation (Placement(transformation(extent={{100,-120},{120,-100}})));
  Modelica.Blocks.Interfaces.RealOutput    u_HeatPump1_ErrorScheudle
    annotation (Placement(transformation(extent={{100,120},{120,140}})));
equation

  connect(combiTimeTable.y[h], u_HeatPump1_ErrorScheudle) annotation (Line(
        points={{-63.2,-10},{96,-10},{96,130},{110,130}}, color={0,0,127}));
  connect(combiTimeTable.y[i], u_HeatPump2_ErrorScheudle) annotation (Line(
        points={{-63.2,-10},{96,-10},{96,90},{110,90}}, color={0,0,127}));
  connect(combiTimeTable.y[j], u_Electrolyzer_ErrorScheudle) annotation (Line(
        points={{-63.2,-10},{96,-10},{96,50},{110,50}}, color={0,0,127}));
  connect(combiTimeTable.y[k], u_CHP_ErrorScheudle) annotation (Line(points={
          {-63.2,-10},{96,-10},{96,10},{110,10}}, color={0,0,127}));
  connect(combiTimeTable.y[l], u_Boiler_ErrorScheudle) annotation (Line(
        points={{-63.2,-10},{96,-10},{96,-30},{110,-30}}, color={0,0,127}));
  connect(combiTimeTable.y[m], u_StorageLoad_ErrorScheudle) annotation (Line(
        points={{-63.2,-10},{96,-10},{96,-70},{110,-70}}, color={0,0,127}));
  connect(combiTimeTable.y[n], u_StorageUnload_ErrorScheudle) annotation (
      Line(points={{-63.2,-10},{96,-10},{96,-110},{110,-110}}, color={0,0,127}));
  annotation(experiment(
      StopTime=21600,
      Interval=3600,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html><p>This example model reads the gain parameters from different cells and sheets of the Excel XLSX file <a href=\"modelica://ExternData/Resources/Examples/test.xlsx\">test.xlsx</a>. For gain1 the gain parameter is read as Real value using the function <a href=\"modelica://ExternData.XLSXFile.getReal\">ExternData.XLSXFile.getReal</a>. For gain2 the String value is retrieved by function <a href=\"modelica://ExternData.XLSXFile.getString\">ExternData.XLSXFile.getString</a> and converted to a Real value (using the utility function <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">Modelica.Utilities.Strings.scanReal</a>). For timeTable the table parameter is read as Real array of dimension 3x2 by function <a href=\"modelica://ExternData.XLSXFile.getRealArray2D\">ExternData.XLSXFile.getRealArray2D</a>. The read parameters are assigned by parameter bindings to the appropriate model parameters.</p></html>"),
    Diagram(coordinateSystem(extent={{-100,-120},{100,140}})),
    Icon(coordinateSystem(extent={{-100,-120},{100,140}}), graphics={
                                Rectangle(
        extent={{-100,-120},{100,140}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-200,200},{200,140}},
        textString="%name",
        lineColor={0,0,255}),
    Polygon(lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      points={{-80,70},{-88,48},{-72,48},{-80,70}}),
    Line(points={{-80,48},{-80,-100}},
      color={192,192,192}),
    Line(points={{-90,-90},{82,-90}},
      color={192,192,192}),
    Polygon(lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      points={{90,-90},{68,-82},{68,-98},{90,-90}}),
    Rectangle(lineColor={255,255,255},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-48,-70},{2,50}}),
    Line(points={{-48,-70},{-48,50},{52,50},{52,-70},{-48,-70},{-48,-40},{52,
              -40},{52,-10},{-48,-10},{-48,20},{52,20},{52,50},{2,50},{2,-71}})}));
end CSVReader_ErrorProfiles;
