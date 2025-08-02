import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class RecordForm extends LightningElement {
    @api recordId;
    @api objectApiName;
    
    fields=[NAME_FIELD, REVENUE_FIELD, INDUSTRY_FIELD];
    handleSubmit(event){
        
        event.preventDefault();
        const field1 = event.detail.fields;
        console.log('fields',field1.AnnualRevenue);
        if(!field1.AnnualRevenue){
            console.log('inside if');
            const showToast = new ShowToastEvent({
                title : "Value Missing",
                message : "Value Missing",
                variant : "error",
                mode : "stiky"
            });
    
        this.dispatchEvent(showToast);

        }

        else{
            
                this.template.querySelector('lightning-record-form').submit(field1);
              
        }

    }

}