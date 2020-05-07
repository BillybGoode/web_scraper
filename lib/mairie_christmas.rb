require 'pry' #use with binding.pry
require 'nokogiri'
require 'open-uri'

def open_website(url)
    page = Nokogiri::HTML(open(url))   
    # page.class   # => Nokogiri::HTML::Document
    page
end

# returns e-mail from one townhall url
def get_townhall_email(url)
    page_html = open_website(url)
    mail = page_html.xpath("//body/div/main/section/div/table/tbody/tr/td/text()")[7].text()
end

def get_townhall_urls
    url = "https://www.annuaire-des-mairies.com/val-d-oise.html"
    page_html = open_website(url)

    townhall_urls = []
    page_html.xpath("//a[@class = 'lientxt']").each do |each_link|
        temp_hash = {}
        temp_hash[each_link.text()] = get_townhall_email("https://www.annuaire-des-mairies.com/" + each_link['href'][2..each_link['href'].size-1])
        townhall_urls << temp_hash
    end
    townhall_urls
end

# get_townhall_urls