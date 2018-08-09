trigger ExpenseTracker on Expense__c (after insert,after update,before delete) 
{   
    if(trigger.isAfter && trigger.isInsert)
    {
        for(Expense__c exp : trigger.new)
        {
                if(exp.recordtypeid=='0126A000000BERS')
                {
                    ExpenseTrackerTriggerHandler ob = new ExpenseTrackerTriggerHandler();
                    ob.personalExpense(trigger.new);
                }
                else if(exp.recordtypeid=='0126A000000BERQ')
                {
                    ExpenseTrackerTriggerHandler ob = new ExpenseTrackerTriggerHandler();
                    ob.sharedEqualExpense(trigger.new);
                }
                else if(exp.recordtypeid=='0126A000000BERR')
                {
                    ExpenseTrackerTriggerHandler ob = new ExpenseTrackerTriggerHandler();
                    ob.sharedUnEqualExpense(trigger.new);
                }
        }
    }
    
    if(checkRecursive.runOnce())
    {
        if(trigger.isAfter && trigger.isUpdate)
        {
            for(Integer i=0; i<trigger.new.size(); i++)
            {
                    if(trigger.new[i].recordtypeid=='0126A000000BERS')
                    {
                        ExpenseTrackerTriggerHandler ob = new ExpenseTrackerTriggerHandler();
                        ob.personalExpenseUpdate(trigger.new[i]);
                    }
                    else if(trigger.new[i].recordtypeid=='0126A000000BERQ')
                    {
                        Decimal oldAmount = trigger.old[i].expense_amount__c;
                        ExpenseTrackerTriggerHandler ob = new ExpenseTrackerTriggerHandler();
                        ob.sharedEqualExpenseUpdate(trigger.new[i],oldAmount);
                    }
                    else if(trigger.new[i].recordtypeid=='0126A000000BERR')
                    {
                        Decimal oldAmount = trigger.old[i].expense_amount__c;
                        ExpenseTrackerTriggerHandler ob = new ExpenseTrackerTriggerHandler();
                        ob.sharedUnEqualExpenseUpdate(trigger.new[i],oldAmount);
                    }
            }
        }
    }
}