require 'rails_helper'

RSpec.describe GetDomainsService do
  let!(:redis) { Redis.new(db: 1) }
  let(:params) { ["https://stackoverflow.com/questions/11828270/", "mail.ru"] }

  before do
    SaveLinksService.new.call(params)
  end

  describe '#call' do
    let(:result) { described_class.new(from, to).call }

    context 'valid data' do
      let(:from) { (Time.now - 1.hour).strftime("%Y%m%d%H") }
      let(:to) { (Time.now + 1.hour).strftime("%Y%m%d%H") }

      it 'returm array of domains' do
        expect(result). to eq(["stackoverflow.com", "mail.ru"])
      end
    end

    context 'invalid data' do
      let(:from) { 0 }
      let(:to) { '2020030910' }

      it 'return nil' do
        expect(result).to be nil
      end
    end
  end
end
