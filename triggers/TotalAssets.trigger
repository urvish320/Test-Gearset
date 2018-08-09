trigger TotalAssets on Asset (after insert) 
{
    if(trigger.isAfter && trigger.isInsert)
    {
        TotalAssestTriggerHandler.noOfAssets(trigger.new);
    }
}