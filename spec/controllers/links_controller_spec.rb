require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :controller do

  describe 'POST #visited_links' do
    context 'valid request' do
      let(:params) {
        {
          "links": [
            "https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor",
          ]
        }
      }
      before do
        post :visited_links, params: params
      end

      it 'return OK' do
        expect(JSON.parse(response.body)).to eq({ "status" => "ok" })
      end
    end

    context 'invalid request' do
      let(:params) { { "links": [] } }

      expected_response = {
        "status" => {
          "error" => "array is empty"
        }
      }

      before do
        post :visited_links, params: params
      end

      it 'return error' do
        expect(JSON.parse(response.body)).to eq(expected_response)
      end
    end
  end

  describe 'GET #visited_domains' do
    context 'valid request' do
      let(:from) { (Time.now - 1.day).strftime("%Y%m%d%H") }
      let(:to) { (Time.now + 1.day).strftime("%Y%m%d%H") }
      let(:params) { { from: from, to: to } }

      before do
        get :visited_domains, params: params
      end

      it 'return ok' do
        expect(JSON.parse(response.body).dig('status')).to eq('ok')
      end
    end

    context 'invalid request' do
      before do
        get :visited_domains, params: {}
      end

      it 'return error' do
        expect(JSON.parse(response.body)).to eq({ "status" => "error" })
      end
    end
  end
end
