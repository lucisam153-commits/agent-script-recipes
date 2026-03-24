/**
 * @description Data shape for CLT input — referenced by caseInput/schema.json.
 * Fields map to the caseInputEditor LWC form fields.
 */
public class CaseInput {
    @InvocableVariable(label='Subject' description='Case subject' required=true)
    public String subject;

    @InvocableVariable(label='Priority' description='Case priority')
    public String priority;

    @InvocableVariable(label='Category' description='Case category')
    public String category;

    @InvocableVariable(label='Description' description='Case description')
    public String description;
}
