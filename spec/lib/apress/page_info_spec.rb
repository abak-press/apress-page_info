require 'spec_helper'

AnonymousController = Class.new(ActionController::Base)

RSpec.describe Apress::PageInfo, type: :controller do
  controller AnonymousController do
    include Apress::PageInfo

    define_seo_for :index

    def index
      render nothing: true
    end
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

      it { expect(controller.page_title).to eq "#{I18n.t('pages.anonymous.foo.title', foo: :bar)}#{postfix}" }
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
      it { expect(controller.page_header).to eq I18n.t('pages.anonymous.index.header') }
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

      it { expect(controller.page_header).to eq I18n.t('pages.anonymous.index.foo.header') }
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
        expect(controller.page_header).to eq I18n.t('pages.anonymous.foo.header', foo: :bar)
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
      it { expect(controller.page_description).to eq I18n.t('pages.anonymous.index.description') }
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

      it { expect(controller.page_description).to eq I18n.t('pages.anonymous.index.foo.description') }
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

      it { expect(controller.page_description).to eq I18n.t('pages.anonymous.foo.description', foo: :bar) }
    end

    context 'when setted custom description' do
      before do
        controller.send(:set_custom_description, 'My awesome custom description')
      end

      it { expect(controller.page_description).to eq('My awesome custom description') }
    end
  end

  describe '#page_keywords' do
    context 'when default' do
      it { expect(controller.page_keywords).to eq I18n.t('pages.anonymous.index.keywords') }
    end

    context 'when last_error given' do
      before do
        allow(controller).to receive_messages(:last_error => 'Something wrong', :last_error? => true)
      end

      it { expect(controller.page_keywords).to be_empty }
    end

    context 'when given custom keywords key' do
      before do
        controller.send(:set_keywords_key, 'foo.keywords')
      end

      it { expect(controller.page_keywords).to eq I18n.t('pages.anonymous.index.foo.keywords') }
    end

    context 'when not exist locale for given action' do
      before { allow(controller).to receive(:params).and_return(action: :noname) }

      it { expect { controller.page_keywords }.not_to raise_error }
    end

    context 'when with variables' do
      before do
        controller.send(:set_title_variables, foo: :bar)
        allow(controller).to receive(:params).and_return(action: :foo)
      end

      it { expect(controller.page_keywords).to eq I18n.t('pages.anonymous.foo.keywords', foo: :bar) }
    end
  end

  describe '#page_promo_text' do
    context 'when default' do
      it { expect(controller.page_promo_text).to eq I18n.t('pages.anonymous.index.promo_text') }
    end

    context 'when last_error given' do
      before do
        allow(controller).to receive_messages(:last_error => 'Something wrong', :last_error? => true)
      end

      it { expect(controller.page_promo_text).to be_empty }
    end

    context 'when given custom promo_text key' do
      before do
        controller.send(:set_promo_text_key, 'foo.promo_text')
      end

      it { expect(controller.page_promo_text).to eq I18n.t('pages.anonymous.index.foo.promo_text') }
    end

    context 'when not exist locale for given action' do
      before { allow(controller).to receive(:params).and_return(action: :noname) }

      it { expect { controller.page_promo_text }.not_to raise_error }
    end

    context 'when with variables' do
      before do
        controller.send(:set_title_variables, foo: :bar)
        allow(controller).to receive(:params).and_return(action: :foo)
      end

      it { expect(controller.page_promo_text).to eq I18n.t('pages.anonymous.foo.promo_text', foo: :bar) }
    end
  end

  describe '#title_postfix' do
    context 'when default' do
      it { expect(controller.title_postfix).to eq I18n.t('pages.anonymous.postfix') }
    end
  end

  describe '.define_seo_for' do
    let!(:seo_config_before) { Apress::PageInfo::SeoConfig.storage }

    after { Apress::PageInfo::SeoConfig.storage = seo_config_before }

    before do
      Apress::PageInfo::SeoConfig.configure do
        seo_for :'anonymous/index' do
          config :seo_for_user do
            desc 'Seo meta for user'
            condition -> { signed_in? }
            variables(foo: 'bar')
          end

          config :seo_for_guest do
            desc 'Seo meta for guest'
            variables(foo: 'fiz')
          end
        end
      end
    end

    context 'when guest' do
      before do
        allow(controller).to receive_messages(
          :signed_in? => false
        )
      end

      it 'defines title, description and header for guest' do
        get :index

        expect(controller.page_title).to eq(
          "#{I18n.t('pages.anonymous.index.seo_for_guest.title', foo: 'fiz')}#{postfix}"
        )
        expect(controller.page_description).to eq I18n.t('pages.anonymous.index.seo_for_guest.description', foo: 'fiz')
        expect(controller.page_keywords).to eq I18n.t('pages.anonymous.index.seo_for_guest.keywords', foo: 'fiz')
        expect(controller.page_header).to eq I18n.t('pages.anonymous.index.seo_for_guest.header', foo: 'fiz')
      end
    end

    context 'when user' do
      before do
        allow(controller).to receive_messages(
          :signed_in? => true
        )
      end

      it 'defines title, description and header for user' do
        get :index

        expect(controller.page_title).to eq(
          "#{I18n.t('pages.anonymous.index.seo_for_user.title', foo: 'bar')}#{postfix}"
        )
        expect(controller.page_description).to eq I18n.t('pages.anonymous.index.seo_for_user.description', foo: 'bar')
        expect(controller.page_keywords).to eq I18n.t('pages.anonymous.index.seo_for_user.keywords', foo: 'bar')
        expect(controller.page_header).to eq I18n.t('pages.anonymous.index.seo_for_user.header', foo: 'bar')
      end
    end
  end
end
