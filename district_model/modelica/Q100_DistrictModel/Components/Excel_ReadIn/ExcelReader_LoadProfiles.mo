within Q100_DistrictModel.Components.Excel_ReadIn;
model ExcelReader_LoadProfiles "Excel XLSX file read in"
  import ModelicaServices;
  extends Modelica.Icons.Record;
  parameter String sheetName="LoadProfiles" "Excel sheet name" annotation(choices(choice="set1" "First Excel sheet", choice="set2" "Second Excel sheet"));
  parameter String firstCell="A2" "First upper left cell of data set (without header)";
  parameter Integer endRow = 35040 "Number of rows in data set (without header)";
  parameter Integer endColumne = 9 "Number of columns in data set (with time columne)";
  parameter Integer k = 1 "Column number of E_th_RH_HH profil in data set (without time columne)";
  parameter Integer l = 2 "Column number of E_th_TWE_HH profil in data set (without time columne)";
  parameter Integer m = 4 "Column number of E_th_RH_GHD profil in data set (without time columne)";
  parameter Integer n = 5 "Column number of E_th_TWE_GHD profil in data set (without time columne)";
  parameter Integer o = 6 "Column number of E_el_GHD profil in data set (without time columne)";
  parameter Integer p = 3 "Column number of E_el_HH profil in data set (without time columne)";

  Modelica.Blocks.Math.Add add2 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation=0,     origin={10,-40})));
  Modelica.Blocks.Math.Add add3 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation=0,     origin={10,40})));
  Modelica.Blocks.Math.Add add4 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation=0,     origin={50,0})));
  parameter ExternData.XLSXFile dataSource(fileName=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://Q100_DistrictModel/input/ExcelReader_input.xlsx"))
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
  Modelica.Blocks.Interfaces.RealOutput E_th_load annotation (Placement(transformation(extent={{100,-10},
            {120,10}})));
  Modelica.Blocks.Math.Add add1 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation=0,     origin={10,-120})));
  Modelica.Blocks.Math.Gain E_el_GHD(k=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-100})));
  Modelica.Blocks.Math.Gain E_el_HH(k=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-140})));
  Modelica.Blocks.Interfaces.RealOutput E_el_load
    annotation (Placement(transformation(extent={{100,-130},{120,-110}})));
equation
  connect(combiTimeTable.y[k], E_th_RH_HH.u) annotation (Line(points={{-61.2,0},
          {-50,0},{-50,60},{-42,60}}, color={0,0,127}));
  connect(combiTimeTable.y[l], E_th_TWE_HH.u) annotation (Line(points={{-61.2,0},
          {-50,0},{-50,20},{-42,20}}, color={0,0,127}));
  connect(combiTimeTable.y[m], E_th_RH_GHD.u) annotation (Line(points={{-61.2,0},
          {-50,0},{-50,-20},{-42,-20}}, color={0,0,127}));
  connect(combiTimeTable.y[n], E_th_TWE_GHD.u) annotation (Line(points={{-61.2,0},
          {-50,0},{-50,-60},{-42,-60}}, color={0,0,127}));
  connect(E_th_RH_HH.y, add3.u1) annotation (Line(points={{-19,60},{-10,60},{-10,
          46},{-2,46}}, color={0,0,127}));
  connect(E_th_TWE_HH.y, add3.u2) annotation (Line(points={{-19,20},{-10,20},{-10,
          34},{-2,34}}, color={0,0,127}));
  connect(E_th_RH_GHD.y, add2.u1) annotation (Line(points={{-19,-20},{-10,-20},{
          -10,-34},{-2,-34}}, color={0,0,127}));
  connect(E_th_TWE_GHD.y, add2.u2) annotation (Line(points={{-19,-60},{-10,-60},
          {-10,-46},{-2,-46}}, color={0,0,127}));
  connect(add2.y, add4.u2) annotation (Line(points={{21,-40},{30,-40},{30,-6},{38,
          -6}}, color={0,0,127}));
  connect(add3.y, add4.u1)
    annotation (Line(points={{21,40},{30,40},{30,6},{38,6}}, color={0,0,127}));
  connect(add4.y, E_th_load)
    annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(combiTimeTable.y[o], E_el_GHD.u) annotation (Line(points={{-61.2,0},{-50,
          0},{-50,-100},{-42,-100}}, color={0,0,127}));
  connect(combiTimeTable.y[p], E_el_HH.u) annotation (Line(points={{-61.2,0},{-50,
          0},{-50,-140},{-42,-140}}, color={0,0,127}));
  connect(E_el_GHD.y, add1.u1) annotation (Line(points={{-19,-100},{-10,-100},{-10,
          -114},{-2,-114}}, color={0,0,127}));
  connect(E_el_HH.y, add1.u2) annotation (Line(points={{-19,-140},{-10,-140},{-10,
          -126},{-2,-126}}, color={0,0,127}));
  connect(add1.y, E_el_load)
    annotation (Line(points={{21,-120},{110,-120}}, color={0,0,127}));
  annotation(experiment(StopTime=1),
    Documentation(info="<html><p>This example model reads the gain parameters from different cells and sheets of the Excel XLSX file <a href=\"modelica://ExternData/Resources/Examples/test.xlsx\">test.xlsx</a>. For gain1 the gain parameter is read as Real value using the function <a href=\"modelica://ExternData.XLSXFile.getReal\">ExternData.XLSXFile.getReal</a>. For gain2 the String value is retrieved by function <a href=\"modelica://ExternData.XLSXFile.getString\">ExternData.XLSXFile.getString</a> and converted to a Real value (using the utility function <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">Modelica.Utilities.Strings.scanReal</a>). For timeTable the table parameter is read as Real array of dimension 3x2 by function <a href=\"modelica://ExternData.XLSXFile.getRealArray2D\">ExternData.XLSXFile.getRealArray2D</a>. The read parameters are assigned by parameter bindings to the appropriate model parameters.</p></html>"),
    Diagram(coordinateSystem(extent={{-100,-160},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-160},{100,100}})));
end ExcelReader_LoadProfiles;
