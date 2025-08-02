import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {

    selected = {};
    myQuestions = [
        { id : '1.', question : 'Which club has won the most number of champions leagues?', options : {a:'Real Madrid',b:'Liverpool FC',c:'Bayern Munich', answer :"a"}},
        { id : '2.', question : 'Which club has won the most number of English league titles?', options : {a:'Man United',b:'Liverpool FC',c:'Arsenel', answer :"b"}},
        { id : '3.', question : 'Which club has won the most number of english league cups?', options : {a:'Real Madrid',b:'Liverpool FC',c:'Arsenel', answer :"b"}}
    ];
    correctAnswers = 0;
    isSubmitted = false;

    get allAnswersNotSelected(){
        return !(Object.keys(this.selected).length === Object.keys(this.myQuestions).length);
    }

    get whatIsTheScore(){
        return `slds-text-heading_large ${this.myQuestions.length=== this.correctAnswers ? 'slds-text-color_success' :'slds-text-color_error'}`;
    }
    changeHandler(event){
        const{name,value} = event.target;
        console.log(name,value);
        this.selected = {...this.selected,[name]:value};
    }

    handleSubmit(event){

        event.preventDefault();
        let correct = this.myQuestions.filter((item=>{
            return this.selected[item.id]=== item.options.answer;
        })) 
        this.isSubmitted = true;
        this.correctAnswers = correct.length;
        console.log(this.correctAnswers);
    }

    handleReset(){
        this.selected ={};
        this.correctAnswers = 0;
        this.isSubmitted = false;

    }
}