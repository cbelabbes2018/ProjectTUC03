@isTest
public class EventBookingTest {  

    @isTest
    public static void refuseCaseCreationWhenAnAccountIsNotAttachedToACase(){
        Case request = TestDataFactory.createCase('Phone','Event Booking','Book Spots',null);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(request, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('You cannot create a request without attaching an account',
        result.getErrors()[0].getMessage());
        }
        
        @isTest
        public static void refuseCaseCreationWhenNoContactIsAttachedToAnAccount(){
            // Given
      
            Account a1 = new Account(Name = 'Salesforce');
            insert a1;

            Case request = new Case(Origin = 'Phone',Subject = 'Event Booking', Description = 'Book Spots', AccountId = a1.ID);
            
            // When 

            Test.startTest();

            Database.SaveResult result = Database.insert(request, false);

            Test.stopTest();

            // Then

            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('You cannot create a request for accounts without contacts',
            result.getErrors()[0].getMessage());
        }
        
        @isTest
        public static void bookEventFromPhone(){
            Account a1 = TestDataFactory.createAccount('Salesforce');            
            Contact c1 = TestDataFactory.createContact('Contact 1', a1.ID);    
            Contact c2 = TestDataFactory.createContact('Contact 2', a1.ID);    
            Contact c3 = TestDataFactory.createContact('Contact 3', a1.ID); 
    		Case request = TestDataFactory.createCase('Phone','Event Booking','Book Spots for Company A1 & their 3 employees',a1.ID);            
            Test.startTest();
            Database.SaveResult result = Database.insert(request, false);
            Test.stopTest();
            System.assert(result.isSuccess());
        }


        @isTest
        public static void refuseEventBookingWhenNumberOfAttendeesIsMoreThanThreeForPhoneCases(){
            // Given
            
            Account a1 = TestDataFactory.createAccount('Salesforce');            
            Contact c1 = TestDataFactory.createContact('Contact 1', a1.ID);    
            Contact c2 = TestDataFactory.createContact('Contact 2', a1.ID);    
            Contact c3 = TestDataFactory.createContact('Contact 3', a1.ID); 
            Contact c4 = TestDataFactory.createContact('Contact 4', a1.ID); 
    		Case request = TestDataFactory.createCase('Phone','Event Booking','Book Spots for Company A1 & their 4 employees',a1.ID);                        
            
            Test.startTest();
            Database.SaveResult result = Database.insert(request, false);
            Test.stopTest();

            // Then
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('Phone request are only allowed to have three attendee',
            result.getErrors()[0].getMessage());

        }
        
        @isTest
        public static void bookEventFromTheWeb(){
            // Given
            Account a1 = TestDataFactory.createAccount('Salesforce');                              
            Contact c1 = TestDataFactory.createContact('Contact 1', a1.ID);    
    		Case request = TestDataFactory.createCase('Web','Event Booking','Book One Spot for Company A1',a1.ID);                                        
            // When 
            Test.startTest();
            Database.SaveResult result = Database.insert(request, false);
            Test.stopTest();
            // Then
            System.assert(result.isSuccess());                
        } 
            
        @isTest
        public static void refuseEventBookingWhenNumberOfAttendeesIsMoreThanOneForWebCases(){
            // Given            
            Account a1 = TestDataFactory.createAccount('Salesforce');                                          
            Contact c1 = TestDataFactory.createContact('Contact 1', a1.ID);    
            Contact c2 = TestDataFactory.createContact('Contact 2', a1.ID);    
            Contact c3 = TestDataFactory.createContact('Contact 3', a1.ID);     
            Case request = new Case(Origin = 'Web',Subject = 'Event Booking', Description = 'Book Spots for Company A1 & their 3 employees', AccountId = a1.ID);            
            // When 

            Test.startTest();
            Database.SaveResult result = Database.insert(request, false);
            Test.stopTest();
            // Then
            System.assert(!result.isSuccess());
            System.assert(result.getErrors().size() > 0);
            System.assertEquals('Web request are only allowed to have one attendee',
            result.getErrors()[0].getMessage());

                
        } 
    
    
}
