class CreateAssessmentSessionAccess < ActiveRecord::Migration[5.2]
  def change
    create_table :assessment_session_access do |t|
      t.references :assessment, foreign_key: true
      t.string :session_id, null: false
    end
    add_index :assessment_session_access, :session_id
  end
end
