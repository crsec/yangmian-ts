require("TSLib")
require("tsp")
require("AWZ")
require("ALZ")


----------------------封装---------------------


function movet(x,y,x1,y1,time)
local time = time or 2

touchDown(x, y);    --在坐标 (150, 550)按下
mSleep(30);
touchMove(x1, y1);    --移动到坐标 (150, 600)，注意一次滑动的坐标间隔不要太大，不宜超过 50 像素
mSleep(30);
touchUp(x1, x1);

delay(time)

end


phonekeyArr = {
	{  131,  950, 0x000000},
	{  365,  955, 0x000000},
	{  644,  946, 0x000000},
	{  115, 1056, 0x000000},
	{  366, 1046, 0x191919},
	{  639, 1049, 0x000000},
	{  120, 1172, 0x000000},
	{  373, 1157, 0x000000},
	{  641, 1152, 0x000000},
	[0]={  362, 1280, 0x000000},
}

function phoneKey(phone)
	for i =1,string.len(phone) do
		local phone_mun = tonumber(string.sub(phone,i,i))
		click(phonekeyArr[phone_mun][1],phonekeyArr[phone_mun][2],0.3)
	end
end

function ocr(x1,y1,x2,y2)
	return ocrText(x1,y1,x2,y2, 0) or 0
end


function orcText(t)
	local res={}
	for k,v in pairs(t)do
		local text = ocr(v[1],v[2],v[3],v[4])
		res[k]=text
		log(text)
	end
	res['pwd']=res.ka1mima1..res.ka1mima2
	
	var.name = "京东E卡"
	var.idfa = res.ka1
	var.password = res.pwd
	var.phone = var.phone
	idfaupdate()
	return res
end

function orcText_(t)
	keepScreen(true)
	local res={}
	for k,v in pairs(t)do
		local text = ocr(v[1],v[2],v[3],v[4])
		res[k]=text
		log(text)
	end
	var.name = "积分卡券"
	var.idfa = res_.ka
	var.password = res_.pwd
	var.phone = var.phone
	idfaupdate()
	keepScreen(false)
	return res
end

local res={}
------------82元扫描-------------
res.ka1={134, 530,462, 560}
res.ka1mima1={532, 530,701, 563}
res.ka1mima2={75, 571,241, 602}
------------21元扫描-------------
res_={}
res_.ka={134, 530,417, 561}
res_.pwd={489, 530,585, 562}

------------------上传idfa888----------------------
function idfaupdate()
	local url = "http://idfa888.com/Public/idfa/?service=idfa.idfa"
	local tb={}
	tb.name = var.name or '畅享家充值'
	tb.idfa = var.idfa or var.phone
	tb.ip = var.ip
	tb.phonename = var.phonename or getDeviceName()
	tb.other = var.other 
	tb.password = var.password
	tb.phone = var.phone
	tb.account = var.account or var.awz_name
	return post(url,tb)
end


------------------------从wenfree获取-------------------------
function getwenfree()
	local url = "http://wenfree.cn/api/Public/tjj/?service=hbcy.getNoId"
	local tc={}
	return post(url,tc)
end
-----返回当前ID激活-------
function back()
	local url = "http://wenfree.cn/api/Public/tjj/?service=hbcy.backNoId"
	local tc={
		['id']=var.id
		}
	return post(url,tc)
end


----------------变量----------获取var数据---------------------------
var = {}

---------------主要参数---------------------

--url = 'https://m.changyoyo.com/partner/index.htm#shareTo?inviteCode=224b0406e0761ddbae80458ea5c116d1'
url = 'https://m.changyoyo.com/partner/index.htm#shareTo?inviteCode=8cd4d82d628ce0f3b3a9b5129a9db76a'
safaribid = 'com.apple.mobilesafari'
zhifubao = 'com.alipay.iphoneclient'

----支付密码----
tihot001 = '123124'

-----------------------------------safari--------------------------------------------------------------------
t = {}
t['立即开通'] = { 0x181218, "-22|36|0x6b5c49,-341|-3|0xe2583d,-341|14|0xfff1db", 90, 6, 1152, 739, 1324}

