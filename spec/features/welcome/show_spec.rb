require 'rails_helper'

RSpec.describe "Little Esty Shop Landing Page" do
  it "links to the merchant dashbaords index page" do
    visit ('/')

    expect(page).to have_link("Merchant Dashboard Access")
  end
  it "links to the admin dashboards" do
    visit ('/')

    expect(page).to have_link("Admin Access")
  end
end
