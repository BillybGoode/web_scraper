require_relative "../lib/mairie_christmas.rb"

describe "For a given url uses nokogiri to open the link " do
    it "checks using nokogiri page.class" do
        expect(open_website("https://www.github.com").class).to eq(Nokogiri::HTML::Document)
    end
end

load_once = get_townhall_urls

describe "Output format testing : " do
    it "Array class is returned" do
        expect(load_once.class).to eq(Array)
    end
    it "Hash classes are within the array" do
        expect(load_once[0].class).to eq(Hash)
        expect(load_once[-1].class).to eq(Hash)
    end
end