t['密码登录界面'] = {0xb6b6b6, "15|-3|0x727272,3|33|0x333333,136|33|0x4a4a4a,153|12|0x000000,146|-1|0x0a0a0a", 90, 38, 239, 203, 399}
t['登录'] = { 0xfffefa, "-5|0|0xffedb2,-8|19|0xfff2c7,50|18|0xfff7de,-170|-27|0xffedb2,226|39|0xffedb2", 90, 130, 488, 615, 1119}
	t['密码登录界面or登录_点手机号'] = { 0xf6f6f6, "23|-2|0xcdcdcd,6|26|0xebebeb,37|26|0xc1c1c1,76|26|0xe7e7e7,85|-1|0xbcbcbc", 90, 36, 202, 139, 773}
	t['密码登录界面or登录_点手密码'] = { 0xf2f2f2, "3|26|0xbcbcbc,25|26|0xdcdcdc,57|-1|0xc9c9c9,59|12|0xcacaca,56|26|0xdfdfdf", 90, 38, 263, 112, 1116}
	t['密码登录界面or登录_完成'] = { 0x057cff, "-32|-9|0x5fa8fa,24|9|0x3292fc", 90, 666, 745, 737, 801}

t['立即加入'] = { 0x000000, "-45|-10|0x000000,-139|-38|0xffc922,150|42|0xffc922,65|14|0x211a04", 90, 434, 1140, 745, 1248}	
	t['立即加入_点击月卡'] = { 0xffffff, "-228|-55|0xff4119,-211|49|0x000000,70|-18|0xdddddd", 90, 380, 345, 725, 496}

t['会员专属权益界面'] = { 0xb87e3c, "2|-9|0xba813f,36|-6|0xb87e3c,139|-7|0xcda475,177|4|0xc18e54,216|3|0xbc8446", 90, 29, 156, 303, 516}
	t['会员专属权益界面_京东E卡'] = { 0x584b3b, "-23|-5|0x2e2d2d,-15|-33|0x2e2d2d,-32|55|0xff6b4c,25|61|0xff5532", 90, 53, 151, 183, 711}
	t['会员专属权益界面_查看'] = { 0xb5936e, "10|-9|0xe6b886,-77|-5|0x2d2d2d,64|0|0xe6b886", 90, 397, 334, 561, 386}
	
t['立即领取'] = { 0xd5a940, "-60|-10|0x6f5e38,-115|37|0xd5a940,92|38|0x584e36", 90, 260, 1149, 498, 1239}
t['本月券包已领取'] = { 0xdab764, "0|25|0xdab763,-11|6|0xd5aa43,180|3|0xdbb96a,181|23|0xe6d8b7", 90, 261, 1170, 486, 1219}
t['返回箭头'] = { 0xa2cdfb, "14|-17|0x88bffc,14|18|0x88bffc", 90, 27, 1261, 74, 1318}

t['我的票券界面'] = { 0xbfbfbf, "26|0|0x101010,2|23|0x000000,115|24|0x656565,118|-5|0xe3e3e3", 90, 309, 106, 444, 193}
	t['我的票券界面_电子券'] = {  0x626262, "11|-5|0xe5e5e6,10|22|0xa2a2a3,90|14|0x929293,85|-4|0x8f8f90", 90, 312, 548, 438, 609}
	t['我的票券界面_1000积分'] = { 0x333333, "-404|-13|0x1aa2ff,-369|49|0x1aa2ff,-358|-34|0x1aa2ff,-363|-6|0xffffff", 90, 63, 920, 631, 1061 } --多点找色
	t['我的票券界面_京东E卡30元']={ 0xe5d09d, "-456|-61|0xf7a6a1,-465|-36|0xf7a09b,-321|-116|0x333333,-174|-105|0x333333,-8|-107|0xd5d5d5", 90, 27, 183, 692, 962 } --多点找色
	t['我的票券界面_京东e卡100元']={ 0x333333, "-302|28|0xca1729,-257|-35|0xc71325,-249|-8|0xcdc8ca,-224|35|0xe00824", 90, 71, 683, 553, 828 } --多点找色


