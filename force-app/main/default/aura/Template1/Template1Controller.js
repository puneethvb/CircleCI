({
    toggleState : function(component, event, helper) {

        let collapsed = component.get('v.collapsedView');
        component.set('v.collapsedView',!collapsed);
        let leftCol = component.find('leftCol');
        let rightCol = component.find('rightCol');
        $A.util.toggleClass(leftCol,'collapsed');
        $A.util.toggleClass(leftCol,'expanded');
        $A.util.toggleClass(rightCol,'slds-size--12-of-12');
        console.log(leftCol);
        console.log(rightCol);
    }
})