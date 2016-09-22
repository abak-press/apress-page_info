# coding: utf-8

require 'spec_helper'

RSpec.describe Apress::PageInfo::SeoConfig do
  let!(:config_before) { described_class.storage }

  before do
    described_class.storage = nil

    described_class.configure do
      seo_for :'anonymous/index' do
        config :ekb do
          desc 'Ekb seo config'
          condition false
          variables(foo: 'bar')
        end

        config :default do
          desc 'Default config'
          variables(fiz: 'buz')
        end
      end
    end
  end

  after { described_class.storage = config_before }

  describe '.storage' do
    it 'builds seo configuration by given dsl' do
      expect(described_class.storage).to eq({
        :'anonymous/index' => [
          {
            description: 'Ekb seo config',
            condition: false,
            variables: {foo: 'bar'},
            prefix: 'ekb.'
          },
          {
            description: 'Default config',
            condition: true,
            variables: {fiz: 'buz'},
            prefix: 'default.'
          }
        ]
      }.with_indifferent_access)
    end
  end
end
