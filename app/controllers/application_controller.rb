# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private

  def article_author?
    unless @article.author == current_user
      redirect_to articles_path, alert: 'No access to that article.'
    end
  end
end
