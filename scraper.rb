require 'HTTParty'
require 'Nokogiri'
require 'open-uri'
require 'pry'

class Scraper

    # attr_accessor :url

    #def initialize(url)
    #    @url = url
    #end

    def parse_url(url)
        unparsed_page = open(url)
        Nokogiri::HTML(unparsed_page)
    end

    def scraper(url)
        parsed_page = parse_url(url)

        # header = parsed_page.css('div.header').children[1].text
        # header_split = header.split('|')
        # header_split_exp = header_split.last.split('Exp:')

        court = parsed_page.css('div.content').children[4].children[0].text.split('>').last.strip
        author = parsed_page.css('div.content').children[4].children[2].text.split('Actor:').last.strip
        defendant = parsed_page.css('div.content').children[4].children[4].text.split('Demandado:').last.strip

        summary = parsed_page.css('div.content').children[7].text
        notification = parsed_page.css('div.postDegradado').css('li.list-group-item').map{ |nots| p nots.children[3].text }.compact

        document_info = [
            court: court,
            author: author,
            defendant: defendant,
            summary: summary,
            notification: notification
        ]

        return document_info
    end
end

#scraper = Scraper.new("https://www.poderjudicialvirtual.com/df-floriberto-garcia-ramirez--c-director-del-registro")
#scraper = Scraper.new("https://www.poderjudicialvirtual.com/df-trejo-bouquet-jacqueline-del-carmen--nueva-wal-mart-de-mexico-s-de-r-l-de-c-v-y-servicios-adminis-26/2020")
#scraper.scraper
scraper = Scraper.new
#scraper.scraper('https://www.poderjudicialvirtual.com/df-floriberto-garcia-ramirez--c-director-del-registro')
