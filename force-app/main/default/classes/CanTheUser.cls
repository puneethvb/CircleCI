/*
    Generic Class to check CRUD and FLS
*/

public with sharing class CanTheUser {
    
    @testVisible
    private static Map<String,Set<String>> readableFieldsByObject = new Map<String,Set<String>>();
    @testVisible
    private static Map<String,Set<String>> updateableFieldsByObject = new Map<String,Set<String>>();

    public class CanTheUserException extends Exception{

    }

    public enum CrudType {

        CREATE,
        READ,
        EDIT,
        DEL,
        UPS        
    }

    public enum FLSType {

        ACCESSIBLE,
        UPDATEABLE        
    }

    //To Check CRUD when SObject is passed.
    public static Boolean crud(SObject obj, CrudType permission){
        switch on permission {

            when CREATE {

                return obj.getSObjectType().getDescribe().isCreateable();
                
            }

            when READ {

                return obj.getSObjectType().getDescribe().isAccessible();
                
            }

            when EDIT {

                return obj.getSObjectType().getDescribe().isUpdateable();

            }

            when DEL{

                return obj.getSObjectType().getDescribe().isDeletable();
            }

        }

        return false;
    }

    //CRUD from SObjects List
    public static Boolean crud(List<SObject> objects , CrudType permission){
        
        return (objects != null && !objects.isEmpty()) ? crud(objects[0],permission) : false;
    }

    //CRUD From SOBJECT Name

    public static Boolean crud(String objName, CrudType permission){
        Type t = Type.forName(objName);
        //SObject obj = (SObject)JSON.deserialize('{}',t);
        SObject obj = (SObject)t.newInstance();
        return crud(obj,permission);
    }

    public static Boolean create(SObject obj){
        return crud(obj,CrudType.CREATE);
    }

    public static Boolean create(List<SObject> objects){
        return crud(objects,CrudType.CREATE);
    }

    public static Boolean create(String objName){
        return crud(objName,CrudType.CREATE);
    }

    public static Boolean read(SObject obj){
        return crud(obj,CrudType.READ);
    }

    public static Boolean read(List<SObject> objects){
        return crud(objects,CrudType.READ);
    }

    public static Boolean read(String objName){
        return crud(objName,CrudType.READ);
    }

    //edit
    public static Boolean edit(SObject obj){
        return crud(obj,CrudType.EDIT);
    }

    public static Boolean edit(List<SObject> objects){
        return crud(objects,CrudType.EDIT);
    }

    public static Boolean edit(String objName){
        return crud(objName,CrudType.EDIT);
    }

    //Del
    
    public static Boolean destroy(SObject obj){
        return crud(obj,CrudType.DEL);
    }

    public static Boolean destroy(List<SObject> objects){
        return crud(objects,CrudType.DEL);
    }

    public static Boolean destroy(String objName){
        return crud(objName,CrudType.DEL);
    }

    //Pass object name and get fields List and whether updateable/Accessible

    public static Map<String,Map<FLSType,Boolean>> calculateFLS(String objName){

        //Get ObjectDescribeResult
        List<Schema.DescribeSObjectResult> descRes = Schema.describeSObjects(new List<String>{objName});
        Map<String,Map<FLSType,Boolean>> result = new Map<String,Map<FLSType,Boolean>>();
        for(SObjectField field : descRes[0].fields.getMap().values()){
            DescribeFieldResult fieldDetails = field.getDescribe();
            String fieldKey = String.valueOf(field).toLowerCase();
            result.put(fieldKey, new Map<FLSType,Boolean>());
            result.get(fieldKey).put(FLSType.ACCESSIBLE,fieldDetails.isAccessible());
            result.get(fieldKey).put(FLSType.UPDATEABLE,fieldDetails.isUpdateable());
        }
        return result;
    }

    public static Boolean getFLSForFieldOnObject(String objName, String fieldName, FLSType checkType){

        Map<String,Map<FLSType,Boolean>> result = calculateFLS(objName);
        Boolean returnVal = result.get(fieldName.toLowerCase())?.get(checkType);
        return (returnVal!=null && returnVal) ? true : false;

    }

    public static Boolean isFieldAccessible(String objName, String fieldName){
        return getFLSForFieldOnObject(objName,fieldName,FLSType.ACCESSIBLE);
    }

    public static Map<String,Boolean> isFieldAccessible(String objName, Set<String> fieldNames){

        Map<String,Boolean> results = new Map<String,Boolean>();
        for(String fieldName : fieldNames){
            Boolean res = isFieldAccessible(objName,fieldName);
            results.put(fieldName,res);
        }

        return results;       
    }

    public static Boolean isFieldupdateble(String objName, String fieldName){
        return getFLSForFieldOnObject(objName,fieldName,FLSType.UPDATEABLE);
    }

    public static Map<String,Boolean> isFieldupdateble(String objName, Set<String> fieldNames){

        Map<String,Boolean> results = new Map<String,Boolean>();
        for(String fieldName : fieldNames){
            Boolean res = isFieldupdateble(objName,fieldName);
            results.put(fieldName,res);
        }

        return results;       
    }

}