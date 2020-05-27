require './lib/scraper'

url = 'https://lta.reuters.com/articulo/salud-coronavirus-mexico-datos-idLTAKBN23301D?taid=5ecdc9aa9e7b1b0001fda890&utm_campaign=trueAnthem%3A+Trending+Content&utm_medium=trueAnthem&utm_source=twitter'
scraper = Judicial::Scraper.new(url)
scraper.scraper

