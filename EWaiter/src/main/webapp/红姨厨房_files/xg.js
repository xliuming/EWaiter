﻿function orderinfo(db_number, back_targetId) {

    document.getElementById("slider_order").style.webkitTransform = "translate3d(0%,0,0)";
    var sub_data = "r_id=" + R_ID + "&db_Number=" + db_number;

    jAjax({
        type: "post",
        url: "/1/dining.asmx/carte",
        data: sub_data,
        showLoading: false,
        success: function (data) {
            var obj = eval('(' + data + ')');
            obj.shopname = localStorage.getItem('index_shop_title');

            $("#slider_order").html(tmpl("tmpl-order-info", obj));

            $("#pay-type").bind("click", function () {
                if ($(this).hasClass("last")) {
                    $(this).removeClass("last");
                    $(this).children(".expland").attr("class", "expland up");
                } else {
                    $(this).addClass("last");
                    $(this).children(".expland").attr("class", "expland down");
                };
                $("#paytype-list").toggle(300);
            });

            // if ($("#cj_btn").text() == "无活动")) { $("#cj_btn").hide(); }
            if ($("#cj_btn").text() == "无活动" || $("#cj_btn").text() == "") { $("#cj_btn").hide(); };
            $("#cj_btn").bind("click", function () {
                var this_state = $(this).text();
                var _states = 1;
                if (this_state == "等待兑奖") {
                    _states = 2;
                };
                if (this_state == "等待抽奖" || this_state == "等待兑奖") {
                    //                    if (LotteryMode == "1") {
                    //                        document.getElementById("ifm").src = "../ggk/lotter.html?rid=" + R_ID + "&db_number=" + db_number + "&state=" + _states;
                    //                    } else {
                    //                        document.getElementById("ifm").src = "../ggk/cj.html?rid=" + R_ID + "&db_number=" + db_number + "&state=" + _states;
                    //                    };
                    setLotter(db_number, _states);

                    document.getElementById("lottery").style.webkitTransform = "translate3d(0, 0, 0)";

                }
            });



            $("#order-back").unbind("click").bind("click", function () {
                //document.getElementById("carte_page").className = "";

                document.getElementById("slider_order").style.webkitTransform = "translate3d(100%, 0, 0)";

            });




            setTimeout(function () {
                var $order_scroll = new iScroll("order_scroll", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true });
            }, 100);

            setTimeout(function () {
                document.getElementById("carte_page").style.webkitTransform = "translate3d(0, 100%, 0)";
            }, 500);
        },
        error: function () {
            showdialog(1, "load failed");
        }
    }); 
};

//$("#index_menu").bind("click", function() {
//alert(1)
//    $(this).animate({" -webkit-transform": "rotate(-45deg)" }, "slow");
//});



var index_menuBtn = document.querySelector('#index_menu');
$("#headImg").bind("click", function () {
    if ($(this).attr("stop")) { return; }
    $(this).attr("stop", "true");
    $("#index_menu").attr("stop", "true");

    $(this).removeClass("showimg").addClass("hideimg")
    $("#index_menu").show().addClass("flash-menu-show");
    $("#head_add").show().removeClass("hideadd").addClass("showadd");

});
$("#index_menu").bind("click", function () {
    if ($(this).attr("stop")) { return; }
    $(this).attr("stop", "true");
    $("#headImg").attr("stop", "true");
    $(this).addClass("flash-menu-hidden");
    $("#headImg").removeClass("hideimg").addClass("showimg");
    $("#head_add").removeClass("showadd").addClass("hideadd");

});

index_menuBtn.addEventListener("webkitAnimationEnd", function () { //动画结束时事件
    if ($(this).hasClass("hidden-img")) {
        $(this).removeClass("hidden-img");
        $(this).addClass("show-img");
        $(this).removeClass("flash-menu-show");
    } else {
        $(this).removeClass("show-img");
        $(this).addClass("hidden-img");
        $(this).removeClass("flash-menu-hidden");
        $(this).hide();
        $("#head_add").hide();
    };
    $("#headImg").attr("stop", "");
    $("#index_menu").attr("stop", "");

}, false);

