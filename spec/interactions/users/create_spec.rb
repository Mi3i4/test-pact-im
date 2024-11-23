require 'rails_helper'

RSpec.describe Users::Create, type: :interaction do
  let(:valid_params) do
    {
      name: 'John', surname: 'Doe', patronymic: 'Smith', email: 'john.doe@example.com',
      age: 25, nationality: 'American', country: 'USA', gender: 'male', interests: %w[Sports Reading],
      skills: %w[Ruby, JavaScript]
    }
  end

  it 'creates a user successfully with valid params' do
    result = Users::Create.run(valid_params)
    expect(result.valid?).to be_truthy
    expect(result.result).to be_a(User)
  end

  it 'fails if required params are missing' do
    invalid_params = valid_params.except(:name)
    result = Users::Create.run(invalid_params)
    expect(result.valid?).to be_falsey
    expect(result.errors.full_messages).to include('Name is required')
  end

  it 'associates interests and skills' do
    result = Users::Create.run(valid_params)
    user = result.result
    expect(user.interests.count).to eq(2)
    expect(user.skills.count).to eq(2)
  end
end