require 'spec_helper'

AnonymousController = Class.new(ActionController::Base)

RSpec.describe Apress::PageInfo, type: :controller do
  controller AnonymousController do
    include Apress::PageInfo
  end

  let(:postfix) { I18n.t('pages.anonymous.postfix') }

  before { allow(controller).to receive(:params).and_return(action: :index) }

  describe '#page_title' do
    context 'when default' do
      it { expect(controller.page_title).to eq "#{I18n.t('pages.anonymous.index.title')}#{postfix}" }
    end

    context 'when last_error given' do
      before do
        allow(controller).to receive_messages(:last_error => 'Something wrong', :last_error? => true)
      end

      it { expect(controller.page_title).to eq 'Something wrong' }
    end

    context 'when given custom title key' do
      before do
        controller.send(:set_title_key, 'foo.title')
      end

      it { expect(controller.page_title).to eq "#{I18n.t('pages.anonymous.index.foo.title')}#{postfix}" }
    end

    context 'when not exist locale for given action' do
      before { allow(controller).to receive(:params).and_return(action: :noname) }

      it { expect { controller.page_title }.to raise_error I18n::MissingTranslationData }
    end

    context 'when with variables' do
      before do
        controller.send(:set_title_variables, foo: :bar)
        allow(controller).to receive(:params).and_return(action: :foo)
      end

      it do
        expect(controller.page_title).to eq(
          "#{I18n.t('pages.anonymous.foo.title', foo: :bar)}#{postfix}"
        )
      end
    end

    context 'when setted custom title' do
      before do
        controller.send(:set_custom_title, 'My awesome custom title')
      end

      it { expect(controller.page_title).to eq('My awesome custom title') }
    end
  end

  describe '#page_header' do
    context 'when default' do
      it { expect(controller.page_header).to eq "#{I18n.t('pages.anonymous.index.header')}" }
    end

    context 'when last_error given' do
      before do
        allow(controller).to receive_messages(:last_error => 'Something wrong', :last_error? => true)
      end

      it { expect(controller.page_header).to be_empty }
    end

    context 'when given custom title key' do
      before do
        controller.send(:set_header_key, 'foo.header')
      end

      it { expect(controller.page_header).to eq "#{I18n.t('pages.anonymous.index.foo.header')}" }
    end

    context 'when not exist locale for given action' do
      before { allow(controller).to receive(:params).and_return(action: :noname) }

      it { expect { controller.page_header }.not_to raise_error }
    end

    context 'when with variables' do
      before do
        controller.send(:set_title_variables, foo: :bar)
        allow(controller).to receive(:params).and_return(action: :foo)
      end

      it do
        expect(controller.page_header).to eq(
          "#{I18n.t('pages.anonymous.foo.header', foo: :bar)}"
        )
      end
    end

    context 'when setted custom header' do
      before do
        controller.send(:set_custom_header, 'My awesome custom header')
      end

      it { expect(controller.page_header).to eq('My awesome custom header') }
    end
  end

  describe '#page_description' do
    context 'when default' do
      it { expect(controller.page_description).to eq "#{I18n.t('pages.anonymous.index.description')}" }
    end

    context 'when last_error given' do
      before do
        allow(controller).to receive_messages(:last_error => 'Something wrong', :last_error? => true)
      end

      it { expect(controller.page_description).to be_empty }
    end

    context 'when given custom description key' do
      before do
        controller.send(:set_description_key, 'foo.description')
      end

      it { expect(controller.page_description).to eq "#{I18n.t('pages.anonymous.index.foo.description')}" }
    end

    context 'when not exist locale for given action' do
      before { allow(controller).to receive(:params).and_return(action: :noname) }

      it { expect { controller.page_description }.not_to raise_error }
    end

    context 'when with variables' do
      before do
        controller.send(:set_title_variables, foo: :bar)
        allow(controller).to receive(:params).and_return(action: :foo)
      end

      it do
        expect(controller.page_description).to eq(
          "#{I18n.t('pages.anonymous.foo.description', foo: :bar)}"
        )
      end
    end
  end

  describe '#title_postfix' do
    context 'when default' do
      it { expect(controller.title_postfix).to eq I18n.t('pages.anonymous.postfix') }
    end
  end
end
