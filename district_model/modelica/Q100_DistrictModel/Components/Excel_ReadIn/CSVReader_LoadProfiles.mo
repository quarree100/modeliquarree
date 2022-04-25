within Q100_DistrictModel.Components.Excel_ReadIn;
model CSVReader_LoadProfiles "CSV file read in"
  import ModelicaServices;
  parameter Integer firstCell[2]={2,1} "First upper left cell of data set (without header)";
  parameter Integer offset = 0 "Number of columns in data set befor Data(without time columne)";
  parameter Integer endRow = 35040 "Number of rows in data set (without header)";
  parameter Integer endColumne = 9 "Number of columns in data set (with time columne)";
  parameter Integer k = 1 + offset "Column number of E_th_RH_HH profil in data set (without time columne)";
  parameter Integer l = 2 + offset "Column number of E_th_TWE_HH profil in data set (without time columne)";
  parameter Integer m = 4 + offset "Column number of E_th_RH_GHD profil in data set (without time columne)";
  parameter Integer n = 5 + offset "Column number of E_th_TWE_GHD profil in data set (without time columne)";
  parameter Integer o = 6 + offset "Column number of E_el_GHD profil in data set (without time columne)";
  parameter Integer p = 3 + offset "Column number of E_el_HH profil in data set (without time columne)";

  replaceable parameter
            ExternData.CSVFile  dataSource(fileName=
        ModelicaServices.ExternalReferences.loadResource("modelica://Q100_DistrictModel/input/LoadProfiles_input.CSV"),
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
  Modelica.Blocks.Math.Gain E_th_TWE_HH(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,20})));
  Modelica.Blocks.Math.Gain E_th_RH_GHD(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-20})));
  Modelica.Blocks.Math.Gain E_th_TWE_GHD(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-60})));
  Modelica.Blocks.Math.Gain E_th_RH_HH(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,60})));
  Modelica.Blocks.Interfaces.RealOutput E_th_load annotation (Placement(transformation(extent={{100,20},
            {120,40}}), iconTransformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Math.MultiSum Sum_E_el_Load(nu=2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,-120})));
  Modelica.Blocks.Math.Gain E_el_GHD(k=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-100})));
  Modelica.Blocks.Math.Gain E_el_HH(k=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-140})));
  Modelica.Blocks.Interfaces.RealOutput E_el_load
    annotation (Placement(transformation(extent={{100,-100},{120,-80}}),
        iconTransformation(extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Math.MultiSum Sum_E_th_Load(nu=4)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(combiTimeTable.y[k], E_th_RH_HH.u) annotation (Line(points={{-61.2,0},
          {-50,0},{-50,60},{-42,60}}, color={0,0,127}));
  connect(combiTimeTable.y[l], E_th_TWE_HH.u) annotation (Line(points={{-61.2,0},
          {-50,0},{-50,20},{-42,20}}, color={0,0,127}));
  connect(combiTimeTable.y[m], E_th_RH_GHD.u) annotation (Line(points={{-61.2,0},
          {-50,0},{-50,-20},{-42,-20}}, color={0,0,127}));
  connect(combiTimeTable.y[n], E_th_TWE_GHD.u) annotation (Line(points={{-61.2,0},
          {-50,0},{-50,-60},{-42,-60}}, color={0,0,127}));
  connect(combiTimeTable.y[o], E_el_GHD.u) annotation (Line(points={{-61.2,0},{-50,
          0},{-50,-100},{-42,-100}}, color={0,0,127}));
  connect(combiTimeTable.y[p], E_el_HH.u) annotation (Line(points={{-61.2,0},{-50,
          0},{-50,-140},{-42,-140}}, color={0,0,127}));
  connect(Sum_E_el_Load.y, E_el_load)
    annotation (Line(points={{81.7,-120},{96,-120},{96,-90},{110,-90}},
                                                      color={0,0,127}));
  connect(Sum_E_th_Load.y, E_th_load)
    annotation (Line(points={{81.7,0},{96,0},{96,30},{110,30}},
                                                color={0,0,127}));
  connect(E_th_RH_HH.y, Sum_E_th_Load.u[1]) annotation (Line(points={{-19,60},{
          40,60},{40,5.25},{60,5.25}}, color={0,0,127}));
  connect(E_th_TWE_HH.y, Sum_E_th_Load.u[2]) annotation (Line(points={{-19,20},
          {20,20},{20,1.75},{60,1.75}}, color={0,0,127}));
  connect(E_th_RH_GHD.y, Sum_E_th_Load.u[3]) annotation (Line(points={{-19,-20},
          {20,-20},{20,-1.75},{60,-1.75}}, color={0,0,127}));
  connect(E_th_TWE_GHD.y, Sum_E_th_Load.u[4]) annotation (Line(points={{-19,-60},
          {40,-60},{40,-5.25},{60,-5.25}}, color={0,0,127}));
  connect(E_el_GHD.y, Sum_E_el_Load.u[1]) annotation (Line(points={{-19,-100},{
          20,-100},{20,-116},{60,-116},{60,-116.5}}, color={0,0,127}));
  connect(E_el_HH.y, Sum_E_el_Load.u[2]) annotation (Line(points={{-19,-140},{
          20,-140},{20,-122},{60,-122},{60,-123.5}}, color={0,0,127}));
  annotation(experiment(StopTime=1),
    Documentation(info="<html><p>This example model reads the gain parameters from different cells and sheets of the Excel XLSX file <a href=\"modelica://ExternData/Resources/Examples/test.xlsx\">test.xlsx</a>. For gain1 the gain parameter is read as Real value using the function <a href=\"modelica://ExternData.XLSXFile.getReal\">ExternData.XLSXFile.getReal</a>. For gain2 the String value is retrieved by function <a href=\"modelica://ExternData.XLSXFile.getString\">ExternData.XLSXFile.getString</a> and converted to a Real value (using the utility function <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">Modelica.Utilities.Strings.scanReal</a>). For timeTable the table parameter is read as Real array of dimension 3x2 by function <a href=\"modelica://ExternData.XLSXFile.getRealArray2D\">ExternData.XLSXFile.getRealArray2D</a>. The read parameters are assigned by parameter bindings to the appropriate model parameters.</p></html>"),
    Diagram(coordinateSystem(extent={{-100,-160},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-160},{100,100}}), graphics={
                                Rectangle(
        extent={{-100,-160},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-200,160},{200,100}},
        textString="%name",
        lineColor={0,0,255}),
    Polygon(lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      points={{-80,30},{-88,8},{-72,8},{-80,30}}),
    Line(points={{-80,8},{-80,-140}},
      color={192,192,192}),
    Line(points={{-90,-130},{82,-130}},
      color={192,192,192}),
    Polygon(lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid,
      points={{90,-130},{68,-122},{68,-138},{90,-130}}),
    Rectangle(lineColor={255,255,255},
      fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-48,-110},{2,10}}),
    Line(points={{-48,-110},{-48,10},{52,10},{52,-110},{-48,-110},{-48,-80},{52,
              -80},{52,-50},{-48,-50},{-48,-20},{52,-20},{52,10},{2,10},{2,-111}})}));
end CSVReader_LoadProfiles;
