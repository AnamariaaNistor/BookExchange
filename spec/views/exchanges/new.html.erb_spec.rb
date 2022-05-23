require 'rails_helper'

RSpec.describe 'exchanges/new', type: :view do
  before(:each) do
    assign(:exchange, Exchange.new)
  end

  it 'renders new exchange form' do
    render

    assert_select 'form[action=?][method=?]', exchanges_path, 'post' do
    end
  end
end
