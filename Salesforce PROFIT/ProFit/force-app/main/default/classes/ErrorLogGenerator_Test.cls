@isTest
public with sharing class ErrorLogGenerator_Test {
    @IsTest
    static void testError(){
        
        Test.startTest();
        DateTime logDate = datetime.newInstance(2020, 3, 15, 17, 25, 0);
        String logDetails = 'Error Test';
        String name = 'Test Error Name';
        ErrorLogGenerator.createErrorLog(name, logDetails, logDate);

        Test.stopTest();
        Error_Log__c eLog = [Select Id, Log_Date_Time__c,Log_Details__c,Process_Name__c from Error_Log__c];
        System.assertEquals('Test Error Name', eLog.Process_Name__c);
    }
}