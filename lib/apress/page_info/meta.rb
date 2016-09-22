# coding: utf-8
module Apress
  module PageInfo
    class Meta
      attr_accessor :controller
      alias_method :c, :controller

      attr_reader :title_variables,
                  :title_key,
                  :postfix_key,
                  :header_key,
                  :description_key,
                  :custom_title,
                  :custom_header

      def initialize(controller)
        @controller = controller
      end

      # Public: вычисление названия страницы
      #
      # Returns String
      def page_title
        return c.last_error if c.respond_to?(:last_error?) && c.last_error?
        return compact_spaces(@custom_title) if @custom_title.present?

        key = title_key.presence || :title
        default_vars = {scope: action_scope}

        vars = title_variables.present? ? default_vars.merge!(title_variables) : default_vars

        compact_spaces("#{I18n.t!(key, vars)}#{title_postfix}")
      end

      # Public: вычисление заголовка (h1) страницы
      #
      # Returns String
      def page_header
        return '' if c.respond_to?(:last_error?) && c.last_error?
        return compact_spaces(@custom_header) if @custom_header.present?

        key = header_key.presence || :header
        default_vars = {scope: action_scope, default: ''}

        vars = title_variables.present? ? default_vars.merge!(title_variables) : default_vars

        compact_spaces(I18n.t!(key, vars))
      end

      # Public: вычисление описания страницы
      #
      # Returns String
      def page_description
        return '' if c.respond_to?(:last_error?) && c.last_error?

        key = description_key.presence || :description
        default_vars = {scope: action_scope, default: ''}

        vars = title_variables.present? ? default_vars.merge!(title_variables) : default_vars

        compact_spaces(I18n.t!(key, vars))
      end

      # постфикс названия страницы
      def title_postfix
        key            = :postfix
        action_key     = action_scope.join('.') + ".#{key}"
        controller_key = controller_scope.join('.') + ".#{key}"
        default_key    = default_scope.join('.') + ".default_#{key}"

        vars = (title_variables || {}).merge(
          :default => [controller_key.to_sym, default_key.to_sym]
        )

        return I18n.t!("#{action_scope.join('.')}.#{postfix_key}", vars) if postfix_key
        I18n.t!(action_key, vars)
      end

      def action_scope
        @action_scope ||= [
          :pages,
          c.class.name.underscore.gsub('/', '.').gsub(/_controller$/, ''),
          c.params[:action]
        ]
      end

      def controller_scope
        @controller_scope ||= [
          :pages,
          c.class.name.underscore.gsub('/', '.').gsub(/_controller$/, '')
        ]
      end

      def default_scope
        @default_scope ||= [
          :pages
        ]
      end

      # это использовать в наследниках
      def set_title_variables(vars)
        raise ArgumentError unless vars.is_a?(Hash)
        @title_variables = vars.symbolize_keys
      end

      # это использовать в наследниках
      def set_title_key(key)
        raise ArgumentError unless key.is_a?(String)
        @title_key = key
      end

      def set_postfix_key(key)
        raise ArgumentError unless key.is_a?(String)
        @postfix_key = key
      end

      # это использовать в наследниках
      def set_header_key(key)
        raise ArgumentError unless key.is_a?(String)
        @header_key = key
      end

      # это использовать в наследниках
      def set_description_key(key)
        raise ArgumentError unless key.is_a?(String)
        @description_key = key
      end

      def set_custom_title(title)
        if title.blank?
          false
        else
          @custom_title = title
        end
      end

      def set_custom_header(header)
        if header.blank?
          false
        else
          @custom_header = header
        end
      end

      def compact_spaces(value)
        value.gsub(/[ ]+/, ' ').gsub(/ ([\,\.\:\!])/, '\1')
      end
    end
  end
end
