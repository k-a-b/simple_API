require 'rails_helper'

RSpec.describe SaveLinksService do
  subject { described_class.new }
  let!(:redis) { Redis.new(db: 1) }
  let(:valid_params) { ["https://stackoverflow.com/questions/11828270/", "mail.ru"] }
  let(:invalid_params) { [] }

  describe 'redis' do

    before do
      allow_any_instance_of(described_class).to receive(:time_stamp).and_return(time_stamp)
    end

    context 'valid params' do
      let(:time_stamp) { '2020060909061591685791' }

      before { subject.call(valid_params) }

      it 'save' do
        expect(redis.keys).to include(time_stamp)
      end

      it 'save rigt link' do
        expect(JSON.parse(redis.get(time_stamp))).to eq(valid_params)
      end
    end

    context 'invalid params' do
      let(:time_stamp) { '2020060910061591685791' }
      before { subject.call(invalid_params) }

      it 'don\'t save link' do
        expect(redis.get(time_stamp)).to be nil
      end
    end
  end

  describe '#call' do
    context 'valid data' do
      let(:result) { subject.call(valid_params) }

      it 'return OK' do
        expect(result).to eq('OK')
      end
    end

    context 'invalid data' do
      let(:result) { subject.call(invalid_params) }

      it 'return error' do
        expect(result).to eq('array is empty')
      end
    end
  end
end
