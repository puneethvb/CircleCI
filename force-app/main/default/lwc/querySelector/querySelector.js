import { LightningElement } from 'lwc';

export default class QuerySelector extends LightningElement {
    users = ['Puneeth','Divya','Kalyani','Janaki'];
    handleClick1(){
        const elem = this.template.querySelector('p');
        elem.style.border = "1px solid red";
        console.log(elem.innerText);
        const elem1 = this.template.querySelectorAll('.name');
        Array.from(elem1).forEach(item=>{
            item.setAttribute("title",item.innerText);
            console.log(item.innerText);
        })

        const elem2 = this.template.querySelector('.child');
        elem2.innerHTML = '<p>I am the child</p>';
    }
}