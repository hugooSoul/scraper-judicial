require './lib/scraper'

url = 'https://www.poderjudicialvirtual.com/df-trejo-bouquet-jacqueline-del-carmen--nueva-wal-mart-de-mexico-s-de-r-l-de-c-v-y-servicios-adminis-26/2020'
scraper = Judicial::Scraper.new(url)
scraper.scraper

