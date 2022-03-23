public with sharing class Case_TriggerHandler {
    public Case_TriggerHandler() {
    }
    public void BeforeInsert(List<SObject> newItems) {
        Case_TriggerHelper.BeforeInsert((List<Case>) Trigger.New);
    }
    public void AfterUpdate(List<SObject> newItems) {
        List<Case> listCase = new List<Case>();
        for(Case newCaseItem : (List<Case>) Trigger.New){
            Case oldCaseItem=(Case)Trigger.oldMap.get(newCaseItem.ID);
            if(newCaseItem.Status !=oldCaseItem.Status && (newCaseItem.Status).equalsIgnoreCase('Closed') ) {
              listCase.add(newCaseItem);
        	}  
        }
        if(!listCase.isEmpty()){
          Case_TriggerHelper.AfterUpdate(listCase);
        }
    }
}
