require 'set'

class Evidence < ApplicationRecord
  belongs_to :assessment
  after_validation :empty_lists_where_required

  def validity_score
    complete_physical_check = self.physical_check == 'yes' &&
      self.physical_original_check == 'yes' &&
      self.physical_errors_check == 'yes' &&
      self.digital_tool_used == 'yes' &&
      self.digital_tool_follows_standard == 'yes' &&
      self.checker_trained == 'yes' &&
      self.checker_training_frequency == '12_months' &&
      self.official_templates_used == 'yes' &&
      self.official_templates_update_frequency == 'every_year' &&
      self.expiry_check == 'yes' &&
      self.replay_attack_check == 'yes' &&
      self.visible_features_check == 'yes' &&
      self.visible_tamper_check == 'yes' &&
      self.visible_features.to_set == Set['printed_using_intaglio', 'laser_etched', 'watermarks', 'security_fibres', 'secondary_background'] &&
      self.visible_features_consistency == 'yes' &&
      (self.visible_features_equipment & %w[magnification_tool low_angle_light other_equipment]).any? &&
      self.visible_features_controlled_conditions == 'yes' &&
      self.visible_features_supervision == 'yes' &&
      self.uv_ir_features_check == 'yes' &&
      self.uv_ir_features.to_set == Set['paper_printed_on', 'layout_of_document', 'fluorescent_features']

    complete_crypto_check = self.crypto_check == 'yes' &&
      self.crypto_features.to_set == Set['not_expired', 'digital_signature', 'organisation_signing_key', 'evidence_signing_key', 'revoked_signing_key']

    if self.authoritative_source_check == 'yes' &&
        self.cancellation_check == 'yes' &&
        complete_physical_check

      if complete_crypto_check
        return 4
      else
        return 3
      end
    elsif complete_crypto_check
      return 3
    end

    0
  end

private

  def empty_lists_where_required
    if self.crypto_features&.include? 'dont_check'
      self.crypto_features = []
    end
  end
end
