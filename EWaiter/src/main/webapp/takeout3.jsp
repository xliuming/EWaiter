<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String dishJSON = (String)request.getAttribute("menu");
	%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
    
   <script>
       //判断是否微信中打开
       var ua = navigator.userAgent.toLowerCase();
       var gdata;
       var dishJson;
       try { gdata = JSON.parse(localStorage.getItem('gdata')); } catch (ex) { alert('error'); gdata = null };
       try { dishJson = JSON.parse(localStorage.getItem('dishJson')); } catch (ex) { alert('error'); gdata = null };
       if (gdata == null) { gdata = {}; };
       if (dishJson == null) {
    	   dishJson = <%= dishJSON%>;
    	   localStorage.setItem('dishJson', JSON.stringify(dishJson));
       }
/*        if (ua.match(/MicroMessenger/i) == "micromessenger" && !gdata.ML_GUID) {
           var _state = window.location.host;
           var param = document.location.search;
           if (!param) {
               _state = _state + "?filePath=htm";
           } else {
               _state = _state + param + "&filePath=htm"
           };
           _state = _state.replace(/&/g, "amp;").replace(/\?/g, "bmp;");
           var url = " https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxcf34c168e61773d0&redirect_uri=http://zyd.caipad.cn/weixin_redirect_page.html&response_type=code&scope=snsapi_base&state=" + _state + "#wechat_redirect";
           window.location.href = url;
       }; */
    
   </script>
    <link href="../resource/css/main.css" rel="stylesheet" type="text/css" />
    <link href="../resource/css/base.css" rel="stylesheet" type="text/css" />
    <link href="../resource/css/xg.css" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<body>

    <!--选择桌台-->
    <div id="slider_table_Full" style=" background:#000; display:none; position:absolute ; top:0; height:100%; width:100%; opacity: 0.5; z-index:20;" > </div>
    <div id="slider_table" class="animation below slider_down" style=" display:block; -webkit-transform: translate3d(0px, 100%, 0px);">
        <div id="basic_table">
            <div class="thick_border content cancel" style=" height:40px; line-height:40px; color:#220f00; font-size:20px; border-bottom:1px solid #6e4421;background: #C8C7C7;" id="cancel_table">取消选桌设置</div>
            <div id="table_category"></div>
        </div>
    </div>
    <!--选择人数-->
    <div id="slider_person" class="animation below slider_down" style=" display:block; -webkit-transform: translate3d(0,100%,0);">
        <div id="basic_person">
            <div class="thick_border content cancel" style="background-color:lavender;" id="cancel_person">取消人数设置</div>
            <div id="person_category"></div>
        </div>
    </div>
    <!--选择菜品的页面-->
    <div id="slider_dish" class="animation" style="-webkit-transform: translate3d(100%, 0px, 0px);display: block;">
        <div class="dish_title">
            <span id="dish_back" class="back"></span>
            <div id="dish_shop_title" siteTitle="true"></div>
            <div id="dish_search"></div>
        </div>
        
        <div id="dish_container">
            <div id="dish_menu"></div>
            <div id="dish_list"></div>
        </div>
        
        <div id="dish_footer">
            <div id="dish_info"></div>
            <div id="dish_ok"><button class="select_ok">选好了</button></div>
        </div>
    </div>
    <!--首页-->
    <div id="index_page" class="animation" style="  left:0; top:0px;">
        <!--<div class="index_bg"></div>
        <div class="index_title">
            <div id="index_shop_title">神州美味</div>
        </div>-->

        <div style="text-align: center;height: 100px;margin-top: 70px;">
            <img src="../resource/img/logo.png" style="height:100px;position: relative;z-index: 2;" />
        </div>

        <div style="position:absolute;height: 100px; width:100%;bottom:35%;">
            <div id="open_slider_person" style="height:100%;margin: 20px;padding: 10px;color: #FFF;font-size: 20px;background: url(img/black.png);border-radius:5px;">
                <p style="text-align:center; font-size:18px;  line-height:60px; margin:0;">欢迎您&nbsp;!请问您的用餐人数&nbsp;?</p>
                <p style="text-align:center; margin:0;" id="open_slider_person_index">点击选择</p>
            </div>
        </div>
        <div id="index_menu_Container">
            <div id= "headImg" class="showimg"></div>
            <div id= "head_add" class=""></div>
            <div id="index_menu" class="hidden-img"> 
                <span id="index-huiyuan" class="huiyuan"></span>
                 <span id="index-order" class="order"></span>
                  <span id="index-call" class="call"></span>
            </div>
        </div>
        <div class="index_load">
            <!--<img id="loading_img" src="../img/btn_sync_bg_sync.png" alt="" />-->
            <div id="loading_img">开始点餐</div>
        </div>
        <div id="index_tip">
            <span></span>
            <div class="tip_close"></div>
        </div>

        
        <div id="index_footer" >
            <p style="  z-index:20;position: relative; height: 100%;text-align: center;color: black;padding-top: 10px;color:#fff;font-size:10px;"><span id="index_qundian">小伙伴一起点餐</span>&nbsp;&nbsp;&nbsp;&nbsp;<span style=" width:8px; height:8px; background:#fff; border-radius: 45px; display: inline-block;"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id="index_waimai">我要外卖</span>&nbsp;&nbsp;&nbsp;&nbsp;<span style=" width:8px; height:8px; background:#fff; border-radius: 45px; display: inline-block;"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id="index_qa">不会用点这里</span></p>
            <!--<table class="index_menu">
                <tbody>
                    <tr>
                        <td style="background: url(../img/index_line.png);background-repeat: no-repeat;background-position: right;">
                            <div  id="open_slider_person">
                                <div class="index_btn_pe"></div>
                                <br />
                                <span class="index-btn-span" id="index_table_pe">人数</span>
                            </div>
                        </td>
                        <td>
                            <div  id="open_slider_table">
                            <div class="index_btn_table"></div>
                            <br />
                            <span class="index-btn-span" id="index_table_text">选桌</span>
                            </div>
                            
                        </td>
                    </tr>
                </tbody>
            </table>-->
        </div>
    </div>
    <!--加载div-->
    <div id="load" class="load">
        <div class="full"></div>
            <div class="l-body">
                <div class="content"></div>
                <div class="spinner">
                    <div class="spinner-container container1">
                      <div class="circle1"></div>
                      <div class="circle2"></div>
                      <div class="circle3"></div>
                      <div class="circle4"></div>
                    </div>
                    <div class="spinner-container container2">
                      <div class="circle1"></div>
                      <div class="circle2"></div>
                      <div class="circle3"></div>
                      <div class="circle4"></div>
                    </div>
                    <div class="spinner-container container3">
                      <div class="circle1"></div>
                      <div class="circle2"></div>
                      <div class="circle3"></div>
                      <div class="circle4"></div>
                    </div>
                </div>
           <div class="load-text"></div>
      </div>
    </div>
    <!--个人中心-->
    <div id="slider_my" class="animation" style="-webkit-transform: translate3d(100%, 0px, 0px); display:block; ">
        <div class="title">
            <span id="slider_my_back" class="back" ></span>个人中心
        </div>
        <div class="main" id="slider_my_scroll">
            <div>
                <div class="userHead_Container">
                    <img class="userHead_img" id="userHead_img" src="img/user-head.png">
                    <div id="userHead_Name"></div>
                </div>
                <div id="body">
                    <div class="table">
                    <div class="item_noborder next">
                        <div class="fullRow" id="my_orderlist">订单记录</div>
                    </div>
                    <div class="item border_efefef next" style="color: #aaa9a9;">
                        <div class="fullRow">收藏</div>
                    </div>
                    <div class="item border_efefef next">
                        <div class="fullRow" id="my_addresslist">送餐地址</div>
                    </div>
                    <div class="item border_efefef next"  style="color: #aaa9a9;">
                        <div class="fullRow">发票</div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
    <!--账单列表-->    
    <div id="slider_orderlist" class="animation" style="-webkit-transform: translate3d(100%, 0px, 0px);  display:block; "> 
        <div class="title"><span id="slider_orderlist_back" class="back"></span>个人中心</div>
        <div><div class="orderlist_Hd"><div class="item curr" id="hd01">未完成订单</div><div class="item" id="hd02">已完成订单</div></div></div>
        <div class="main" style="top:82px;">
            <div class="pageItem animation" id="pageitem01"></div>
            <div class="pageItem animation" id="pageitem02" style="-webkit-transform: translate3d(100%, 0px, 0px);"></div>
        </div>
    </div>
    <!--结账单-->
    <div id="slider_order" class="animation" style="-webkit-transform: translate3d(100%, 0px, 0px); display: block;"></div> 
    <!-- Carte Page -->
    <div id="carte_page" class="animation slider_down" style="-webkit-transform: translate3d(100%, 0, 0px);display: block;">
        <div class="carte_title">
            <span id="cart_back" class="back"></span>
            <div id="cart_shop_title" siteTitle="true"></div>
        </div>
        <div id="carte_container">
           
            <div id="carte_mark">
                <div id="zhuotaiRow" style="padding-left: 15px;border-bottom: 1px solid #f3f4f4;"> 
                <div id="carte_table">用餐人数:<div id="select_table" class="">未选择</div></div>
                </div>
				<div style="padding-left: 15px;">
					<div id="carte_memo" style="position: relative;">
						电话:
						<div
							style="position: absolute; top: 0px; left: 60px; right: 15px;">
							<input id="phone_input" type="tel" style="" class="input no_value"
								value="请输入电话" 
								onfocus="this.className='input'; if(this.value=='请输入电话'){this.value='';}"
								onblur="this.blur();if(this.value==''){this.value='请输入电话';this.className='input no_value';}" />
						</div>
					</div>
				</div>
				<div style="padding-left: 15px;">
					<div id="carte_memo" style="position: relative;">
						备注:
						<div
							style="position: absolute; top: 0px; left: 60px; right: 15px;">
							<input id="remark_input" style="" class="input no_value"
								value="请输入特殊要求"
								onfocus="this.className='input'; if(this.value=='请输入特殊要求'){this.value='';}"
								onblur="this.blur();if(this.value==''){this.value='请输入特殊要求';this.className='input no_value';}" />
						</div>
					</div>
				</div>				
				<div id="waimaiRow" style=" display:none;">
                    <div style="padding-left: 15px;border-bottom: 1px solid #f3f4f4;">
                       <div style=" position:relative ;padding-left: 20px;">姓名:
                          <div style=" position:absolute ; top:0px; left:60px; right:15px;">
                            <input class="input" id="waimai_name" />
                          </div>
                       </div>
                    </div>

                    <div style="padding-left: 15px;border-bottom: 1px solid #f3f4f4;">
                       <div style=" position:relative ;padding-left: 20px;">电话:
                          <div style=" position:absolute ; top:0px; left:60px; right:15px;">
                            <input class="input" id="waimai_phone" />
                          </div>
                       </div>
                    </div>

                    <div style="padding-left: 15px;border-bottom: 1px solid #f3f4f4;">
                       <div style=" position:relative ;padding-left: 20px;">地址:
                          <div style=" position:absolute ; top:0px; left:60px; right:15px;">
                            <input class="input" id="waimai_address" />
                          </div>
                       </div>
                    </div>
                </div>

				<!--<div style="padding-left: 15px;"> <div id="carte_memo">备注:<textarea id="remark_input" class="input no_value" value="请输入特殊要求" onfocus="this.className='input'; if(this.value=='请输入特殊要求'){this.value='';}" onblur="this.blur();if(this.value==''){this.value='请输入特殊要求';this.className='input no_value';}"></textarea> </div></div>-->
                
            </div>
            <div id="carte_dish"></div>
        </div>

        <div id="carte_footer">
            <div id="carte_info">共计11个菜,&nbsp;<span class="price">￥0.43</span></div>
            <div id="carte_ok"><button class="select_ok">立即下单</button></div>
        </div>
    </div>
    

    <!-- 搜索页面 -->
    <div id="searchPage" style="display:none;">
        <div class="mask"></div>
        <div id="search_content">
        <div class="main">
            <input class="input search" value="请输入菜名" onfocus="this.value=''" onblur="if(this.value==''){this.value='请输入菜名'}" id="search_input" />
           </div>
            <span id="search_content_finish">取消</span>
        </div>
        <div id="search_result"></div>
    </div>

    <!-- 详细页面 -->
    <div id="dish_details" style="display: none;"></div>

    <!-- 外卖页面 -->
    <div id="takeaway" class="page animation"  style="-webkit-transform: translate3d(100%, 0px, 0px); display:  block;">
        <div class="title">
            <span id="takeaway_back" class="back"></span>
            <div siteTitle="true"></div>
        </div>
        <div id="takeawaymain" class="main" style=" bottom:41px;">
            <div>
                <div class="list" id="takeaway_list" mark="name">
                    <div style=" text-align:center ; padding:10px;"><div class="date">2014-08-12</div></div>
                    <div class="item">
                        <div class="l_img">&nbsp;</div> 
                        <div class="l_right">
                                    <div class="beign_img_l"></div>
                                    <div>您好，欢迎光临红姨厨房。</div>
                                    <div>餐厅地址：1层</div>
                                    <div>送餐范围：500米。</div>
                                    <div>50元起送。</div>
                                    <div>配送费：5元。</div>
                                    <div>满200元免配送费。</div>
                                    <div>联系方式:18612345678</div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="l_img">&nbsp;</div> 
                        <div class="l_right">
                                    <div class="beign_img_l"></div>
                                    <div>请问您的送餐地址是</div>
                        </div>
                    </div>
                    <div class="item2">
                        <div class="l_img">&nbsp;</div> 
                        <div class="l_right">
                                    <div class="beign_img_l"></div>
                                    <div>请问您的送餐地址是</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="takeaway_footer">
            <div class="input_div">
                <input id="sendMessage-Text"/>
            </div>
            <div id="listBtn" class="right" title="收货地址列表">&nbsp;</div>
            <div id="messagebtn" class="right">发送</div>
            
        </div>

        <div class="mylist" id="mylist">
            <div id="mylist_scroll">
                
            </div>
   
        </div>
        <div class="tanchu">&nbsp;</div>
    </div>

    <!-- 外卖页面 -->
    <div id="myAddress" class="page myAddress animation"  style="-webkit-transform: translate3d(100%, 0px, 0px); display:block;">
         <div class="title">
            <span id="myAddress_back" class="back"></span>
            <div>管理收货地址</div>
            <span class="rightBgn" id="myaddress_add_btn">新增</span>
        </div>
        <div id="Address_Main" class="main">
            
        </div>
    </div>

    <div id="myAddress_add" class="page myAddress animation"  style="-webkit-transform: translate3d(100%, 0px, 0px); display: block;">
         <div class="title">
            <span id="myAddress_add_back" class="back"></span>
            <div id="addTitle">新建送餐地址</div>
            <span class="rightBgn" id="saveAddress_btn">保存</span>
        </div>
        <div id="Address_add_Main" class="main">
            <div>
                <div class="item">
                    <span class="name">联系人：</span><input class="input_noborder" id="lx_name" />
                </div>
                <div class="item">
                    <span class="name">手机号码：</span><input class="input_noborder" id="lx_phone" />
                </div>
                <div class="item">
                    <span class="name">送餐地址：</span><input class="input_noborder" id="lx_address" />
                </div>
            </div>
        </div>

    </div>

    <div id="lottery" style="-webkit-transform: translate3d(0px, 1000px, 0px);display: block;">
        <div class="lotter-title">
            <span id="lotteryBack" class="back" ></span>幸运抽奖
        </div>
        <div>
        <script>
