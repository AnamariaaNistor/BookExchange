require 'rails_helper'

RSpec.describe 'exchanges/show', type: :view do
  before(:each) do
    @exchange = assign(:exchange, Exchange.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
