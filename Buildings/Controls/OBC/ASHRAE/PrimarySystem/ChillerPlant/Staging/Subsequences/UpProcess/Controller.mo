within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcess;
block Controller
  "Sequence for control devices when there is stage-up command"

  parameter Integer nChi=2 "Total number of chillers in the plant";
  parameter Integer nSta=3
    "Total stages, zero stage should be seem as one stage";
  parameter Real chiDemRedFac=0.75
    "Demand reducing factor of current operating chillers"
    annotation (Dialog(group="Chiller demand limit"));
  parameter Modelica.SIunits.Time holChiDemTim=300
    "Time of actual demand less than center percentage of currnet load"
    annotation (Dialog(group="Chiller demand limit"));
  parameter Modelica.SIunits.Time byPasSetTim=300
    "Time to reset minimum by-pass flow"
    annotation (Dialog(group="Reset minimum bypass"));
  parameter Modelica.SIunits.VolumeFlowRate minFloSet[nSta]={0,0.0089,0.0177}
    "Minimum flow rate at each chiller stage"
    annotation (Dialog(group="Reset minimum bypass"));
  parameter Modelica.SIunits.Time aftByPasSetTim=60
    annotation (Dialog(group="Reset minimum bypass"));
  parameter Modelica.SIunits.VolumeFlowRate minFloDif=0.01
    "Minimum flow rate difference to check if bybass flow achieves setpoint"
    annotation (Dialog(group="Reset minimum bypass"));
  parameter Boolean isheadered=true
    "Flag of headered condenser water pumps design: true=headered, false=dedicated"
    annotation (Dialog(group="Enable condenser water pump"));
  parameter Boolean haveWSE=true
    "Flag of waterside economizer: true=have WSE, false=no WSE"
    annotation (Dialog(group="Enable condenser water pump"));
  parameter Real chiNum[nSta]={0,1,2}
    "Total number of operating chillers at each stage"
    annotation (Dialog(group="Enable condenser water pump"));
  parameter Real uLow=0.005 "if y=true and u<uLow, switch to y=false"
    annotation (Dialog(group="Enable condenser water pump"));
  parameter Real uHigh=0.015 "if y=false and u>uHigh, switch to y=true"
    annotation (Dialog(group="Enable condenser water pump"));
  parameter Modelica.SIunits.Time thrTimEnb=10
    "Threshold time to enable head pressure control after condenser water pump being reset"
    annotation (Dialog(group="Enable head pressure control"));
  parameter Modelica.SIunits.Time waiTim=30
    "Waiting time after enabling next head pressure control"
    annotation (Dialog(group="Enable head pressure control"));
  parameter Boolean heaStaCha=true
    "Flag to indicate if next head pressure control should be ON or OFF: true = in stage-up process"
    annotation (Dialog(group="Enable head pressure control"));
  parameter Modelica.SIunits.Time chaChiWatIsoTim=300
    "Time to slowly change isolation valve"
    annotation (Dialog(group="Enable CHW isolation valve"));
  parameter Real iniValPos=0
    "Initial valve position, if it is in stage-up process, the value should be 0"
    annotation (Dialog(group="Enable CHW isolation valve"));
  parameter Real endValPos=1
    "Ending valve position, if it is in stage-up process, the value should be 1"
    annotation (Dialog(group="Enable CHW isolation valve"));
  parameter Modelica.SIunits.Time proOnTim=300
    "Threshold time to check if newly enabled chiller being operated by more than 5 minutes"
    annotation (Dialog(group="Enable next chiller"));


  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp
    "Stage up status: true=stage-up"
    annotation (Placement(transformation(extent={{-280,190},{-240,230}}),
      iconTransformation(extent={{-230,142},{-190,182}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiLoa[nChi]
    "Current chiller load"
    annotation (Placement(transformation(extent={{-280,150},{-240,190}}),
      iconTransformation(extent={{-230,110},{-190,150}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[nChi]
    "Chiller status: true=ON"
    annotation (Placement(transformation(extent={{-280,110},{-240,150}}),
      iconTransformation(extent={{-210,80},{-170,120}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput VBypas_flow(
    final unit="m3/s")
    "Measured bypass flow rate"
    annotation (Placement(transformation(extent={{-280,80},{-240,120}}),
      iconTransformation(extent={{-220,36},{-180,76}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uSta
    "Current stage index"
    annotation (Placement(transformation(extent={{-280,0},{-240,40}}),
      iconTransformation(extent={{-220,40},{-180,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-280,50},{-240,90}}),
      iconTransformation(extent={{-246,0},{-206,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWSE
    "Water side economizer status: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-280,-80},{-240,-40}}),
      iconTransformation(extent={{-226,-80},{-186,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpe
    "Current condenser water pump speed"
    annotation (Placement(transformation(extent={{-280,-100},{-240,-60}}),
      iconTransformation(extent={{-216,-118},{-176,-78}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiHeaCon[nChi]
    "Chillers head pressure control status"
    annotation (Placement(transformation(extent={{-280,-130},{-240,-90}}),
      iconTransformation(extent={{-244,-156},{-204,-116}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiWatIsoVal[nChi]
    "Chilled water isolation valve position"
    annotation (Placement(transformation(extent={{-280,-180},{-240,-140}}),
      iconTransformation(extent={{-246,-186},{-206,-146}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatReq[nChi]
    "Chilled water requst status for each chiller"
    annotation (Placement(transformation(extent={{-280,-240},{-240,-200}}),
      iconTransformation(extent={{0,-214},{40,-174}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uConWatReq[nChi]
    "Condenser water requst status for each chiller"
    annotation (Placement(transformation(extent={{-280,-40},{-240,0}}),
      iconTransformation(extent={{-58,-224},{-18,-184}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiPri[nChi]
    "Chiller enabling priority"
    annotation (Placement(transformation(extent={{-280,230},{-240,270}}),
      iconTransformation(extent={{-184,178},{-144,218}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiDem[nChi]
    "Chiller demand setpoint"
    annotation (Placement(transformation(extent={{240,160},{260,180}}),
      iconTransformation(extent={{212,188},{232,208}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatBypSet
    "Chilled water minimum flow bypass setpoint"
    annotation (Placement(transformation(extent={{240,80},{260,100}}),
      iconTransformation(extent={{172,60},{192,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yLeaConWatPum
    "Lead condenser water pump status"
    annotation (Placement(transformation(extent={{240,20},{260,40}}),
      iconTransformation(extent={{194,-34},{214,-14}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yConWatPumSpeSet
    "Condenser water pump speed"
    annotation (Placement(transformation(extent={{240,0},{260,20}}),
      iconTransformation(extent={{180,-36},{200,-16}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yConWatPumNum
    "Number of operating condenser water pumps"
    annotation (Placement(transformation(extent={{240,-20},{260,0}}),
      iconTransformation(extent={{176,-46},{196,-26}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChiHeaCon[nChi]
    "Chiller head pressure control enabling status"
    annotation (Placement(transformation(extent={{240,-102},{260,-82}}),
      iconTransformation(extent={{190,-106},{210,-86}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatIsoVal[nChi]
    "Chiller chilled water isolation valve position"
    annotation (Placement(transformation(extent={{240,-160},{260,-140}}),
      iconTransformation(extent={{190,-110},{210,-90}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChi[nChi]
    "Chiller enabling status"
    annotation (Placement(transformation(extent={{240,-220},{260,-200}}),
      iconTransformation(extent={{212,-130},{232,-110}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.NextChiller nexChi(
    final nChi=nChi)
    "Identify next enabling chiller"
    annotation (Placement(transformation(extent={{-80,220},{-60,240}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcess.Subsequences.ReduceChillerDemand chiDemRed(
    final nChi=nChi,
    final chiDemRedFac=chiDemRedFac,
    final holChiDemTim=holChiDemTim) "Limit chiller demand"
    annotation (Placement(transformation(extent={{-80,160},{-60,180}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.ResetMinBypassSetpoint minBypSet(
    final aftByPasSetTim=aftByPasSetTim,
    final minFloDif=minFloDif) "Check if minium bypass has been reset"
    annotation (Placement(transformation(extent={{60,120},{80,140}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcess.Subsequences.EnableNextCWPump enaNexCWP
    "Identify correct stage number for enabling next condenser water pump"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.EnableHeadControl enaHeaCon(
    final nChi=nChi,
    final thrTimEnb=thrTimEnb,
    final waiTim=waiTim,
    final heaStaCha=heaStaCha)
    "Enabling head pressure control for next enabling chiller"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.EnableChiIsoVal enaChiIsoVal(
    final nChi=nChi,
    final chaChiWatIsoTim=chaChiWatIsoTim,
    final iniValPos=iniValPos,
    final endValPos=endValPos)
    "Enable chilled water isolation valve for next enabling chiller"
    annotation (Placement(transformation(extent={{60,-160},{80,-140}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.UpProcess.Subsequences.EnableNextChiller enaNexChi(
    final nChi=nChi,
    final nSta=nSta,
    final proOnTim=proOnTim,
    final minFloSet=minFloSet,
    final byPasSetTim=byPasSetTim,
    final aftByPasSetTim=aftByPasSetTim,
    final minFloDif=minFloDif) "Enable next chiller"
    annotation (Placement(transformation(extent={{60,-230},{80,-210}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint minBypSet1(
    final nSta=nSta,
    final byPasSetTim=byPasSetTim,
    final minFloSet=minFloSet)
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(final k=false)
    "False constant"
    annotation (Placement(transformation(extent={{-80,58},{-60,78}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pump.CondenserWaterP.Controller conWatPumCon(
    final isheadered=isheadered,
    final haveWSE=haveWSE,
    final nSta=nSta,
    final chiNum=chiNum,
    final uLow=uLow,
    final uHigh=uHigh) "Enabling next condenser water pump or change pump speed"
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr "Multiple or"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr1 "Multiple or"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi[nChi] "Logical switch"
    annotation (Placement(transformation(extent={{200,-160},{220,-140}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep(final nout=nChi)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{120,-160},{140,-140}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi[nChi] "Logical switch"
    annotation (Placement(transformation(extent={{200,-102},{220,-82}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1 "Logical switch"
    annotation (Placement(transformation(extent={{200,80},{220,100}})));
  Buildings.Controls.OBC.CDL.Logical.Edge edg
    "Rising edge, output true at the moment when input turns from false to true"
    annotation (Placement(transformation(extent={{-200,200},{-180,220}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat
    "Logical latch, maintain ON signal until condition changes"
    annotation (Placement(transformation(extent={{-140,200},{-120,220}})));

equation
  connect(chiDemRed.yChiDemRed, minBypSet.uUpsDevSta) annotation (Line(points={{-59,166},
          {-20,166},{-20,138},{58,138}},      color={255,0,255}));
  connect(uStaUp, edg.u)
    annotation (Line(points={{-260,210},{-202,210}}, color={255,0,255}));
  connect(edg.y, lat.u)
    annotation (Line(points={{-179,210},{-141,210}}, color={255,0,255}));
  connect(lat.y, nexChi.uStaUp) annotation (Line(points={{-119,210},{-100,210},{
          -100,230},{-82,230}},
                           color={255,0,255}));
  connect(lat.y, chiDemRed.uStaUp) annotation (Line(points={{-119,210},{-100,210},
          {-100,176},{-82,176}},color={255,0,255}));
  connect(chiDemRed.uChiLoa, uChiLoa)
    annotation (Line(points={{-82,170},{-260,170}}, color={0,0,127}));
  connect(chiDemRed.uChi, uChi) annotation (Line(points={{-82,164},{-220,164},{-220,
          130},{-260,130}}, color={255,0,255}));
  connect(lat.y, minBypSet.uStaCha) annotation (Line(points={{-119,210},{-100,210},
          {-100,134},{58,134}},color={255,0,255}));
  connect(minBypSet.VBypas_flow, VBypas_flow) annotation (Line(points={{58,126},
          {-140,126},{-140,100},{-260,100}},
                                           color={0,0,127}));
  connect(lat.y, minBypSet1.uStaUp) annotation (Line(points={{-119,210},{-100,210},
          {-100,98},{-2,98}},color={255,0,255}));
  connect(minBypSet1.uSta, uSta) annotation (Line(points={{-2,90},{-120,90},{-120,
          20},{-260,20}}, color={255,127,0}));
  connect(chiDemRed.yChiDemRed, minBypSet1.uUpsDevSta) annotation (Line(points={{-59,166},
          {-20,166},{-20,94},{-2,94}},       color={255,0,255}));
  connect(con.y, minBypSet1.uStaDow) annotation (Line(points={{-59,68},{-20,68},
          {-20,82},{-2,82}},
                        color={255,0,255}));
  connect(minBypSet1.uOnOff, uOnOff) annotation (Line(points={{-2,86},{-200,86},
          {-200,70},{-260,70}}, color={255,0,255}));
  connect(minBypSet1.yChiWatBypSet, minBypSet.VBypas_setpoint) annotation (Line(
        points={{21,90},{40,90},{40,122},{58,122}}, color={0,0,127}));
  connect(minBypSet.yMinBypRes, enaNexCWP.uMinBypRes) annotation (Line(points={{81,130},
          {90,130},{90,60},{-20,60},{-20,28},{-2,28}},        color={255,0,255}));
  connect(lat.y, enaNexCWP.uStaUp) annotation (Line(points={{-119,210},{-100,210},
          {-100,19.8},{-2,19.8}},color={255,0,255}));
  connect(uSta, enaNexCWP.uSta) annotation (Line(points={{-260,20},{-120,20},{-120,
          12},{-2,12}}, color={255,127,0}));
  connect(mulOr.y, conWatPumCon.uLeaChiOn) annotation (Line(points={{-58.3,-10},
          {-20,-10},{-20,-16},{58,-16}},
                                       color={255,0,255}));
  connect(conWatPumCon.uWSE, uWSE) annotation (Line(points={{58,-24},{0,-24},{0,
          -60},{-260,-60}}, color={255,0,255}));
  connect(conWatPumCon.uConWatPumSpe, uConWatPumSpe) annotation (Line(points={{58,-28},
          {20,-28},{20,-80},{-260,-80}},      color={0,0,127}));
  connect(enaNexCWP.ySta, conWatPumCon.uChiSta) annotation (Line(points={{21,20},
          {40,20},{40,-12},{58,-12}}, color={255,127,0}));
  connect(lat.y, enaHeaCon.uStaCha) annotation (Line(points={{-119,210},{-100,210},
          {-100,-86},{58,-86}},color={255,0,255}));
  connect(conWatPumCon.yPumSpeChe, enaHeaCon.uUpsDevSta) annotation (Line(
        points={{81,-29},{90,-29},{90,-60},{40,-60},{40,-82},{58,-82}},
        color={255,0,255}));
  connect(nexChi.yNexEnaChi, enaHeaCon.uNexChaChi) annotation (Line(points={{-59,239},
          {-40,239},{-40,-94},{58,-94}},      color={255,127,0}));
  connect(enaHeaCon.uChiHeaCon, uChiHeaCon) annotation (Line(points={{58,-98},{-60,
          -98},{-60,-110},{-260,-110}}, color={255,0,255}));
  connect(nexChi.yNexEnaChi, enaChiIsoVal.uNexChaChi) annotation (Line(points={{-59,239},
          {-40,239},{-40,-142},{58,-142}},          color={255,127,0}));
  connect(enaChiIsoVal.uChiWatIsoVal, uChiWatIsoVal) annotation (Line(points={{58,-146},
          {-80,-146},{-80,-160},{-260,-160}},       color={0,0,127}));
  connect(enaHeaCon.yEnaHeaCon, enaChiIsoVal.yUpsDevSta) annotation (Line(
        points={{81,-84},{90,-84},{90,-112},{40,-112},{40,-154},{58,-154}},
        color={255,0,255}));
  connect(lat.y, enaChiIsoVal.uStaCha) annotation (Line(points={{-119,210},{-100,
          210},{-100,-158},{58,-158}},
                                 color={255,0,255}));
  connect(nexChi.yNexEnaChi, enaNexChi.uNexEnaChi) annotation (Line(points={{-59,239},
          {-40,239},{-40,-209},{59,-209}},      color={255,127,0}));
  connect(lat.y, enaNexChi.uStaUp) annotation (Line(points={{-119,210},{-100,210},
          {-100,-211},{59,-211}},color={255,0,255}));
  connect(enaChiIsoVal.yEnaChiWatIsoVal, enaNexChi.uEnaChiWatIsoVal)
    annotation (Line(points={{81,-144},{100,-144},{100,-180},{40,-180},{40,-213},
          {59,-213}}, color={255,0,255}));
  connect(uChi, enaNexChi.uChi) annotation (Line(points={{-260,130},{-220,130},{
          -220,-215},{59,-215}}, color={255,0,255}));
  connect(uOnOff, enaNexChi.uOnOff) annotation (Line(points={{-260,70},{-200,70},
          {-200,-217},{59,-217}}, color={255,0,255}));
  connect(enaNexChi.uChiWatReq, uChiWatReq) annotation (Line(points={{59,-221},{
          40,-221},{40,-220},{-260,-220}}, color={255,0,255}));
  connect(enaNexChi.uChiWatIsoVal, uChiWatIsoVal) annotation (Line(points={{59,-223},
          {-80,-223},{-80,-160},{-260,-160}}, color={0,0,127}));
  connect(mulOr1.y, conWatPumCon.uLeaConWatReq) annotation (Line(points={{-58.3,
          -40},{-20,-40},{-20,-20},{58,-20}},
                                          color={255,0,255}));
  connect(uConWatReq, enaNexChi.uConWatReq) annotation (Line(points={{-260,-20},
          {-180,-20},{-180,-225},{59,-225}}, color={255,0,255}));
  connect(uChiHeaCon, enaNexChi.uChiHeaCon) annotation (Line(points={{-260,-110},
          {-60,-110},{-60,-227},{59,-227}}, color={255,0,255}));
  connect(uSta, enaNexChi.uSta) annotation (Line(points={{-260,20},{-120,20},{-120,
          -229},{59,-229}}, color={255,127,0}));
  connect(VBypas_flow, enaNexChi.VBypas_flow) annotation (Line(points={{-260,100},
          {-140,100},{-140,-231},{59,-231}},color={0,0,127}));

  connect(uConWatReq, mulOr1.u) annotation (Line(points={{-260,-20},{-180,-20},{
          -180,-40},{-82,-40}},             color={255,0,255}));
  connect(uChi, mulOr.u) annotation (Line(points={{-260,130},{-220,130},{-220,-10},
          {-82,-10}},                       color={255,0,255}));

  connect(nexChi.uChiPri, uChiPri) annotation (Line(points={{-82,238},{-140,238},
          {-140,250},{-260,250}}, color={255,127,0}));
  connect(uChi, nexChi.uChiEna) annotation (Line(points={{-260,130},{-220,130},{
          -220,234},{-82,234}}, color={255,0,255}));
  connect(chiDemRed.yChiDem, yChiDem) annotation (Line(points={{-59,174},{120,174},
          {120,170},{250,170}}, color={0,0,127}));
  connect(conWatPumCon.yLeaPum, yLeaConWatPum) annotation (Line(points={{81,-11},
          {120,-11},{120,30},{250,30}}, color={255,0,255}));
  connect(conWatPumCon.yConWatPumSpeSet, yConWatPumSpeSet) annotation (Line(
        points={{81,-17},{130,-17},{130,10},{250,10}}, color={0,0,127}));
  connect(conWatPumCon.yConWatPumNum, yConWatPumNum) annotation (Line(points={{81,
          -23},{139.5,-23},{139.5,-10},{250,-10}}, color={255,127,0}));
  connect(enaNexChi.yChi, yChi) annotation (Line(points={{81,-211},{220,-211},{220,
          -210},{250,-210}}, color={255,0,255}));
  connect(enaChiIsoVal.yEnaChiWatIsoVal, booRep.u) annotation (Line(points={{81,
          -144},{100,-144},{100,-150},{118,-150}}, color={255,0,255}));
  connect(booRep.y, swi.u2)
    annotation (Line(points={{141,-150},{198,-150}}, color={255,0,255}));
  connect(enaNexChi.yChiWatIsoVal, swi.u1) annotation (Line(points={{81,-214},{184,
          -214},{184,-142},{198,-142}}, color={0,0,127}));
  connect(swi.y, yChiWatIsoVal)
    annotation (Line(points={{221,-150},{250,-150}}, color={0,0,127}));
  connect(booRep.y, logSwi.u2) annotation (Line(points={{141,-150},{160,-150},{160,
          -92},{198,-92}}, color={255,0,255}));
  connect(enaNexChi.yChiHeaCon, logSwi.u1) annotation (Line(points={{81,-217},{170,
          -217},{170,-84},{198,-84}}, color={255,0,255}));
  connect(enaHeaCon.yChiHeaCon, logSwi.u3) annotation (Line(points={{81,-96},{140,
          -96},{140,-100},{198,-100}}, color={255,0,255}));
  connect(logSwi.y, yChiHeaCon)
    annotation (Line(points={{221,-92},{250,-92}}, color={255,0,255}));
  connect(enaChiIsoVal.yEnaChiWatIsoVal, swi1.u2) annotation (Line(points={{81,-144},
          {100,-144},{100,90},{198,90}}, color={255,0,255}));
  connect(enaNexChi.yChiWatBypSet, swi1.u1) annotation (Line(points={{81,-223},{
          180,-223},{180,98},{198,98}}, color={0,0,127}));
  connect(minBypSet1.yChiWatBypSet, swi1.u3) annotation (Line(points={{21,90},{40,
          90},{40,82},{198,82}}, color={0,0,127}));
  connect(swi1.y, yChiWatBypSet)
    annotation (Line(points={{221,90},{250,90}}, color={0,0,127}));
  connect(enaNexChi.yEndSta, lat.u0) annotation (Line(points={{81,-229},{100,-229},
          {100,-240},{-160,-240},{-160,204},{-141,204}}, color={255,0,255}));
  connect(enaChiIsoVal.yChiWatIsoVal, swi.u3) annotation (Line(points={{81,-150},
          {90,-150},{90,-166},{190,-166},{190,-158},{198,-158}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,-260},
            {240,260}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-240,-260},{240,260}})));
end Controller;