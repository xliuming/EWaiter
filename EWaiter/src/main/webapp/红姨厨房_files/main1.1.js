﻿var $crowd_carte_Scroll;
var localdata = [];
try { localdata = JSON.parse(localStorage.getItem('localdata')); } catch (ex) {localdata = []; };
var crowdObj = { crowd_code: "", crowd_version: "" };
$(function () {
    var $mylist_scroll;
    var $qundian_scroll;
    Bind_BackEvent();
    Bind_ClickEvent();
    Bind_ScrollEvent();

    //绑定列表滚动事件
    function Bind_ScrollEvent() {
        $mylist_scroll = new iScroll("qa_main", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true });
        $qundian_scroll = new iScroll("crowd_main", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true });

    };

    //绑定返回按钮
    function Bind_BackEvent() {
        $("#qa_back").click(function () { document.getElementById('qaPage').style.webkitTransform = 'translate3d(100%, 0, 0)'; });
        $("#crowd_back").click(function () { document.getElementById('crowdPage').style.webkitTransform = 'translate3d(100%, 0, 0)'; });
        $("#crowdcarte_back").click(function () { document.getElementById('crowdcarte_Page').style.webkitTransform = 'translate3d(100%, 0, 0)'; });
        $("#crowduser_back").click(function () { document.getElementById('crowduser_Page').style.webkitTransform = 'translate3d(100%, 0, 0)'; });

    };

    //绑定点击事件
    function Bind_ClickEvent() {
        $("#btn_click_right").click(function () { $("#share-wx").show(); });
        $("#share-wx").click(function () { $(this).hide(); });
        $("#index_qa").click(function () { document.getElementById('qaPage').style.webkitTransform = 'translate3d(0%, 0, 0)'; });
        $("#index_qundian").click(function () { OpenQundian(); });
        $("#qaPage .item").click(function () {
            var _this_button = $(this).find("[button='true']")
            var _content = $(this).find(".content");
            if (_this_button.attr("class") == "button_right") {
                _content.slideDown();
                _this_button.attr("class", "button_down")
            } else {
                _content.slideUp();
                _this_button.attr("class", "button_right")
            };
            $mylist_scroll.refresh();
        });

        $("#go_dishlist").click(function () {
            if ($shop_load && $table_load) {
                dineType = 0;
                //$(this).addClass("rotate_animation");
                initDishList();
                refreshCart("dish_info");
            }
            else {
                showdialog(1, "店铺信息初始化失败，请刷新重试!");
            }

        });

        $("#btn_beginOrder").click(function () {
            //群点下单
            showdialog(2, "请确定小伙伴们都已经点完菜了，确认即下单！", crowdOrder);

        });

        $("#crowdcarte_refresh").click(function () {
            //刷新群点购物车
            GetCrowCarteList();
        });

    };


});

