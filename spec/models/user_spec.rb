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
      user = described_class.build(user_params)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = described_class.build(name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a surname' do
      user = described_class.build(surname: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a patronymic' do
      user = described_class.build(patronymic: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a nationality' do
      user = described_class.build(nationality: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a country' do
      user = described_class.build(country: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user = described_class.build(email: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid if email already exists' do
      described_class.create(user_params)
      user = described_class.build(user_params)
      expect(user).to_not be_valid
    end

    it 'is not valid if age is not within the valid range' do
      user = described_class.build(age: 91)
      expect(user).to_not be_valid
    end

    it 'is not valid if gender is not male or female' do
      user = described_class.build(gender: 'dog')
      expect(user).to_not be_valid
    end
  end
end
