public with sharing class SampleMethodsClass {
    
    public static String swapNumbers(Integer x, Integer y){

        x = x+y;

        y=x-y;

        x = x-y;

        return 'x='+x+' y='+y;


    }
}