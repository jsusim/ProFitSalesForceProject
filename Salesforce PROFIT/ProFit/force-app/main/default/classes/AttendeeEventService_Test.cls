@isTest
public with sharing class AttendeeEventService_Test {
    static Id createTestNewEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Start_Date__c = datetime.newInstance(2021, 7, 21, 19, 30, 0);
        evt.Live__c = true;
        insert evt;
        return evt.Id;
    }
    static Id createTestOldEvent(){
        Event__c evt = new Event__c();
        evt.Name__c = 'Test Event';
        evt.Start_Date__c = datetime.newInstance(2021, 3, 21, 19, 30, 0);
        evt.Live__c = false;
        insert evt;
        return evt.Id;
    }
    static Id createTestAttendee(){
        Attendees__c att = new Attendees__c();
        att.Name = 'Test Attendee';
        insert att;
        return att.Id;
    }
    @isTest
    static void testUpcomingEvents(){
        Test.startTest();
        EventAttendees__c eA = new EventAttendees__c();
        eA.Event__c = createTestNewEvent();
        eA.Attendees__c = createTestAttendee();
        eA.Name = 'Test EA';
        insert eA;
        EventAttendees__c name;
        List<EventAttendees__c> retrievedAttendee = AttendeeEventService.upcomingEvents(eA.Attendees__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test EA', name.Name);
    }
    @isTest
    static void testPastEvents(){
        Test.startTest();
        EventAttendees__c eA = new EventAttendees__c();
        eA.Event__c = createTestOldEvent();
        eA.Attendees__c = createTestAttendee();
        
        eA.Name = 'Test EA';
        insert eA;
        EventAttendees__c name;
        List<EventAttendees__c> retrievedAttendee = AttendeeEventService.pastEvents(eA.Attendees__c);
        name = retrievedAttendee.get(0);
        
        Test.stopTest();
        System.assertEquals('Test EA', name.Name);
    }
}
