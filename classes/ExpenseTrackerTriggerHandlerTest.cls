@isTest(SeeAllData=true)
private class ExpenseTrackerTriggerHandlerTest 
{
    @isTest static void testExpenseTracker() 
    {
        Total_Expense__c t = new Total_Expense__c();
        t.name = 'RM';
        insert t;
        
        Expense__c e1 = new Expense__c();
        e1.recordtypeid = '0121C000001l9mg';
        e1.name = 't1';
        e1.expense_owner__c = 'Urvish';
        e1.expense_type__c = 'Lunch';
        e1.expense_amount__c = 400.00;
        e1.Parent_Expense__c =  t.id;
        e1.Date_of_Expense__c = date.today();
        insert e1;
        
        Expense__c e2 = new Expense__c();
        e2.recordtypeid = '0121C000001l9ml';
        e2.name = 't2';
        e2.expense_owner__c = 'Urvish';
        e2.expense_type__c = 'Lunch';
        e2.expense_amount__c = 400.00;
        e2.Parent_Expense__c =  t.id;
        e2.Share_Expense_with_Everybody__c = 'Yes';
        e2.Date_of_Expense__c = date.today();
        insert e2;
        
        Expense__c e3 = new Expense__c();
        e3.recordtypeid = '0121C000001l9mq';
        e3.name = 't3';
        e3.expense_owner__c = 'Urvish';
        e3.expense_type__c = 'Lunch';
        e3.expense_amount__c = 400.00;
        e3.Parent_Expense__c =  t.id;
        e3.Date_of_Expense__c = date.today();
        e3.urvish__c = 400.00;
        insert e3;
    }
}