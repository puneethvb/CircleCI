import { LightningElement, api } from 'lwc';
import getCustFields from '@salesforce/apex/CustomerServices.getCustomerFields';
const STATE_FIELD_LABEL = 'State';
export default class CustomerDetailForm extends LightningElement {

    @api recordId;
    @api sobjecttype;
    errorMsg;
    detailFields;
    msgForUser;

    connectedCallback(){

        this.getDetailFields();

    }

    getDetailFields(){

        if(this.sobjecttype){

            getCustFields({objectType: this.sobjecttype})
                .then((result)=>{
                    this.detailFields = Object.values(result);
                })
                .catch((error)=>{
                    this.errorMsg = error;
                    this.msgForUser = 'Something went wrong';
                });
        }

    }

    handleSavedRecord(event){
        let stateVal;
        for(let value in event.detail.fields){
            if(value.includes(STATE_FIELD_LABEL)){
                stateVal = event.detail.fields[value].value;
            }
        }
        const saveEvt = new CustomEvent('customerupdate',{detail : stateVal});
        this.dispatchEvent(saveEvt);
    }

    handleDraft(){
        const draftEvt = new CustomEvent('draftreservation');
        this.dispatchEvent(draftEvt);
    }
}