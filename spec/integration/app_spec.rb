require 'spec_helper'

describe 'My App' do
  it 'responds ok' do
    get '/'
    expect(last_response).to be_ok
  end
end
