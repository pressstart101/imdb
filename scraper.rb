require 'nokogiri'
require 'open-uri'
require 'capybara/poltergeist'

require_relative './person.rb'
require_relative './mostKnownWork.rb'

# session = Capybara::Session.new(:poltergeist)


# session.visit('https://www.gov.uk/')
# session.fill_in('q', with: 'passport')
# session.click_button('Search')
# session.all('#results h3').each do |h3|
#   puts h3.text.strip
# end

class Scraper
  def get_page
    Nokogiri::HTML(open("http://www.imdb.com/search/name?birth_monthday=02-02"))
  end

  def get_people
    self.get_page.css("div.lister-item")
    # person = self.get_page.css("div.lister-item").first
    # name = person.css("h3 a").text.strip
    # photo = person.css("div.lister-item-image img").attr('src')
    # profile = "http://www.imdb.com" + person.css("h3 a").attr('href')
    # puts profile
  end

  def make_people
    self.get_people.each do |post|
      person = Person.new
      work = MostKnownWork.new
      person.mostKnownWork = work
      person.name = post.css("h3 a").text.strip
      person.photoURL = post.css("div.lister-item-image img").attr('src')
      person.profileUrl = "http://www.imdb.com" + post.css("h3 a").attr('href')
      person.mostKnownWork.title = post.css("p a").first.text
      person.mostKnownWork.url = "http://www.imdb.com" + post.css("p a").attr('href')
      session = Capybara::Session.new(:poltergeist)
      session.visit(person.mostKnownWork.url)
      rate = session.first('div.ratingValue')
      dir = session.first('div.credit_summary_item a')
      person.mostKnownWork.rating = rate.text
      person.mostKnownWork.director = dir.text

      # element = session.first('article header h2')
      # puts element.text.strip
      break
    end
  end

  def print_people
    self.make_people
    Person.all.each do |person|
      if person.name
        puts "  name: #{person.name}"
        puts "  photoURL: #{person.photoURL}"
        puts "  profileUrl: #{person.profileUrl}"
        puts "  mostKnownWork #{person.mostKnownWork.title}"
        puts "  mostKnownWork #{person.mostKnownWork.rating}"
        puts "  mostKnownWork #{person.mostKnownWork.director}"
        puts "  mostKnownWork #{person.mostKnownWork.url}"
      end
    end
  end


  # movie_title = imdb_nokogiri.css("h1 span.itemprop").text
  # test = imdb_nokogiri.css("//h1[@itemprop = 'name']").text
  # puts test

end
one = Scraper.new
one.print_people