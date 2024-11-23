require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:interests) }
    it { should have_and_belong_to_many(:skills) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(name: 'John', surname: 'Doe', email: 'john.doe@example.com', age: 25, nationality: 'USA', country: 'USA', gender: 'male')
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = User.new(name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user = User.new(email: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid if age is not within the valid range' do
      user = User.new(age: 100)
      expect(user).to_not be_valid
    end
  end
end