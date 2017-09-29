class WelcomeController < ApplicationController

def index
  flash[:notice] = " hello santi!"
end 

end
