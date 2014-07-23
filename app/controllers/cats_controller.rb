class CatsController < ApplicationController
  respond_to :json
  before_action :find_cat, only: :show

  def show
    respond_with @cat
  end

  def index
    @cats = Cat.all
    respond_with @cats
  end

  private
  def find_cat
    @cat = Cat.find(params[:id])
  end
end
