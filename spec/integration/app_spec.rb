require "spec_helper"
require_relative '../../app.rb'
require 'rack/test'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/')

      expect(response.status).to eq(200)
      
      expect(response.body).to eq("Hello")
    end
  end

end