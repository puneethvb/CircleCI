import { LightningElement,api,wire } from 'lwc';
import getCustomerList from '@salesforce/apex/ReservationManagerController.getCustomerList';
import TILE_SELECT_MC from "@salesforce/messageChannel/Tile_Selection__c";
import FLOW_STATUS_CHANGE_MC from '@salesforce/messageChannel/Flow_Status_Change__c';
import { MessageContext, publish,subscribe,APPLICATION_SCOPE } from 'lightning/messageService';
import { refreshApex } from '@salesforce/apex';



export default class CustomerList extends LightningElement {

    customers=[];
    @api sobject;
    errorMsg;
    msgForUser;
    wiredRecords;

    @wire(MessageContext)
    messageContext;

    connectedCallback(){

    }

    subscribeToMessageChannel(){
        subscribe(
            this.messageContext,
            FLOW_STATUS_CHANGE_MC,
            (message)=> this.handleMessage(message),
            {scope : APPLICATION_SCOPE}

        );
    }

    handleMessage(message){
        if(message.flowName === 'createReservation' && 
            message.status === 'FINISHED' && message.state){
                if(message.state.sobjecttype === this.sobject){
                    refreshApex(this.wiredRecords);
                }
            } 
    }

    @wire(getCustomerList,{sobjectType:'$sobject'})
    wiredCustomers(value){
        this.wiredRecords = value;
        if(value.error){
            this.errorMsg = value.error;
            this.msgForUser = "Something went wrong";
        }
        else if(value.data){
            this.customers = value.data;
        }
    }

    publishSelect(event){
        console.log('In event');
        console.log(event.detail.customerId);
        const payload = {tileType: 'customer',properties : event.detail};
        publish(this.messageContext,TILE_SELECT_MC,payload);

    }

}