//            function dyniframesize(down) {
//                var pTar = null;
//                if (document.getElementById) {
//                    pTar = document.getElementById(down);
//                }
//                else {
//                    eval('pTar = ' + down + ';');
//                };
//                if (pTar && !window.opera) {
//                    pTar.style.display = "block"
//                    if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight) {
//                        //ns6 syntax 
//                        pTar.height = pTar.contentDocument.body.offsetHeight + 20;
//               
//                        if (pTar.height < (document.body.clientHeight - 41)) {
//                            pTar.height = document.body.clientHeight - 41;
//                        }
//                    }
//                    else if (pTar.Document && pTar.Document.body.scrollHeight) {
//                        //ie5+ syntax 
//                   
//                        pTar.height = pTar.Document.body.scrollHeight;
//                        if (pTar.height < (document.body.clientHeight - 41)) {
//                            pTar.height = document.body.clientHeight - 41;
//                        }
//                    }
//                }
//            } 

        
        </script>
        <!--<iframe src ="../ggk/lotter.html" frameborder="0" marginheight="0" marginwidth="0" frameborder="0" scrolling="auto" id="ifm" name="ifm" onload="javascript:dyniframesize('ifm');" width="100%"></iframe> 
       --> 
       <div id="bodylotter"">
        <div class="bodylotter" >
            <div id="wScratchPad" style="display:inline-block; background:#fff; position:relative; margin-top:10px;"></div>
            <div class="contents" id="firstDiv" style="display:none;">
                <div class="title">恭喜您中奖了：</div>
                <div style=" padding: 0 12px;">
                    <div>您中了：<span id="span01"></span></div>
                    <div>奖品名称：<span id="span02"></span></div>
                    <div>中奖时间：<span id="span03"></span></div>
                </div>
            </div>

            <div class="contents" >
                <div class="title">奖项设置</div>
                <div style=" padding: 0 12px;" id="list"></div>
            </div>


            <div class="contents" id="secondDiv" style="display:none;">
                <div class="title">商家兑奖</div>
                <div style=" padding: 0 12px;">
                    <input id="num" class="num" />
                    <div class="ok" id="ok">商家提交</div>
                </div>
            </div>
            <div class="contents">
                <div class="title">其他说明</div>
                <div style=" padding: 0 12px;" id="memo">
       
                </div>
            </div>
    </div>
        </div>
        <!-- end-->


        
        </div>
    </div>
    <!-- 常见问题 -->
    <div id="qaPage" class="page animation" style="-webkit-transform: translate3d(100%, 0px, 0px);">
         <div class="title">
            <span id="qa_back" class="back"></span>
            <div >常见问题</div>
        </div>
        <div class="main" id="qa_main">
            <div>
                <div class="qa_list">
                    <div class="item">
                        <span button="true" class="button_right">&nbsp;</span>
                        <div class="hd">Q:在店内如何点餐?</div>
                        <div class="content">
                            1.在餐厅首页中选择要就餐的桌台后开始点餐。<br />
                            2.选择好菜品和数量加入到购物车。<br />
                            3.确认订单信息无误，提交订单。<br />
                            4.等待服务员的确认，点餐完成。
                        </div>
                    </div>

                     <div class="item">
                        <span button="true" class="button_right">&nbsp;</span>
                        <div class="hd">Q:如何和朋友一起点餐？</div>
                        <div class="content">
                            1.从餐厅首页进入到“小伙伴一起点餐”，同时分享给朋友。<br />
                            2.查看已点好的所有菜品，确认订单信息无误后提交。<br />
                            3.等待服务员确认，群点完成。<br />
                        </div>
                    </div>
                     <div class="item">
                        <span button="true" class="button_right">&nbsp;</span>
                        <div class="hd">Q: 如何呼叫外卖？</div>
                        <div class="content">
                            1.从餐厅首页进入到“叫外卖”，按要求输入姓名、地址、电话号码。<br />
                            2.确定送餐地址在送餐范围内，开始点菜。<br />
                            3.确认订单信息无误，提交订单。<br />
                            4.等待服务员的确认，点餐完成。
                        </div>
                    </div>
                     <div class="item">
                        <span button="true" class="button_right">&nbsp;</span>
                        <div class="hd">Q:优惠活动如何参加？</div>
                        <div class="content">
                            1.如果商家有优惠活动时，点击首页头部进入活动介绍页面，查看活动规则。<br />
                            2.满足相应条件的订单可以参加抽奖。<br />
                            3.中奖后请联系餐厅服务员进行兑奖。

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="crowdPage" class="page animation" style="-webkit-transform: translate3d(100%, 0px, 0px);">
        <div class="title">
            <span id="crowd_back" class="back"></span>
            <div siteTitle="true"></div>
        </div>
      
        <div class="main" id="crowd_main">
            
            <div style=" padding-bottom:10px;">
                <div class="body">
                    <div class="userInfoDiv">
                        <div class="user_head_img" id="qundian_userhead"></div>
                        <div class="user_username" id="qundian_username"></div>
                    </div>
                    <div class="erweima" >
                        <div id="erweima" class="erweimaMain"></div>
                    </div>
                    <div style="color:#b2b2b2; font-size:12px;">扫描二维码开启群点体验，或者<span id="btn_click_right" style="color:#0028f3;">点击右上角</span>邀请小伙伴一起加入！</div>
                </div>
                <div class="buttonline"  >
                    <div class="button" id="go_dishlist">去点餐</div>
                </div>
            </div>
        </div>
      

    </div>
    <div id="crowdcarte_Page" class="page animation" style="-webkit-transform: translate3d(100%, 0px, 0px);">
        <div class="title">
            <span id="crowdcarte_back" class="back"></span>
            <div >提交菜品</div>
            <span class="rightBgn" id="crowdcarte_refresh">&nbsp;</span>
        </div>
        <div class="order_meark">
            <div class="item">
                <div class="table-row ">
                   桌台: <div class="select_table" id="select_table2">未选择</div>
                </div>
            </div>
            <div class="item" style="border:none;"> 
                <div id="carte_memo2" style="position:relative ;">
                备注:
                  <div style=" position:absolute ; top:0px; left:60px; right:15px;">
                    <input id="remark_input2" style=" " class="input no_value" value="请输入特殊要求" onfocus="this.className='input'; if(this.value=='请输入特殊要求'){this.value='';}" onblur="this.blur();if(this.value==''){this.value='请输入特殊要求';this.className='input no_value';}" />

                  </div>
               </div>
            </div>

        </div>
        <div class="main" style="top:145px;" id="crow_carte_container">
           
        </div>

        <div class="botton_footer">
            <div id="crow_info">共计11个菜,&nbsp;<span class="price">￥0.43</span></div>
            <div id="crow_ok"><button class="select_ok" id="btn_beginOrder">立即下单</button></div>
        </div>
    </div>


    <div id="crowduser_Page" class="page animation" style="-webkit-transform: translate3d(100%, 0px, 0px);">
        <div class="title">
            <span id="crowduser_back" class="back"></span>
            <div id="crow_carteName"></div>
        </div>
        <div class="main" id="crowduser_container">
            
        </div>
    </div>
    <div id="share-wx">
        <p>
            <img src="img/2000.png" />
        </p>
    </div>
    <div id="temp-div" style="display:none;"></div>
   

    <script src="../resource/js/jquery-1.8.3.min.js" type="text/javascript"></script>
   
    <script src="../resource/js/iscroll.js" type="text/javascript"></script>
    <!--延迟加载-->
    <script src="../resource/js/blazy.js" type="text/javascript"></script>
    <!--模板-->
    <script src="../resource/js/tmpl.min.js" type="text/javascript"></script>
    <!--ajax 请求库-->
    <script src="../resource/js/jlib.js" type="text/javascript"></script>
    <!--arraylist-->
    <script src="../resource/js/jarray.min.js" type="text/javascript"></script>
    <script src="../resource/js/main.js" type="text/javascript"></script>
    <script src="../resource/js/xg.js" type="text/javascript"></script>
    <script src="../resource/js/wechat.js" type="text/javascript"></script>
    <script src="../resource/js/main1.1.js" type="text/javascript"></script>
    <script src="../resource/js/wScratchPad.js" type="text/javascript"></script>
    <script src="../resource/js/gzy.run.js" type="text/javascript"></script>
    <!--选择人数-->
    <script type="text/x-tmpl" id="tmpl-person-category">
        <div id="person_category_scroller">
            <ul>
                {% for (var i=1; i<= 20 ; i++) { %}
                <li class="thick_border content" data-id="{%=i %}"><span>{%=i %}</span></li>
                {% } %}
            </ul>
        </div>
    </script>
    <!-- 选择桌台 -->
    <script type="text/x-tmpl" id="tmpl-table-category">
        <div id="table_category_scroller">
            <ul>
            {% for (var i=0; i< o.tabletypelist.length ; i++) { %}
               {% for (var j in o.tabletypelist[i].tableinfolist) { 
                   if($table_data_id==o.tabletypelist[i].tableinfolist[j].TI_Code)
                   {
                       $("#open_slider_tableName").html(o.tabletypelist[i].TT_Name+"-"+o.tabletypelist[i].tableinfolist[j].TI_Name);
                   }
               %}
                
                <li class="thick_border content" data-id="{%=o.tabletypelist[i].tableinfolist[j].TI_Code %}" 
                    data-code="{%=o.tabletypelist[i].tableinfolist[j].TI_Code %}" data-name="{%=o.tabletypelist[i].TT_Name %}-{%=o.tabletypelist[i].tableinfolist[j].TI_Name %}">
                    <span>{%=o.tabletypelist[i].TT_Name %}-{%=o.tabletypelist[i].tableinfolist[j].TI_Name %}</span></li>
                {% } %}
            {% } %}
            </ul>
        </div>
    </script>
    <!--获取所有的菜品分类-->
    <script type="text/x-tmpl" id="tmpl-dish-category">
        <div id="dish_category_scroller">
            <ul>
                {%
                 var f_flag=false;<!--推荐的菜在此处做便利-->
                 for (var i=0; i< 0 ; i++) {f_flag=true;  %}
                    <li d-id={%=o.foodTypeList[i].id %}    {% if(i==0){ %}class="active" {%}%}>
                    {% if(i==0){ %}
                        <img src='../img/triangle.png' class='hot_category' />
                    {% } %}
                    <span>{%=o.foodTypeList[i].name %}</span><span class="num">2</span></li>
                {% } %}

                {% 
                
                for (var i=0; i< o.foodTypeList.length ; i++) { %}
                    <li d-id={%=o.foodTypeList[i].id %}   {% if(i==0 && !f_flag){ %}class="active" {%}%} >
                    <span>{%=o.foodTypeList[i].name %}</span><span class="num">2</span></li>
                {% } %}
            </ul>
        </div>
    </script>

    <script type="text/x-tmpl" id="tmpl-dish-list">
        <div id="dish_list_scroller">
            <ul>
              {% 
                var this_price="";
                var this_price_vip="";
                for (var k=0; k< o.foodTypeList.length ; k++) { %}  
                    <li class="dish_list_active nav" data-ctid="{%=o.foodTypeList[k].id%}" >{%=o.foodTypeList[k].name%}</li>
                {% for (var i=0; i< o.foodTypeList[k].foodModels.length ; i++) { %}
                    <li class="dish_list_active">
                        <div class="dish_item">
                            <div class="dish_image"><img class="dish_img b-lazy" 
                                src="/default.png" data-src="/dish/{%=o.RestaurantSign %}/LO/128x128/{%=o.foodTypeList[k].foodModels[i].id%}.jpg" alt="" /></div>
                            <div class="dish_name">{%=o.foodTypeList[k].foodModels[i].name%}</div>
                            {%
                                if(i<=1)
                                {
                                  this_price=subNum(o.foodTypeList[k].foodModels[i].dPrice);
                                  //this_price_vip=subNum(o.foodTypeList[k].foodModels[i].dPrice);
								  this_price_vip=0;
                                }
                            %}
                            
                            <div class="dish_price">￥{%=this_price%}/{%=o.foodTypeList[k].foodModels[i].unitModel.name%} {% if(this_price_vip>0){ %} <span class="vip" style="padding-left: 15px;">VIP {%=this_price_vip %}</span>  {% } %} </div>
                            <div class="dish_add"></div>
                            <div class="dish_ope" style="display:none;"
                                data-remark="{%=o.foodTypeList[k].foodModels[i].name%}"
                                id="dish_ope_id_{%=o.foodTypeList[k].foodModels[i].id%}" cp-id="{%=o.foodTypeList[k].foodModels[i].id%}" d-ctid="{%=o.foodTypeList[k].id%}" data-id="{%=o.foodTypeList[k].foodModels[i].id%}" 
                                data-name="{%=o.foodTypeList[k].foodModels[i].name%}" data-spec="{%=o.foodTypeList[k].foodModels[i].unitModel.name%}"
                                data-ref-id="dish_ope_id_{%=o.foodTypeList[k].foodModels[i].unitModel.id%}"
                                data-price="{%=this_price%}" data-vip-price="{%=this_price_vip%}"  data-img="/dish/{%=o.RestaurantSign %}/LO/128x128/{%=o.foodTypeList[k].foodModels[i].id%}.jpg">
                                <span class="sub"></span><span class="number" >0</span><span class="add"></span>
                            </div> 
                        </div>
                    </li>
                {% }} %}
            </ul>
        </div>
    </script>

    <script type="text/x-tmpl" id="order-dish-item">
        <div id="carte_dish_scroller">
            <ul>
                {% for (var i=0; i<o.list.length ; i++) { %}
                    <li>
                        <div class="dish_item">
                            <div class="dish_image"><img class="dish_img" src="{%=o.list[i].img %}" onerror="javascript:this.src='../resource/img/carte_default_small.png';" alt="" /></div>
                            <div class="dish_name">{%=o.list[i].name %}</div>
                            <div class="dish_price">￥{%=o.list[i].price %}</div>
                            <div class="dish_ope"  data-id="{%=o.list[i].id %}" data-name="{%=o.list[i].name%}" data-spec="{%=o.list[i].spec%}"
                                 data-price="{%=o.list[i].price%}" data-ref-id="{%=o.list[i].ref_id%}">
                                 <span class="sub"></span><span class="number">{%=o.list[i].num %}</span><span class="add"></span>
                            </div>
                        </div>
                     </li>
                 {% } %}
            </ul>
         </div>
    </script>

    <script type="text/x-tmpl" id="search-dish-item">
        <div id="search_dish_scroller">
            <ul>
            {% for (var i=0; i< o.datas.length ; i++) { %}
                
                    <li class="dish_list_active">
                        <div class="dish_item">
                            <div class="dish_image">
                                <img class="dish_img b-lazy" src="/default.png" data-src="/dish/{%=o.RestaurantSign %}/LO/128x128/{%=o.datas[i].C_ID%}.jpg" alt="" />
                            </div>
                            <div class="dish_name">{%=o.datas[i].name%}</div>
                            <div class="dish_price">￥{%=o.datas[i].dPrice%}/{%=o.datas[i].unitModel.name%}</div>
                            <div class="dish_ope" data-ref-id="dish_ope_id_{%=o.datas[i].id%}">
                                <span class="sub"></span><span class="number">{%=o.datas[i].number %}</span><span class="add"></span>
                            </div> 
                        </div>
                    </li>
             {% } %}
            </ul>
         </div>    
    </script>

    <script type="text/x-tmpl" id="search-dish-noitem">
        <div id="search_dish_noresult">对不起，没有找到菜品</div>
    </script>

    <!--订单模板-->
    <script type="text/x-tmpl" id="tmpl-order-info">
    <div class="dish_title"><span id="order-back" class="back"></span>结账单</div>
    <div class="nav_img"></div>
    <div class="body" id="order_scroll">
         <div id="order-content">
              <div class="scroll">
                   <div class="Container">
                        <div class="order-Tip" style="height: 40px;line-height: 40px;background-color: #FFF2DD;position: relative;padding: 0 10px;"><span style="color: #DA643C;">请等待服务员与您确认订单</span>
                            <div style="width: 16px;height: 16px;background: url(../img/close.png) no-repeat;background-size: contain;position: absolute;right: 10px;top: 12px;" onclick="javascript:$(this).parent().remove();"></div>
                        </div>
                        <div class="content">
                            <div class="hd">{%=o.shopname%}</div>
                            <div class="nav">
                                <div class="left">订单号：{%=o.DB_Number%}</div>
                                <div class="right">{%=o.time%}</div>
                            </div>
                            <ul class="list">
                             {% for(var i in o.list) { %}
                                <li class="item clearfix">
                                    <div class="name">{%=o.list[i].DC_Name %}</div>
                                    <div class="num">x&nbsp;{%=o.list[i].DC_Amount %}</div>
                                    <div class="price">{%=o.list[i].DC_Sum %}</div>
                                </li>
                             {% } %}
                            </ul>
                            <div class="row"><div class="left"></div><div class="heji right">合计:<div class="totalPrice">{%=o.sum%}</div></div></div>
                            <div class="row"><div class="left">桌台号：{%=o.TI_Name %}</div>
                            </div>
                            <div class="mark"><div style="line-height: 18px;padding-top: 10px;">备注:{%=o.DB_Remark%}</div></div>
                        </div>
                    </div>
            </div>
            <div style="height: 10px; background: #f5f5f5;"></div>
            <div>
                <div id="cj_btn" style="height: 40px;line-height: 40px;border-radius: 5px;font-size: 14px;margin: 0 15px;background: #fff;padding: 0 10px;">{%=o.lotterState%}</div>
            </div>
            <div style="height: 10px; background: #f5f5f5;"></div>
            <div style="padding: 0 15px;">
                <div class="payContainer">
                    <div class="item hd" id="pay-type">支付方式<div class="expland up"></div></div>
                        <div id="paytype-list">
                            <div class="item select ">现金支付<div class="memo">请等待服务员与您确认订单<span class="right-img"></span></div></div>
                            <div class="item " style="color: #aaa9a9;">微信支付<div class="memo">推介安装微信5.0及以上版本使用<span class="right-img"></span></div></div>
                            <div class="item last" style="color: #aaa9a9;">支付宝<div class="memo">推介有支付宝的用户使用<span class="right-img"></span></div></div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            </div>
        </div>
    </script>
    
    <script type="text/x-tmpl" id="order_submit">
        <data>
            {% for (var i=0; i<o.list.length ; i++) { %}
                <Carte>
                    <CS_ID>{%=o.list[i].id %}</CS_ID>
                    <DC_Name>{%=o.list[i].name %}</DC_Name>
                    <DC_Amount>{%=o.list[i].num %}</DC_Amount>
                    <DC_Price>{%=o.list[i].price %}</DC_Price>
                    <DC_Sum>0</DC_Sum>
                    <DC_Remark></DC_Remark>
                </Carte>
             {% } %}
         </data>
    </script>
    <!--菜品详情模板-->
     <script type="text/x-tmpl" id="tmpl_dish_detail">
        <div class="wrap"">
            <div class="pagebar"></div>
            <div class="mask"></div>
            
			<div class="sly_frame dish_detail" id="dish_detail">
                <ul class="clearfix">
                    {% for (var i=0; i<o.list.length ; i++) { %}
                        <li id="scroll_dish_info_{%=o.list[i].id %}">
                            <div style="width:80%;height: 100%;margin: 0 auto;position: relative;background: #fff;">
                                <div class="title">{%=o.list[i].name%}</div>
                                <div class="content">
                                <table>
                                  <tbody><tr><td><img class="img" src="{%=o.list[i].img%}"/></td></tr>
                                </tbody></table>
                                </div>
                                <div class="bottom">
                                    <div>价格：<span>{%=o.list[i].price%}</span></div>
                                    <div>详情：<span>{%=o.list[i].mark%}</span></div>
                                    <div class="btn_add"></div>
                                </div>
                            </div>
                        </li>
                     {% } %}
                 </ul>
                 <div class="close" >close</div>
			</div>
		</div>
    </script>
    
    <script type="text/x-tmpl" id="tmpl_dish_detail_one">
           <div class="wrap">
                <div class="mask" id="mask_dish"></div>
                    <div class="sly_frame dish_detail" id="dish_detail" style="overflow: hidden;">
                        <ul class="clearfix">
                            <li>
                                <div style="width:100%;height: 100%;margin: 0 auto;position: relative;background: #fff;-webkit-border-radius: 5px;border-radius: 15px;">
                                        <div class="title"><span id="dish_title_name" style="display: inline-block;width: 130px;text-align: center;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">{%=o.name%} </span><button id="close_dish"></button></div>
                                        <div class="content" id="image-scroll">
                                            <div ><img class="img" src="" alt="" onerror="javascript:this.src='img/carte_default_big.png'"/></div>
			                                <div ><img class="img" src="" alt="" onerror="javascript:this.src='img/carte_default_big.png'"/></div>
                                            <div ><img class="img" src="" alt="" onerror="javascript:this.src='img/carte_default_big.png'"/></div>
                                        
                                        </div>
                                        <div class="bottom" id="dish_detail_bottom">
                                        <div>
                                            <div style="padding:0px 10px; height: 52px;">
                                                <div style="line-height: 52px;height: 52px;float: left; width:100%;" class="clearfix">
                                                    <span style="width:45px;float: left; ">价格：</span>
                                                    <span id="dish_details_price" style="color:red;padding-left: 5px;float: left;display: block;font-family: Arial; color:#e8383d;">￥{%=o.price%}   
                                                    {% if(o.vip>0){ %} <span class="vip" style="padding-left: 15px;">VIP {%=o.vip %}</span>  {% } %} 
                                                    </span>
                                                    <div style="margin-top: 10px;float: right">
                                                        <div class="dish_add dish_add_02"></div>
                                                        <div class="dish_ope dish_ope_02" style="display:none;" data-ref-id="dish_ope_id_{%=o.id%}">
                                                            <span class="sub"></span><span class="number" id="dish_details_num">{%=o.num%}</span><span class="add"></span>
                                                        </div>
                                                    </div>

                                                </div>

                                            </div>
                                            {%
                                                 var _markStr="暂无详情";
                                                 if(o.mark){
                                                    _markStr=o.mark;
                                                 }
                                             %}

                                            <div id="dish_detail_scroll"  style="line-height:20px;height:78px;overflow: hidden; ">
                                                <div style="padding: 8px 10px 10px 10px; " class="clearfix">
                                                    <span style="width:45px;float: left; ">详情：</span><span id="dish_details_meark" style="float: left;width: 220px;color: #605d5c;">{%=_markStr%}</span>
                                                </div>
                                            </div>
                                          
                                        </div>
                                        </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
    </script>
    
