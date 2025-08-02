import { LightningElement } from 'lwc';

export default class LifeCycleChild extends LightningElement {
    constructor(){
        super();
        console.log('Child constructor called');
    }

    connectedCallback(){
        console.log('Child Connected call back');
        throw new Error('Child load failed');
    }

    renderedCallback(){
        console.log('Child rendered call back');
    }
    disconnectedCallback(){
        alert('disconnected call back from child');
    }
}