class AddCompletenessFields < ActiveRecord::Migration[5.2]
  def change
    add_column :evidence, :is_complete, :boolean, null: false, default: false
    add_column :assessments, :activity_section_is_complete, :boolean, null: false, default: false
    add_column :assessments, :fraud_section_is_complete, :boolean, null: false, default: false
    add_column :assessments, :verification_section_is_complete, :boolean, null: false, default: false
  end
end
