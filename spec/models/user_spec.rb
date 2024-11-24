require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_params) {
    {
      name: 'Alex',
      surname: 'Coder',
      patronymic: 'Some',
      email: 'ac@mail.ru',
      age: 25,
      nationality: 'russian',
      country: 'Russia',
      gender: 'male'
    }
  }

  describe 'associations' do
    it { should have_and_belong_to_many(:interests) }
    it { should have_and_belong_to_many(:skills) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.build(user_params)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.build(name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a surname' do
      user = User.build(surname: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a patronymic' do
      user = User.build(patronymic: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a nationality' do
      user = User.build(nationality: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a country' do
      user = User.build(country: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user = User.build(email: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid if email already exists' do
      User.create(user_params)
      user = User.build(user_params)
      expect(user).to_not be_valid
    end

    it 'is not valid if age is not within the valid range' do
      user = User.build(age: 100)
      expect(user).to_not be_valid
    end

    it 'is not valid if gender is not male or female' do
      user = User.build(gender: 'dog')
      expect(user).to_not be_valid
    end
  end
end