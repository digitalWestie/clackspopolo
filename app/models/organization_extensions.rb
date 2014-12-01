module OrganizationExtensions
  extend ActiveSupport::Concern

  included do
    accepts_nested_attributes_for :links
    accepts_nested_attributes_for :sources

    singleton_class.prepend ClassMethods
    prepend InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
  end
end