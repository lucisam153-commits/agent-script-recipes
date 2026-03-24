/**
 * @description Data shape for CLT output — referenced by caseResult/schema.json.
 * Fields map to the caseResultRenderer LWC display fields.
 */
public class CaseResult {
    @InvocableVariable(label='Case Number')
    public String caseNumber;

    @InvocableVariable(label='Subject')
    public String subject;

    @InvocableVariable(label='Priority')
    public String priority;

    @InvocableVariable(label='Category')
    public String category;

    @InvocableVariable(label='Description')
    public String description;

    @InvocableVariable(label='Status')
    public String status;

    @InvocableVariable(label='Created Date')
    public String createdDate;

    @InvocableVariable(label='Estimated Response')
    public String estimatedResponse;
}
