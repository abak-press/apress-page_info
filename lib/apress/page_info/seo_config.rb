# coding: utf-8

require 'apress/page_info/seo/dsl/configuration'
require 'apress/page_info/seo/dsl/condition'

module Apress
  module PageInfo
    # Public: configuration of seo
    # every gem can have own seo config, all configs will merge on app boot
    # anytime you can view global seo config in hash `Apress::PageInfo::SeoConfig.storage`
    #
    # Examples:
    #   # In config/initializers/seo_config.rb:
    #
    #   Apress::PageInfo::SeoConfig.configure do
    #     seo_for :'news/show' do
    #       config 'seo_for_user' do
    #         desc 'News show: current_user is present'
    #         condition -> { signed_in? }
    #         variables(foo: 'bar')
    #       end
    #
    #       config 'base' do
    #         desc 'News show: seo for guest'
    #         variables(fiz: 'buz')
    #       end
    #     end
    #   end
    #
    #   # In config/locales/pages.yml:
    #
    #   ru:
    #     news:
    #       show:
    #         seo_for_user:
    #           title: 'News %{foo}'
    #           description: 'Description of page %{foo}
    #           header: ''
    #         base:
    #           title: 'News %{fiz}'
    #           description: ''
    #           header: ''
    #
    class SeoConfig
      class << self
        attr_accessor :storage

        def configure(&block)
          @storage ||= HashWithIndifferentAccess.new

          new.instance_eval(&block)
        end
      end

      # Public: creates new configuration for page
      #
      # page - Symbol, composition of :"<controller_name>/<action_name>"
      # block - ruby block
      #
      # Returns nothing
      def seo_for(page, &block)
        self.class.storage[page] = Seo::Dsl::Configuration.new(&block).to_a
      end
    end
  end
end
