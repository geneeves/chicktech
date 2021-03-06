require 'spec_helper'

feature 'Creating jobs' do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:event) { FactoryGirl.create(:event) }

  scenario 'with valid inputs' do
    sign_in(admin)
    event = FactoryGirl.create(:event)
    visit event_path(event)
    click_on 'Add jobs'
    fill_in 'Name', with: 'Example name'
    click_on 'Create Job'
    page.should have_content 'successfully'
  end

  scenario 'with no inputs' do
    sign_in(admin)
    event = FactoryGirl.create(:event)
    visit event_path(event)
    click_on 'Add jobs'
    click_on 'Create Job' 
    page.should have_content 'blank'
  end
end

feature 'User signs up for a job' do
  let(:volunteer) { FactoryGirl.create(:volunteer) }
  let(:job) { FactoryGirl.create(:job)}
  before { sign_in(volunteer) }

  scenario 'successfully' do
    visit event_path(job.workable)
    click_on 'Sign Up!'
    page.should have_content 'Congratulations!'
  end

  scenario 'resigns from a job' do
    volunteer.jobs << job
    visit event_path(job.workable)
    click_on 'Resign!'
    page.should have_content 'resigned'
  end
end

feature 'Admin deletes a job' do
  let(:superadmin) { FactoryGirl.create(:superadmin) }
  let(:job) { FactoryGirl.create(:job) }
  before { sign_in(superadmin) }

  scenario 'successfully' do
    visit job_path(job)
    click_on 'Delete'
    page.should have_content "'#{job.name}' deleted."
  end
end
