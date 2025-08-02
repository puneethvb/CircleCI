import { LightningElement, api } from 'lwc';
import {FlowNavigationNextEvent} from 'lightning/flowSupport';

export default class ReservationHelperForm extends LightningElement {

    @api customerid;
    @api objecttype;
    currentState;
    @api 
    get state(){
        return this.currentState;
    }

    set state(value){
        this.currentState = value;
    }

    _endDays = 7;
    _numberOfPeople = 20;

    @api
    get startDate(){
        return this._startDate;
    }
    @api
    get endDays() {
        return this._endDays;
    }

    @api
    get numberOfPeople() {
        return this._numberOfPeople;
    }

    @api
    get requestedMarket() {
        return this._requestedMarket;
    }

    handleCustomerUpdate(event){
        if(this.currentState !== event.detail ){
            this.currentState = event.detail;
        }

    }

    handleDraftReservation(){
        const nextBtn = new FlowNavigationNextEvent();
        this.dispatchEvent(nextBtn);
    }

}