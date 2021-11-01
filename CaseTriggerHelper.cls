public with sharing class CaseTriggerHelper {

    public Static void sendMail(List<Case> cases){
        
        // Get the current userid
        Id cUID = UserInfo.getUserId();

        // Checking for the Bypass custom settings        
        if(Bypass_Setting__c.getInstance(cUID).Bypass_Automation__c){

             // Just save the record and do nothing
             System.debug('Bypass automation and save the case record');

        } else {

                  // Query on email template object. If your template name is different, please update the template name in the line below
            EmailTemplate eMailTemp =[SELECT Id FROM EmailTemplate WHERE name='Support: High Priority Case Created'];
       
            // List of emails
            List<Messaging.SingleEmailMessage> eMails = new List<Messaging.SingleEmailMessage>();

            for(case c : cases){

                // Initialize messaging method
                Messaging.SingleEmailMessage singleMail = Messaging.renderStoredEmailTemplate(eMailTemp.Id, cUID, c.Id);
                
                // Set object Id to User
                singleMail.setTargetObjectId(cUID);
                   
                // Set inserting activity history to false
                singleMail.setSaveAsActivity(false);

                // Add mail
                eMails.add(singleMail);
    
          }
            
          // Send emails
          Messaging.sendEmail(eMails);

        }
    }   
}
