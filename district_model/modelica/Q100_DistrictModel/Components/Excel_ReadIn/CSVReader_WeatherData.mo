within Q100_DistrictModel.Components.Excel_ReadIn;
model CSVReader_WeatherData "CSV file read in"
  import ModelicaServices;
  parameter Integer firstCell[2]={2,1} "First upper left cell of data set (without header)";
  parameter Integer offset = 0 "Number of columns in data set befor Data(without time columne)";
  parameter Integer endRow = 8760 "Number of rows in data set (without header)";
  parameter Integer endColumne = 2 "Number of columns in data set (with time columne)";
  parameter Integer k = 1 + offset "Column number of T_amp profil in data set (without time columne)";


  replaceable parameter
            ExternData.CSVFile  dataSource(fileName=
        ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/input/T_amp_input.CSV"),
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
        origin={-70,0})));
  Modelica.Blocks.Interfaces.RealOutput T_amp
    annotation (Placement(transformation(extent={{200,-10},{220,10}})));
equation
  connect(combiTimeTable.y[k], T_amp)
    annotation (Line(points={{-61.2,0},{210,0}}, color={0,0,127}));
  annotation(experiment(StopTime=1),
    Documentation(info="<html><p>This example model reads the gain parameters from different cells and sheets of the Excel XLSX file <a href=\"modelica://ExternData/Resources/Examples/test.xlsx\">test.xlsx</a>. For gain1 the gain parameter is read as Real value using the function <a href=\"modelica://ExternData.XLSXFile.getReal\">ExternData.XLSXFile.getReal</a>. For gain2 the String value is retrieved by function <a href=\"modelica://ExternData.XLSXFile.getString\">ExternData.XLSXFile.getString</a> and converted to a Real value (using the utility function <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">Modelica.Utilities.Strings.scanReal</a>). For timeTable the table parameter is read as Real array of dimension 3x2 by function <a href=\"modelica://ExternData.XLSXFile.getRealArray2D\">ExternData.XLSXFile.getRealArray2D</a>. The read parameters are assigned by parameter bindings to the appropriate model parameters.</p></html>"),
    Diagram(coordinateSystem(extent={{-200,-200},{200,200}})),
    Icon(coordinateSystem(extent={{-200,-200},{200,200}}), graphics={
                                        Text(
        extent={{-200,262},{200,202}},
        textString="%name",
        lineColor={0,0,255}),
        Rectangle(
          extent={{-200,202},{200,-198}},
          lineColor={124,142,255},
          fillColor={124,142,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-144,152},{30,-22}},
          lineColor={255,220,220},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,0}),
        Polygon(
          points={{114,64},{97.973,0.9844},{98,0},{130,10},{158,8},{184,-4},{
              202,-70},{158,-144},{30,-152},{-120,-148},{-146,-72},{-130,-18},{
              -82,-16},{-58.211,-33.8418},{-58,-34},{-72,28},{-38,78},{54,98},{
              114,64}},
          lineColor={220,220,220},
          lineThickness=0.1,
          fillPattern=FillPattern.Sphere,
          smooth=Smooth.Bezier,
          fillColor={230,230,230})}));
end CSVReader_WeatherData;
