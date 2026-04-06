/**
 * Intentionally vulnerable Apex class with multiple security issues
 * that SquireX should detect
 */
public with sharing class DangerousApexController {
    
    // VULNERABILITY 4: SOQL Injection vulnerability
    public static List<Account> searchAccounts(String searchTerm) {
        // UNSAFE: Direct string concatenation
        String query = 'SELECT Id, Name, AnnualRevenue FROM Account WHERE Name LIKE \'%' + searchTerm + '%\'';
        return Database.query(query);
    }
    
    // VULNERABILITY 5: System mode without sharing
    @AuraEnabled
    public static void updateAllRecords(String newValue) {
        // No sharing enforcement - runs in system context
        List<Account> allAccounts = [SELECT Id FROM Account LIMIT 1000];
        for(Account acc : allAccounts) {
            acc.Description = newValue;
        }
        update allAccounts;
    }
    
    // VULNERABILITY 6: Dynamic DML with user input
    public static void createRecordFromJSON(String jsonInput) {
        // UNSAFE: Deserializing untrusted JSON
        Map<String, Object> inputMap = (Map<String, Object>)JSON.deserializeUntyped(jsonInput);
        
        Account newAcc = new Account();
        newAcc.Name = (String)inputMap.get('name');
        newAcc.Industry = (String)inputMap.get('industry');
        
        // No validation or sanitization
        insert newAcc;
    }
    
    // VULNERABILITY 7: HTTP callout with dynamic URL
    public static void callExternalAPI(String endpoint) {
        HttpRequest req = new HttpRequest();
        // UNSAFE: User-controlled endpoint
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
    }
}