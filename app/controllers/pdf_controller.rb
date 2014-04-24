class PdfController < ApplicationController
  def index
  	respond_to do |format|
  	  format.html

  	  format.pdf do
  	    render  :pdf => "user-inventory",
  	            :header => {:center => "Mule Moving"},
  	            :footer => {:center => "[page] of [topage]"},
  	            :show_as_html => params[:debug].present?
  	  end
  	end
  end
end
