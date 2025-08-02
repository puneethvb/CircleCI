public with sharing class FetchCMDTRec {
    @AuraEnabled(cacheable=true)
    public static List<Picklist_Bucket__mdt> getCMDTRecords() {
        // Query the Custom Metadata Type records
        List<Picklist_Bucket__mdt> cmdtRecords = [SELECT Id, MasterLabel FROM Picklist_Bucket__mdt];
        
        // Return the list of records
        return cmdtRecords;
    }
}