public class UpdateEventBatch implements Database.Batchable<sObject> {
	
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String Query = 'Select Id, Name__c From Event__c Where Live__c = false AND Status__c != \'Completed\' AND End_Date__c < LAST_N_MONTHS:4';
        return Database.getQueryLocator(Query);
    }   

    public void execute(Database.BatchableContext batchContext, List<Event__c> eventList ){
        List<Event__c> deletedEvtRecsList = new List<Event__c>();
        for(Event__c evt: eventList){
            evt.Status__c = 'Deleted';
            deletedEvtRecsList.add(evt);  
        }
        update deletedEvtRecsList;
    }
    
    public void finish(Database.BatchableContext batchContext){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String userName = UserInfo.getUserName();
        User activeUser = [Select Name,Email From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        String userWholeName = activeUser.Name;
        
        mail.setSubject('Batch Processing Completed');
        List<String> toAddress = new List<String>();
        toAddress.add(userEmail);
        mail.setToAddresses( toAddress );
        mail.setSenderDisplayName(userWholeName);
        
        mail.setHtmlBody('The Update Batch Processing has been Completed');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    
    }
}