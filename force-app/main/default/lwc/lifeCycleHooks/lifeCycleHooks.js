import { LightningElement, wire } from 'lwc';
import getCmdtRecords from '@salesforce/apex/FetchCMDTRec.getCMDTRecords';


export default class LifeCycleHooks extends LightningElement {
    cmdtRecords;
    constructor(){
        super();
        console.log('Constructor called');
        getCmdtRecords()
            .then(result => {
                this.cmdtRecords = result;
                console.log('Data fetched successfully');
            }
            )
            .catch(error => {
                console.error('Error fetching data', error);
            }); 

    }

}