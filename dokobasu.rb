#!/usr/bin/env ruby

# -*- coding: utf-8 -*-

require 'net/http'
require 'kconv'
require 'nokogiri'

Net::HTTP.start('www.dokobasu.kotsu.city.sendai.jp', 80) {|http|
  stop_s ="東北大川内キャンパス・萩ホール前"
  stop_e ="情報科学研究科前"
  response = http.post('/busloca/sekin.htm',"stop_s=#{stop_s.encode("Shift_JIS")}&stop_e=#{stop_e.encode("Shift_JIS")}")
  doc = Nokogiri::HTML(Kconv.toutf8(response.body))
  doc.xpath('//table[@class="SEKIN"][@width="933"]/tr').each do |trs|
    puts trs.xpath('td').text
  end
}
