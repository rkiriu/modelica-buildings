within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Validation;
model Status
  "Validates the waterside economizer enable/disable sequence"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Status
    wseSta "waterside economizer enable status sequence"
    annotation (Placement(transformation(extent={{-68,0},{-48,20}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Status
    wseSta1 "waterside economizer enable status sequence"
    annotation (Placement(transformation(extent={{40,0},{60,20}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Status
    wseSta2 "waterside economizer enable status sequence"
    annotation (Placement(transformation(extent={{160,0},{180,20}})));

protected
  parameter Modelica.SIunits.Temperature TOutWetBul = 283.15
  "Average outdoor air wet bulb temperature";

  parameter Modelica.SIunits.Temperature TChiWatRet = 293.15
  "Chilled water retun temperature upstream of the WSE";

  parameter Modelica.SIunits.Temperature TWseOut = 290.15
  "Chilled water retun temperature downstream of the WSE";

  parameter Real VChiWat_flow(quantity="VolumeFlowRate", unit="m3/s") = 0.01
  "Measured chilled water return temperature";

  CDL.Continuous.Sources.Constant chiWatFlow(final k=VChiWat_flow)
    "Chilled water flow"
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));

  CDL.Continuous.Sources.Pulse TOutWetSig(
    final amplitude=5,
    final period=2*15*60,
    final offset=TOutWetBul) "Measured outdoor air wet bulb temperature"
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));

  CDL.Continuous.Sources.Constant constTowFanSig(final k=1)
    "Cooling tower fan full load signal"
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));

  CDL.Continuous.Sources.Constant TChiWatRetSig(final k=TChiWatRet)
    "Chilled water return temperature upstream of WSE"
    annotation (Placement(transformation(extent={{-140,30},{-120,50}})));

  CDL.Continuous.Sources.Constant TChiWatRetDow(final k=TWseOut)
    "Chilled water return temperature downstream of WSE"
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));

  CDL.Continuous.Sources.Constant chiWatFlow1(final k=VChiWat_flow)
    "Chilled water flow"
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));

  CDL.Continuous.Sources.Constant TOutWetSig1(final k=TOutWetBul)
    "Measured outdoor air wet bulb temperature"
    annotation (Placement(transformation(extent={{-30,60},{-10,80}})));

  CDL.Continuous.Sources.Constant constTowFanSig1(final k=1)
    "Cooling tower fan full load signal"
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));

  CDL.Continuous.Sources.Constant TChiWatRetSig1(final k=TChiWatRet)
    "Chilled water return temperature upstream of WSE"
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));

  CDL.Continuous.Sources.Pulse TChiWatRetDow1(
    final period=2*15*60,
    final offset=TWseOut,
    final amplitude=2.5)
    "Chilled water return temperature downstream of WSE"
    annotation (Placement(transformation(extent={{-30,0},{-10,20}})));

  CDL.Continuous.Sources.Constant chiWatFlow2(final k=VChiWat_flow)
    "Chilled water flow"
    annotation (Placement(transformation(extent={{90,-40},{110,-20}})));

  CDL.Continuous.Sources.Pulse TOutWetSig2(
    final amplitude=5,
    final period=2*15*60,
    final offset=TOutWetBul) "Measured outdoor air wet bulb temperature"
    annotation (Placement(transformation(extent={{90,60},{110,80}})));

  CDL.Continuous.Sources.Constant constTowFanSig2(final k=1)
    "Cooling tower fan full load signal"
    annotation (Placement(transformation(extent={{90,-80},{110,-60}})));

  CDL.Continuous.Sources.Constant TChiWatRetSig2(final k=TChiWatRet)
    "Chilled water return temperature upstream of WSE"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  CDL.Continuous.Sources.Pulse    TChiWatRetDow2(
    final period=2*15*60,
    final offset=TWseOut,
    final amplitude=2.5)
    "Chilled water return temperature downstream of WSE"
    annotation (Placement(transformation(extent={{90,0},{110,20}})));

equation

  connect(constTowFanSig.y, wseSta.uTowFanSpe) annotation (Line(points={{-119,-70},
          {-80,-70},{-80,2},{-70,2}},color={0,0,127}));
  connect(TOutWetSig.y, wseSta.TOutWet) annotation (Line(points={{-119,70},{-80,
          70},{-80,18},{-70,18}},
                             color={0,0,127}));
  connect(TChiWatRetSig.y, wseSta.TChiWatRet) annotation (Line(points={{-119,40},
          {-100,40},{-100,14},{-70,14}},
                                      color={0,0,127}));
  connect(chiWatFlow.y, wseSta.VChiWat_flow) annotation (Line(points={{-119,-30},
          {-90,-30},{-90,6},{-70,6}},color={0,0,127}));
  connect(TChiWatRetDow.y, wseSta.TChiWatWseDow)
    annotation (Line(points={{-119,10},{-70,10}},
                                                color={0,0,127}));
  connect(constTowFanSig1.y, wseSta1.uTowFanSpe) annotation (Line(points={{-9,-70},
          {30,-70},{30,2},{38,2}}, color={0,0,127}));
  connect(TOutWetSig1.y, wseSta1.TOutWet) annotation (Line(points={{-9,70},{30,70},
          {30,18},{38,18}}, color={0,0,127}));
  connect(TChiWatRetSig1.y, wseSta1.TChiWatRet) annotation (Line(points={{-9,40},
          {10,40},{10,14},{38,14}}, color={0,0,127}));
  connect(chiWatFlow1.y, wseSta1.VChiWat_flow) annotation (Line(points={{-9,-30},
          {20,-30},{20,6},{38,6}}, color={0,0,127}));
  connect(TChiWatRetDow1.y, wseSta1.TChiWatWseDow)
    annotation (Line(points={{-9,10},{38,10}}, color={0,0,127}));
  connect(constTowFanSig2.y,wseSta2. uTowFanSpe) annotation (Line(points={{111,-70},
          {150,-70},{150,2},{158,2}},
                                   color={0,0,127}));
  connect(TOutWetSig2.y,wseSta2. TOutWet) annotation (Line(points={{111,70},{150,
          70},{150,18},{158,18}},
                            color={0,0,127}));
  connect(TChiWatRetSig2.y,wseSta2. TChiWatRet) annotation (Line(points={{111,40},
          {130,40},{130,14},{158,14}},
                                    color={0,0,127}));
  connect(chiWatFlow2.y,wseSta2. VChiWat_flow) annotation (Line(points={{111,-30},
          {140,-30},{140,6},{158,6}},
                                   color={0,0,127}));
  connect(TChiWatRetDow2.y,wseSta2. TChiWatWseDow)
    annotation (Line(points={{111,10},{158,10}},
                                               color={0,0,127}));
annotation (
 experiment(StopTime=3600.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Economizer/Validation/Status.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Status\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizer.Status</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
October 15, 2018, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"),
Icon(graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{200,100}}),
        graphics={
        Text(
          extent={{-160,-82},{-100,-104}},
          lineColor={0,0,127},
          textString="Tests enable conditions 
based on the outdoor air 
wetbulb temperature"),
        Text(
          extent={{-50,-82},{10,-104}},
          lineColor={0,0,127},
          textString="Tests disable conditions 
based on the chilled water  
temperature downstream of WSE"),
        Text(
          extent={{72,-82},{132,-104}},
          lineColor={0,0,127},
          textString="Tests dcombined enable 
and disable conditions")}));
end Status;
