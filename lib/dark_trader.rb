require 'pry' #use with binding.pry
require 'nokogiri'
require 'open-uri'

def open_website(url)
    page = Nokogiri::HTML(open(url))   
    # page.class   # => Nokogiri::HTML::Document
    page
end

# returns an array of hashes crypto_name:value
def coinmarketcap_parser
    page_html = open_website("https://coinmarketcap.com/all/views/all/")
    
    coin_name = page_html.xpath("//tbody/tr/td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol']")
    coin_market = page_html.xpath("//tbody/tr/td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']")
    
    crypto_name_list = []
    crypto_price_list = []

    coin_name.each {|element| crypto_name_list << element.text() }
    coin_market.each {|element| crypto_price_list << element.text()[1..element.text().size-1].to_f }

    list_crypto_info = []
    for i in 0..crypto_name_list.size-1 do
        crypto_hash = {}
        crypto_hash[crypto_name_list[i]] = crypto_price_list[i]
        list_crypto_info << crypto_hash
    end
    list_crypto_info
end