<!--订单列表页面-->
    <script type="text/x-tmpl" id="orderlistpage">
            <ul id="">
                {% for (var i=0; i<o.list.length ; i++) { %}
                <li class="group" data-id={%=o.list[i].DB_Number%}>
                 
                    <div class="item clearfix">
                        <div class="left color">{%=o.shopname %}</div>
                        <div class="right color">{%=o.list[i].t1 %}</div>
                    </div>

                    <div class="item clearfix">
                        <div class="left">共计{%=o.list[i].D_Count %}个菜，<span style="color: #de4046;font-family: Arial;">￥{%=o.list[i].P_Sum %}</span></div>
                        <div class="right">现金支付</div>
                    </div>
                    <div class="go_next"></div>
                </li>
                {% } %}
            </ul>
</script>

    <script type="text/x-tmpl" id="takeaway_model">
            <div style=" text-align:center ; padding:10px;"><div class="date">{%=o.t %}</div></div>
            <div class="item">
                <div class="l_img"><img src="{%=o.img%}" onerror="javascript:this.src='../img/shangjia-header90.png'"/></div> 
                <div class="l_right">
                            <div class="beign_img_l"></div>
                            <div>您好，欢迎光临{%=o.Name %}。</div>
                            <div>餐厅地址：{%=o.Address %}</div>
                            <div>送餐范围：{%=o.Takeout.Distance %}米。</div>
                            <div>10元起送。</div>
                            <div>配送费：5元。</div>
                            <div>满200元免配送费。</div>
                            <div>联系方式:{%=o.Phone %}</div>
                </div>
            </div>
            <div class="item">
                <div class="l_img"><img src="{%=o.img%}" onerror="javascript:this.src='../img/shangjia-header90.png'"/></div> 
                <div class="l_right">
                            <div class="beign_img_l"></div>
                            <div>请问您的名字是?</div>
                </div>
            </div>


    </script>


    <script type="text/x-tmpl" id="takeaway_model2">
        <div class="item">
                <div class="l_img" ><img src="{%=o.img%}" onerror="javascript:this.src='../img/shangjia-header90.png'"/></div> 
                <div class="l_right">
                            <div class="beign_img_l"></div>
                            <div>请问您的{%=o.name %}是?</div>
                </div>
            </div>
    </script>
     <script type="text/x-tmpl" id="takeaway_model3">
        <div class="item">
                <div class="l_img"><img src="{%=o.img%}" onerror="jjavascript:this.src='../img/shangjia-header90.png'"/></div> 
                <div class="l_right">
                            <div class="beign_img_l"></div>
                            <div>美味很快送达，请<a a-click="true" style="color:red;" href="javascript:void(0);">点此选菜</a></div>
                </div>
        </div>
    </script>

    <script type="text/x-tmpl" id="takeaway_model4">
        <div class="item">
                <div class="l_img"><img src="{%=o.img%}" onerror="javascript:this.src='../img/shangjia-header90.png'"/></div> 
                <div class="l_right">
                            <div class="beign_img_l"></div>
                            <div>请确认您输入的位置在送餐范围内。<a a-click="true" style="color:red;" href="javascript:void(0);">点此选菜</a></div>
                </div>
        </div>
    </script>




    <script type="text/x-tmpl" id="takeaway_model5">
            <div class="item2" mark="{%=o.mark%}"><div class="l_img"><img src="{%=o.img%}" onerror="javascript:this.src='img/index-head.png'"/></div> <div class="l_right"> <div class="beign_img_l"></div><div class="message">{%=o.name%}</div><div class="tip">重新输入</div></div></div>
    </script>

     

    <script type="text/x-tmpl" id="takeaway_model6">
        <div class="item">
                <div class="l_img"><img src="{%=o.img%}" onerror="javascript:this.src='../img/shangjia-header90.png'"/></div> 
                <div class="l_right">
                            <div class="beign_img_l"></div>
                            <div style=" color:red;">{%=o.message%}</div>
                </div>
        </div>
    </script>

