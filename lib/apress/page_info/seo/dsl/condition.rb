# coding: utf-8

module Apress
  module PageInfo
    module Seo
      module Dsl
        # Public: defines condition for some seo logic
        class Condition
          attr_reader :storage

          def initialize(prefix, &block)
            @storage = {}

            instance_eval(&block)

            @storage[:prefix] = "#{prefix}." if prefix.present?
            @storage[:condition] = true unless @storage.key?(:condition)
          end

          # Public: description of condition
          #
          # text - String
          #
          # Returns nothing
          def desc(text)
            @storage[:description] = text
          end

          # Public: condition, if not defined in initializer, then true
          #
          # condition - Boolean | Proc (will execute in controller context)
          #
          # Returns nothing
          def condition(condition)
            @storage[:condition] = condition
          end

          # Public: set variables
          #
          # vars - Hash | Proc (will execute in controller context)
          #
          # Returns nothing
          def variables(vars)
            @storage[:variables] = vars
          end
        end
      end
    end
  end
end
