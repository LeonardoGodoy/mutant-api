class CreateMutantsSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :mutants_skills, id: false do |t|
      t.belongs_to :mutant, index: true
      t.belongs_to :skill, index: true
    end
  end
end
