within Buildings.Obsolete.Media.GasesPTDecoupled.Examples;
model MoistAirUnsaturatedTemperatureEnthalpyInversion
  "Model to check computation of h(T) and its inverse"
  extends Modelica.Icons.Example;
  extends Buildings.Media.Examples.BaseClasses.TestTemperatureEnthalpyInversion(
    redeclare package Medium =
        Buildings.Obsolete.Media.Air);
  annotation (
experiment(StopTime=1.0),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Obsolete/Media/GasesPTDecoupled/Examples/MoistAirUnsaturatedTemperatureEnthalpyInversion.mos"
        "Simulate and plot"));
end MoistAirUnsaturatedTemperatureEnthalpyInversion;