<script type="text/x-tmpl" id="temp_myaddresslist">
<div>
    {% for (var i in o.addresses) { %}
    <div class="item item2" CA_ID="{%=o.addresses[i].CA_ID %}">
        <div class="name">{%=o.addresses[i].CA_Contact %} {%=o.addresses[i].CA_Phone %}</div>
        <div class="name">{%=o.addresses[i].CA_Address %}</div>
        <div class="del">删除</div>
    </div>
    {% } %}
</div>
</script>
<!--外卖选择收货地址-->
<script type="text/x-tmpl" id="temp_myaddresslist2">
<div>
    {% for (var i in o) { %}
    <div class="item {%if(i==0){ %} no-border {% } %}" name="{%=o[i].CA_Contact %}" phone="{%=o[i].CA_Phone %}" address="{%=o[i].CA_Address %}" >
        <div>您可能的送餐地址:</div>
        <div>{%=o[i].CA_Contact %} {%=o[i].CA_Phone %}</div>
        <div>{%=o[i].CA_Address %}</div>
    </div>
    {% } %}
</div>
</script>

<!--群点菜品-->
<script type="text/x-tmpl" id="temp_crowd_nodata">
    <div style="text-align: center;background: #fff;height: 100%;line-height: 80px;">
        <span>小伙伴们都还没有点菜！</span>
    </div>
