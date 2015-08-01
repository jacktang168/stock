class MainController < ApplicationController

    def index
        @stock_hash = []
        stock_group = ["150181","150209"]  #  分级A基金代码
        for code in stock_group
            stock = []
            stock[0] = code
            page = Nokogiri::HTML(open("http://finance.sina.com.cn/fund/quotes/"+code+"/bc.shtml"),nil,"GBK")
            #找到A净值
            for a in  page.css('div[class="box-hq"]')
               b =  /(单位净值:)(\d.\d{0,4})/.match(a.content)
               stock[1]  = b[2] 
            end

            tmps = []
            #迭代出B基金和母基金
            for a in page.css('div[class="fund-title"]')
               tmps = /(子基金:)(\d{6})  (母基金:)(\d{6})/.match(a.content)
            end
           
            #找B基金的代码
            b_code = tmps[2]
            stock[2]  = b_code
            page = Nokogiri::HTML(open("http://finance.sina.com.cn/fund/quotes/"+b_code+"/bc.shtml"),nil,"GBK")
            for a in  page.css('div[class="box-hq"]')
               b =  /(单位净值:)(\d.\d{0,4})/.match(a.content)
               stock[3] =  b[2] 
            end
            
            #找母基金代码
            m_code = tmps[4]
            stock[4]  = m_code
            page = Nokogiri::HTML(open("http://finance.sina.com.cn/fund/quotes/"+m_code+"/bc.shtml"),nil,"GBK")
            for a in  page.css('div[class="box-hq"]')
               b =  /(单位净值:)(\d.\d{0,4})/.match(a.content)
               stock[5]  = b[2] 
            end
            
            #上新浪取实时价格
            page = Nokogiri::HTML(open("http://hq.sinajs.cn/list=sz"+stock[0]+","+"sz"+stock[2]),nil,"GBK")
            tmp = page.css('p').text.split(';')
            i = 0
            x = 6
            while i < tmp.length-1 do
               result = tmp[i].split('=')
               xx = result[1].split(',')
               i = i+1 
               stock[x] = xx [0]  #股票名称
               x = x+1
               stock[x] = xx [3]  #股票价格
               x = x+1
            end
            @stock_hash << stock
        end 

    end
end
