require 'rails_helper'

RSpec.describe "Homepage", type: :request do
  it "renders the root path" do
    get "/"
    expect(response).to have_http_status(:ok)
  end
end
