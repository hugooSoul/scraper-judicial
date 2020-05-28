# scraper.rb
require 'HTTParty'
require 'Nokogiri'
require 'open-uri'
require 'pry'

module Judicial
    class Scraper
        def initialize(url = nil)
            @uri = url
        end
    
        def parse_url(url)
            uri = URI.parse(url)
            uri.is_a?(URI::HTTP) && !uri.host.nil?
            unparsed_page = open(uri)
            Nokogiri::HTML(unparsed_page)

        rescue => e
            print e
        end
    
        def scraper
            parsed_page = parse_url(@uri)

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
            
            print document_info
            return document_info
        end
    end
end
