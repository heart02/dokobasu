#!/usr/bin/env ruby

# -*- coding: utf-8 -*-

require 'net/http'
require 'kconv'
require 'nokogiri'

Net::HTTP.start('www.dokobasu.kotsu.city.sendai.jp', 80) {|http|
  stop_s ="電力ビル前"
  stop_e ="木町通二丁目"
  response = http.post('/busloca/sekin.htm',"stop_s=#{stop_s.encode("Shift_JIS")}&stop_e=#{stop_e.encode("Shift_JIS")}")
  doc = Nokogiri::HTML(Kconv.toutf8(response.body))
  
  #TIME
  doc.xpath('//table[@class="MAIN_WIDTH"]/tr').each do |trs02|
  puts trs02.xpath('td[@class="INFO_TIME"]').text
  
  end
  #start end
    doc.xpath('//table[@class="MAIN_WIDTH"]/tr').each do |trs02|
  puts trs02.xpath('td[@class="PAGE_TITLE"]').text  
  
  end
  
  
  doc.xpath('//table[@class="SEKIN"][@width="933"]/tr').each do |trs|
    #puts trs.xpath('td').text
    keito = trs.xpath('td[@width="60"]').text
    ikisaki = trs.xpath('td[@width="284"]').text
    noriba = trs.xpath('td[@width="45"]').text
    syaryo_unkoujoukyo = trs.xpath('td[@width="96"]').text
    bikou = trs.xpath('td[@width="246"]').text    
    
    puts "系統番号:#{keito}"
    puts "行　先:#{ikisaki}"
    puts "のりば:#{noriba}"
    puts "車両&運行状況:#{syaryo_unkoujoukyo}"
    puts "備考:#{bikou}"
    
  end
}
