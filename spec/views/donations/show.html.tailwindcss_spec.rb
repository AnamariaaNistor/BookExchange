require 'rails_helper'

RSpec.describe 'donations/show', type: :view do
  before(:each) do
    @donation = assign(:donation, Donation.create!(
                                    sending_status: 2,
                                    receiving_status: 3,
                                    process_status: 4
                                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