$("#index_menu #index-huiyuan").bind("click", function (event) {
    event.stopPropagation();
    //    $(this).attr("class", "huiyuan02");
    //    $("#index_menu #index-order").attr("class", "order");
    //    $("#index_menu #index-call").attr("class", "call");

    if (!$table_data_id) {
        showdialog(1, "请先选择桌台！");
        return;
    };

    var datasend = "r_id=" + R_ID + "&content=桌台[" + $table_data_id + "]呼叫服务员";
 
    jAjax({
        type: "post",
        data: datasend,
        url: "/1/member.asmx/call_service",
        success: function (data) {
        alert(data)
            var res = eval('(' + data + ')');
            if (res.result == 0) {
                showdialog(1, "呼叫成功，请等候服务员。");
            }
            else {
                showdialog(1, "网络错误，呼叫服务员失败。");
            };

        }
    });


});
$("#index_menu #index-order").bind("click", function (event) {
    event.stopPropagation();
    initLoginMark(2);


    //    $(this).attr("class", "order02");
    //    $("#index_menu #index-huiyuan").attr("class", "huiyuan");
    //    $("#index_menu #index-call").attr("class", "call");
});
$("#index_menu #index-call").bind("click", function(event) {
    
    event.stopPropagation();
//    $(this).attr("class", "call02");
//    $("#index_menu #index-order").attr("class", "order");
//    $("#index_menu #index-huiyuan").attr("class", "huiyuan");
    //table-data-id

    document.getElementById("slider_my").style.webkitTransform = "translate3d(0%, 0, 0)";
});

function load_orderlistData() {

    //bills(string ml_guid, string r_id, byte type, int page_index, int page_size)
    var ml_guid = gdata.ML_GUID || gdata.ML_GUID_02;
    var sub_data = "ml_guid=" + ml_guid + "&r_id=" + R_ID + "&type=0&page_index=1&page_size=10"
   // var sub_data = "ML_GUID=" + $user.ML_GUID + "&type=0&pageIndex=1&pageSize=10";
    jAjax({
        type: "post",
        url: "/1/member.asmx/bills",
        data: sub_data,
        showLoading: true,
        success: function (data) {
            var obj = eval('(' + data + ')');
            if (obj.list) {
                for (var j in obj.list) {
                    
                    //var newT = new Date(obj.list[j].t);
                    var newT = new Date(obj.list[j].t.replace(/-/g, "/"));
                    obj.list[j].t1 = newT.getFullYear() + "-" + (newT.getMonth() + 1) + "-" + newT.getDate();
                    obj.list[j].t2 = newT.getHours() + ":" + newT.getMinutes() + ":" + newT.getSeconds();
                }
            };
            if (obj.result == 0) {
                obj.shopname = localStorage.getItem('index_shop_title');
                $("#pageitem01").html(tmpl("orderlistpage", obj));
            } else {
                $("#pageitem01").html("<div class='no_data'>您还没有未完成订单</div>");
            };
            setTimeout(function () {
                new iScroll("pageitem01", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true });
            }, 100);

            $("#pageitem01 li").bind("click", function () {
                orderinfo($(this).attr("data-id"), "slider_orderlist");
            });


            //            setTimeout(function() {
            //                document.getElementById("carte_page").style.webkitTransform = "translate3d(0, 100%, 0)";
            //            }, 500);
        },
        error: function () {
    
            showdialog(1, "load failed");
        }
    });


    //var sub_data2 = "ML_GUID=" + $user.ML_GUID + "&type=1&pageIndex=1&pageSize=10";
    var ml_guid = gdata.ML_GUID || gdata.ML_GUID_02;
    var sub_data2 = "ml_guid=" + ml_guid + "&r_id=" + R_ID + "&type=1&page_index=1&page_size=10"
    //bills(string ml_guid, string r_id, byte type, int page_index, int page_size)
    jAjax({
        type: "post",
        url: "/1/member.asmx/bills",
        data: sub_data2,
        showLoading: true,
        success: function (data) {
            var obj = eval('(' + data + ')');
            if (obj.list) {
                for (var j in obj.list) {
                    //var newT = new Date(obj.list[j].t);
                    var newT = new Date(obj.list[j].t.replace(/-/g, "/"));
                    obj.list[j].t1 = newT.getFullYear() + "-" + (newT.getMonth() + 1) + "-" + newT.getDate();
                    obj.list[j].t2 = newT.getHours() + ":" + newT.getMinutes() + ":" + newT.getSeconds();
                }
            };
            if (obj.result == 0) {
                obj.shopname = localStorage.getItem('index_shop_title');

                $("#pageitem02").html(tmpl("orderlistpage", obj));
            } else {
                $("#pageitem02").html("<div class='no_data'>您还没有已完成订单</div>");
            };

            setTimeout(function () {
                new iScroll("pageitem02", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true });
            }, 100);

            $("#pageitem02 li").bind("click", function () {
                orderinfo($(this).attr("data-id"), "slider_orderlist");
            });

            //            setTimeout(function() {
            //                document.getElementById("carte_page").style.webkitTransform = "translate3d(0, 100%, 0)";
            //            }, 500);
        },
        error: function () {
            showdialog(1, "load failed");
        }
    }); 
    
     
};

