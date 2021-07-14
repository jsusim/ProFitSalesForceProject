trigger EventAttendeeTrigger on EventAttendees__c  (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        EventAttendeeTriggerHandler.sendConfirmationEmail(Trigger.New);
    }
}