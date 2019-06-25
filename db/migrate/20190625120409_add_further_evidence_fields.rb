class AddFurtherEvidenceFields < ActiveRecord::Migration[5.2]
  def change
    add_column :evidence, :physical_original_check, :string
    add_column :evidence, :physical_errors_check, :string
    add_column :evidence, :digital_tool_used, :string
    add_column :evidence, :digital_tool_follows_standard, :string
    add_column :evidence, :checker_trained, :string
    add_column :evidence, :checker_training_frequency, :string
    add_column :evidence, :official_templates_used, :string
    add_column :evidence, :official_templates_update_frequency, :string
    add_column :evidence, :expiry_check, :string
    add_column :evidence, :replay_attack_check, :string
    add_column :evidence, :visible_features_check, :string
    add_column :evidence, :visible_tamper_check, :string
    add_column :evidence, :visible_features, :json
    add_column :evidence, :visible_features_consistency, :string
    add_column :evidence, :visible_features_equipment, :json
    add_column :evidence, :visible_features_controlled_conditions, :string
    add_column :evidence, :visible_features_supervision, :string
    add_column :evidence, :uv_ir_features_check, :string
    add_column :evidence, :uv_ir_features, :string
    add_column :evidence, :crypto_features, :json
  end
end
