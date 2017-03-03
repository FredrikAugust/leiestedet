class StaticPageController < ApplicationController
  def index
  end

  def acme
    render text: ''
  end
end
