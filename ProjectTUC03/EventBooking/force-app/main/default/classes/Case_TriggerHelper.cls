public with sharing class Case_TriggerHelper {

    public static void BeforeInsert (List<Case> newListCases) {
        Set<Id> setAccountId = new Set<Id>();
        Map<Id,Account> mapId_Account = new Map<Id,Account> ();
        for(Case caseItem : newListCases){
             setAccountId.add(caseItem.AccountId);
        }
        List<Account> accountList =  [SELECT ID, (select id from contacts) FROM Account where Id IN : setAccountId];
        for(Account accountItem : accountList){
            mapId_Account.put(accountItem.Id,accountItem);
        }        
        for(Case caseItem : newListCases){
          if(caseItem != null && caseItem.AccountId != null){
            Integer sizeContacts = (mapId_Account.get(caseItem.AccountId)).Contacts.size();
            if(sizeContacts ==0){
              caseItem.addError('You cannot create a request for accounts without contacts');
            }else {
              switch on caseItem.Origin {
                when 'Web' {
                    if(sizeContacts >= 2 ){
                        caseItem.addError('Web request are only allowed to have one attendee');
                    }
                }
                when 'Phone'{
                    if(sizeContacts >= 4 ){
                        caseItem.addError('Phone request are only allowed to have three attendee');
                    }
                }
              }                            
          }
        }else {
          caseItem.addError('You cannot create a request without attaching an account');
        }
      }
    }      
    public static void AfterUpdate(List<Case> listCase) {
        Boolean requestSentToExternalSystem = false;
        ExternalSystemService service = new ExternalSystemService();
        for(Case c : listCase){
          service.registerAttendees(c);
        }
    } 
}
