require 'test_helper'

describe Lotus::Router do
  before do
    @router = Lotus::Router.new(prefix: '/admin') do
      get '/dashboard', to: ->(env) { [200, {}, ['Hello from admin dashboard']] }, as: :dashboard
    end

    @app = Rack::MockRequest.new(@router)
  end

  it 'recognizes get path' do
    @app.request('GET', '/admin/dashboard').body.must_equal 'Hello from admin dashboard'
  end

  it 'generates path' do
    @router.path(:dashboard).must_equal '/admin/dashboard'
  end

  it 'generates url' do
    @router.url(:dashboard).must_equal 'http://localhost/admin/dashboard'
  end
end
