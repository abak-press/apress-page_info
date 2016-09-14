# coding: utf-8
require 'apress/page_info/version'
require 'active_support'

module Apress
  module PageInfo
    extend ActiveSupport::Concern

    autoload :Meta, 'apress/page_info/meta'

    included do
      delegate :page_title,
               :page_header,
               :page_description,

               :title_variables,
               :set_title_variables,

               :title_key,
               :set_title_key,

               :postfix_key,
               :set_postfix_key,

               :header_key,
               :set_header_key,

               :description_key,
               :set_description_key,

               :set_custom_title,
               :set_custom_header,

               :title_postfix,

               :to => :page_info

      helper_method :page_title
      helper_method :page_header
      helper_method :page_description
      helper_method :title_key
      helper_method :header_key
      helper_method :description_key
    end

    def page_info
      @page_info ||= Meta.new(self)
    end
  end
end
