require 'simplecov'
SimpleCov.start do
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Views", "app/views"
end

require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end
SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  def deny(condition)
    assert !condition
  end
  
  def create_context
    # Create 4 organization categories
    @blitz = FactoryGirl.create(:organization_category, :name => "Blitz")
    @independent = FactoryGirl.create(:organization_category, :name => "Independent")
    @frat = FactoryGirl.create(:organization_category, :name => "Fraternity")
    @sorority = FactoryGirl.create(:organization_category, :name => "Sorority")

    # Create 2 organizations
    @theta = FactoryGirl.create(:organization, :name => "Kappa Alpha Theta", :organization_category => @sorority)
    @sdc = FactoryGirl.create(:organization, :name => "Student Dormitory Council", :organization_category => @independent)
    @scc = FactoryGirl.create(:organization, :name => "Spring Carnival Committee", :organization_category => @independent)

    # Create 2 organization aliases
    @theta_alias = FactoryGirl.create(:organization_alias, :name => "Theta", :organization => @theta)
    @sdc_alias = FactoryGirl.create(:organization_alias, :name => "SDC", :organization => @sdc)
    @scc_alias = FactoryGirl.create(:organization_alias, :name => "SCC", :organization => @scc)

    # Create 2 charge types
    @miss_meeting = FactoryGirl.create(:charge_type, :default_amount => 100.00, :description => "Missed a meeting", :name => "Meeting", :requires_booth_chair_approval => false)
    @trip_breaker = FactoryGirl.create(:charge_type, :default_amount => 200.00, :description => "Tripped a breaker", :name => "Breaker", :requires_booth_chair_approval => true)
  

    # Create 4 participants
    @rachel = FactoryGirl.create(:andrewid => "rcrown", :has_signed_waiver => true, :has_signed_hardhat_waiver => false, :phone_number => "123-456-7890", :organization => @scc)
    @shannon = FactoryGirl.create(:andrewid => "shannon1", :organization => @sdc, :has_signed_waiver => false, :has_signed_hardhat_waiver => true, :phone_number => "412-412-4124")
    @dylan = FactoryGirl.create(:andrewid => "dylanc", :has_signed_hardhat_waiver => true, :has_signed_waiver => true, :organization => @theta, :phone_number => "412-123-5555")
    @alexis = FactoryGirl.create(:andrewid => "alexed", :organization => @theta, :has_signed_waiver => false, :has_signed_hardhat_waiver => false, :phone_number => "539-123-4124")

    # Create 3 tasks
    @assign_rides = FactoryGirl.create(:task, :name =>"Assign rides", :participant => @rachel, :task_status => @in_progress)
    @buy_wood = FactoryGirl.create(:tasks, :name => "Buy wood", :participant => @shannon, :task_status => @complete)
    @takeout_trash = FactoryGirl.create(:task, :name => "Take-out trask", :participant => @dylan, :task_status => @incomplete)

    # Create 3 task statuses
    @complete = FactoryGirl.create(:task_status, :name => "Complete")
    @incomplete = FactoryGirl.create(:task_status, :name => "Incomplete")
    @in_progress = FactoryGirl.create(:task_status, :name => "In Progress")

    # Create 3 shift types
    @watch_shift = FactoryGirl.create(:shift_type, :name => "Watch Shift")
    @security_shift = FactoryGirl.create(:shift_type, :name => "Security Shift")
    @ride_shift = FactoryGirl.create(:shift_type, :name => "Ride Shift")

    # Create 3 shifts
    @shift1 = FactoryGirl.create(:shift, :ends_at => Date.new, :required_number_of_participants => 3, :starts_at => Date.new)
    @shift2 = FactoryGirl.create(:shift, :ends_at => Date.new, :required_number_of_participants => 3, :starts_at => Date.new)
    @shift3 = FactoryGirl.create(:shift, :ends_at => Date.new, :required_number_of_participants => 3, :starts_at => Date.new)

    # Create 4 tools
    @hammer = FactoryGirl.create(:tool, :barcode => 123780890, :description => "HAMMER", :name => "Hammer")
    @saw = FactoryGirl.create(:tool, :barcode => 123789043, :description => "SAW", :name => "Saw")
    @ladder = FactoryGirl.create(:tool, :barcode => 123780120, :description => "LADDER", :name => "Ladder")
    @hard_hat = FactoryGirl.create(:tool, :barcode => 123780812, :description => "HARD HAT", :name => "Hard Hat")

    # Create 4 checkouts
    @hammer_checkout1 = FactoryGirl.create(:checkout, :checked_in => Date.new, :checked_out => Date.new, :tool => @hammer)
    @hammer_checkout2 = FactoryGirl.create(:checkout, :checked_in => Date.new, :checked_out => Date.new, :tool => @hammer)
    @saw_checkout = FactoryGirl.create(:checkout, :checked_in => Date.new, :checked_out => Date.new, :tool => @saw)
    @hard_hat_checkout = FactoryGirl.create(:checkout, :checked_in => Date.new, :checked_out => Date.new, :tool => @hard_hat)

    # Create three charge types
    @miss_meeting = FactoryGirl.create(:charge_type, :default_amount => 50.00, :description => "Missed a meeting", :name => "Meeting", :requires_booth_chair_approval => false)
    @trip_breaker = FactoryGirl.create(:charge_type, :default_amount => 25.00, :description => "Tripped a breaker", :name => "Breaker", :requires_booth_chair_approval => true)
  
    # Create 2 charges
    @meeting_fine = FactoryGirl.create(:charge, :charge_type => @miss_meeting, :issuing_participant => @rachel, :receiving_participant => nil, :organization => @theta, :amount => 50.00, :charged_at => Date.today, :description => "Missed 10/2 meeting")
    @breaker_fine = FactoryGirl.create(:charge, :charge_type => @trip_breaker, :issuing_participant => @rachel, :receiving_participant => @alexis, :organization => @theta, :amount => 25.00, :charged_at => Date.today-1, :description => "Breaker trip")
  
    # Create 2 memberships
    @member_rachel = FactoryGirl.create(:membership, :participant => @rachel, :organization => @SCC, :booth_chair_order => nil, :is_booth_chair => false, :title => "Head of Booth")
    @member_alexis = FactoryGirl.create(:membership, :participant => @alexis, :organization => @theta, :booth_chair_order => 1, :is_booth_chair => true, :title => nil)
  end
  
  def remove_context
    # Destroy 4 organization categories
    @blitz.destroy
    @independent.destroy
    @frat.destroy
    @sorority.destroy

    # Destroy 2 organizations
    @theta.destroy
    @sdc.destroy
    @scc.destroy

    # Destroy 2 organization aliases
    @theta_alias.destroy
    @sdc_alias.destroy
    @scc_alias.destroy

    # Destroy 3 charge types
    @miss_meeting.destroy
    @trip_breaker.destroy

    # Destroy 4 participants
    @rachel.destroy
    @shannon.destroy
    @dylan.destroy
    @alexis.destroy

    # Destroy 3 tasks
    @assign_rides.destroy
    @buy_wood.destroy
    @takeout_trash.destroy

    # Destroy task status
    @complete.destroy
    @incomplete.destroy
    @in_progress.destroy
    # Destroy 3 shift types
    @watch_shift.destroy
    @security_shift.destroy
    @ride_shift.destroy

    # Destroy 3 shifts
    @shift1.destroy
    @shift2.destroy
    @shift3.destroy

    # Destroy 4 tools
    @hammer.destroy
    @saw.destroy
    @ladder.destroy
    @hard_hat.destroy

    # Destroy 4 checkouts
    @hammer_checkout1.destroy
    @hammer_checkout2.destroy
    @saw_checkout.destroy
    @hard_hat_checkout.destroy
    
    # Destroy 2 charges
    @meeting_fine.destroy
    @breaker_fine.destroy
    
    # Destroy 2 memberships
    @member_rachel.destroy
    @member_alexis.destroy
  end
end