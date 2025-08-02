import { LightningElement } from 'lwc';
import modal from "@salesforce/resourceUrl/custommodal";
import { loadStyle } from "lightning/platformResourceLoader";

export default class LwcAction123 extends LightningElement {
    renderedCallback() {
        
        Promise.all([
            loadStyle( this, modal)
            ]).then(() => {
                console.log( 'Files loaded' );
            })
            .catch(error => {
                console.log( error.body.message );
        });

    }
}