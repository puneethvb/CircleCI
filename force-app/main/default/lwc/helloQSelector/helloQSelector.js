import { LightningElement } from 'lwc';

export default class HelloQSelector extends LightningElement {
    userNames = ["hdjhjdf","kjksjks","ksdjkjdskd"];
    fetchDetails(){
        const elem = this.template.querySelector('h1');
        elem.style = "color:red";
        console.log(elem.innerText);
        const allElem = this.template.querySelectorAll('.nameC');
        Array.from(allElem).forEach(item=>{
            item.setAttribute("title",item.innerText);
            console.log(item.innerText);
        })
    }
}