/*--------------------------------以下群点功能------------------------------*/
/*--------------------------------打开群点------------------------------*/
function OpenQundian() {

    if (ua.match(/MicroMessenger/i) != "micromessenger") {
         showdialog(1, "只有使用微信才能和小伙伴一起点餐!");
         return;
    };
     var data = "ml_guid=" + gdata.ML_GUID + "&r_id=" + gdata.shop_config.R_ID;

     jAjax({
         type: "post",
         url: "/1/crowd.asmx/open",
         data: data,
         showLoading: true,
         success: function (data) {
	
             var jsonResult = eval('(' + data + ')');

             if (jsonResult.result == 0) {
                 crowdObj.crowd_code = jsonResult.crowd_code;
                 //crowdObj.crowd_version = jsonResult.crowd_version;
                 crowdObj.crowd_version = "";
                 var current_url = document.URL;
                 if (current_url.indexOf('?') > -1) {
                     current_url = current_url.split('?')[0];
                 };
                 current_url = current_url.replace("htm", "crowd");
                 current_url += '?i=' + jsonResult.crowd_code;
                 document.getElementById('crowdPage').style.webkitTransform = 'translate3d(0%, 0, 0)';
                 document.getElementById("qundian_userhead").style.backgroundImage = "url(" + gdata.userinfo.M_Image + ")";
                 document.getElementById("qundian_username").innerText = gdata.userinfo.M_Name;
                 //document.getElementById("erweima").style.backgroundImage = "url(http://api.kuaipai.cn/qr?chs=150x150&chl="+current_url+")";
                 document.getElementById("erweima").style.backgroundImage = "url(/QrCodeShow.ashx?size=5&content=" + current_url + ")";




                 wechatParm.shareimgUrl = gdata.userinfo.M_Image;
                 wechatParm.lineLink = current_url;
                 wechatParm.descContent = gdata.userinfo.M_Name + "邀请您一起点餐,快去看看吧!"; //+ current_url;
                 wechatParm.shareTitle = '群点';
                 SetWechatFn();



             }
             else {
                 showdialog(1, "打开群点失败，请刷新重试!");
             }
         }
     });
};
/*--------------------------------群点提交菜品------------------------------*/
//carte_submit(string ml_guid, decimal r_id, string crowd_code, string xml)
function qundianAdd() {
    var dishList = { "list": [] };
    for (var j = 0; j < $order.size(); j++) {
        dishList.list.push($order.get(j));
    };
    var sub_xml = tmpl("order_submit", dishList);
    var data = "ml_guid=" + gdata.ML_GUID + "&r_id=" + gdata.shop_config.R_ID + "&crowd_code=" + crowdObj.crowd_code + "&xml=" + encodeURIComponent(sub_xml);

    jAjax({
        type: "post",
        url: "/1/crowd.asmx/carte_submit",
        data: data,
        showLoading: true,
        success: function (data) {
            var jsonResult = eval('(' + data + ')');

            if (jsonResult.result == 0) {
                crowdObj.crowd_version = jsonResult.crowd_version;
                localdata = jsonResult.list; //保存下当前菜品
                localStorage.setItem('localdata', JSON.stringify(localdata));
                document.getElementById('crowdcarte_Page').style.webkitTransform = 'translate3d(0%, 0, 0)';
                setTimeout(function () {
                    document.getElementById('carte_page').style.webkitTransform = 'translate3d(100%, 0, 0)';
                },500);

                GetCrowCarteList();
                //移除点菜信息
                //选择状态为0
                $("#dish_list").find('.dish_add').css('display', 'block');
                $("#dish_list").find('.dish_ope').css('display', 'none');
                $("#dish_list").find('.number').html(0);
                $("#dish_category_scroller").find(".num").css('display', 'none').html(0);
                $("#dish_list").find(".dish_item").css('background-color', '#FFF');
                $order = new ArrayList();
                refreshCart("dish_info");
                //清除选中状态
                $(".dish_list_active").css('border-bottom', '1px solid #f3f4f4').find(".vip").show();

            } else {
                showdialog(1, "提交菜品失败!错误信息:" + jsonResult.error);
            };

        }
    });
};

//获取服务器群点菜品
//get(string ml_guid, decimal r_id, string crowd_code, string crowd_version)
function GetCrowCarteList() {
    var data = "ml_guid=" + gdata.ML_GUID + "&r_id=" + gdata.shop_config.R_ID + "&crowd_code=" + crowdObj.crowd_code + "&crowd_version=" + crowdObj.crowd_version;
    jAjax({
        type: "post",
        url: "/1/crowd.asmx/get",
        data: data,
        showLoading: true,
        success: function (data) {
            var jsonResult = eval('(' + data + ')');

            var this_change = true;
            if (jsonResult.result == 651) {
                //数据未发生变化
                this_change = false;
            } else {
                crowdObj.crowd_version = jsonResult.crowd_version;
                if (jsonResult.result == 0) {
                    localdata = jsonResult.list;
                    localStorage.setItem('localdata', JSON.stringify(localdata));
                }
            };
            var _data = GetDataInfo(localdata);
            if (_data.list.length > 0) {
                $("#crow_carte_container").html(tmpl("temp_crowd_carte_list", _data));
                //<div id="crow_info">共计11个菜,&nbsp;<span class="price">￥0.43</span></div>
                $("#crow_info").html("<span style='font-family: Arial;'>" + _data.cnt + "</span>个菜，&nbsp<span class='price'>￥" + _data.money + "</span>");
                Bind_Serverlist_Btn_Event($("#crow_carte_container"));
                setTimeout(function () {
                    $crowd_carte_Scroll = new iScroll("crow_carte_scroll", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true });
                }, 500);
            } else {
                $("#crow_carte_container").html(tmpl("temp_crowd_nodata"));
                $("#crow_info").html("<span style='font-family: Arial;'>" + 0 + "</span>个菜，&nbsp<span class='price'>￥" + 0 + "</span>");
                       
            }

        }
    });
};

