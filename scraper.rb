#!/usr/bin/env ruby
require 'HTTParty'
require 'Nokogiri'
require 'uri'
require 'pry'

class Scraper

    attr_accessor :url
    BASE_PATH = "https://www.poderjudicialvirtual.com/"

    def initialize(url)
        @url = BASE_PATH + url
    end

    def parse_url(url)
        unparsed_page = HTTParty.get(@url)
        Nokogiri::HTML(unparsed_page)
    end

    def scraper
        parsed_page = parse_url(@url)

        # header = parsed_page.css('div.header').children[1].text
        # header_split = header.split('|')
        # header_split_exp = header_split.last.split('Exp:')

        court = parsed_page.css('div.content').children[4].children[0].text.split('>').last.strip
        author = parsed_page.css('div.content').children[4].children[2].text.split('Actor:').last.strip
        defendant = parsed_page.css('div.content').children[4].children[4].text.split('Demandado:').last.strip

        summary = parsed_page.css('div.content').children[7].text
        notification = parsed_page.css('div.postDegradado').css('li.list-group-item').map{ |nots| p nots.children[3].text }.compact
    end
end

# scraper = Scraper.new("https://www.poderjudicialvirtual.com/df-floriberto-garcia-ramirez--c-director-del-registro")
#scraper = Scraper.new("https://www.poderjudicialvirtual.com/df-trejo-bouquet-jacqueline-del-carmen--nueva-wal-mart-de-mexico-s-de-r-l-de-c-v-y-servicios-adminis-26/2020")
#scraper.scraper
