class ApplicationController < ActionController::Base
  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    respond_to do |format|
      format.html { render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false }
      format.json { head :not_found }
      format.atom { head :not_found }
    end
  end
  protect_from_forgery

  private

  def handle_date_params(object_params, field_name)
    built_str = [object_params.delete("#{field_name}(1i)")]
    built_str << object_params.delete("#{field_name}(2i)")
    built_str << object_params.delete("#{field_name}(3i)")
    built_str = built_str.join('-')
    object_params.merge!(field_name => built_str) unless built_str.eql?('--')
    object_params
  end

end
