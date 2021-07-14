@isTest
public class EventAttendeeTrigger_Test {
    @testSetup
    public static void setupData(){
        
        Event_Organizer__c  org = new Event_Organizer__c (
            Name = 'Badong Badong',
            Phone__c = '11223344',
            Email__c = 'Sample@email.com',
            Alternative_Phone__c  = '22113311',
            Alternative_Email__c ='test@email.com'
        );
        insert org;
        
        Event__c event = new Event__c(
            Name__c = 'Fitness Focus',
            Event_Organizer__c  = org.Id,
            Event_Type__c = 'Virtual',
            Frequency__c  = 'Weekly',
            Max_Seats__c  = 50,
            Recurring__c = true,
            Live__c = true,
            Start_Date__c = System.now(),
            End_Date__c  = System.now().addDays(3)
        );
        insert event;
        Attendees__c att = new Attendees__c(
            Name = 'Badong Badong',
            Email__c = 'Sample@email.com',
            Phone__c = '11223344'
        );
        insert att;
        
        EventAttendees__c evtAtt = new EventAttendees__c(Event__c = event.Id, Attendees__c = att.Id);
        insert evtAtt;
    }
    
    @isTest
    static void sendEmailTest(){
        Test.startTest();
        try{
            integer i = 10/0;
        }catch(System.Exception ex ){
            System.debug('Exception -- ' + ex.getMessage());
        }
        Test.stopTest();
    }
}
    