t['查看券码']={ 0x2d2511, "62|-15|0xdfb856,-78|18|0xdfb856,-576|-163|0xea5b14,-483|-171|0xec5c15", 90, 36, 346, 734, 634 } --多点找色

t['卡券包界面']={ 0xdbdbdb, "-12|13|0xa9a9a9,0|30|0xbcbcbc,78|29|0x767676,78|4|0x000000", 90, 322, 148, 426, 195 } --多点找色
	t['卡券包界面_电子券']={ 0x999999, "0|17|0x9d9d9d,12|23|0xc9c9c9,80|23|0xb2b2b2,84|-5|0xa6a6a6", 90, 509, 226, 620, 273 } --多点找色
	t['卡券包界面_京东e卡100元']={ 0x5e5e5e, "-265|-11|0xc71325,-239|14|0xcac1cb,-210|58|0xc81425,-242|73|0xc81326", 90, 70, 352, 636, 469 } --多点找色
	t['卡券包界面_1000积分']={ 0x333333, "-365|6|0x1aa2ff,-329|-15|0x1aa2ff,-287|31|0x1aa2ff,-330|59|0x1aa2ff", 90, 68, 546, 612, 675 } --多点找色
	
t['卡券详情界面'] ={ 0x41454d, "-12|13|0x6c7076,1|29|0xffffff,112|2|0x6b6e74,110|29|0x8d8f94,109|29|0xd4d5d6", 90, 303, 147, 444, 192 } --多点找色
	t['卡券详情界面_京东e卡100元']={ 0x000000, "0|-62|0xc81426,-22|-102|0xcf111d,41|-90|0xc71325,21|-74|0xcc9291", 90, 294, 272, 529, 419 } --多点找色
	t['卡券详情界面_1000积分']={ 0x161616, "9|-50|0x1aa2ff,-28|-94|0x1aa2ff,9|-126|0x1aa2ff,49|-87|0x1aa2ff", 90, 285, 238, 457, 427 } --多点找色

t['京东E卡30元立即购买']={ 0xffffff, "194|-30|0xd3b669,-123|13|0xe1cd99,-467|-6|0xd9ba6e,-459|27|0x6d6d6d", 90, 26, 1154, 707, 1328 } --多点找色
t['京东E卡30元确认下单']={ 0x000000, "-5|0|0xa89152,-251|22|0xfde596,324|-17|0xd7ac45,-104|-76|0xd5b96d,249|-83|0xc4c0ab", 90, 70, 1062, 667, 1207 } --多点找色

t['收银台界面_支付成功查看订单']={ 0x505050, "260|-105|0x000000,217|-291|0x000000,-62|-177|0xebce84,-60|-133|0xf5ba10", 90, 111, 118, 489, 497 } --多点找色

t['首页_钱包']={ 0x393939, "-184|-15|0x52410b,-180|-17|0x55430b,-171|20|0xffc922,-462|-5|0x2d2c2c,6|35|0xa7a7a7", 90, 52, 1156, 711, 1330 } --多点找色
t['钱包_我的票券']={ 0x333333, "259|497|0xffc922,269|576|0xffc922,427|568|0x232222,611|16|0x999999", 90, 77, 587, 722, 1330 } --多点找色
----------------------tips-------------------------------
t['tips_打开'] = { 0x007aff, "-18|-10|0x62abfc,-289|-5|0x007aff,-234|14|0x1b87fe", 90, 164, 695, 577, 753}

t['收银台界面'] = { 0x333333, "-27|-9|0x333333,-339|-6|0x666666,-340|-6|0x8c8c8c", 90, 27, 142, 468, 209}
	t['收银台界面_选择支付宝'] = { 0xffffff, "-21|-2|0xaaaaaa,-639|-7|0x91d6f6,-596|20|0x55bff0", 90, 23, 528, 725, 835}
	t['收银台界面_确认支付'] = { 0xf8f4e8, "-1|-2|0xdbc485,-140|-49|0xd3b669,92|34|0xd3b669", 90, 491, 1140, 745, 1249}



------------------------------支付宝界面-----------------------------
t['支付宝_立即付款'] = { 0xe0ecf5, "-16|-9|0x118ae2,-327|-40|0x118ae2,354|43|0x118ae2", 90, 26, 1206, 727, 1317}

