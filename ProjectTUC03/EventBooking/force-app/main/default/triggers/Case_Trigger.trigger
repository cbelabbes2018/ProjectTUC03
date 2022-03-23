trigger Case_Trigger on Case (before insert,after update ) {
  
  Case_TriggerHandler handler = new Case_TriggerHandler();
}