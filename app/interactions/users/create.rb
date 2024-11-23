class Users::Create < ActiveInteraction::Base
  # Описание атрибутов, которые будет принимать наш класс
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

  # Описание основной логики
  def execute
    return errors.add(:base, 'All required fields must be provided') if invalid_params?

    user = User.create!(name: name, surname: surname, patronymic: patronymic,
                        email: email, age: age, nationality: nationality, country: country,
                        gender: gender, full_name: full_name || "#{surname} #{name} #{patronymic}")

    create_interests(user)

    create_skills(user)

    user
  end

  private

  def invalid_params?
    name.blank? || surname.blank? || email.blank? || age.blank? ||
      nationality.blank? || country.blank? || gender.blank?
  end

  def create_interests(user)
    interests.each do |interest_name|
      interest = Interest.find_or_create_by(name: interest_name)
      user.interests << interest
    end
  end

  def create_skills(user)
    skills.each do |skill|
      skill = Skill.find_or_create_by(name: skill)
      user.skills << skill
    end
  end
end