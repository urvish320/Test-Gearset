public class TotalAssestTriggerHandler
{
    public static void noOfAssets(List<Asset> assets)
    {
        List<Account> accounts = new List<Account>();
        Set<Id> accountIds = new Set<Id>();
        Map<Id,List<Asset>> mapAccountToAsset = new Map<Id,List<Asset>>();
        
        //Get account ids associated with Assets inserted and create a map of Account => List of Assets
        for(Asset a : assets)
        {
            accountIds.add(a.AccountId);
            if(mapAccountToAsset.containsKey(a.accountId))
            {
               mapAccountToAsset.get(a.accountId).add(a); 
            }
            else
            {
                mapAccountToAsset.put(a.accountId,new List<Asset>{a});
            }
            
        }
        
        //Update all the accounts' no of assets field with the size of the list associated with that account id in a map
        for(Account a : [select id,No_of_assets__c from Account where Id IN: accountIds])
        {
            if(a.No_of_assets__c == null)
            {
               a.No_of_assets__c = 0; 
            }
            a.No_of_assets__c += mapAccountToAsset.get(a.id).size();
            accounts.add(a);
        }
        
        update accounts;
    }
}