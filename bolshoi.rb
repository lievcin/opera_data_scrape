require 'rubygems'
require 'nokogiri'
require 'open-uri'

1.upto(1).each do |opera_number| #570
	url = "https://www.bolshoi.ru/en/performances/" + opera_number.to_s + "/roles/#all"
  doc = Nokogiri::HTML(open(url))
  opera_title = doc.at_css(".navigation_title")&.text
  opera_description = doc.at_css(".perf_desc_title")&.text
  doc.css(".performance_main_content__dates_all .cast_selector").each do |performance|
    if performance[:href]
    	date = performance[:href]
    	date[0] = '' #remove the first character
    	cast = doc.css(".cast_" + date)

    	cast.search('tr').each do |row|
    		role = row.css(".performance_main_content__cast_role_name").text
    		artist = row.css(".performance_main_content__cast_role_person").text.gsub("\n", ' ').squeeze(' ').strip
    		print opera_number.to_s + ' - '
    		print opera_title + ' - '
    		print date[0..7] + ' - '
    		print role + ' - '
    		print artist
    		puts ' '
			end

    end
  end

end
