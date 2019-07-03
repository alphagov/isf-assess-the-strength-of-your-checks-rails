class AddCustomStrengthToEvidence < ActiveRecord::Migration[5.2]
  def change
    add_column :evidence, :custom_strength, :int
  end
end
