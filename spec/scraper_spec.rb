require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe AppleWarranty::Scraper do

  context 'before data fetched' do
    before(:each) do
      @scraper = AppleWarranty::Scraper.new
    end
    describe '.errors' do
      it 'is empty' do
        expect(@scraper.errors).to eq []
      end
    end
    describe '.warranty_expired?' do
      it 'fire exception' do
        expect { @scraper.warranty_expired? }.to raise_error(AppleWarranty::Errors::DataNotFetchedError)
      end
    end
    describe '.warranty_active?' do
      it 'fire exception' do
        expect { @scraper.warranty_active? }.to raise_error(AppleWarranty::Errors::DataNotFetchedError)
      end
    end
    describe '.warranty_expired_at' do
      it 'fire exception' do
        expect { @scraper.warranty_expired_at }.to raise_error(AppleWarranty::Errors::DataNotFetchedError)
      end
    end
  end

  context 'data fetched with active warranty' do
    before(:all) do
      response_data = File.read(File.dirname(__FILE__) + '/fixtures/response_with_warranty.html')
      stub_request(:get, /013977000323877/).to_return(body: response_data)

      @scraper = AppleWarranty::Scraper.new
      @scraper.get_data('013977000323877')
    end

    describe '.warranty_expired?' do
      it { expect(@scraper.warranty_expired?).to eq false }
    end

    describe '.warranty_active?' do
      it { expect(@scraper.warranty_active?).to eq true }
    end

    describe '.warranty_expired_at' do
      it { expect(@scraper.warranty_expired_at).to eq Date.new(2016, 6, 15) }
    end
  end

  context 'data fetched with expired warranty' do
    before(:all) do
      response_data = File.read(File.dirname(__FILE__) + '/fixtures/response_without_warranty.html')
      stub_request(:get, /DQTJRT2YF193/).to_return(body: response_data)

      @scraper = AppleWarranty::Scraper.new
      @scraper.get_data('DQTJRT2YF193')
    end

    describe '.warranty_expired?' do
      it { expect(@scraper.warranty_expired?).to eq true }
    end

    describe '.warranty_active?' do
      it { expect(@scraper.warranty_active?).to eq false }
    end

    describe '.warranty_expired_at' do
      it { expect(@scraper.warranty_expired_at).to eq nil }
    end
  end

  context 'blank data fetched' do
    before(:all) do
      stub_request(:get, /ERRRORPAGE/).to_return(body: '')
      @scraper = AppleWarranty::Scraper.new
      @scraper.get_data('ERRRORPAGE')
    end

    describe '.errors' do
      it 'has 1 error' do
        expect(@scraper.errors.length).to eq 1
      end
    end

    describe '.warranty_expired?' do
      it 'fire exception' do
        expect { @scraper.warranty_expired? }.to raise_error(AppleWarranty::Errors::DataNotFetchedError)
      end
    end
    describe '.warranty_active?' do
      it 'fire exception' do
        expect { @scraper.warranty_active? }.to raise_error(AppleWarranty::Errors::DataNotFetchedError)
      end
    end
    describe '.warranty_expired_at' do
      it 'fire exception' do
        expect { @scraper.warranty_expired_at }.to raise_error(AppleWarranty::Errors::DataNotFetchedError)
      end
    end
  end

  context 'data fetch error' do
    before(:all) do
      stub_request(:get, /500PAGEERROR/).to_return(body: '', status: 500)
      @scraper = AppleWarranty::Scraper.new
      @scraper.get_data('500PAGEERROR')
    end

    describe '.errors' do
      it 'has 1 error' do
        expect(@scraper.errors.length).to eq 1
      end
    end
  end


  context 'invalid imei' do
    before(:each) do
      @scraper = AppleWarranty::Scraper.new
    end

    describe '.get_data' do
      it 'false if imei length less than 10 chars' do
        expect(@scraper.get_data('1234567890123456')).to eq false
      end
      it 'false if imei length more than 15 chars' do
        expect(@scraper.get_data('123456789')).to eq false
      end
    end
  end
end
