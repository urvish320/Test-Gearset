public class ExpenseTrackerTriggerHandler
{
    Map<string,string> ownerToApi = new Map<string,string>{'Urvish'=>'urvish__c','Rutvi'=>'rutvi__c','Arpit'=>'arpit__c',
                                                          'Palak'=>'palak__c','Purav'=>'purav__c','Krutarth'=>'krutarth__c',
                                                          'Harsh'=>'harsh__c','Tirth'=>'tirth__c','Nirali'=>'nirali__c'};
                                                          
    List<Expense__c> updateExpense = new List<Expense__c>();
    
    public void personalExpense(List<Expense__c> expenses)
    {
        List<Expense__c> updateExpenses = [select Who_do_you_share_this_expense_with__c ,expense_owner__c,Expense_amount__c,id,urvish__c,rutvi__c,arpit__c,palak__c,purav__c,krutarth__c,harsh__c,tirth__c
                                          from Expense__c
                                          where Id IN: expenses];
                                          
        
        if(!updateExpenses.isEmpty())
        {
            for(Expense__c exp : updateExpenses)
            {
                System.debug('In1-->>');
                String apiName = ownerToApi.get(exp.expense_owner__c);
                System.debug('In1-->>'+apiName+exp.Expense_amount__c);
                exp.put(apiName,exp.Expense_amount__c);
                System.debug('In1-->>'+exp);
                updateExpense.add(exp);
            }
        }
        System.debug('In2-->>'+updateExpense);
        update updateExpense;
    }
    
    public void sharedEqualExpense(List<Expense__c> expenses)
    {
        List<Expense__c> updateExpenses = [select Who_do_you_share_this_expense_with__c,Expense_type__c,expense_owner__c,Share_Expense_with_Everybody__c,Expense_amount__c,id,urvish__c,rutvi__c,arpit__c,palak__c,purav__c,krutarth__c,harsh__c,tirth__c
                                          from Expense__c
                                          where Id IN: expenses];
                                          
        
        if(!updateExpenses.isEmpty())
        {
            for(Expense__c exp : updateExpenses)
            {
                if(exp.Share_Expense_with_Everybody__c=='Yes')
                {
                    Decimal amount = exp.Expense_amount__c/9;
                    for(String key : ownerToApi.keySet())
                    {
                        String apiName = ownerToApi.get(key);
                        exp.put(apiName,amount);
                    }
                }
                if(exp.Share_Expense_with_Everybody__c=='No')
                {
                    List<String> includedPeople = exp.Who_do_you_share_this_expense_with__c.split(';');
                    Integer countOfPeople = includedPeople.size();
                    Decimal amount = exp.Expense_amount__c/countOfPeople;
                    
                    for(String key : ownerToApi.keySet())
                    {
                        if(includedPeople.contains(key))
                        {
                            String apiName = ownerToApi.get(key);
                            exp.put(apiName,amount);
                        }
                    }
                }
                updateExpense.add(exp);
            }
        }
        update updateExpense;
    }
    
    public void sharedUnEqualExpense(List<Expense__c> expenses)
    {
        List<Expense__c> updateExpenses = [select Who_do_you_share_this_expense_with__c,Expense_type__c,expense_owner__c,Expense_amount__c,id,urvish__c,rutvi__c,arpit__c,palak__c,purav__c,krutarth__c,harsh__c,tirth__c,nirali__c
                                          from Expense__c
                                          where Id IN: expenses];
                                         
        if(!updateExpenses.isEmpty())
        {
            for(Expense__c exp : updateExpenses)
            {
                for(String key : ownerToApi.keySet())
                {
                    String apiName = ownerToApi.get(key);
                    if(exp.get(apiName)==null)
                    {
                        exp.put(apiName,0.00);
                    }
                }
                updateExpense.add(exp);
            }
        }
        
        update updateExpense;
    }
    
    //Update Expense
    public void personalExpenseUpdate(Expense__c expenses)
    {
        List<Expense__c> updateExpenses = [select Who_do_you_share_this_expense_with__c ,expense_owner__c,Expense_amount__c,id,urvish__c,rutvi__c,arpit__c,palak__c,purav__c,krutarth__c,harsh__c,tirth__c,nirali__c
                                          from Expense__c
                                          where Id=:expenses.id];
                                          
        
        if(!updateExpenses.isEmpty())
        {
            for(Expense__c exp : updateExpenses)
            {
                String apiName = ownerToApi.get(exp.expense_owner__c);
                for(String key : ownerToApi.keySet())
                {
                    if(exp.expense_owner__c==key)
                    {
                        exp.put(apiName,exp.Expense_amount__c);
                    }
                    else
                    {
                        System.debug('Bug-->>');
                        String api = ownerToApi.get(key);
                        exp.put(api,0.00);
                    }
                }
                updateExpense.add(exp);
            }
        }
        
        update updateExpense;
    }
    
    public void sharedEqualExpenseUpdate(Expense__c expenses,Decimal oldAmount)
    {
        List<Expense__c> updateExpenses = [select Who_do_you_share_this_expense_with__c,Expense_type__c,expense_owner__c,Share_Expense_with_Everybody__c,Expense_amount__c,id,urvish__c,rutvi__c,arpit__c,palak__c,purav__c,krutarth__c,harsh__c,tirth__c,nirali__c
                                          from Expense__c
                                          where Id=:expenses.id];
                                          
                                         
        if(!updateExpenses.isEmpty())
        {
            for(Expense__c exp : updateExpenses)
            {
                if(exp.Share_Expense_with_Everybody__c=='Yes')
                {
                    Decimal amount = exp.Expense_amount__c/9;
                    for(String key : ownerToApi.keySet())
                    {
                        String apiName = ownerToApi.get(key);
                        exp.put(apiName,amount);
                    }
                }
                if(exp.Share_Expense_with_Everybody__c=='No')
                {
                    List<String> includedPeople = exp.Who_do_you_share_this_expense_with__c.split(';');
                    Integer countOfPeople = includedPeople.size();
                    Decimal amount = exp.Expense_amount__c/countOfPeople;
                    
                    for(String key : ownerToApi.keySet())
                    {
                        if(includedPeople.contains(key))
                        {
                            String apiName = ownerToApi.get(key);
                            exp.put(apiName,amount);
                        }
                        else
                        {
                            String apiName = ownerToApi.get(key);
                            exp.put(apiName,0.00);
                        }
                    }
                }
                updateExpense.add(exp);
            }
        }
        update updateExpense;
    }
    
    public void sharedUnEqualExpenseUpdate(Expense__c expenses,Decimal oldAmount)
    {
        List<Expense__c> updateExpenses = [select Who_do_you_share_this_expense_with__c,Expense_type__c,expense_owner__c,Expense_amount__c,id,urvish__c,rutvi__c,arpit__c,palak__c,purav__c,krutarth__c,harsh__c,tirth__c,nirali__c
                                          from Expense__c
                                          where Id=:expenses.id];
        
        
        if(!updateExpenses.isEmpty())
        {
            for(Expense__c exp : updateExpenses)
            {
                for(String key : ownerToApi.keySet())
                {
                    String apiName = ownerToApi.get(key);
                    if(exp.get(apiName)==null)
                    {
                        exp.put(apiName,0.00);
                    }
                }
                updateExpense.add(exp);
            }
        }
        
        update updateExpense;
    }
}