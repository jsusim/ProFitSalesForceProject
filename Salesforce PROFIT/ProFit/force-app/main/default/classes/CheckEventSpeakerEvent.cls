public class CheckEventSpeakerEvent {
    public static void checkDuplicate(List<Event_Speaker__c> eventSpeaker){
    
        try{

            Set<Id> eventId = new Set<Id>();
            Set<Id> eventSpeakerId = new Set<Id>();
    
            for(Event_Speaker__c evntSpkr : eventSpeaker){
                eventId.add(evntSpkr.Event__c);
                eventSpeakerId.add(evntSpkr.Speaker__c);
            }
            
            Map<Id, DateTime> startrequestedEvents = new Map<Id, DateTime>();
            Map<Id, DateTime> endrequestedEvents = new Map<Id, DateTime>();
           
            
    
    
            List<Event__c> relatedEventList = [Select Id, Name,Start_Date__c,End_Date__c From Event__c 
            Where Id IN: eventId];
    
    
            for(Event__c evt : relatedEventList ){
                startrequestedEvents.put(evt.Id, evt.Start_Date__c);
                endrequestedEvents.put(evt.Id, evt.End_Date__c);
            
                
            }
    
    
            
            List<Event_Speaker__c> relatedEventSpeakerList = [ SELECT Id, Event__c, Speaker__c,Event__r.Start_Date__c,
            Event__r.End_Date__c From Event_Speaker__c
            WHERE Speaker__c IN : eventSpeakerId];
    
    
    
            
        for(Event_Speaker__c evntSpkr : eventSpeaker){
    
            DateTime startTime = startrequestedEvents.get(evntSpkr.Event__c);
            DateTime endTime = endrequestedEvents.get(evntSpkr.Event__c);
    
    
                for(Event_Speaker__c rS: relatedEventSpeakerList)
                {
                    if((rS.Event__r.Start_Date__c < endTime && rS.Event__r.End_Date__c > endTime)||
                    (rS.Event__r.Start_Date__c < startTime && rS.Event__r.End_Date__c > startTime)||
                    (rS.Event__r.Start_Date__c >= startTime && rS.Event__r.End_Date__c <= endTime))
                    {
                        evntSpkr.Speaker__c.addError('The Speaker has already an event!');
                    }
    
                }
              
            }
        
            
           }catch (Exception ex) {
				System.debug('Get Exception: '+ex.getMessage());
       		}

    }
}