//解析菜品  获得点菜详情统计信息
function GetDataInfo() {
    var _temp = [];
    var _moneyTotl = 0;
    var carteTotl = 0;
    for (var k in localdata) {
        _moneyTotl = _moneyTotl + localdata[k].CD_Sum;
        carteTotl = carteTotl + localdata[k].CD_Amount;
        var _this_addFlag = true;

        var _this_item = {};
        for (var kk in _temp) {
            if (localdata[k].CS_ID == _temp[kk].CS_ID) {
                _this_addFlag = false;
                _this_item = _temp[kk];
            }
        };
        if (_this_addFlag) {
            _this_item.CS_ID = localdata[k].CS_ID;
            _this_item.CD_Name = localdata[k].CD_Name;
            _this_item.CD_Amount = localdata[k].CD_Amount;
            _this_item.CD_Price = localdata[k].CD_Price;
            _this_item.CD_Sum = localdata[k].CD_Sum;
            _this_item.user = [];
            var _this_user = { M_Name: localdata[k].M_Name, M_Image: localdata[k].M_Image, cnt: localdata[k].CD_Amount };
            _this_item.user.push(_this_user);
            _temp.push(_this_item);
        } else {
            _this_item.CD_Amount += localdata[k].CD_Amount;
            _this_item.CD_Sum += localdata[k].CD_Sum;
            //检测用户
            var _this_userAddFlag = true;
            var _this_user_item;
            for (var kk in _this_item.user) {
                if (_this_item.user[kk].M_Name == localdata[k].M_Name) {
                    _this_userAddFlag = false;
                    _this_user_item = _this_item.user[kk];
                }
            };
            if (_this_userAddFlag) {
                var _this_user = { M_Name: localdata[k].M_Name, M_Image: localdata[k].M_Image, cnt: localdata[k].CD_Amount };
                _this_item.user.push(_this_user);
            } else {
                _this_item.user.cnt += localdata[k].CD_Amount;
            }

        };
    };
    return { cnt: carteTotl, money: _moneyTotl, list: _temp };
};

