public with sharing class AttendeeEventService {
    @AuraEnabled(cacheable = true)
  public static List<EventAttendees__c> upcomingEvents(String attendeeId) {
    List<EventAttendees__c> eventLists = [
      SELECT
        Id,
        Name,
        Event__c,
        Event__r.Location__c,
        Event__r.Location__r.Name,
        Event__r.Event_Organizer__c,
        Event__r.Event_Organizer__r.Name,
        Event__r.Name__c,
        Event__r.Start_Date__c,
        Event__r.End_Date__c
      FROM EventAttendees__c
      WHERE
        Attendees__c = :attendeeId
        AND Event__r.Start_Date__c >= today
        AND Event__r.Live__c = true
      WITH SECURITY_ENFORCED
    ];
    return eventLists;
  }

  @AuraEnabled(cacheable = true)
  public static List<EventAttendees__c> pastEvents(String attendeeId) {
    List<EventAttendees__c> eventLists = [
      SELECT
        Id,
        Name,
        Event__c,
        Event__r.Location__c,
        Event__r.Location__r.Name,
        Event__r.Event_Organizer__c,
        Event__r.Event_Organizer__r.Name,
        Event__r.Name__c,
        Event__r.Start_Date__c,
        Event__r.End_Date__c
      FROM EventAttendees__c
      WHERE Attendees__c = :attendeeId AND Event__r.Start_Date__c < today
      WITH SECURITY_ENFORCED
    ];
    return eventLists;
  }
}
