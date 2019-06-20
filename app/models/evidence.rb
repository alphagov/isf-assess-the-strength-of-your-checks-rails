class Evidence < FormResponses
  ATTRS = %i[id evidence_type evidence_type_other
             physical_check crypto_check authoritative_source_check cancellation_check
             check_original check_errors digital_tool_used digital_tool_follows_standard checker_trained checker_training_frequency official_templates_used official_templates_update_frequency expiry_check replay_attack_check security_features_check security_features
             visible_tamper_check visible_features visible_features_consistency visible_features_equipment visible_features_controlled_conditions visible_features_supervision

            ].freeze
  attr_accessor(*ATTRS)
end
