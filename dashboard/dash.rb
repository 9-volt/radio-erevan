require 'sinatra'
require 'haml'

require_relative 'dash_presenter'
require_relative '../app'

class Dash < Sinatra::Base

  get '/' do
    @dash = DashPresenter.new
    haml :index
  end
end

