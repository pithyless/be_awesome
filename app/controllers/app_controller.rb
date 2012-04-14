class AppController < ApplicationController
  skip_before_filter :check_sign_in, :only => [:index]

  def index
  end
end
