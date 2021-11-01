trigger CaseTrigger on Case (after insert) {

    if(Trigger.isAfter){
      
        if(Trigger.isInsert){
        
          // Helper class for checking Automation Bypass
          CaseTriggerHelper.sendMail(trigger.new);
        
        }
    }
}
