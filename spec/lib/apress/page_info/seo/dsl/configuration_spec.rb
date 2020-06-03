# coding: utf-8
# frozen_string_literal: true

RSpec.describe Apress::PageInfo::Seo::Dsl::Configuration do
  describe '#config' do
    context 'when simple configuration' do
      let(:configuration) do
        described_class.new do
          config {}
        end
      end

      it { expect(configuration.storage.length).to eq 1 }
    end
  end
end
