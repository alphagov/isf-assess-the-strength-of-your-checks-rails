class CreateEvidences < ActiveRecord::Migration[5.2]
  def change
    create_table :evidence do |t|
      t.string :evidence_type
      t.string :evidence_type_other
      t.string :physical_check
      t.string :crypto_check
      t.string :authoritative_source_check
      t.string :cancellation_check
      t.belongs_to :assessment, index: true
      t.timestamps
    end
  end
end
