<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery/jquery.js"></script>
        <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery/jquery-3.2.1.js"></script>
<div class="row">
<div class="col-xs-4 col-sm-4 col-md-4">
<div class="form-group">



請選擇縣市
<select class="form-control input-lg" name="City" id="City" tabindex="3">
<option value="">請選擇</option>
<option value="0">台北市</option>
<option value="1">基隆市</option>
<option value="2">台北縣</option>
<option value="3">宜蘭縣</option>
<option value="4">新竹市</option>
<option value="5">新竹縣</option>
<option value="6">桃園縣</option>
<option value="7">苗栗縣</option>
<option value="8">台中市</option>
<option value="9">台中縣</option>
<option value="10">彰化縣</option>
<option value="11">南投縣</option>
<option value="12">嘉義市</option>
<option value="13">嘉義縣</option>
<option value="14">雲林縣</option>
<option value="15">台南市</option>
<option value="16">台南縣</option>
<option value="17">高雄市</option>
<option value="18">高雄縣</option>
<option value="19">澎湖縣</option>
<option value="20">屏東縣</option>
<option value="21">台東縣</option>
<option value="22">花蓮縣</option>
<option value="23">金門縣</option>
<option value="24">連江縣</option>
<option value="25">南海諸島</option>
<option value="26">釣魚台列嶼</option>
</select></div>
</div>
<div class="col-xs-4 col-sm-4 col-md-4">
<div class="form-group">
鄉鎮地區
<select class="form-control input-lg" name="Area" id="Area" tabindex="3">
<option value="0" c="0" z="100">中正區</option>
<option value="1" c="0" z="103">大同區</option>
<option value="2" c="0" z="104">中山區</option>
<option value="3" c="0" z="105">松山區</option>
<option value="4" c="0" z="106">大安區</option>
<option value="5" c="0" z="108">萬華區</option>
<option value="6" c="0" z="110">信義區</option>
<option value="7" c="0" z="111">士林區</option>
<option value="8" c="0" z="112">北投區</option>
<option value="9" c="0" z="114">內湖區</option>
<option value="10" c="0" z="115">南港區</option>
<option value="11" c="0" z="116">文山區</option>
<option value="0" c="1" z="200">仁愛區</option>
<option value="1" c="1" z="201">信義區</option>
<option value="2" c="1" z="202">中正區</option>
<option value="3" c="1" z="203">中山區</option>
<option value="4" c="1" z="204">安樂區</option>
<option value="5" c="1" z="205">暖暖區</option>
<option value="6" c="1" z="206">七堵區</option>
<option value="0" c="2" z="207">萬里鄉</option>
<option value="1" c="2" z="208">金山鄉</option>
<option value="2" c="2" z="220">板橋市</option>
<option value="3" c="2" z="221">汐止市</option>
<option value="4" c="2" z="222">深坑鄉</option>
<option value="5" c="2" z="223">石碇鄉</option>
<option value="6" c="2" z="224">瑞芳鎮</option>
<option value="7" c="2" z="226">平溪鄉</option>
<option value="8" c="2" z="227">雙溪鄉</option>
<option value="9" c="2" z="228">貢寮鄉</option>
<option value="10" c="2" z="231">新店市</option>
<option value="11" c="2" z="232">坪林鄉</option>
<option value="12" c="2" z="233">烏來鄉</option>
<option value="13" c="2" z="234">永和市</option>
<option value="14" c="2" z="235">中和市</option>
<option value="15" c="2" z="236">土城市</option>
<option value="16" c="2" z="237">三峽鎮</option>
<option value="17" c="2" z="238">樹林市</option>
<option value="18" c="2" z="239">鶯歌鎮</option>
<option value="19" c="2" z="241">三重市</option>
<option value="20" c="2" z="242">新莊市</option>
<option value="21" c="2" z="243">泰山鄉</option>
<option value="22" c="2" z="244">林口鄉</option>
<option value="23" c="2" z="247">蘆洲市</option>
<option value="24" c="2" z="248">五股鄉</option>
<option value="25" c="2" z="249">八里鄉</option>
<option value="26" c="2" z="251">淡水鎮</option>
<option value="27" c="2" z="252">三芝鄉</option>
<option value="28" c="2" z="253">石門鄉</option>
<option value="0" c="3" z="260">宜蘭市</option>
<option value="1" c="3" z="261">頭城鎮</option>
<option value="2" c="3" z="262">礁溪鄉</option>
<option value="3" c="3" z="263">壯圍鄉</option>
<option value="4" c="3" z="264">員山鄉</option>
<option value="5" c="3" z="265">羅東鎮</option>
<option value="6" c="3" z="266">三星鄉</option>
<option value="7" c="3" z="267">大同鄉</option>
<option value="8" c="3" z="268">五結鄉</option>
<option value="9" c="3" z="269">冬山鄉</option>
<option value="10" c="3" z="270">蘇澳鎮</option>
<option value="11" c="3" z="272">南澳鄉</option>
<option value="0" c="4" z="300">全區</option>
<option value="0" c="5" z="302">竹北市</option>
<option value="1" c="5" z="303">湖口鄉</option>
<option value="2" c="5" z="304">新豐鄉</option>
<option value="3" c="5" z="305">新埔鄉</option>
<option value="4" c="5" z="306">關西鎮</option>
<option value="5" c="5" z="307">芎林鄉</option>
<option value="6" c="5" z="308">寶山鄉</option>
<option value="7" c="5" z="310">竹東鎮</option>
<option value="8" c="5" z="311">五峰鄉</option>
<option value="9" c="5" z="312">橫山鄉</option>
<option value="10" c="5" z="313">尖石鄉</option>
<option value="11" c="5" z="314">北埔鄉</option>
<option value="12" c="5" z="315">峨嵋鄉</option>
<option value="0" c="6" z="320">中壢市</option>
<option value="1" c="6" z="324">平鎮市</option>
<option value="2" c="6" z="325">龍潭鄉</option>
<option value="3" c="6" z="326">楊梅鎮</option>
<option value="4" c="6" z="327">新屋鄉</option>
<option value="5" c="6" z="328">觀音鄉</option>
<option value="6" c="6" z="330">桃園市</option>
<option value="7" c="6" z="333">龜山鄉</option>
<option value="8" c="6" z="334">八德市</option>
<option value="9" c="6" z="335">大溪鎮</option>
<option value="10" c="6" z="336">復興鄉</option>
<option value="11" c="6" z="337">大園鄉</option>
<option value="12" c="6" z="338">蘆竹鄉</option>
<option value="0" c="7" z="350">竹南鎮</option>
<option value="1" c="7" z="351">頭份鎮</option>
<option value="2" c="7" z="352">三灣鄉</option>
<option value="3" c="7" z="353">南庄鄉</option>
<option value="4" c="7" z="354">獅潭鄉</option>
<option value="5" c="7" z="356">後龍鎮</option>
<option value="6" c="7" z="357">通霄鎮</option>
<option value="7" c="7" z="358">苑裡鎮</option>
<option value="8" c="7" z="360">苗栗市</option>
<option value="9" c="7" z="361">造橋鄉</option>
<option value="10" c="7" z="362">頭屋鄉</option>
<option value="11" c="7" z="363">公館鄉</option>
<option value="12" c="7" z="364">大湖鄉</option>
<option value="13" c="7" z="365">泰安鄉</option>
<option value="14" c="7" z="366">鉰鑼鄉</option>
<option value="15" c="7" z="367">三義鄉</option>
<option value="16" c="7" z="368">西湖鄉</option>
<option value="17" c="7" z="369">卓蘭鄉</option>
<option value="0" c="8" z="400">中區</option>
<option value="1" c="8" z="401">東區</option>
<option value="2" c="8" z="402">南區</option>
<option value="3" c="8" z="403">西區</option>
<option value="4" c="8" z="404">北區</option>
<option value="5" c="8" z="406">北屯區</option>
<option value="6" c="8" z="407">西屯區</option>
<option value="7" c="8" z="408">南屯區</option>
<option value="0" c="9" z="411">太平市</option>
<option value="1" c="9" z="412">大里市</option>
<option value="2" c="9" z="413">霧峰鄉</option>
<option value="3" c="9" z="414">烏日鄉</option>
<option value="4" c="9" z="420">豐原市</option>
<option value="5" c="9" z="421">后里鄉</option>
<option value="6" c="9" z="422">石岡鄉</option>
<option value="7" c="9" z="423">東勢鎮</option>
<option value="8" c="9" z="424">和平鄉</option>
<option value="9" c="9" z="426">新社鄉</option>
<option value="10" c="9" z="427">潭子鄉</option>
<option value="11" c="9" z="428">大雅鄉</option>
<option value="12" c="9" z="429">神岡鄉</option>
<option value="13" c="9" z="432">大肚鄉</option>
<option value="14" c="9" z="433">沙鹿鎮</option>
<option value="15" c="9" z="434">龍井鄉</option>
<option value="16" c="9" z="435">梧棲鎮</option>
<option value="17" c="9" z="436">清水鎮</option>
<option value="18" c="9" z="437">大甲鎮</option>
<option value="19" c="9" z="438">外圃鄉</option>
<option value="20" c="9" z="439">大安鄉</option>
<option value="0" c="10" z="500">彰化市</option>
<option value="1" c="10" z="502">芬園鄉</option>
<option value="2" c="10" z="503">花壇鄉</option>
<option value="3" c="10" z="504">秀水鄉</option>
<option value="4" c="10" z="505">鹿港鎮</option>
<option value="5" c="10" z="506">福興鄉</option>
<option value="6" c="10" z="507">線西鄉</option>
<option value="7" c="10" z="508">和美鎮</option>
<option value="8" c="10" z="509">伸港鄉</option>
<option value="9" c="10" z="510">員林鎮</option>
<option value="10" c="10" z="511">社頭鄉</option>
<option value="11" c="10" z="5112">永靖鄉</option>
<option value="12" c="10" z="513">埔心鄉</option>
<option value="13" c="10" z="514">溪湖鎮</option>
<option value="14" c="10" z="515">大村鄉</option>
<option value="15" c="10" z="516">埔鹽鄉</option>
<option value="16" c="10" z="520">田中鎮</option>
<option value="17" c="10" z="521">北斗鎮</option>
<option value="18" c="10" z="522">田尾鄉</option>
<option value="19" c="10" z="523">埤頭鄉</option>
<option value="20" c="10" z="524">溪州鄉</option>
<option value="21" c="10" z="525">竹塘鄉</option>
<option value="22" c="10" z="526">二林鎮</option>
<option value="23" c="10" z="527">大城鄉</option>
<option value="24" c="10" z="528">芳苑鄉</option>
<option value="25" c="10" z="530">二水鄉</option>
<option value="0" c="11" z="540">南投市</option>
<option value="1" c="11" z="541">中寮鄉</option>
<option value="2" c="11" z="542">草屯鎮</option>
<option value="3" c="11" z="544">國姓鄉</option>
<option value="4" c="11" z="545">埔里鎮</option>
<option value="5" c="11" z="546">仁愛鄉</option>
<option value="6" c="11" z="551">名間鄉</option>
<option value="7" c="11" z="552">集集鄉</option>
<option value="8" c="11" z="553">水里鄉</option>
<option value="9" c="11" z="555">魚池鄉</option>
<option value="10" c="11" z="556">信義鄉</option>
<option value="11" c="11" z="557">竹山鎮</option>
<option value="12" c="11" z="558">鹿谷鄉</option>
<option value="0" c="12" z="600">全區</option>
<option value="0" c="13" z="602">番路鄉</option>
<option value="1" c="13" z="603">梅山鄉</option>
<option value="2" c="13" z="604">竹崎鄉</option>
<option value="3" c="13" z="605">阿里山</option>
<option value="4" c="13" z="606">中埔鄉</option>
<option value="5" c="13" z="607">大埔鄉</option>
<option value="6" c="13" z="608">水上鄉</option>
<option value="7" c="13" z="611">鹿草鄉</option>
<option value="8" c="13" z="612">太保市</option>
<option value="9" c="13" z="613">朴子市</option>
<option value="10" c="13" z="614">東石鄉</option>
<option value="11" c="13" z="615">六腳鄉</option>
<option value="12" c="13" z="616">新港鄉</option>
<option value="13" c="13" z="621">民雄鄉</option>
<option value="14" c="13" z="622">大林鎮</option>
<option value="15" c="13" z="623">漢口鄉</option>
<option value="16" c="13" z="624">義竹鄉</option>
<option value="17" c="13" z="625">布袋鎮</option>
<option value="0" c="14" z="630">斗南市</option>
<option value="1" c="14" z="631">大埤鄉</option>
<option value="2" c="14" z="632">虎尾鎮</option>
<option value="3" c="14" z="633">土庫鎮</option>
<option value="4" c="14" z="634">褒忠鄉</option>
<option value="5" c="14" z="635">東勢鄉</option>
<option value="6" c="14" z="636">台西鄉</option>
<option value="7" c="14" z="637">崙背鄉</option>
<option value="8" c="14" z="638">麥寮鄉</option>
<option value="9" c="14" z="640">斗六市</option>
<option value="10" c="14" z="643">林內鄉</option>
<option value="11" c="14" z="646">古坑鄉</option>
<option value="12" c="14" z="647">莿桐鄉</option>
<option value="13" c="14" z="648">西螺鎮</option>
<option value="14" c="14" z="649">二崙鄉</option>
<option value="15" c="14" z="651">北港鎮</option>
<option value="16" c="14" z="652">水林鄉</option>
<option value="17" c="14" z="653">口湖鄉</option>
<option value="18" c="14" z="654">四湖鄉</option>
<option value="19" c="14" z="655">元長鄉</option>
<option value="0" c="15" z="700">中區</option>
<option value="1" c="15" z="701">東區</option>
<option value="2" c="15" z="702">南區</option>
<option value="3" c="15" z="703">西區</option>
<option value="4" c="15" z="704">北區</option>
<option value="5" c="15" z="708">安平區</option>
<option value="6" c="15" z="709">安南區</option>
<option value="0" c="16" z="710">永康市</option>
<option value="1" c="16" z="711">歸仁鄉</option>
<option value="2" c="16" z="712">新化鎮</option>
<option value="3" c="16" z="713">左鎮鄉</option>
<option value="4" c="16" z="714">玉井鄉</option>
<option value="5" c="16" z="715">楠西鄉</option>
<option value="6" c="16" z="716">南化鄉</option>
<option value="7" c="16" z="717">仁德鄉</option>
<option value="8" c="16" z="718">關廟鄉</option>
<option value="9" c="16" z="719">龍崎鄉</option>
<option value="10" c="16" z="720">官田鄉</option>
<option value="11" c="16" z="721">麻豆鎮</option>
<option value="12" c="16" z="722">佳里鎮</option>
<option value="13" c="16" z="723">西港鄉</option>
<option value="14" c="16" z="724">七股鄉</option>
<option value="15" c="16" z="725">將軍鄉</option>
<option value="16" c="16" z="726">學甲鎮</option>
<option value="17" c="16" z="727">北門鄉</option>
<option value="18" c="16" z="730">新營市</option>
<option value="19" c="16" z="731">後壁鄉</option>
<option value="20" c="16" z="732">白河鎮</option>
<option value="21" c="16" z="733">東山鄉</option>
<option value="22" c="16" z="734">六甲鄉</option>
<option value="23" c="16" z="735">下營鄉</option>
<option value="24" c="16" z="736">柳營鄉</option>
<option value="25" c="16" z="737">鹽水鎮</option>
<option value="26" c="16" z="741">善化鎮</option>
<option value="27" c="16" z="742">大內鄉</option>
<option value="28" c="16" z="743">山上鄉</option>
<option value="29" c="16" z="744">新市鄉</option>
<option value="30" c="16" z="745">安定鄉</option>
<option value="0" c="17" z="800">新興區</option>
<option value="1" c="17" z="801">前金區</option>
<option value="2" c="17" z="802">苓雅區</option>
<option value="3" c="17" z="803">鹽埕區</option>
<option value="4" c="17" z="804">鼓山區</option>
<option value="5" c="17" z="805">旗津區</option>
<option value="6" c="17" z="806">前鎮區</option>
<option value="7" c="17" z="807">三民區</option>
<option value="8" c="17" z="811">楠梓區</option>
<option value="9" c="17" z="812">小港區</option>
<option value="10" c="17" z="813">左營區</option>
<option value="0" c="18" z="814">仁武鄉</option>
<option value="1" c="18" z="815">大社鄉</option>
<option value="2" c="18" z="820">岡山鎮</option>
<option value="3" c="18" z="821">路竹鄉</option>
<option value="4" c="18" z="822">阿蓮鄉</option>
<option value="5" c="18" z="823">田寮鄉</option>
<option value="6" c="18" z="824">燕巢鄉</option>
<option value="7" c="18" z="825">橋頭鄉</option>
<option value="8" c="18" z="826">梓官鄉</option>
<option value="9" c="18" z="827">彌陀鄉</option>
<option value="10" c="18" z="828">永安鄉</option>
<option value="11" c="18" z="829">湖內鄉</option>
<option value="12" c="18" z="830">鳳山市</option>
<option value="13" c="18" z="831">大寮鄉</option>
<option value="14" c="18" z="832">林園鄉</option>
<option value="15" c="18" z="833">鳥松鄉</option>
<option value="16" c="18" z="840">大樹鄉</option>
<option value="17" c="18" z="842">旗山鎮</option>
<option value="18" c="18" z="843">美濃鎮</option>
<option value="19" c="18" z="844">六龜鄉</option>
<option value="20" c="18" z="845">內門鄉</option>
<option value="21" c="18" z="846">杉林鄉</option>
<option value="22" c="18" z="847">甲仙鄉</option>
<option value="23" c="18" z="848">桃源鄉</option>
<option value="24" c="18" z="849">三民鄉</option>
<option value="25" c="18" z="851">茂林鄉</option>
<option value="26" c="18" z="852">茄萣鄉</option>
<option value="0" c="19" z="880">馬公市</option>
<option value="1" c="19" z="881">西嶼鄉</option>
<option value="2" c="19" z="882">望安鄉</option>
<option value="3" c="19" z="883">七美鄉</option>
<option value="4" c="19" z="884">白沙鄉</option>
<option value="5" c="19" z="885">湖西鄉</option>
<option value="0" c="20" z="900">屏東市</option>
<option value="1" c="20" z="901">三地門</option>
<option value="2" c="20" z="902">霧台鄉</option>
<option value="3" c="20" z="903">瑪家鄉</option>
<option value="4" c="20" z="904">九如鄉</option>
<option value="5" c="20" z="905">里港鄉</option>
<option value="6" c="20" z="906">高樹鄉</option>
<option value="7" c="20" z="907">鹽埔鄉</option>
<option value="8" c="20" z="908">長治鄉</option>
<option value="9" c="20" z="909">麟洛鄉</option>
<option value="10" c="20" z="911">竹田鄉</option>
<option value="11" c="20" z="912">內埔鄉</option>
<option value="12" c="20" z="913">萬丹鄉</option>
<option value="13" c="20" z="920">潮州鎮</option>
<option value="14" c="20" z="921">泰武鄉</option>
<option value="15" c="20" z="922">來義鄉</option>
<option value="16" c="20" z="923">萬巒鄉</option>
<option value="17" c="20" z="924">嵌頂鄉</option>
<option value="18" c="20" z="925">新埤鄉</option>
<option value="19" c="20" z="926">南州鄉</option>
<option value="20" c="20" z="927">林邊鄉</option>
<option value="21" c="20" z="928">東港鎮</option>
<option value="22" c="20" z="929">琉球鄉</option>
<option value="23" c="20" z="931">佳冬鄉</option>
<option value="24" c="20" z="932">新園鄉</option>
<option value="25" c="20" z="940">枋寮鄉</option>
<option value="26" c="20" z="941">枋山鄉</option>
<option value="27" c="20" z="942">春日鄉</option>
<option value="28" c="20" z="943">獅子鄉</option>
<option value="29" c="20" z="944">車城鄉</option>
<option value="30" c="20" z="945">牡丹鄉</option>
<option value="31" c="20" z="946">恆春鎮</option>
<option value="32" c="20" z="947">滿州鄉</option>
<option value="0" c="21" z="950">台東市</option>
<option value="1" c="21" z="951">綠島鄉</option>
<option value="2" c="21" z="952">蘭嶼鄉</option>
<option value="3" c="21" z="953">延平鄉</option>
<option value="4" c="21" z="954">卑南鄉</option>
<option value="5" c="21" z="955">鹿野鄉</option>
<option value="6" c="21" z="956">關山鎮</option>
<option value="7" c="21" z="957">海端鄉</option>
<option value="8" c="21" z="958">池上鄉</option>
<option value="9" c="21" z="959">東河鄉</option>
<option value="10" c="21" z="961">成氐燡</option>
<option value="11" c="21" z="962">長濱鄉</option>
<option value="12" c="21" z="963">太麻里</option>
<option value="13" c="21" z="964">金峰鄉</option>
<option value="14" c="21" z="965">大武鄉</option>
<option value="15" c="21" z="966">達仁鄉</option>
<option value="0" c="22" z="970">花蓮市</option>
<option value="1" c="22" z="971">新城鄉</option>
<option value="2" c="22" z="972">秀林鄉</option>
<option value="3" c="22" z="973">吉安鄉</option>
<option value="4" c="22" z="974">壽豐鄉</option>
<option value="5" c="22" z="975">鳳林鎮</option>
<option value="6" c="22" z="976">光復鄉</option>
<option value="7" c="22" z="977">豐濱鄉</option>
<option value="8" c="22" z="978">瑞穗鄉</option>
<option value="9" c="22" z="979">萬榮鄉</option>
<option value="10" c="22" z="981">玉里鎮</option>
<option value="11" c="22" z="982">卓溪鄉</option>
<option value="12" c="22" z="983">富里鄉</option>
<option value="0" c="23" z="890">金沙鎮</option>
<option value="1" c="23" z="891">金湖鎮</option>
<option value="2" c="23" z="892">金寧鄉</option>
<option value="3" c="23" z="893">金城鎮</option>
<option value="4" c="23" z="894">烈嶼鄉</option>
<option value="5" c="23" z="896">烏坵鄉</option>
<option value="0" c="24" z="209">南竿鄉</option>
<option value="1" c="24" z="210">北竿鄉</option>
<option value="2" c="24" z="211">莒光鄉</option>
<option value="3" c="24" z="212">東引</option>
<option value="0" c="25" z="817">東沙</option>
<option value="1" c="25" z="819">西沙</option>
<option value="0" c="26" z="290">全區</option>
</select>
</div>
</div>
<div class="col-xs-4 col-sm-4 col-md-4">
<div class="form-group">

郵遞區號
<input class="form-control input-sm" name="ZIP" type="text" id="ZIP" size="5" tabindex="3"/>

</div>
</div>
</div>
