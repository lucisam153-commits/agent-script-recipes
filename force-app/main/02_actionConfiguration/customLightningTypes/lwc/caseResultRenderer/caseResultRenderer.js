import { LightningElement, api } from 'lwc';

export default class CaseResultRenderer extends LightningElement {
    @api value;

    caseNumber;
    subject;
    priority;
    category;
    description;
    status;
    createdDate;
    estimatedResponse;

    connectedCallback() {
        if (this.value) {
            this.caseNumber = this.value.caseNumber || '';
            this.subject = this.value.subject || '';
            this.priority = this.value.priority || '';
            this.category = this.value.category || '';
            this.description = this.value.description || '';
            this.status = this.value.status || '';
            this.createdDate = this.value.createdDate || '';
            this.estimatedResponse = this.value.estimatedResponse || '';
        }
    }

    get priorityClass() {
        switch (this.priority) {
            case 'Critical':
                return 'slds-theme_error';
            case 'High':
                return 'slds-theme_warning';
            case 'Medium':
                return 'slds-theme_info';
            case 'Low':
                return 'slds-theme_success';
            default:
                return '';
        }
    }
}