function Bind_Serverlist_Btn_Event(target) {
    $(".sub", target).click(function () {
        servercartEdit(this, "del");
    });
    $(".add", target).click(function () {
        servercartEdit(this, "add");
    });
    $(".imagelist", target).click(function () {
        var Datastr = $(this).attr("data-user");
        var dataName = $(this).attr("data_name");
        var this_jsonData = eval('(' + Datastr + ')');
        $("#crow_carteName").text(dataName);
        $("#crowduser_container").html(tmpl("temp_user_carte", this_jsonData));
        document.getElementById('crowduser_Page').style.webkitTransform = 'translate3d(0, 0, 0)';
    });
};
//群点下单
function crowdOrder() {

    if ($table_data_id == null) {
        //$("#open_slider_table").trigger("click");
        document.getElementById("slider_table_Full").style.display = "block";
        document.getElementById("slider_table").style.webkitTransform = "translate3d(0,0, 0)";
        return;
    };
    var sub_ML_GUID = gdata.ML_GUID;
    var sub_TI_Code = $table_data_id;
    var sub_PD_Type = -1; //现金支付
    var sub_DB_Remark = ($("#remark_input2").val() == "请输入特殊要求" ? "" : $("#remark_input").val()); //备注
    var sub_data = "r_id=" + R_ID + "&ml_guid=" + sub_ML_GUID + "&ti_code=" + sub_TI_Code + "&pd_type=" + sub_PD_Type + "&db_remark=" + sub_DB_Remark + "&xml=" + "&crowd_code=" + crowdObj.crowd_code + "&crowd_version=" + crowdObj.crowd_version;
    jAjax({
        type: "post",
        url: "/1/dining.asmx/add",
        data: sub_data,
        showLoading: true,
        success: function (data) {
            var obj = eval('(' + data + ')');
            if (obj.result == 0) {
                orderinfo(obj.DB_Number);
            }
            else if (obj.result == 652) {
                //群点数据已发生改变，刷新后重新下单
                showdialog(1, "您的小伙伴已经更新了菜品，点击刷新！", GetCrowCarteList);
               
            }
            else {
                //桌台不存在或者被占用
                if (obj.result == 162 || obj.result == 160) {
                    $table_data_id = null;
                    // $("#open_slider_table").trigger("click");
                    document.getElementById("slider_table_Full").style.display = "block";
                    document.getElementById("slider_table").style.webkitTransform = "translate3d(0,0, 0)";
                };
                showdialog(1, obj.error);
            }
        },
        error: function () {
            showdialog(1, "请求失败!");
        }
    });



};
//群点增加/删除菜品
function servercartEdit(target,editType) {
    //(string ml_guid, decimal r_id, string crowd_code, string crowd_version,decimal cs_id)
    var parentLi = $(target).parents("li");
    var csid = $(target).parent().attr("csid");
    var numText = $(target).parent().find(".number");

    if (editType == "del") {
        if (Number(numText.text()) <= 0) {
            return;
        }
    };


    var sub_data = "ml_guid=" + gdata.ML_GUID + "&r_id=" + R_ID + "&crowd_code=" + crowdObj.crowd_code + "&crowd_version=" + crowdObj.crowd_version + "&cs_id=" + csid;
    var sub_url = "/1/crowd.asmx/carte_add";
    if (editType == "del") {
        sub_url = "/1/crowd.asmx/carte_delete";
    };
    jAjax({
        type: "post",
        url: sub_url,
        data: sub_data,
        loadMessage: "正在通信中，请稍后。。。",
        showLoading: true,
        success: function (data) {
            var obj = eval('(' + data + ')');
            if (obj.result == 0) {

                crowdObj.crowd_version = obj.crowd_version;
                var current_N = Number(numText.text());
                if (editType == "del") {
                    EditLocaldata(csid, "del");
                    current_N -= 1;
                } else {
                    EditLocaldata(csid, "add");
                    current_N += 1;
                };
                if (current_N <= 0) {
                    current_N = 0;
                    parentLi.slideUp(500);
                    $crowd_carte_Scroll.refresh();
                };
                numText.text(current_N);
                var _data = GetDataInfo(localdata);
                $("#crow_info").html("<span style='font-family: Arial;'>" + _data.cnt + "</span>个菜，&nbsp<span class='price'>￥" + _data.money + "</span>");

            }
            else if (obj.result == 652) {

                showdialog(1, "您的小伙伴已经更新了菜品，点击刷新！", function () {

                    //重新刷新列表
                    crowdObj.crowd_version = obj.crowd_version;
                    localdata = obj.list;
                    var _data = GetDataInfo(localdata);

                    if (_data.list.length > 0) {

                        $("#crow_carte_container").html(tmpl("temp_crowd_carte_list", _data));
                        //<div id="crow_info">共计11个菜,&nbsp;<span class="price">￥0.43</span></div>
                        $("#crow_info").html("<span style='font-family: Arial;'>" + _data.cnt + "</span>个菜，&nbsp<span class='price'>￥" + _data.money + "</span>");
                        Bind_Serverlist_Btn_Event($("#crow_carte_container"));
                        setTimeout(function () {
                            $crowd_carte_Scroll = new iScroll("crow_carte_scroll", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true });
                        }, 500);
                    } else {
                        $("#crow_carte_container").html(tmpl("temp_crowd_nodata"));
                        $("#crow_info").html("<span style='font-family: Arial;'>" + 0 + "</span>个菜，&nbsp<span class='price'>￥" + 0 + "</span>");
                       
                    }

                });

                
            }
            else {
                showdialog(1, obj.error);
            };


            localStorage.setItem('localdata', JSON.stringify(localdata));
        },
        error: function () {
            showdialog(1, "请求失败!");
        }
    });
};

//修改localdata数据
function EditLocaldata(csid,editType) {
    for (var k in localdata) {
        if (localdata[k].CS_ID == csid) {
            if (editType == "del") {
                if (localdata[k].CD_Amount > 1) {
                    localdata[k].CD_Amount -= 1;
                } else {
                    localdata.splice(k, 1);
                }
            } else {
                localdata[k].CD_Amount += 1;
            }
            break;
        };
    }
    
};
