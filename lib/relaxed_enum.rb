require 'active_record' unless defined? ActiveRecord
require 'relaxed_enum/version'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/inflector'

module RelaxedEnum
  extend ActiveSupport::Concern

  class_methods do
    def relax_enum(attribute)
      define_method("#{attribute}=") do |arg|
        begin
          if arg.is_a?(String) && !(arg =~ /\A[-+]?[0-9]+\z/).nil?
            super(arg.to_i)
          elsif (arg.is_a?(String) || arg.is_a?(Symbol)) && self.class.public_send(attribute.to_s.pluralize).key?(arg)
            super(self.class.public_send(attribute.to_s.pluralize)[arg])
          else
            super(arg)
          end
        rescue ArgumentError
          errors.add(attribute, 'is not valid')
        end
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  class ActiveRecord::Base
    include RelaxedEnum
  end
end
