require_relative "../lib/dark_trader.rb"

describe "For a given url uses nokogiri to open the link " do
    it "checks using nokogiri page.class" do
        expect(open_website("https://www.github.com").class).to eq(Nokogiri::HTML::Document)
    end
end

load_once = coinmarketcap_parser

describe "Output format testing : " do
    it "Array class is returned" do
        expect(load_once.class).to eq(Array)
    end
    it "Hash classes are within the array" do
        expect(load_once[0].class).to eq(Hash)
        expect(load_once[-1].class).to eq(Hash)
    end
end

def test_a(coin_name)
    test_success = false
    load_once.each do |each_hash|
        if each_hash.has_key?(coin_name)
            test_success = true
            break
        end
    end
    test_success ? 'BTC' : nil
end

describe "Testing if the program can at least retrieve the following crypto name for " do
    it "Bitcoin." do
        expect(test_a('BTC')).to eq('BTC')
    end
    it "Ethereum." do
        expect(test_a('ETH')).to eq('BTC')
    end
end

describe "Testing if a float number is retrieved as value for " do
    it "some random hashes" do
        expect(load_once[rand(0..load_once.size-1)].values[0].class).to eq(Float)
        expect(load_once[rand(0..load_once.size-1)].values[0].class).to eq(Float)
        expect(load_once[rand(0..load_once.size-1)].values[0].class).to eq(Float)
        expect(load_once[rand(0..load_once.size-1)].values[0].class).to eq(Float)
        expect(load_once[rand(0..load_once.size-1)].values[0].class).to eq(Float)
    end
end