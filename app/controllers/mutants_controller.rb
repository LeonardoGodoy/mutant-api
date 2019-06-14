class MutantsController < ApplicationController
  before_action :set_mutant, only: [:update, :destroy]

  def index
    if filter_params.present?
      name = "%#{filter_params[:skill]}%"
      mutants = Mutant.joins(:skills).where('skills.name like :name', name: name).uniq
    else
      mutants = Mutant.all
    end

    render(json: { mutants: mutants.map { |mutant| MutantSerializer.new(mutant).as_json } })
  end
  
  def create
    mutant = Mutant.new(mutant_attributes)

    if mutant.valid? && mutant.save
      skills = skills_params[:skills].map do |skill_params|
        Skill.find_or_create_by(skill_params)
      end

      mutant.skills = skills

      render json: mutant, serializer: MutantSerializer, status: :ok
    else
      render json: mutant.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @mutant.present? && @mutant.update(mutant_attributes)

      skills = skills_params[:skills].map do |skill_params|
        Skill.find_or_create_by(skill_params)
      end

      @mutant.skills = skills
      render json: @mutant, serializer: MutantSerializer, status: :ok
    else
      render json: @mutant.errors.messages, status: :unprocessable_entity
    end
  end


  def destroy
    @mutant.destroy
    render json: @mutant, serializer: MutantSerializer, status: :ok
  end

  private

  def set_mutant
    @mutant = Mutant.find_by(id: params[:id])
  end

  def filter_params
    params.permit(:skill)
  end

  def mutant_attributes
    params.permit(:name, :image)
  end

  def skills_params
    params.permit(skills: [:name])
  end
end
