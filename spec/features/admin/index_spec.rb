require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  describe "displays basic information" do
    it "should have a header indicating it is the Admin Dashboard" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    xit "should have links to the Admin merchant and invoice index" do
      visit "/admin"

      click_link("Merchants")
      expect(current_path).to eq("/admin/merchants")
      visit "/admin"

      click_link("Invoices")
      expect(current_path).to eq("/admin/invoices")

    end
  end
end
