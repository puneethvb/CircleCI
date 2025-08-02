public inherited sharing class CustomerServices {
    
    @auraEnabled(cacheable=true)
    public static Customer getCustomerFields(String objectType) {
        Customer customer;
        for (Customer_Fields__mdt c : [
            SELECT
                Customer_Name__r.QualifiedAPIName,
                Customer_Email__r.QualifiedAPIName,
                Customer_City__r.QualifiedAPIName,
                Customer_State__r.QualifiedAPIName,
                Customer_Status__r.QualifiedAPIName
            FROM Customer_Fields__mdt
            WHERE Sobject_Type__r.QualifiedAPIName = :objectType
            WITH SECURITY_ENFORCED
        ]) {
            customer = new Customer(
                c.Customer_Name__r.QualifiedAPIName,
                c.Customer_Email__r.QualifiedAPIName,
                c.Customer_City__r.QualifiedAPIName,
                c.Customer_State__r.QualifiedAPIName,
                '',
                ''
            );
        }
        return customer;
    }

    public class Customer{

        @AuraEnabled
        public String email {get; set;}

        @AuraEnabled
        public String name {get; set;}

        @AuraEnabled
        public String city {get; set;}

        @AuraEnabled
        public String state {get; set;}

        @AuraEnabled
        public String status {get; set;}

        @AuraEnabled
        public String Id {get; set;}

        public customer(String name, String email, String status, String city, String state, String Id){

            this.name = name;
            this.email = String.isNotBlank(email)? email:this.email;
            this.state = String.isNotBlank(state)? state:this.state;
            this.status = String.isNotBlank(status)? status:this.status;
            this.city = String.isNotBlank(city)? city:this.city;
            this.Id = String.isNotBlank(Id)? Id:this.Id;

        }

    }
}