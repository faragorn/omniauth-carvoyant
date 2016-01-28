require 'test_helper'

describe OmniAuth::Strategies::Carvoyant do
  let(:enterprise_site) { 'https://some.other.site.com' }
  let(:enterprise_authorize_url) { 'https://some.other.site.com/oauth/authorize' }
  let(:enterprise_token_url) { 'https://some.other.site.com/oauth/token' }

  let(:enterprise) do
    OmniAuth::Strategies::Carvoyant.new('CARVOYANT_KEY', 'CARVOYANT_SECRET',
      {
        :client_options => {
          :site => enterprise_site,
          :authorize_url => enterprise_authorize_url,
          :token_url => enterprise_token_url
        }
      }
    )
  end

  subject do
    OmniAuth::Strategies::Carvoyant.new({})
  end


  describe 'client options' do
    it 'should have correct site' do
      subject.options.client_options.site.must_equal "https://auth.carvoyant.com"
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.must_equal 'https://auth.carvoyant.com/oauth/authorize'
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.must_equal 'https://api.carvoyant.com/oauth/token'
    end
    describe "should be overrideable" do
      it "for site" do
        enterprise.options.client_options.site.must_equal enterprise_site
      end

      it "for authorize url" do
        enterprise.options.client_options.authorize_url.must_equal enterprise_authorize_url
      end

      it "for token url" do
        enterprise.options.client_options.token_url.must_equal enterprise_token_url
      end
    end
  end
end
