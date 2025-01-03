class Users::Create < ActiveInteraction::Base

  hash :user_params do
    string :name
    string :surname
    string :patronymic
    string :email
    integer :age
    string :nationality
    string :country
    string :gender
    string :full_name, default: nil
    array :interests, default: []
    array :skills, default: []
  end

  validate :validate_user_params

  def execute
    return nil if errors.any?

    User.transaction do
      user = User.create(user_params.except(:skills, :interests).merge(full_name:))
      create_interests(user)
      create_skills(user)
      user
    end
  end

  private

  def full_name
    user_params[:full_name] ||
      [user_params[:surname], user_params[:name], user_params[:patronymic]].compact.join(' ')
  end

  def validate_user_params
    errors.add(:email, 'is already taken') if User.exists?(email: user_params[:email])
    errors.add(:age, 'is not in (1..90) range') unless (1..90).include?(user_params[:age])
    errors.add(:gender, 'should be male or female') unless %w[male female].include?(user_params[:gender])
  end

  def create_interests(user)
    interest_objects = Interest.where(name: user_params[:interests]).to_a
    new_interests = user_params[:interests] - interest_objects.map(&:name)
    new_interests.each { |name| interest_objects << Interest.create!(name:) }
    user.interests = interest_objects
  end

  def create_skills(user)
    skill_objects = Skill.where(name: user_params[:skills]).to_a
    new_skills = user_params[:skills] - skill_objects.map(&:name)
    new_skills.each { |name| skill_objects << Skill.create!(name:) }
    user.skills = skill_objects
  end
end
