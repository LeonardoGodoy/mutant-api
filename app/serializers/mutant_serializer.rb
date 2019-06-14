class MutantSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :skills

  def skills
    object.skills.map do |skill|
      SkillSerializer.new(skill).as_json
    end      
  end
end