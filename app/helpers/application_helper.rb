# frozen_string_literal: true

module ApplicationHelper
  def favicon_helper
    favicon_link_tag('/favicon.ico', rel: 'icon', type: 'image/x-icon')
  end
end
