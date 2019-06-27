class Evidence < ApplicationRecord
  belongs_to :assessment
  after_validation :empty_lists_where_required

private

  def empty_lists_where_required
    if self.crypto_features&.include? 'dont_check'
      self.crypto_features = []
    end
  end
end
