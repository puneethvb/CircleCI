({
    invoke : function(component, event, helper) {

        let recordId = component.get('v.recordId');
        let sobject = component.get('v.sobject');
        let workSpaceApi = component.find('workspace');

        workSpaceApi
            .openTab({
                url : 'lightning/r/' +sobject+'/' + recordId + '/view'
            })

            .then(function(response){
                workSpaceApi.focusTab({tabId : response});
                workSpaceApi.refreshTab({tabId : response, inincludeAllSubtabs: false});
            })

            .catch(function(error){
                console.log(error);
            })


    }
})