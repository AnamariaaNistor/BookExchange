require 'rails_helper'

RSpec.describe 'exchanges/edit', type: :view do
  before(:each) do
    @exchange = assign(:exchange, Exchange.create!)
  end

  it 'renders the edit exchange form' do
    render

    assert_select 'form[action=?][method=?]', exchange_path(@exchange), 'post' do
    end
  end
end
