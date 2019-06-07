require 'rails_helper'

# probably mostly testing error cases here – successful flows have system tests?

describe EvidenceQuestionsController, type: :controller do
  describe "POST choose_evidence" do
    it "shows errors if nothing posted" do
      post :choose_evidence, params: { assessment_id: 'some-assessment-id', evidence_id: 'new' }
      expect(assigns(:errors)).not_to be_empty
    end
  end
end
