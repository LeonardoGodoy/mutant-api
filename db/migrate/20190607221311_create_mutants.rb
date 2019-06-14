class CreateMutants < ActiveRecord::Migration[5.2]
  def change
    create_table :mutants do |t|
      t.string :name
      t.text :image

      t.timestamps
    end
  end
end
