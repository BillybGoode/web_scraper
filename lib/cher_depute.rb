require 'pry' #use with binding.pry
require 'nokogiri'
require 'open-uri'

$nomail_count = 0

def open_website(url)
    page = Nokogiri::HTML(open(url))   
    # page.class   # => Nokogiri::HTML::Document
    page
end

# returns hash with deputy infos
def get_one_deputy_infos(url)
    infos = {}
    page_html = open_website(url)
    fullname = page_html.xpath("//body/div/div/div/div/div/section/div/article/div/h1").text().split(" ")
    puts "Récupération du mail de : #{fullname.join(" ")}"
    infos['first_name'] = fullname[1]
    infos['last_name'] = fullname[2..fullname.size-1].join(' ')
    begin
        infos['email'] = page_html.xpath("//body/div/div/div/div/div/section/div/article/div/div/dl/dd/ul/li/a")[2].text()
    rescue # si pas d'email renseigné
        infos['email'] = "N/A"
        $nomail_count += 1
    end

    infos
end

def get_all_deputy_infos
    page_html = open_website('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique')
    list_of_deputy_info = []
    deputy_links = page_html.xpath("/html/body/div/div/div/div/section/div/article/div/div/div/div/ul/li/a")
    
    deputy_links.each do |link|
        url = 'http://www2.assemblee-nationale.fr' + link['href']
        list_of_deputy_info << get_one_deputy_infos(url)
    end

    puts "#{$nomail_count} erreur(s) rencontrée(s) >> pas d'e-mail (c'est louche)."
    list_of_deputy_info
end