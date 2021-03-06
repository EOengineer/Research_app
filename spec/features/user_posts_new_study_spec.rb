require 'rails_helper'


feature 'user posts a new study', %q{
  as a site user
  I want to post a new study
  so that others will be aware of my work
  } do

  scenario 'authenticated member posts a new study' do

    #SETUP
    type = FactoryGirl.create(:cancer_subtype, name: "Inflammatory Breast Cancer")
    status = FactoryGirl.create(:status, name: 'Completed')
    size = FactoryGirl.create(:size, number: '25')
    duration = FactoryGirl.create(:duration, length: '6 months')
    state = FactoryGirl.create(:state, name: 'Massachusetts')
    user = FactoryGirl.create(:user)
    visit new_user_study_path
    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    expect(current_path).to eq(new_user_study_path)


    #cancer info
    starting_count = Study.all.count
    select 'Inflammatory Breast Cancer', from: 'Cancer subtype'

    #study info
    fill_in 'Title', with: 'Breast Cancer in Automotive Workers'
    select 'Completed', from: 'Status'
    select '25', from: 'Size'
    select '6 months', from: 'Duration'
    fill_in 'Summary', with: 'This study was condicted over 6 months in Boston.  It involved monitoring 25 patients for changes under organic diet.'

    #location info
    select 'Massachusetts', from: 'State'
    click_button 'Submit'
    expect(current_path).to eql("/user/studies/#{starting_count + 1}")
    expect(starting_count).to eq(Study.all.count - 1)
  end
end
