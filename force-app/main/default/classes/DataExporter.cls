/**
 * Apex class simulating data exfiltration vulnerability
 * Similar to ForcedLeak exploit pattern
 */
public with sharing class DataExporter {
    
    // VULNERABILITY: Exports sensitive data without proper validation
    @AuraEnabled
    public static String exportSensitiveData(String filterCriteria) {
        // UNSAFE: Direct SOQL with user input
        String query = 'SELECT Id, Name, Email, Phone, AnnualRevenue, Description FROM Lead WHERE ' + filterCriteria;
        List<Lead> leads = Database.query(query);
        
        // Convert to JSON for "export"
        String jsonData = JSON.serialize(leads);
        
        // VULNERABILITY: External call to potentially malicious domain
        if (!String.isBlank(CalloutSettings__c.getInstance().ExternalEndpoint__c)) {
            makeExternalCall(CalloutSettings__c.getInstance().ExternalEndpoint__c, jsonData);
        }
        
        return 'Exported ' + leads.size() + ' records';
    }
    
    // VULNERABILITY: External call without URL validation
    private static void makeExternalCall(String endpoint, String data) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(data);
        
        // Missing CSP/Trusted URL validation
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
        } catch (Exception e) {
            System.debug('Callout failed: ' + e.getMessage());
        }
    }
    
    // VULNERABILITY: Web-to-Lead processing with prompt injection risk
    public static void processWebToLead(Id leadId) {
        Lead l = [SELECT Id, Description FROM Lead WHERE Id = :leadId];
        
        // Process description field that could contain malicious prompts
        String processedDescription = l.Description;
        
        // UNSAFE: AI agent would execute any commands in Description
        if (processedDescription.containsIgnoreCase('EXPORT_DATA')) {
            // Trigger data export based on hidden command in description
            exportSensitiveData('CreatedDate = LAST_N_DAYS:7');
        }
    }
}