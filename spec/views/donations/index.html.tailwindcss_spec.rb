require 'rails_helper'

RSpec.describe "donations/index", type: :view do
  before(:each) do
    assign(:donations, [
      Donation.create!(
        sending_status: 2,
        recieving_status: 3,
        process_status: 4
      ),
      Donation.create!(
        sending_status: 2,
        recieving_status: 3,
        process_status: 4
      )
    ])
  end

  it "renders a list of donations" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
  end
end
