require 'rails_helper'

RSpec.describe "donations/edit", type: :view do
  before(:each) do
    @donation = assign(:donation, Donation.create!(
      sending_status: 1,
      recieving_status: 1,
      process_status: 1
    ))
  end

  it "renders the edit donation form" do
    render

    assert_select "form[action=?][method=?]", donation_path(@donation), "post" do

      assert_select "input[name=?]", "donation[sending_status]"

      assert_select "input[name=?]", "donation[recieving_status]"

      assert_select "input[name=?]", "donation[process_status]"
    end
  end
end
