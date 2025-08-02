public with sharing class JSONTest {
    

    public static void createJSOnString(){
        JSONGenerator jsonBuilder = JSON.createGenerator(false);
		jsonBuilder.writeStartObject();
        jsonBuilder.writeStringField('Title','CST00381299_TestDocument');
        jsonBuilder.writeStringField('PathOnClient','C:\\NissanApi\\CST00381299_TestDocument.pdf');
        jsonBuilder.writeStringField('firstPublishLocationId','5002I00002FC7DNQA1');
        jsonBuilder.writeEndObject();
		system.debug('jsonBuilder:'+jsonBuilder.getAsString());
    }
}