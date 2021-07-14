trigger DuplicateEventSpeakerTrigger on Event_Speaker__c (before insert, before update) {
	if(trigger.isBefore && (trigger.isInsert||trigger.isUpdate)){
		CheckEventSpeakerEvent.checkDuplicate(Trigger.New);
	}
}