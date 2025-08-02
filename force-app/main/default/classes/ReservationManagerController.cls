public with sharing class ReservationManagerController {
    
    @AuraEnabled(cacheable=true)
    public static List<CustomerServices.Customer> getCustomerList(String sobjectType){
        List<CustomerServices.Customer> customers = new List<CustomerServices.Customer>();
        
        Customer_Fields__mdt mdt = [SELECT Customer_Name__r.QualifiedAPIName,
                                    Customer_City__r.QualifiedAPIName,
                                    Customer_Email__r.QualifiedAPIName,
                                    Customer_State__r.QualifiedAPIName,
                                    Customer_Status__r.QualifiedAPIName,
                                    Customer_Draft_Status_Values__c 
                                    FROM Customer_Fields__mdt WHERE 
                                    Sobject_Type__c = :sobjectType LIMIT 1];
        
        List<String> draftStatuses = mdt.Customer_Draft_Status_Values__c.split(',');

        String query = 'SELECT ';
        query+= mdt.Customer_Name__r.QualifiedAPIName + ',';
        query+= mdt.Customer_City__r.QualifiedAPIName + ',';
        query+= mdt.Customer_State__r.QualifiedAPIName + ',';
        query+= mdt.Customer_Status__r.QualifiedAPIName + ',';
        query+= mdt.Customer_Email__r.QualifiedAPIName+ ',';
        query+= 'Id';
        query+= ' FROM '+sobjectType;
        if(!draftStatuses.isEmpty()){
            query+= ' WHERE '+mdt.Customer_Status__r.QualifiedAPIName+' IN :draftStatuses';
        }
        query+= ' WITH SECURITY_ENFORCED ORDER BY CreatedDate DESC LIMIT 6';

        System.debug('query: '+query);

        for(SObject obj: Database.query(query)){
            CustomerServices.Customer customer = new CustomerServices.Customer(
                (String)obj.get(mdt.Customer_Name__r.QualifiedAPIName),
                (String)obj.get(mdt.Customer_Email__r.QualifiedAPIName),
                (String)obj.get(mdt.Customer_Status__r.QualifiedAPIName),
                (String)obj.get(mdt.Customer_City__r.QualifiedAPIName),
                (String)obj.get(mdt.Customer_State__r.QualifiedAPIName),
                (String)obj.get('Id')
            );

            customers.add(customer);
        }

        system.debug('customers: '+customers);

        return customers;        
    }
}