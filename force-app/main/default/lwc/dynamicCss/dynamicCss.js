import { LightningElement } from 'lwc';

export default class DynamicCss extends LightningElement {

    

    percentage = 10;

    changeHandler(event){
        this.percentage = event.target.value;
    }

    get percent(){
        return `width:${this.percentage}%`;
    }
}