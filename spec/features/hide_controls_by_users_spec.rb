require 'rails_helper'

RSpec.feature "HideControlsByUsers", type: :feature do
  context 'Only being able to control events and venues I created' do
    Steps "creating a user, venue and event" do
      Given "I am on the landing page" do
        visit "/"
      end
      Then "I can sign up and log in as a user" do
        click_on "Sign Up"
        fill_in "Email", with: "mrin@mrin.m"
        fill_in "Password", with: "mrinsin"
        fill_in "Password confirmation", with: "mrinsin"
        fill_in "First name", with: "firstname"
        fill_in "Last name", with: "lastname"
        click_on "Sign up"
      end

      Then "I can create a new venue" do
        user1 = User.new(email: "mrin@mrin.m", password: "mrinsin", password_confirmation: "mrinsin", first_name: "firstname", last_name: "lastname")
        user1.save
        user2 = User.find_by_first_name("firstname")

        visit "/venues"
        click_on "New Venue"
        fill_in "Name", with: "Mars Attacks"
        fill_in "Description", with: "Mars Attacks again"
        fill_in "Street 1", with: "Mars"
        fill_in "City", with: "Mars"
        fill_in "State", with: "Mars"
        fill_in "Zip", with: "Mars"
        attach_file('venue[image]', 'spec/images/foo.jpg')
        click_on "Create Venue"
        expect(page).to have_content("Venue was successfully created")
      end

      Then "I can edit/delete my venue as the logged in user" do
        click_on "Back"
        expect(page).to have_content "Edit"
        expect(page).to have_content "Destroy"
      end

      Then "I can add a new event" do
        visit "/events"
        click_on "New Event"
        fill_in "Name", with: "Mating Season"
        select "Mars", from: "Venue"
        click_on "Create Event"
      end

      And "I can see the event I just created" do
        expect(page).to have_content "Event was successfully created"
        expect(page).to have_content "Mating Season"
      end

      Then "I can edit and delete the event that I created" do
        click_on "Back"
        expect(page).to have_content "Edit"
        expect(page).to have_content "Destroy"
      end

      And "I can not edit or delete the event as a guest" do
        click_on "Sign Out"
        expect(page).not_to have_content("New Venue")
        expect(page).not_to have_content("Edit")
        expect(page).not_to have_content("Destroy")
      end

      And "I can not edit or delete a venue as a guest" do
        click_on "Venues"
        expect(page).not_to have_content("New Venue")
        expect(page).not_to have_content("Edit")
        expect(page).not_to have_content("Destroy")
      end
    end
  end
end
