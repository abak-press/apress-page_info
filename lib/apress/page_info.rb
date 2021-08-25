# coding: utf-8
# frozen_string_literal: true

require 'apress/page_info/version'
require 'active_support'
require 'apress/page_info/seo_config'

module Apress
  module PageInfo
    extend ActiveSupport::Concern

    CONTROLLER_NAME_TAIL = /Controller$/.freeze
    PAGE_SEO_META = %w(title description keywords header promo_text).freeze

    autoload :Meta, 'apress/page_info/meta'

    included do
      delegate :page_title,
               :page_header,
               :page_description,
               :page_keywords,
               :page_promo_text,

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

               :keywords_key,
               :set_keywords_key,

               :promo_text_key,
               :set_promo_text_key,

               :set_custom_title,
               :set_custom_header,
               :set_custom_description,

               :title_postfix,

               :to => :page_info

      helper_method :page_title
      helper_method :page_header
      helper_method :page_description
      helper_method :page_keywords
      helper_method :page_promo_text
      helper_method :title_key
      helper_method :header_key
      helper_method :description_key
      helper_method :keywords_key
      helper_method :promo_text_key
    end

    module ClassMethods
      # Public: defines callback for given set of actions
      #
      # actions - set of actions
      #
      # Returns nothing
      def define_seo_for(*actions)
        if Rails.version > '5.0'
          before_action :seo_for_page, only: actions
        else
          before_filter :seo_for_page, only: actions
        end
      end
    end

    def page_info
      @page_info ||= Meta.new(self)
    end

    private

    # Internal: defines seo meta (title, description, keywords, header, promo_text) for given action
    #
    # Returns nothing
    def seo_for_page
      PAGE_SEO_META.each do |meta|
        send("set_#{meta}_key", "#{seo_condition[:prefix]}#{meta}")
      end

      set_title_variables(seo_variables)
    end

    # Internal: seo configuration for given action
    #
    # Returns Array, list of different conditions
    def seo_config
      return @seo_config if defined?(@seo_config)

      controller_fullname = self.class.name.sub(CONTROLLER_NAME_TAIL, '').underscore

      @seo_config = Apress::PageInfo::SeoConfig.storage[:"#{controller_fullname}##{action_name}"]
    end

    # Internal: finds suitable condition of seo
    #
    # Returns Hash
    def seo_condition
      return @seo_condition if defined?(@seo_condition)
      return @seo_condition = {} unless seo_config

      @seo_condition = seo_config.find do |conf|
        condition = conf.fetch(:condition)

        condition.respond_to?(:call) ? instance_exec(&conf.fetch(:condition)) : condition
      end
    end

    def seo_variables
      variables = seo_condition.fetch(:variables)
      variables.respond_to?(:call) ? instance_exec(&variables) : variables
    end
  end
end