$("#my_orderlist").bind("click", function() {
    document.getElementById("slider_orderlist").style.webkitTransform = "translate3d(0%, 0, 0)";

    load_orderlistData();
});

$("#my_addresslist").bind("click", function () {
    // if (!gdata.ML_GUID) { showdialog(1, "请在微信中打开!"); }
    document.getElementById("myAddress").style.webkitTransform = "translate3d(0%, 0, 0)";
    getmyAddressList();
});
$("#saveAddress_btn").click(function () {
    var _name = $("#lx_name").val();
    var _phone = $("#lx_phone").val();
    var _address = $("#lx_address").val();
    //add(string ml_guid, string address, string contact, string phone, bool is_default)

    jAjax({
        type: "post",
        url: "/1/address.asmx/add",
        data: "ml_guid=" + gdata.ML_GUID + "&address=" + encodeURIComponent(_address) + "&contact=" + encodeURIComponent(_name) + "&phone=" + _phone + "&is_default=false",
        success: function (data) {
        alert(data)
            var obj = eval('(' + data + ')');
            
        }
    });
});
function getmyAddressList() {
    jAjax({
        type: "post",
        url: "/1/address.asmx/all",
        data: "ml_guid=" + gdata.ML_GUID,
        success: function (data) {
            var obj = eval('(' + data + ')');
            gdata.addresslist = obj.addresses;
            $("#Address_Main").html(tmpl("temp_myaddresslist", obj));
            $myAddress_scroll = new iScroll("Address_Main", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true,
                onScrollMove: function (e) {
                }
            });


        }
    });
};



$("#slider_orderlist #hd01").bind("click", function() {
    if ($(this).hasClass("curr")) {
        return;
    };
    $(this).addClass("curr").next().removeClass("curr");
    $("#slider_orderlist #pageitem02").css({ "-webkit-transform": "translate3d(100%, 0px, 0px)" });
});

$("#slider_orderlist #hd02").bind("click", function() {
    if ($(this).hasClass("curr")) {
        return;
    };
    $(this).addClass("curr").prev().removeClass("curr");
    $("#slider_orderlist #pageitem02").css({ "-webkit-transform": "translate3d(0%, 0px, 0px)" });
});
$("#slider_my_back").bind("click", function() {
    document.getElementById("slider_my").style.webkitTransform = "translate3d(100%, 0, 0)";
});
$("#slider_orderlist .back").bind("click", function() {
    document.getElementById("slider_orderlist").style.webkitTransform = "translate3d(100%, 0, 0)";
});


new iScroll("slider_my_scroll", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true });



