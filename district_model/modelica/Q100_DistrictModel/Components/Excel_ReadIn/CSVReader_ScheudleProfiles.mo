within Q100_DistrictModel.Components.Excel_ReadIn;
model CSVReader_ScheudleProfiles "CSV file read in"
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

  replaceable parameter
            ExternData.CSVFile  dataSource(fileName=
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
    annotation (Placement(transformation(extent={{100,90},{120,110}}),
        iconTransformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Interfaces.RealOutput u_Electrolyzer_scheudle
    annotation (Placement(transformation(extent={{100,50},{120,70}}),
        iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput u_CHP_scheudle
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
        iconTransformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput u_boiler_scheudle
    annotation (Placement(transformation(extent={{100,-30},{120,-10}}),
        iconTransformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput u_StorageLoad_scheudle
    annotation (Placement(transformation(extent={{100,-70},{120,-50}}),
        iconTransformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput u_StorageUnload_scheudle
    annotation (Placement(transformation(extent={{100,-110},{120,-90}}),
        iconTransformation(extent={{100,-110},{120,-90}})));
equation
  connect(combiTimeTable.y[i], u_HeatPump_scheudle) annotation (Line(points={{-61.2,
          10},{96,10},{96,100},{110,100}}, color={0,0,127}));
  connect(combiTimeTable.y[j], u_Electrolyzer_scheudle) annotation (Line(points={{-61.2,
          10},{96,10},{96,60},{110,60}},        color={0,0,127}));
  connect(combiTimeTable.y[k], u_CHP_scheudle) annotation (Line(points={{-61.2,
          10},{96,10},{96,20},{110,20}},
                                     color={0,0,127}));
  connect(combiTimeTable.y[l], u_boiler_scheudle) annotation (Line(points={{-61.2,
          10},{96,10},{96,-20},{110,-20}}, color={0,0,127}));
  connect(combiTimeTable.y[m], u_StorageLoad_scheudle) annotation (Line(points={{-61.2,
          10},{96,10},{96,-60},{110,-60}},        color={0,0,127}));
  connect(combiTimeTable.y[n], u_StorageUnload_scheudle) annotation (Line(
        points={{-61.2,10},{96,10},{96,-100},{110,-100}},
                                                        color={0,0,127}));
  annotation(experiment(StopTime=1),
    Documentation(info="<html><p>This example model reads the gain parameters from different cells and sheets of the Excel XLSX file <a href=\"modelica://ExternData/Resources/Examples/test.xlsx\">test.xlsx</a>. For gain1 the gain parameter is read as Real value using the function <a href=\"modelica://ExternData.XLSXFile.getReal\">ExternData.XLSXFile.getReal</a>. For gain2 the String value is retrieved by function <a href=\"modelica://ExternData.XLSXFile.getString\">ExternData.XLSXFile.getString</a> and converted to a Real value (using the utility function <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">Modelica.Utilities.Strings.scanReal</a>). For timeTable the table parameter is read as Real array of dimension 3x2 by function <a href=\"modelica://ExternData.XLSXFile.getRealArray2D\">ExternData.XLSXFile.getRealArray2D</a>. The read parameters are assigned by parameter bindings to the appropriate model parameters.</p></html>"),
    Diagram(coordinateSystem(extent={{-100,-120},{100,120}})),
    Icon(coordinateSystem(extent={{-100,-120},{100,120}}), graphics={
                                Rectangle(
        extent={{-100,-120},{100,120}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-200,180},{200,120}},
        lineColor={0,0,255},
          textString="%name"),
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
end CSVReader_ScheudleProfiles;
