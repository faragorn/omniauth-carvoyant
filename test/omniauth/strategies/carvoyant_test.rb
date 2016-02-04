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
      subject.options.client_options.site.must_equal "https://api.carvoyant.com/v1/api"
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

  describe 'uid' do
    it 'must return id from raw_info' do
      subject.stub :raw_info, {'id' => 123 } do
        subject.uid.must_equal 123
      end
    end
  end

  describe 'info' do
    it 'must return name from raw_info' do
      subject.stub :raw_info, { 'firstName' => 'John', 'lastName' => 'Doe' } do
        subject.info['name'].must_equal 'John Doe'
      end
    end
    it 'must return first_name from raw_info' do
      subject.stub :raw_info, {'firstName' => 'John' } do
        subject.info['first_name'].must_equal 'John'
      end
    end
    it 'must return last_name from raw_info' do
      subject.stub :raw_info, {'lastName' => 'Doe' } do
        subject.info['last_name'].must_equal 'Doe'
      end
    end
    it 'must return email from raw_info' do
      subject.stub :raw_info, {'email' => 'email@domain.com' } do
        subject.info['email'].must_equal 'email@domain.com'
      end
    end
    it 'must return username from raw_info' do
      subject.stub :raw_info, {'username' => 'johny' } do
        subject.info['username'].must_equal 'johny'
      end
    end
  end

  describe 'raw info' do

    let(:response_body) do
      {
        account: [{
          id: 3,
          firstName: 'Speed',
          lastName: 'Racer',
          username: 'speedracer',
          email: 'speedracer@mail.com'}]
      }
    end

    let(:client) do
      OAuth2::Client.new('abc', 'def') do |builder|
        builder.adapter :test do |stub|
          stub.get("#{subject.class::SITE_PREFIX}/account") { |env|
            [200, { 'content-type' => 'application/json' }, MultiJson.encode(response_body)]
          }
        end
      end
    end
    let(:access_token) { OAuth2::AccessToken.from_hash(client, {}) }

    it 'must properly parse server response' do
      subject.stub :access_token, access_token do
        subject.raw_info.must_include 'id'
        subject.raw_info.must_include 'firstName'
        subject.raw_info.must_include 'lastName'
        subject.raw_info.must_include 'email'
        subject.raw_info.must_include 'username'
      end
    end
  end

  describe 'callback url' do
    it 'should ignore query_string' do
    end
  end
end
