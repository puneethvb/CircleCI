import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';


export default class CustomerTile extends NavigationMixin(LightningElement) {

    @api customer;
    @api object;
    navRef;

    get icon(){
        return 'standard:'+this.object.toLowerCase();
    }

    get altText(){
        return('Navigate to '+this.object+' record detail for '+this.customer.name);
    }

    connectedCallback() {


        console.log('Connected Callback');
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId : this.customer.Id,
                actionName : 'view'
            }
        }).then(url=>{
            console.log('inside URL',url);
            this.navRef = url;
        });  
        
        console.log('navref',this.navRef);
    }

    handleClick(){

        const customerEvt = new CustomEvent('customerselect',{
            detail : {
                customerId : this.customer.Id,
                sobjectType : this.object,
                state : this.customer.state
            }
        });

        this.dispatchEvent(customerEvt);

    }
    

}