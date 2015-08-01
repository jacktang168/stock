require 'open-uri'
require 'nokogiri'
#require 'iconv'



def  strParse(result)
     i = 0 
for str in result
   puts "股票名字"+"="+str    if i==0
   puts "今日开盘价"+"="+str  if i==1
   puts "昨日收盘价"+"="+str  if i==2
   puts "当前价格"+"="+str    if i==3
   puts "今日最高价"+"="+str  if i==4
   puts "今日最低价"+"="+str  if i==5
   puts "买一报价"+"="+str    if i==6
   puts "卖一报价"+"="+str    if i==7
   puts "成交的股票数"+"="+str  if i==8
   puts "成交金额"+"="+str      if i==9
   puts "买一成交"+"="+str      if i==10
   puts "买一报价"+"="+str  if i==11
   puts "买二成交"+"="+str  if i==12
   puts "买二"+"="+str  if i==13
   puts "买三成交"+"="+str  if i==14
   puts "买三"+"="+str  if i==15
   puts "买四成交"+"="+str  if i==16
   puts "买四"+"="+str  if i==17
   puts "买五成交"+"="+str  if i==18
   puts "买五"+"="+str  if i==19
   puts "卖一成交"+"="+str  if i==20
   puts "卖一"+"="+str  if i==21
   puts "卖二成交"+"="+str  if i==22
   puts "卖二"+"="+str  if i==23
   puts "卖三成交"+"="+str  if i==24
   puts "卖三"+"="+str  if i==25
   puts "卖四成交"+"="+str  if i==26
   puts "卖四"+"="+str  if i==27
   puts "卖五成交"+"="+str  if i==28
   puts "卖五"+"="+str  if i==29
   puts "日期"+"="+str if i==30
   puts "时间"+"="+str  if i==31
   puts "尾巴"+"="+str  if i==32
   i = i+1
end
end
    
page = Nokogiri::HTML(open("http://hq.sinajs.cn/list=sz150181,sz150182"),nil,"GBK")
#page.encoding = "GB18030"
#page = Iconv.iconv("UTF-8","GB2312",Nokogiri::HTML(open("http://hq.sinajs.cn/list=sz150181")))  
#puts  Iconv.iconv("GBK","UTF-8",page.css('p').text)
#puts page.css('p').text
#puts  page.css('p').text

tmp = page.css('p').text.split(';')
i = 0
while i < tmp.length-1 do
     result = tmp[i].split('=')
     #strParse(result[1].split(','))
     xx = result[1].split(',')
     puts xx[3]
     puts xx[0]
     i = i+1 
     puts '--------------------'
end


page = Nokogiri::HTML(open("http://finance.sina.com.cn/fund/quotes/150181/bc.shtml"),nil,"GBK")

#puts page.css('div[class="listnum"]').css['tbody']
#html = page.css('div[class="listnum"]')[0]
#puts page.xpath(("//table/tr"))[1].content
for a in  page.css('div[class="box-hq"]')
    
    #b = /(\D{0,1}\d{1,10}\D{0,1}\d{1,10}\D{0,1})(\D{0,1}\d{1,10}\D{0,1}\d{1,10}\D{0,1})/.match(a.content)
    b = /单位净值:\d.\d{0,4}/.match(a.content)
    bb = /(单位净值:)(\d.\d{0,4})/.match(a.content)
    puts b
    #b = /\d{1,10}/.match(a.content)
   # puts b.length
   # puts b[0]
   # puts b[1]
   # puts a.content
    puts bb[2]

end

for a in page.css('div[class="fund-title"]')

    b = /母基金:\d{6}/.match(a.content)
    b1 = /子基金:\d{6}/.match(a.content)
    x  = /(子基金:\d{6})  (母基金:\d{6})/.match(a.content)
    xx = /(子基金:)(\d{6})  (母基金:)(\d{6})/.match(a.content)
    puts a.content
    puts b
    puts b1
    puts x.length
    puts x[0]
    puts x[1]
    puts x[2]
    puts xx.length
    puts xx[2]
    puts xx[4]
     
end



