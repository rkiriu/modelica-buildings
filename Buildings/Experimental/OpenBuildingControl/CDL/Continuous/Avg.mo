within Buildings.Experimental.OpenBuildingControl.CDL.Continuous;
block Avg "Output the average of its two inputs"

  Interfaces.RealInput u1 "Connector of Real input signal 1"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}}),
        iconTransformation(extent={{-140,40},{-100,80}})));

  Interfaces.RealInput u2 "Connector of Real input signal 2"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));

  Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-8},{120,12}}),
        iconTransformation(extent={{100,-8},{120,12}})));

equation
  y = (u1 + u2)/2.0;

  annotation (
    defaultComponentName="avg1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString="%name"),
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-50,34},{52,-26}},
          lineColor={192,192,192},
          textString="avg()"),
        Line(points={{-8,16}}, color={0,0,0}),
        Line(
          points={{-100,60}},
          color={0,0,0},
          thickness=1)}),
    Documentation(info="<html>
<p>
Block that outputs <code>y = avg(u1,u2)</code>,
where
<code>u1</code> and <code>u2<code> are inputs.
</p>
</html>", revisions="<html>
<ul>
<li>
March 15, 2017, by Jianjun Hu:<br/>
First implementation, based on the implementation of the
Modelica Standard Library.
</li>
</ul>
</html>"));
end Avg;
