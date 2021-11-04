within Q100_DistrictModel;
package Excel_ReadIn
  model ExcelReader_ErrorScheudle "Excel XLSX file read in"
    extends Modelica.Icons.Record;
    parameter String sheetName="error_signal" "Excel sheet name" annotation(choices(choice="set1" "First Excel sheet", choice="set2" "Second Excel sheet"));
    parameter String firstCell="A2" "First upper left cell of data set (without header)";
    parameter Integer endRow = 8760 "Number of rows in data set (without header)";
    parameter Integer endColumne = 8 "Number of columns in data set (with time columne)";
    parameter Integer h = 4 "Column number of heat pump 1 profil in error data set (without time columne)";
    parameter Integer i = 5 "Column number of heat pump 2 profil in error data set (without time columne)";
    parameter Integer j = 3 "Column number of electrolysis profil in error data set (without time columne)";
    parameter Integer k = 2 "Column number of CHP profil in error data set (without time columne)";
    parameter Integer l = 6 "Column number of boiler profil in error data set (without time columne)";
    parameter Integer m = 7 "Column number of storage load profil in error data set (without time columne)";
    parameter Integer n = 8 "Column number of storage unload profil in error data set (without time columne)";

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
      Icon(coordinateSystem(extent={{-100,-120},{100,140}})));
  end ExcelReader_ErrorScheudle;

  model ExcelReader_ScheudleProfiles "Excel XLSX file read in"
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
  end ExcelReader_ScheudleProfiles;

  model ExcelReader_LoadProfiles "Excel XLSX file read in"
    extends Modelica.Icons.Record;
    parameter String sheetName="Sheet1" "Excel sheet name" annotation(choices(choice="set1" "First Excel sheet", choice="set2" "Second Excel sheet"));
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
          Modelica.Utilities.Files.loadResource(
          "C:/Users/Tino Mitzinger/ownCloud/FhG-owncloud-Quarree-AB3/AB-3.3/3.3.1 Energiebedarfsprofile/Kataster_v45/Stage_3/Quarree100_load_15_Modelica.xlsx"))
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

  expandable connector DataBus
    "Control bus that is adapted to the signals connected to it"
    extends Modelica.Icons.SignalBus;

    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={Rectangle(
                    extent={{-20,2},{22,-2}},
                    lineColor={255,204,51},
                    lineThickness=0.5)}), Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector contains \"default\" signals that might be utilized
in a connection (the input/output causalities of the signals
are determined from the connections to this bus).
</p>
</html>"));

  end DataBus;

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
end Excel_ReadIn;