</script>
<script type="text/x-tmpl" id="temp_crowd_carte_list">
        <div id="crow_carte_scroll">
            <ul>
                {% for (var i=0; i<o.list.length ; i++) { 
                    if(o.list[i].user.length==1)
                    {
                %}
                    <li>
                        <div class="dish_item">
                            <div class="imagelist people1" data_name="{%=o.list[i].CD_Name %}" data-user="{%= JSON.stringify(o.list[i].user)%}"><img class="dish_img" src="{%=o.list[i].user[0].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" /></div>
                            <div class="dish_name">{%=o.list[i].CD_Name %}</div>
                            <div class="dish_price">￥{%=o.list[i].CD_Price %}</div>
                            <div class="dish_ope" style="right:5px;" csid="{%=o.list[i].CS_ID %}">
                                 <span class="sub"></span><span class="number">{%=o.list[i].CD_Amount %}</span><span class="add"></span>
                            </div>
                        </div>
                     </li>
                {%    
                    }else if(o.list[i].user.length==2)
                    {
                %}
                     <li>
                        <div class="dish_item">
                            <div class="imagelist people2" data_name="{%=o.list[i].CD_Name %}" data-user="{%= JSON.stringify(o.list[i].user)%}">
                                <img class="dish_img" src="{%=o.list[i].user[0].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" />
                                <img class="dish_img" src="{%=o.list[i].user[1].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" />
                            </div>
                            <div class="dish_name">{%=o.list[i].CD_Name %}</div>
                            <div class="dish_price">￥{%=o.list[i].CD_Price %}</div>
                            <div class="dish_ope" style="right:5px;" csid="{%=o.list[i].CS_ID %}">
                                 <span class="sub"></span><span class="number">{%=o.list[i].CD_Amount %}</span><span class="add"></span>
                            </div>
                        </div>
                     </li>

                {%      
                    }else if(o.list[i].user.length==3)
                    {
                %}
                    <li>
                        <div class="dish_item">
                            <div class="imagelist people3" data_name="{%=o.list[i].CD_Name %}" data-user="{%= JSON.stringify(o.list[i].user)%}">
                                <div class="item"><img class="dish_img" id="img01" src="{%=o.list[i].user[0].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" /></div>
                                <div class="item">
                                    <img class="dish_img" src="{%=o.list[i].user[1].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" />
                                    <img class="dish_img" src="{%=o.list[i].user[2].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" />
                                </div>
                            </div>
                            <div class="dish_name">{%=o.list[i].CD_Name %}</div>
                            <div class="dish_price">￥{%=o.list[i].CD_Price %}</div>
                            <div class="dish_ope" style="right:5px;" csid="{%=o.list[i].CS_ID %}">
                                 <span class="sub"></span><span class="number">{%=o.list[i].CD_Amount %}</span><span class="add"></span>
                            </div>
                        </div>
                     </li>

                {%   
                    }else if(o.list[i].user.length==4)
                    {
                %}
                     <li>
                        <div class="dish_item">
                            <div class="imagelist people4" data_name="{%=o.list[i].CD_Name %}" data-user="{%=JSON.stringify(o.list[i].user)%}">
                                <div class="item">
                                    <img class="dish_img" src="{%=o.list[i].user[0].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" />
                                    <img class="dish_img" src="{%=o.list[i].user[1].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" />
                                </div>
                                <div class="item">
                                    <img class="dish_img" src="{%=o.list[i].user[2].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" />
                                    <img class="dish_img" src="{%=o.list[i].user[3].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt="" />
                                </div>
                            </div>
                            <div class="dish_name">{%=o.list[i].CD_Name %}</div>
                            <div class="dish_price">￥{%=o.list[i].CD_Price %}</div>
                            <div class="dish_ope" style="right:5px;" csid="{%=o.list[i].CS_ID %}">
                                 <span class="sub"></span><span class="number">{%=o.list[i].CD_Amount %}</span><span class="add"></span>
                            </div>
                        </div>
                     </li>


                {%   
                    }
                }%}
               
            </ul>
         </div>
    </script>

<!--群点人员所点菜品详情-->
 <script type="text/x-tmpl" id="temp_user_carte">
    <div id="crowduser_scroll">
     <ul>
    {% for (var i=0; i<o.length ; i++) {
    %}
       
            <li><img src="{%=o[i].M_Image %}" onerror="javascript:this.src='img/carte_default_small.png';" alt=""  /><div>{%=o[i].M_Name %}</div><span class="count">{%=o[i].cnt %}份</span></li>
        
    {%}%}
    </ul>
    </div>
 </script>



</body>
</html>
