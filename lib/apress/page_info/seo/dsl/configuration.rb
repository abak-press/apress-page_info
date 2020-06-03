# coding: utf-8
# frozen_string_literal: true

module Apress
  module PageInfo
    module Seo
      module Dsl
        class Configuration
          attr_reader :storage

          def initialize(&block)
            @storage = []

            instance_eval(&block)
          end

          def to_a
            @storage
          end

          def config(prefix = '', &block)
            @storage << Condition.new(prefix, &block).storage
          end
        end
      end
    end
  end
end