t['支付宝_请输入付款密码'] = { 0x414142, "215|3|0xf2f3f3,241|-1|0x7f8080,236|29|0xa2a2a3,-215|12|0x969797", 90, 28, 470, 520, 525}





function rec()
	local 京东E卡key = true
	local 京东30元key = true
	local 京东e卡100元key = true
	local 支付宝21元key = true
	local 支付宝82元key = true
	while true do
		if frontAppBid() == safaribid or frontAppBid() == zhifubao then
		--------------safari------------------
			if d("立即开通",true) then
			elseif d("密码登录界面") or d("登录") then
				if d("密码登录界面or登录_点手机号",true) then
					input(var.phone)
				elseif d("密码登录界面or登录_点手密码",true) then
					input(var.password)
					
				elseif d("密码登录界面or登录_完成",true) then
				else
					if d("登录",true)then
						idfaupdate()
						delay(3)
					end
				end
			elseif d("立即加入") then
				if d("立即加入_点击月卡",true) then
				else
					d("立即加入",true) 
				end
			elseif d("收银台界面") then
				if d("收银台界面_选择支付宝",true) then
				elseif d("收银台界面_确认支付",true) then
				end
			elseif d("会员专属权益界面") then
				if 京东E卡key and d("会员专属权益界面_京东E卡",true) then
				elseif  d("会员专属权益界面_查看",true) then
				 
				end
			elseif d("本月券包已领取") then
				京东E卡key = false
				d("返回箭头",true)
				
			elseif d("立即领取",true) then
				京东E卡key = false
			
			elseif d("我的票券界面") then
				if 京东30元key  then
					if  d("我的票券界面_京东E卡30元",true) then
					else	
						movet(407,1065,436,867,2)
					end	
--				elseif 京东e卡100元key and d("我的票券界面_京东e卡100元",true) then
--				elseif d("我的票券界面_1000积分",true) then
--				elseif d("我的票券界面_电子券",true) then
				
				end
			elseif d("京东E卡30元立即购买",true) then
			elseif d("京东E卡30元确认下单",true) then
			
			elseif d("卡券详情界面") then
				if d("卡券详情界面_京东e卡100元") then
					orcText(res)
					snapAndSave()
					京东e卡100元key = false
					d("返回箭头",true)
				elseif d("卡券详情界面_1000积分") then
					orcText_(res_)
					snapAndSave()
					back()
					return true
				end
			elseif d("查看券码",true) then
			elseif d("卡券包界面") then
				if d("卡券包界面_电子券",true) then
				elseif 京东e卡100元key and d("卡券包界面_京东e卡100元",true) then
				elseif d("卡券包界面_1000积分",true) then
				
				end
			elseif d("收银台界面_支付成功查看订单",true) then
				京东30元key = false
			elseif d("首页_钱包",true) then
			elseif d("钱包_我的票券",true) then
				
		--------------支付宝------------------	
			elseif 支付宝21元key then
				if d("支付宝_立即付款",true) then
				elseif d("支付宝_请输入付款密码") then
					phoneKey(tihot001)
					delay(10)
					closeApp(zhifubao)
					var.other = '21付款成功'
					idfaupdate()
					支付宝21元key = false
				else
					d("tips_打开",true)	
				end
			elseif 支付宝82元key then
				if d("支付宝_立即付款",true) then
				elseif d("支付宝_请输入付款密码") then
					phoneKey(tihot001)
					delay(10)
					closeApp(zhifubao)
					var.account = '82付款成功'
					idfaupdate()
					支付宝82元key = false
				else
					d("tips_打开",true)	
				end
			else
				d("tips_打开",true)
			end
			
		else
			active(safaribid,5)
		end	
		delay(2)
	end
end	

--[[]]
while (true) do
	vpnx()
	if vpn()then
		account_table = getwenfree()
		var.phone = account_table.data.account
		var.password = account_table.data.password
		var.id = account_table.data.id
		
		awzNew(safaribid)
		openURL(url)
		rec()
	
	end
end

--]]--




































