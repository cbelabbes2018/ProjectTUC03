@isTest
public class TestDataFactory {
  public static Case createCase(String OriginStr,String SubjectStr,String DescriptionStr,Id accId){     
    Case c = new Case(Origin = OriginStr,Subject = SubjectStr, Description = DescriptionStr,AccountId = accId );
    insert c;
    return c;
  }
  public static Account createAccount(String accountName){
    Account a1 = new Account(Name = accountName);
    insert a1;
    return a1;    
    } 
  public static Contact createContact(String lastName,Id accountId){
    Contact c1 = new Contact(LastName = lastName, AccountId = accountId);
    insert c1;
    return c1;    
    }  
}