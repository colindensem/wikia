# frozen_string_literal: true
class AuthorsController < ApplicationController
  before_action :set_author
  before_action :current_author?

  def show
    @articles = @author.articles.order(:created_at)
  end

  private

  def set_author
    @author = User.find(params[:id])
  end

  def current_author?
    unless @author == current_user
      redirect_to root_path, alert: 'No access to that author.'
    end
  end
end
