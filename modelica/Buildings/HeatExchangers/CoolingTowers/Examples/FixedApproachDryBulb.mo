model FixedApproachDryBulb 
  import Buildings;
  extends BaseClasses.PartialStaticFourPortCoolingTower(
    redeclare Buildings.HeatExchangers.CoolingTowers.FixedApproachDryBulb tow);
  annotation(Diagram, Commands(file="FixedApproachDryBulb.mos" "run"));
end FixedApproachDryBulb;
