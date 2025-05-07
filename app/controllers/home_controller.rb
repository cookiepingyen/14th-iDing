# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def robots
    robots = File.read("#{Rails.root}/public/robots.txt")
    render plain: robots
  end
end
