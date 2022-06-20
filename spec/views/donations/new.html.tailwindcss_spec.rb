require 'rails_helper'

RSpec.describe 'donations/new', type: :view do
  before(:each) do
    assign(:donation, Donation.new(
                        sending_status: 1,
                        recieving_status: 1,
                        process_status: 1
                      ))
  end

  it 'renders new donation form' do
    render

    assert_select 'form[action=?][method=?]', donations_path, 'post' do
      assert_select 'input[name=?]', 'donation[sending_status]'

      assert_select 'input[name=?]', 'donation[recieving_status]'

      assert_select 'input[name=?]', 'donation[process_status]'
    end
  end
end
