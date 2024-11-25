require 'rails_helper'

RSpec.describe Users::Create, type: :interaction do
  let(:user_params) {
    {
      name: 'Alex',
      surname: 'Coder',
      patronymic: 'Some',
      email: 'ac@mail.ru',
      age: 25,
      nationality: 'russian',
      country: 'Russia',
      gender: 'male',
      interests: %w[Sports Yoga Meditation],
      skills: %w[Ruby, JavaScript]
    }
  }

  it 'creates a user successfully with valid params' do
    result = described_class.run(user_params:)
    expect(result.valid?).to be_truthy
    expect(result.result).to be_a(User)
  end

  it 'fails if required params are missing' do
    invalid_params = user_params.except(:surname)
    result = described_class.run(user_params: invalid_params)
    expect(result.valid?).to be_falsey
    expect(result.errors.full_messages).to include('User params surname is required')
  end

  it 'associates interests and skills' do
    result = described_class.run(user_params:)
    user = result.result
    expect(user.interests.count).to eq(3)
    expect(user.skills.count).to eq(2)
  end

  it 'creates valid full_name' do
    result = described_class.run(user_params:)
    user = result.result
    expect(user.full_name).to eq('Coder Alex Some')
  end

  it 'fails if email already exists' do
    User.create(user_params.except(:skills, :interests))
    result = described_class.run(user_params:)
    expect(result.valid?).to be_falsey
    expect(result.errors.full_messages).to include('Email is already taken')
  end

  it 'fails if age is not within the valid range' do
    invalid_params = user_params.merge( { age: 91 } )
    result = described_class.run(user_params: invalid_params)
    expect(result.valid?).to be_falsey
    expect(result.errors.full_messages).to include('Age is not in (1..90) range')
  end

  it 'fails if gender is not male or female' do
    invalid_params = user_params.merge( { gender: 'dog' } )
    result = described_class.run(user_params: invalid_params)
    expect(result.valid?).to be_falsey
    expect(result.errors.full_messages).to include('Gender should be male or female')
  end
end
