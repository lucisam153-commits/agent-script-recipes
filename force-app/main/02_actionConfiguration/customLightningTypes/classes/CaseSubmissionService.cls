/**
 * @description Service for submitting support cases via Custom Lightning Types.
 * Uses top-level CaseInput and CaseResult classes as CLT data shapes
 * so that Lightning Type Bundles can resolve them in a single deploy.
 */
public with sharing class CaseSubmissionService {
    /**
     * @description Invocable request wrapper — field names must match AgentScript action input names
     */
    public class SubmitCaseRequest {
        @InvocableVariable(required=true)
        public CaseInput case_data;
    }

    /**
     * @description Invocable response wrapper — field names must match AgentScript action output names
     */
    public class SubmitCaseResponse {
        @InvocableVariable
        public CaseResult case_result;

        @InvocableVariable
        public String case_number;
    }

    /**
     * @description Submits a support case and returns the created case details.
     * This is a mock implementation that generates a case number without performing DML,
     * making it safe for demonstration purposes.
     * @param requests List of SubmitCaseRequest objects
     * @return List of SubmitCaseResponse objects with case details
     */
    @InvocableMethod(label='Submit Case' description='Submits a support case')
    public static List<SubmitCaseResponse> submitCase(
        List<SubmitCaseRequest> requests
    ) {
        List<SubmitCaseResponse> responses = new List<SubmitCaseResponse>();

        for (SubmitCaseRequest req : requests) {
            CaseInput input = req.case_data;

            // Generate a mock case number
            String caseNumber =
                'CS-' +
                String.valueOf(Math.round(Math.random() * 900000 + 100000));

            // Build the result object
            CaseResult result = new CaseResult();
            result.caseNumber = caseNumber;
            result.subject = input.subject;
            result.priority = String.isNotBlank(input.priority)
                ? input.priority
                : 'Medium';
            result.category = String.isNotBlank(input.category)
                ? input.category
                : 'General';
            result.description = input.description;
            result.status = 'New';
            result.createdDate = Datetime.now().format('MMMM d, yyyy');
            result.estimatedResponse = getEstimatedResponse(result.priority);

            // Build the response
            SubmitCaseResponse response = new SubmitCaseResponse();
            response.case_result = result;
            response.case_number = caseNumber;
            responses.add(response);
        }

        return responses;
    }

    /**
     * @description Returns an estimated response time based on priority
     * @param priority The case priority level
     * @return Estimated response time string
     */
    private static String getEstimatedResponse(String priority) {
        switch on priority {
            when 'Critical' {
                return 'Within 1 hour';
            }
            when 'High' {
                return 'Within 4 hours';
            }
            when 'Medium' {
                return 'Within 24 hours';
            }
            when 'Low' {
                return 'Within 48 hours';
            }
            when else {
                return 'Within 24 hours';
            }
        }
    }
}
