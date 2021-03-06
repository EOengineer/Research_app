require 'rails_helper'

RSpec.describe User, :type => :model do

# describe 'admin checks' do
  it 'is not an admin if the role is not admin' do
    user = FactoryGirl.build(:user)
    expect(user.is_admin?).to be false
  end

  it 'is an admin if the role is admin' do
    user = FactoryGirl.build(:user, role: 'admin')
    expect(user.is_admin?).to be true
  end

  it {should have_many(:studies)}
end
