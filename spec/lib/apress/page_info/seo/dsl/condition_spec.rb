# coding: utf-8
# frozen_string_literal: true

RSpec.describe Apress::PageInfo::Seo::Dsl::Condition do
  let(:cond) { described_class.new('foo_prefix') {} }

  describe '#desc' do
    before { cond.desc 'some condition' }
    it { expect(cond.storage[:description]).to eq 'some condition' }
  end

  describe '#condition' do
    before { cond.condition true }
    it { expect(cond.storage[:condition]).to eq true }
  end

  describe '#variables' do
    before { cond.variables(foo: :bar) }
    it { expect(cond.storage[:variables]).to eq(foo: :bar) }
  end

  describe ':prefix' do
    context 'when empty' do
      let(:cond) { described_class.new('') {} }

      it { expect(cond.storage.key?(:prefix)).to be_falsy }
    end

    context 'when passed' do
      it { expect(cond.storage[:prefix]).to eq 'foo_prefix.' }
    end
  end

  describe 'construct' do
    let(:cond) do
      described_class.new 'foo_prefix' do
        desc 'foo'
        condition true
        variables(foo: :bar)
      end
    end

    it do
      expect(cond.storage[:description]).to eq 'foo'
      expect(cond.storage[:condition]).to eq true
      expect(cond.storage[:variables]).to eq(foo: :bar)
      expect(cond.storage[:prefix]).to eq 'foo_prefix.'
    end
  end
end
