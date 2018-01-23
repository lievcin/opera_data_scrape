require 'rubygems'
require 'nokogiri'
require 'open-uri'

226.upto(400).each do |season_number| #570
  base_url = "https://www.mariinsky.ru"
	url = base_url + "/en/playbill/archive?season=" + season_number.to_s
  doc = Nokogiri::HTML(open(url))


  # opera_title = doc.at_css(".navigation_title")&.text
  # opera_description = doc.at_css(".perf_desc_title")&.text


  doc.css(".playbill_archive_months a").each do |month_url|
    month = doc.css("h1").text.gsub("Playbill for ", "")
    url_performance = base_url + month_url[:href]
    doc_performance = Nokogiri::HTML(open(url_performance))
    doc_performance.css("div#afisha .row").each do |row|
      performance_date = row.css(".d").text + ' ' + month
      opera_name = row.css(".spec_name").text.gsub("\n", ' ').squeeze(' ').strip
      opera_link = row.css(".spec_name a")[0][:href]
      opera_url = base_url + opera_link
      opera_cast = Nokogiri::HTML(open(opera_url))

    end
  end

    month_link = performance[:href]
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