var lotterflag = false; //是否中奖
var lotterproduct = ""; //中奖物品
var sp;
var lotterScroll;
var beginCj = false;
$(function () {
    sp = $("#wScratchPad").wScratchPad({
        scratchDown: function (e, percent) { e.preventDefault(); e.stopPropagation(); $(this.canvas).css('margin-right', $(this.canvas).css('margin-right') == "0px" ? "1px" : "0px"); },
        scratchMove: function (e, percent) {
            e.preventDefault(); e.stopPropagation();
            if (!beginCj) {
                beginCj = true;
                BeginLotter($("#lottery #ok").attr("dbnumber"));
            };
            $(this.canvas).css('margin-right', $(this.canvas).css('margin-right') == "0px" ? "1px" : "0px");
        },
        scratchUp: function (e, percent) {

            e.preventDefault(); $(this.canvas).css('margin-right', $(this.canvas).css('margin-right') == "0px" ? "1px" : "0px");
            if (percent >= 30) {
                if (lotterflag) {
                    alert('恭喜您，中奖了！');
                    $("#wScratchPad").hide();
                    $("#firstDiv,#secondDiv").show();
                    beginCj = false;
                    lotterScroll.refresh();
                };
            }
        }
    });
    lotterScroll = new iScroll("bodylotter", { hScrollbar: false, vScrollbar: false, lockDirection: true, hScroll: false, vScroll: true, useTransition: true, click: true,
        onBeforeScrollMove: function (e) {
            e = e || event;
            var currentObj = e.target || e.srcElement;
            if (currentObj.tagName.toLowerCase() == "canvas") {
                lotterScroll.stopFlag = true;
            }
        },
        onTouchEnd: function () {
            lotterScroll.stopFlag = false;
        }
    });



    $("#lottery #ok").click(function () {
        var l_key = $("#lottery #num").val();
        var db_number = $(this).attr("dbnumber");
        if (!l_key) { return; }
        $.ajax({
            url: "/1/lottery.asmx/order_cash",
            type: "post",
            dataType: "json",
            data: "r_id=" + R_ID + "&db_number=" + db_number + "&l_key=" + $("#num").val(),
            success: function (data) {
                if (data.result == 0) {
                    showdialog(1, "兑奖成功");
                    document.getElementById("cj_btn").innerHTML = "已兑奖:中" + lotterproduct;

                } else {
                    showdialog(1, data.error);
                }
            }
        });
    });

    $.ajax({
        url: "/1/lottery.asmx/lottery_rule",
        type: "post",
        data: "r_id=" + R_ID,
        success: function (data) {
            $("#lottery #memo").html(data.LotteryExplain);
            var str = "";
            for (var i in data.listLotteryRule) {
                str += "<div>" + data.listLotteryRule[i].name + "</div>";
            };
            $("#lottery #list").html(str);
        }
    });
});


function set_image_bg(imgurl) {
    sp.wScratchPad('image', imgurl);
    sp.wScratchPad('reset');
};



//开始抽奖
function BeginLotter(db_number) {
    $.ajax({
        url: "/1/lottery.asmx/order",
        type: "post",
        data: "r_id=" + R_ID + "&db_number=" + db_number,
        dataType: "json",
        success: function (data) {
            if (data.lottery) {
                lotterflag = true;
                lotterproduct = data.l_remark;
                // set_image_bg("/LotteryImage.ashx?content=" + data.l_name + "&height=100&width=290");
                parent.window.document.getElementById("cj_btn").innerHTML = "等待兑奖";
            };
            set_image_bg("/dish/" + R_ID + "/Lottery/" + data.lr_level + ".jpg");
            if (data.error) {
                $("#lottery #wScratchPad").hide();
                $("#lottery #firstDiv").html(data.error);
            } else {
                $("#lottery #span01").text(data.l_name); //几等奖
                $("#lottery #span02").text(data.l_remark); //奖品名称
                product = data.l_remark;
                $("#lottery #span03").text(data.l_time); //date
            }
            lotterScroll.refresh();
        }
    });

};


//抽奖
function setLotter(db_number, states) {
    beginCj = false;
    $('#wScratchPad').wScratchPad('reset');
    //document.removeEventListener('touchmove', stophand, false);
    $("#lottery #ok").attr("dbnumber", db_number);
    $("#wScratchPad").show();
    $("#lottery #firstDiv").hide();
    $("#lottery #secondDiv").hide();
    

    if (states == 1) {
        //BeginLotter(db_number);
    } else {
        lotterflag = true;
        $.ajax({
            url: "/1/lottery.asmx/lottery_info",
            type: "post",
            data: "r_id=" + R_ID + "&db_number=" + db_number,
            dataType: "json",
            success: function (data) {
                $("#lottery #span01").text(data.L_Name); //几等奖
                $("#lottery #span02").text(data.L_Remark); //奖品名称
                lotterproduct = data.L_Remark;
                $("#lottery #span03").text(data.L_InputTime); //date

                $("#lottery #wScratchPad").hide();
                $("#lottery #firstDiv").show();
                $("#lottery #secondDiv").show();
                lotterScroll.refresh();
            }
        });
    };

    
}

