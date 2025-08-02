public with sharing class ReservationManager {
    
    
    @InvocableMethod(label='Update Reservation Status')
    public static List<Id> updateReservationStatus(List<Requests> records){

        Schema.SobjectType objType;
        SObject recordToUpdate;
        String objName;
        List<Id> successIds = new List<Id>();
        if(!records.isEmpty()){
            objType = records[0].recordId?.getSobjectType();
            objName = objType?.getDescribe()?.getName();
            for( Customer_Fields__mdt cmdt : [SELECT Customer_Status__r.QualifiedAPIName,Customer_Reservation_Status_Value__c
                    FROM Customer_Fields__mdt
                    WHERE Sobject_Type__r.QualifiedAPIName = :objName
                    WITH SECURITY_ENFORCED LIMIT 1]){
                
                recordToUpdate = objType.newSobject(records[0].recordId);
                recordToUpdate.put(cmdt.Customer_Status__r.QualifiedAPIName,cmdt.Customer_Reservation_Status_Value__c);
            }

            if(recordToUpdate!=null){
                SobjectAccessDecision decision = Security.stripInaccessible(
                    AccessType.UPDATABLE,
                    new List<SObject>{ recordToUpdate},
                    true
                );
                List<SObject> lstToUpdate = decision.getRecords();
                try{

                    update lstToUpdate;
                    successIds.add(lstToUpdate[0].Id);
                }
                catch(Exception e){
                    throw new ReservationManagerException(e.getMessage());
                }
            }            
        }

        return successIds;

    }
    
    public class Requests {
        @invocableVariable
        public Id recordId;
    }

    public class ReservationManagerException extends Exception{

    }

}