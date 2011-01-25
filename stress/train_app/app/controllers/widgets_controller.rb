class WidgetsController < ApplicationController

  def index
    @widgets = Widget.limit(10)
    render :json => @widgets
  end

  def create
    @widget = Widget.create!
    render :json => @widget
  end

end
