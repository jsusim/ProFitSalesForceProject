@istest
public with sharing class EventRestService_Test {
    static Id createEventTestRecord(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Record REST Service';
        evt.Start_Date__c = datetime.newInstance(2021, 6, 26, 11, 00, 0);
        evt.End_Date__c = datetime.newInstance(2021, 6, 27, 12, 00, 0);
        evt.Event_Type__c ='Virtual';
        evt.Live__c = true;
        evt.Status__c = 'Created';
        evt.Max_Seats__c = 3;
        insert evt;
        return evt.Id;
    }
    @IsTest
    static void doGetTest(){
        Test.startTest();
            Id EventId =  createEventTestRecord();
            RestRequest req = new RestRequest();
            req.requestURI = 'collabera5--project1.my.my.salesforce.com/services/apexrest/api/Event__c/'+EventId;
            req.httpMethod = 'GET';
            RestContext.request = req;
            Event__c evt = EventRestService.doGetEvt();
            System.assertEquals(EventId, evt.Id);
        Test.stopTest();
    }
}
