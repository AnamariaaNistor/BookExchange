require 'rails_helper'

RSpec.describe 'exchanges/index', type: :view do
  before(:each) do
    assign(:exchanges, [
             Exchange.create!,
             Exchange.create!
           ])
  end

  it 'renders a list of exchanges' do
    render
  end
end
