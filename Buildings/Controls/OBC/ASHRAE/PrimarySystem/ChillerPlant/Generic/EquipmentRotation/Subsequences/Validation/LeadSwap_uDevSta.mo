within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.EquipmentRotation.Subsequences.Validation;
model LeadSwap_uDevSta
  "Validation sequence for enabling and disabling chiller plant"

  parameter Modelica.SIunits.Temperature aveTWetBul = 288.15
    "Chilled water supply set temperature";

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.EquipmentRotation.Subsequences.LeadSwap leaSwa
    "Makes sure the new lead device is proven on before passing on the lead role"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(
    width=0.5,
    period=10)
    annotation (Placement(transformation(extent={{-200,80},{-180,100}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul1(
    width=0.5,
    period=15,
    startTime=0)
    annotation (Placement(transformation(extent={{-200,20},{-180,40}})));

  Buildings.Controls.OBC.CDL.Logical.Not not2 "Not"
    annotation (Placement(transformation(extent={{-160,20},{-140,40}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1 "Not"
    annotation (Placement(transformation(extent={{-160,60},{-140,80}})));

  LeadSwap                                                                                                 leaSwa1
    "A way to switch two signals and invert their values"
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  CDL.Logical.Sources.Pulse                        booPul2(width=0.5, period=10)
    annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
  CDL.Logical.Not                        not4 "Not"
    annotation (Placement(transformation(extent={{-160,-40},{-140,-20}})));
  LeadSwap                                                                                                 leaSwa2
    "Makes sure the new lead device is proven on before passing on the lead role"
    annotation (Placement(transformation(extent={{180,40},{200,60}})));
  CDL.Logical.Sources.Pulse                        booPul4(width=0.5, period=11)
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  CDL.Logical.Sources.Pulse                        booPul5(
    width=0.5,
    period=7,
    startTime=0)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  CDL.Logical.Not                        not5 "Not"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  CDL.Logical.Not                        not6 "Not"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  LeadSwap                                                                                                 leaSwa3
    "Makes sure the new lead device is proven on before passing on the lead role"
    annotation (Placement(transformation(extent={{180,-80},{200,-60}})));
  CDL.Logical.Sources.Pulse                        booPul6(width=0.5, period=10)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  CDL.Logical.Sources.Pulse                        booPul7(
    width=0.5,
    period=10,
    startTime=1)
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  CDL.Logical.Not                        not7 "Not"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  CDL.Logical.Not                        not8 "Not"
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  CDL.Logical.TrueFalseHold truFalHol(trueHoldDuration=0, falseHoldDuration=6)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  CDL.Logical.TrueFalseHold truFalHol1(trueHoldDuration=0, falseHoldDuration=6)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
equation
  connect(booPul.y, not1.u) annotation (
    Line(points={{-178,90},{-170,90},{-170,70},{-162,70}}, color={255,0,255}));
  connect(booPul.y,leaSwa. uDevSta[1]) annotation (
    Line(points={{-178,90},{-90,90},{-90,46},{-42,46}}, color={255,0,255}));
  connect(booPul1.y, not2.u)
    annotation (Line(points={{-178,30},{-162,30}},   color={255,0,255}));
  connect(not2.y,leaSwa. uDevSta[2]) annotation (
    Line(points={{-138,30},{-120,30},{-120,46},{-42,46}},color={255,0,255}));

  connect(booPul.y, leaSwa.uLeaRolSet[1]) annotation (Line(points={{-178,90},{-60,
          90},{-60,54},{-42,54}},     color={255,0,255}));
  connect(not1.y, leaSwa.uLeaRolSet[2]) annotation (Line(points={{-138,70},{-60,
          70},{-60,54},{-42,54}},  color={255,0,255}));
  connect(booPul2.y, not4.u) annotation (Line(points={{-178,-10},{-170,-10},{
          -170,-30},{-162,-30}},
                     color={255,0,255}));
  connect(booPul4.y, not6.u) annotation (Line(points={{42,90},{50,90},{50,70},{58,
          70}},              color={255,0,255}));
  connect(booPul4.y, leaSwa2.uDevSta[1]) annotation (Line(points={{42,90},{130,90},
          {130,46},{178,46}},        color={255,0,255}));
  connect(booPul5.y,not5. u)
    annotation (Line(points={{42,30},{58,30}},       color={255,0,255}));
  connect(not5.y, leaSwa2.uDevSta[2]) annotation (Line(points={{82,30},{100,30},
          {100,46},{178,46}},          color={255,0,255}));
  connect(booPul4.y, leaSwa2.uLeaRolSet[1]) annotation (Line(points={{42,90},{160,
          90},{160,54},{178,54}},        color={255,0,255}));
  connect(not6.y, leaSwa2.uLeaRolSet[2]) annotation (Line(points={{82,70},{160,70},
          {160,54},{178,54}},            color={255,0,255}));
  connect(booPul6.y,not8. u) annotation (Line(points={{42,-30},{50,-30},{50,-50},
          {58,-50}},         color={255,0,255}));
  connect(booPul6.y,leaSwa3. uDevSta[1]) annotation (Line(points={{42,-30},{130,
          -30},{130,-74},{178,-74}}, color={255,0,255}));
  connect(booPul7.y,not7. u)
    annotation (Line(points={{42,-90},{58,-90}},     color={255,0,255}));
  connect(not7.y,leaSwa3. uDevSta[2]) annotation (Line(points={{82,-90},{100,-90},
          {100,-74},{178,-74}},        color={255,0,255}));
  connect(booPul6.y,leaSwa3. uLeaRolSet[1]) annotation (Line(points={{42,-30},{160,
          -30},{160,-66},{178,-66}},     color={255,0,255}));
  connect(not8.y,leaSwa3. uLeaRolSet[2]) annotation (Line(points={{82,-50},{160,
          -50},{160,-66},{178,-66}},     color={255,0,255}));
  connect(booPul2.y, truFalHol.u) annotation (Line(points={{-178,-10},{-120,-10},
          {-120,-50},{-102,-50}}, color={255,0,255}));
  connect(not4.y, truFalHol1.u) annotation (Line(points={{-138,-30},{-130,-30},
          {-130,-90},{-102,-90}}, color={255,0,255}));
  connect(truFalHol.y, leaSwa1.uDevSta[1]) annotation (Line(points={{-78,-50},{
          -60,-50},{-60,-24},{-42,-24}}, color={255,0,255}));
  connect(truFalHol1.y, leaSwa1.uDevSta[2]) annotation (Line(points={{-78,-90},
          {-60,-90},{-60,-24},{-42,-24}}, color={255,0,255}));
  connect(booPul2.y, leaSwa1.uLeaRolSet[1]) annotation (Line(points={{-178,-10},
          {-60,-10},{-60,-16},{-42,-16}}, color={255,0,255}));
  connect(not4.y, leaSwa1.uLeaRolSet[2]) annotation (Line(points={{-138,-30},{
          -110,-30},{-110,-16},{-42,-16}}, color={255,0,255}));
annotation (
  experiment(StopTime=180, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Generic/EquipmentRotation/Subsequences/Validation/LeadSwap_uDevSta.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.EquipmentRotation.Subsequences.LeadSwap\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.EquipmentRotation.Subsequences.LeadSwap</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
September 20, 2019, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(graphics={Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-220,-120},{220,120}})));
end LeadSwap_uDevSta;
