class Evidence < FormResponses
  ATTRS = %i[id evidence_type evidence_type_other
             physical_check
             check_original check_errors digital_tool_used digital_tool_follows_standard checker_trained checker_training_frequency official_templates_used official_templates_update_frequency expiry_check replay_attack_check
             visible_features_check visible_tamper_check visible_features visible_features_consistency visible_features_equipment visible_features_controlled_conditions visible_features_supervision
             uv_ir_check uv_ir_features uv_ir_tamper_check
             crypto_check crypto_features
             authoritative_source_check cancellation_check
            ].freeze
  attr_accessor(*ATTRS)
end
