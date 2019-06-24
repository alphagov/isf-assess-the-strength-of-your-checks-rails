class CreateEvidences < ActiveRecord::Migration[5.2]
  def change
    create_table :evidence do |t|
      t.string :evidence_type
      t.string :evidence_type_other
      t.string :physical_check
      t.string :physical_original_check
      t.string :physical_errors_check
      t.string :digital_tool_used
      t.string :digital_tool_follows_standard
      t.string :checker_trained
      t.string :checker_training_frequency
      t.string :official_templates_used
      t.string :official_templates_update_frequency
      t.string :expiry_check
      t.string :replay_attack_check
      t.string :visible_features_check
      t.string :visible_tamper_check
      t.json :visible_features
      t.string :visible_features_consistency
      t.json :visible_features_equipment
      t.string :visible_features_controlled_conditions
      t.string :visible_features_supervision
      t.string :uv_ir_features_check
      t.string :uv_ir_features
      t.string :crypto_check
      t.json :crypto_features
      t.string :authoritative_source_check
      t.string :cancellation_check
      t.belongs_to :assessment, index: true
      t.timestamps
    end
  end
end
