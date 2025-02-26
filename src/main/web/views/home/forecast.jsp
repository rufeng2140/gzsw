<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>预报</title>
  <%@ include file="../linker.jsp" %>
  <script src="<c:url value="/assets/js/chart.js"></c:url>"></script>
</head>
<style type="text/css">
  .input-tr{
    padding:0 !important;
  }
  .input-tr .layui-input{
    border: none !important;
  }
  #model_cl_1,
  #model_hl_2,
  #model_cl_3,
  #model_hl_4,
  #model_cl_5,
  #model_hl_6,
  #forecast3,
  #forecast4,
  #unit99{
    display: none;
  }
</style>
<body>
  
  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      <div class="layui-col-md3">
        <div class="layui-card layui-form">
          <div class="layui-card-header">预报参数</div>
          <table id="table-show" class="layui-table" style="margin:0;">
            <colgroup>
              <col width="40%">
              <col width="60%">
            </colgroup>
            <tbody>
            <c:if test="${show==1}">
            <tr>
              <td>河系方案</td>
              <td class="input-tr">
                <select name="model" lay-filter="model" lay-verify="required" lay-search="">
                  <option value="">请选择</option>
                  <c:forEach items="${models}" var="model" varStatus="id">
                    <option value="${model.id}" stcd="${model.stcd}">${model.name}</option>
                  </c:forEach>
                </select>
              </td>
            </tr>
            </c:if>
            <c:if test="${show==2}">
            <tr>
              <td>站点类型</td>
              <td class="input-tr">
                <select name="sttp" lay-filter="sttp" lay-verify="required" lay-search="">
                  <option value="">请选择</option>
                  <c:forEach items="${sttps}" var="sttp" varStatus="id">
                    <option value="${sttp.code}" <c:if test="${plan.sttype==sttp.code}">selected</c:if>>${sttp.text}</option>
                  </c:forEach>
                </select>
              </td>
            </tr>
            <tr>
              <td>站点名称</td>
              <td class="input-tr">
                <select name="station" lay-filter="station" lay-verify="required" lay-search="">
                  <option value="">请选择</option>
                </select>
              </td>
            </tr>
            <tr>
              <td>预报方案</td>
              <td class="input-tr">
                <select name="plan" lay-filter="plan" lay-verify="required" lay-search="">
                  <option value="">请选择</option>
                </select>
              </td>
            </tr>
            </c:if>
            <tr>
              <td>预报时间</td>
              <td class="input-tr">
                <input id="forecastTime" type="text" name="forecastTime" placeholder="请选择" autocomplete="off" class="layui-input" value="${forecastTime}">
              </td>
            </tr>
            <tr>
              <td>影响时间</td>
              <td class="input-tr">
                <input id="affectTime" type="text" name="affectTime" placeholder="请选择" autocomplete="off" class="layui-input" value="${affectTime}">
              </td>
            </tr>
            <tr>
              <td>预报天数</td>
              <td class="input-tr">
                <select name="day" lay-filter="day" lay-verify="required" lay-search="">
                  <option value="">请选择</option>
                  <option value="3">3天</option>
                  <option value="5">5天</option>
                </select>
              </td>
            </tr>
            <tr>
              <td>未来降雨</td>
              <td class="input-tr">
                <select name="unit" lay-filter="unit" lay-verify="required" lay-search="">
                  <option value="">请选择</option>
                  <option value="0">实测雨量</option>
                  <option value="1">中央台</option>
                  <option value="2">日本台</option>
                  <option value="3">江西台</option>
                  <option value="6">欧洲台</option>
                  <option value="99">手动输入</option>
                </select>
                <button id="unit99" lay-filter="unit99" class="layui-btn layui-btn-fluid layui-btn-sm">输入未来降雨</button>
              </td>
            </tr>
            </tbody>
          </table>

          <div class="layui-card-header">${areaName}</div>
          <div id="area" class="demo-tree demo-tree-box" style="width: 100%; height: 240px; overflow-y: scroll; padding-top:10px;"></div>
        </div>
      </div>
      <div class="layui-col-md9">
        <div class="layui-card layui-form">
          <div class="layui-card-header">
            <div style="float:left">
              <button id="forecast1" lay-submit="" lay-filter="forecast1" class="layui-btn layui-btn-sm">预报流量</button>
              <button id="forecast2" lay-submit="" lay-filter="forecast2" class="layui-btn layui-btn-sm">预报水位</button>
            </div>
            <div style="float:right">
              <button id="forecast3" lay-submit="" lay-filter="forecast3" class="layui-btn layui-btn-sm">水库调度</button>
              <button id="forecast4" lay-submit="" lay-filter="forecast4" class="layui-btn layui-btn-sm">输入贡献</button>
            </div>
            <div style="float:none;clear:both"></div>
          </div>
          <div class="layui-card-body layui-row">
            <div id="chart0" style="width:100%;height:269px;"><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
            <div id="chart1" style="width:100%;height:269px;display: none;"><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
            <div id="chart2" style="width:100%;height:469px;display: none;"><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <form class="layui-form" lay-filter="updateform" id="updateform" style="padding:15px;display: none;">
    <div class="layui-form-item">
      <table class="layui-table" style="margin:0;">
        <tr>
          <td colspan="8" align="center" style="border-bottom:none;">产流参数</td>
        </tr>
      </table>
      <form id="form_model_cl_1">
        <table id="model_cl_1" lay-filter="model_cl_1" class="model_param_cl layui-table" style="margin:0;">
          <colgroup>
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
          </colgroup>
          <tbody>
          <tr>
            <td>WU0</td>
            <td class="input-tr"><input type="text" name="WU0" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.WU0}"></td>
            <td>WL0</td>
            <td class="input-tr"><input type="text" name="WL0" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.WL0}"></td>
            <td>WD0</td>
            <td class="input-tr"><input type="text" name="WD0" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.WD0}"></td>
            <td>WUM</td>
            <td class="input-tr"><input type="text" name="WUM" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.WUM}"></td>
          </tr>
          <tr>
            <td>WLM</td>
            <td class="input-tr"><input type="text" name="WLM" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.WLM}"></td>
            <td>WDM</td>
            <td class="input-tr"><input type="text" name="WDM" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.WDM}"></td>
            <td>B</td>
            <td class="input-tr"><input type="text" name="B" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.B}"></td>
            <td>K</td>
            <td class="input-tr"><input type="text" name="K" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.K}"></td>
          </tr>
          <tr>
            <td>C</td>
            <td class="input-tr"><input type="text" name="C" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.C}"></td>
            <td>SM</td>
            <td class="input-tr"><input type="text" name="SM" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.SM}"></td>
            <td>EX</td>
            <td class="input-tr"><input type="text" name="EX" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.EX}"></td>
            <td>KSS</td>
            <td class="input-tr"><input type="text" name="KSS" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.KSS}"></td>
          </tr>
          <tr>
            <td>KG</td>
            <td class="input-tr"><input type="text" name="KG" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.KG}"></td>
            <td>IM</td>
            <td class="input-tr"><input type="text" name="IM" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.IM}"></td>
            <td>T</td>
            <td class="input-tr"><input type="text" name="T" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.T}"></td>
            <td>S0</td>
            <td class="input-tr"><input type="text" name="S0" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.S0}"></td>
          </tr>
          <tr>
            <td>FR0</td>
            <td class="input-tr"><input type="text" name="FR0" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.FR0}"></td>
            <td>E</td>
            <td class="input-tr"><input type="text" name="E" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.E}"></td>
            <td colspan="4"></td>
          </tr>
          </tbody>
        </table>
      </form>
      <form id="form_model_cl_3">
        <table id="model_cl_3" lay-filter="model_cl_3" class="model_param_cl layui-table" style="margin:0;">
          <colgroup>
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
          </colgroup>
          <tbody>
          <tr>
            <td>PA</td>
            <td class="input-tr"><input type="text" name="PA" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="<c:choose><c:when test="${not empty plan.PA}">${plan.PA}</c:when><c:otherwise>30</c:otherwise></c:choose>"></td>
            <td colspan="6"></td>
          </tr>
          </tbody>
        </table>
      </form>
      <form id="form_model_cl_5">
        <table id="model_cl_5" lay-filter="model_cl_5" class="model_param_cl layui-table" style="margin:0;">
          <colgroup>
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
          </colgroup>
          <tbody>
          <tr>
            <td>KR</td>
            <td class="input-tr"><input type="text" name="KR" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.KR}"></td>
            <td>IM</td>
            <td class="input-tr"><input type="text" name="IM" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.IM}"></td>
            <td>IMM</td>
            <td class="input-tr"><input type="text" name="IMM" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.IMM}"></td>
            <td>PA</td>
            <td class="input-tr"><input type="text" name="PA" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="<c:choose><c:when test="${not empty plan.PA}">${plan.PA}</c:when><c:otherwise>30</c:otherwise></c:choose>"></td>
          </tr>
          </tbody>
        </table>
      </form>
      <table class="layui-table" style="margin:0;margin-top:15px;">
        <tr>
          <td colspan="8" align="center" style="border-bottom:none;">汇流参数</td>
        </tr>
      </table>
      <form id="form_model_hl_2">
        <table id="model_hl_2" lay-filter="model_hl_2" class="model_param_hl layui-table" style="margin:0;">
          <colgroup>
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
          </colgroup>
          <tbody>
          <tr>
            <td>F</td>
            <td class="input-tr"><input type="text" name="F" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.F}"></td>
            <td>CS</td>
            <td class="input-tr"><input type="text" name="CS" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.CS}"></td>
            <td>CI</td>
            <td class="input-tr"><input type="text" name="CI" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.CI}"></td>
            <td>CG</td>
            <td class="input-tr"><input type="text" name="CG" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.CG}"></td>
          </tr>
          <tr>
            <td>QRS0</td>
            <td class="input-tr"><input type="text" name="QRS0" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.QRS0}"></td>
            <td>QRSS0</td>
            <td class="input-tr"><input type="text" name="QRSS0" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.QRSS0}"></td>
            <td>QRG0</td>
            <td class="input-tr"><input type="text" name="QRG0" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.QRG0}"></td>
            <td>L</td>
            <td class="input-tr"><input type="text" name="L" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.L}"></td>
          </tr>
          </tbody>
        </table>
      </form>
      <form id="form_model_hl_4">
        <table id="model_hl_4" lay-filter="model_hl_4" class="model_param_hl layui-table" style="margin:0;">
          <colgroup>
            <col width="100%">
          </colgroup>
          <tbody>
          <tr>
            <td align="center" colspan="8">无需参数</td>
          </tr>
          </tbody>
        </table>
      </form>
      <form id="form_model_hl_6">
        <table id="model_hl_6" lay-filter="model_hl_6" class="model_param_hl layui-table" style="margin:0;">
          <colgroup>
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
          </colgroup>
          <tbody>
          <tr>
            <td>NA</td>
            <td class="input-tr"><input type="text" name="NA" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.NA}"></td>
            <td>NU</td>
            <td class="input-tr"><input type="text" name="NU" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.NU}"></td>
            <td>KG</td>
            <td class="input-tr"><input type="text" name="KG" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.KG}"></td>
            <td>KU</td>
            <td class="input-tr"><input type="text" name="KU" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.KU}"></td>
          </tr>
          <tr>
            <td>AREA</td>
            <td class="input-tr"><input type="text" name="AREA" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input" value="${plan.AREA}"></td>
            <td colspan="6"></td>
          </tr>
          </tbody>
        </table>
      </form>
      <table class="layui-table" style="margin:0;margin-top:15px;">
        <tr>
          <td colspan="8" align="center" style="border-bottom:none;">演算参数</td>
        </tr>
      </table>
      <form id="form_model_hl_0">
        <table id="model_hl_0" lay-filter="model_hl_0" class="layui-table" style="margin:0;">
          <colgroup>
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
            <col width="10%">
            <col width="15%">
          </colgroup>
          <tbody>
          <tr>
            <td>INTV</td>
            <td class="input-tr"><input type="text" name="INTV" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input"></td>
            <td>KE</td>
            <td class="input-tr"><input type="text" name="KE" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input"></td>
            <td>XE</td>
            <td class="input-tr"><input type="text" name="XE" onblur="value=zhzs(this.value)" autocomplete="off" class="layui-input"></td>
            <td colspan="2"></td>
          </tr>
          </tbody>
        </table>
      </form>
    </div>
  </form>

  <form class="layui-form" lay-filter="contentBox" id="contentBox" style="padding:15px;display: none;">
    <div class="layui-form-item">
      <label class="layui-form-label">水库站点</label>
      <div class="layui-input-block">
        <input type="hidden" name="oqStcd" />
        <input type="text" name="oqStname" autocomplete="off" class="layui-input" readonly/>
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">出库流量</label>
      <div class="layui-input-block">
        <table id="oq-table" class="layui-hide" lay-filter="see-data"></table>
      </div>
    </div>
  </form>

  <form class="layui-form" lay-filter="contentBox2" id="contentBox2" style="padding:15px;display: none;">
    <div id="chart3" style="width:100%;height:369px;"><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
  </form>

  <form class="layui-form" lay-filter="unitBox" id="unitBox" style="padding:15px;display: none;">
    <div class="layui-form-item">
      <div class="layui-inline">
        <label class="layui-form-label">总小时</label>
        <div class="layui-input-inline">
          <input type="number" name="unitH" autocomplete="off" class="layui-input"/>
        </div>
      </div>
      <div class="layui-inline">
        <label class="layui-form-label">总雨量</label>
        <div class="layui-input-inline">
          <input type="number" name="unitP" autocomplete="off" class="layui-input"/>
        </div>
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">未来降雨</label>
      <div class="layui-input-block">
        <table id="unit-table" class="layui-hide" lay-filter="unit-data"></table>
      </div>
    </div>
  </form>

  <script>
  layui.config({
    base: base //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'admin', 'echarts', 'table', 'tree', 'form', 'laydate'], function () {
      var $ = layui.$
          ,admin = layui.admin
          ,tree = layui.tree
          ,form = layui.form
          ,laydate = layui.laydate
          ,table = layui.table
          ,echarts = layui.echarts;
      ajaxSetup($, '由于您长时间没有操作, 请重新登录。');

      var dataTree = [];
      var type = 1;
      var oqObj = {};
      var unitH = '';
      var unitP = '';
      var unitTemp = [];
      var unitArr = [];
      var currentStcd = '';
      var currentType = 1;
      var donePost = false;

      function resize(size){
          var h = $(window).height() - 15 * 2;
          $('#area').css('height', (h-43-$("#table-show").height()-43-10-size)+'px');
          $('#chart0').css('height', (h-63)+'px');
          $('#chart1').css('height', (h/2-63)+'px');
          $('#chart2').css('height', (h/2)+'px');
      }
      resize(0);

      laydate.render({
          elem: '#forecastTime'
          ,type: 'datetime'
          ,done: function (value) {
              if( value != '' ){
                  unitTable(unitH, unitP, value, true);
                  $("#affectTime").val(getNextDate(value,-3));
              }
          }
      });

      function getNextDate(date,day) {
          var dd = new Date(date);
          dd.setDate(dd.getDate() + day);
          var y = dd.getFullYear();
          var m = dd.getMonth() + 1 < 10 ? "0" + (dd.getMonth() + 1) : dd.getMonth() + 1;
          var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate();
          var h = dd.getHours() < 10 ? "0" + dd.getHours() : dd.getHours();
          var i = dd.getMinutes() < 10 ? "0" + dd.getMinutes() : dd.getMinutes();
          var s = dd.getSeconds() < 10 ? "0" + dd.getSeconds() : dd.getSeconds();
          return y + "-" + m + "-" + d + " " + h + ":" + i + ":" + s;
      };

      laydate.render({
          elem: '#affectTime'
          ,type: 'datetime'
      });

      tree.render({
          elem: '#area'
          ,id: 'area'
          ,data: dataTree
          ,onlyIconControl: true
          ,customOperate: true
          ,edit: ['update']
          ,click: function(obj){
              if(!donePost) return;
              loadStation(currentType, obj.data.stcd);
          }
          ,operate: function (obj) {
              var type = obj.type;
              var data = obj.data;
              var elem = obj.elem;
              var deptId = data.id;
              var parentId = data.parentId;
              openForm(deptId);
          }
      });

      function openForm(deptId){
          layer.open({
              type: 1
              ,offset: 'auto'
              ,id: 'layerDemo1'
              ,content: $('#updateform')
              ,area:["900px","420px"]
              ,btn: ['确定', '取消']
              ,btnAlign: 'c' //按钮居中
              ,shade: 0.2 //不显示遮罩
              ,btn1: function(index, layero){
                  var e = each(dataTree, deptId);
                  $.each(e.plan, function(key, value){
                      var val = $("#updateform input[name=" + key + "]").val();
                      if( val !== undefined ) {
                          e.plan[key] = val;
                      }
                  });
                  e.intv = $("#updateform input[name=INTV]").val();
                  e.ke = $("#updateform input[name=KE]").val();
                  e.xe = $("#updateform input[name=XE]").val();
                  console.log(e.update);
                  e.plan.update = true;
                  console.log(e.update);
                  clearForm();
                  console.log(dataTree);
                  layer.closeAll();
              }
              ,btn2: function(index, layero){
                  clearForm();
                  layer.closeAll();
              }
              ,cancel: function(){
                  clearForm();
                  layer.closeAll();
              }
              ,success: function(layero, index){  //弹出成功的回调
                  clearForm();
                  var e = each(dataTree, deptId);
                  $.each(e.plan, function(key, value){
                      $("#updateform input[name=" + key + "]").val(value);
                  });
                  $("#updateform input[name=INTV]").val(e.intv);
                  $("#updateform input[name=KE]").val(e.ke);
                  $("#updateform input[name=XE]").val(e.xe);
                  $(".model_param_cl").hide();
                  $(".model_param_hl").hide();
                  $("#model_cl_" + e.plan.MODEL_CL).show();
                  $("#model_hl_" + e.plan.MODEL_HL).show();
                  form.render();
              }
          });
      }

      function each(data, deptId) {
          for(var i=0; i<data.length; i++){
              var e = data[i];
              if (e.id == deptId) {
                  return e;
              }
              if (e.children != undefined && e.children.length > 0) {
                  var e = each(e.children, deptId);
                  if( e != undefined ){
                      return e;
                  }
              }
          }
          return undefined;
      }

      function clearForm() {
          $("#addform input").val('');
          form.render();
      }

      /* 根据河系获取流域河系 */
      form.on('select(model)', function(data){
          dataTree = {};
          tree.reload('area', {
              data: dataTree
          });
          if( data.value != '' ){
            var loading = layer.load(0);
            $.post(
                '${pageContext.request.contextPath}/model/getArea',
                {
                    modelId: data.value
                },
                function (data) {
                    if( data.code == 200 ) {
                        dataTree = data.data;
                        tree.reload('area', {
                            data: dataTree
                        });
                        donePost = false;
                    }
                    layer.close(loading);
                }
            );
          }
      });

      form.on('select(sttp)', function(data){
          $("select[name=station]").html('<option value="">请选择</option>');
          $("select[name=plan]").html('<option value="">请选择</option>');
          form.render('select');
          var sttp = $("select[name=sttp]").val();
          currentStcd = '';
          if( sttp != "" ){
              var loading = layer.load(0);
              $.post(
                  '${pageContext.request.contextPath}/station/getStation',
                  {sttp: sttp},
                  function (data) {
                      if( data.code == 200 ) {
                          var html = '';
                          $.each(data.data, function (key, value) {
                              html += '<option value="' + value.stcd + '">' + value.stname + '</option>';
                          });
                          $("select[name=station]").append(html);
                          form.render('select');
                      }
                      layer.close(loading);
                  }
              );
          }
      });

      form.on('select(station)', function(data){
          $("select[name=plan]").html('<option value="">请选择</option>');
          form.render('select');
          var stcd = $("select[name=station]").val();
          if( stcd != "" ){
              var loading = layer.load(0);
              $.post(
                  '${pageContext.request.contextPath}/plan/getPlan',
                  {
                      stcd: stcd
                  },
                  function (data) {
                      if( data.code == 200 ) {
                          var html = '';
                          $.each(data.data, function (key, value) {
                              html += '<option value="' + value.id + '">' + value.name + '</option>';
                          });
                          $("select[name=plan]").append(html);
                          form.render('select');
                      }
                      layer.close(loading);
                  }
              );
          }
      });

      form.on('select(plan)', function(data){
          dataTree = {};
          tree.reload('area', {
              data: dataTree
          });
          if( data.value != '' ){
              var loading = layer.load(0);
              $.post(
                  '${pageContext.request.contextPath}/model/getSolo',
                  {
                      planId: data.value
                  },
                  function (data) {
                      if( data.code == 200 ) {
                          dataTree = data.data;
                          tree.reload('area', {
                              data: dataTree
                          });
                          donePost = false;
                      }
                      layer.close(loading);
                  }
              );
          }
      });

      form.on('select(day)', function(){
          if ($("input[name=forecastTime]").val() == "" ||
              $("select[name=day]").val() == "" ||
              $("select[name=unit]").val() == ""
          ) {
              return false;
          }
          unitTable(unitH, unitP, $("#forecastTime").val(), true);
      });

      form.on('select(unit)', function(data){
          if( data.value == 99 ){
              $("#unit99").show();
              resize($("#unit99").height());
          }else{
              $("#unit99").hide();
              resize(0);
          }
      });

      function loadStation(type, stcd) {
          var loading = layer.load(0);
          $.post({
              url: "${pageContext.request.contextPath}/forecast/station",
              contentType: "application/x-www-form-urlencoded",
              data: {
                  type: type,
                  stcd: stcd,
              },
              success : function(data) {
                  if( data.code == 200 ) {
                      currentStcd = data.data.stcd;
                      if( data.data.hasChild ){
                          $("#forecast4").show();
                      }else{
                          $("#forecast4").hide();
                      }
                      if( data.data.sttp == 'RR' ) {
                          $("#forecast3").show();
                          draw2(data.data);
                      }else{
                          $("#forecast3").hide();
                          draw1(data.data);
                      }
                  }else{
                      parent.layer.alert(data.msg, {title: '错误'});
                  }
                  layer.close(loading);
              }
          });
          return false;
      }

      table.render({
          elem: '#oq-table'
          ,id: 'see-table'
          ,cols: [[
              {field:'id', title: 'ID'}
              ,{field:'timeArr', title: '时间'}
              ,{field:'oq', title: '流量', edit: 'text'}
          ]]
          ,data: []
          ,page: false
          ,limit: 1000000
      });

      table.render({
          elem: '#unit-table'
          ,id: 'unit-table'
          ,cols: [[
              {field:'id', title: 'ID'}
              ,{field:'h', title: '时间'}
              ,{field:'p', title: '雨量', edit: 'text'}
          ]]
          ,data: []
          ,page: false
          ,limit: 1000000
      });

      //监听单元格编辑
      table.on('edit(see-data)', function(obj) {
          var value = obj.value //得到修改后的值
              , data = obj.data //得到所在行所有键值
              , field = obj.field; //得到字段
          var oqList = oqObj.data;
          var v = Number(zhzs(value));
          for (var i = data.id - 1; i < oqList.length; i++) {
              oqList[i].oq = v;
          }
          table.reload('see-table', {data: oqList});
      });

      /* 预报流量 */
      form.on('submit(forecast1)', function(data){
          if ($("select[name=model]").val() == "" ||
              $("input[name=forecastTime]").val() == "" ||
              $("input[name=affectTime]").val() == "" ||
              $("select[name=day]").val() == "" ||
              $("select[name=unit]").val() == "" ||
              dataTree.length == 0 ||
              ($("select[name=unit]").val() == 99 && unitArr.length == 0)
              ) {
              layer.msg('请填妥相关信息');
              return false;
          }
          currentType = 1;
          doPost(currentType, dataTree[0].stcd, dataTree, true, unitArr, currentStcd);
          return false;
      });

      /* 预报水位 */
      form.on('submit(forecast2)', function(data){
          if ($("select[name=model]").val() == "" ||
              $("input[name=forecastTime]").val() == "" ||
              $("input[name=affectTime]").val() == "" ||
              $("select[name=day]").val() == "" ||
              $("select[name=unit]").val() == "" ||
              dataTree.length == 0 ||
              ($("select[name=unit]").val() == 99 && unitArr.length == 0)
          ) {
              layer.msg('请填妥相关信息');
              return false;
          }
          currentType = 2;
          doPost(currentType, dataTree[0].stcd, dataTree, true, unitArr, currentStcd);
          return false;
      });

      /* 未来降雨 */
      $('#unit99').on('click', function(data){
          if ($("select[name=model]").val() == "" ||
              $("input[name=forecastTime]").val() == "" ||
              $("input[name=affectTime]").val() == "" ||
              $("select[name=day]").val() == "" ||
              $("select[name=unit]").val() == "" ||
              dataTree.length == 0
          ) {
              layer.msg('请填妥相关信息');
              return false;
          }
          var box = layer.open({
              type: 1
              ,offset: 'auto'
              ,id: 'layerDemo0'
              ,content: $('#unitBox')
              ,title: '未来降雨'
              ,area:["700px","480px"]
              ,btn: ['确定','关闭']
              ,btnAlign: 'c' //按钮居中
              ,shade: 0.2 //不显示遮罩
              ,btn1: function(index, layero){
                  if ($("#unitBox input[name=unitH]").val() == "" ||
                      $("#unitBox input[name=unitP]").val() == "" ||
                      unitTemp.length == 0
                  ) {
                      layer.msg('请填妥相关信息');
                      return false;
                  }
                  unitH = $("#unitBox input[name=unitH]").val();
                  unitP = $("#unitBox input[name=unitP]").val();
                  unitArr = unitTemp;
                  layer.close(box);
              }
              ,cancel: function(){
                  layer.close(box);
              }
              ,success: function(layero, index){  //弹出成功的回调
                  $("#unitBox input[name=unitH]").val(unitH);
                  $("#unitBox input[name=unitP]").val(unitP);
                  table.reload('unit-table', {data: unitArr});
              }
          });
      });

      //监听未来雨量单元格编辑
      table.on('edit(unit-data)', function(obj) {
          var value = obj.value //得到修改后的值
              , data = obj.data //得到所在行所有键值
              , field = obj.field; //得到字段
          unitTemp[data.id-1].p = Number(zhzs(value, 1));
          table.reload('unit-table', {data: unitTemp});
      });

      $("input[name=forecastTime]").on('change', function () {
          var value = $("input[name=forecastTime]").val();
          if( value != '' ){
              unitTable(unitH, unitP, value, true);
          }
      });
      
      $("input[name=unitH]").on('change', function () {
          unitTable($("input[name=unitH]").val(), $("input[name=unitP]").val(), $("#forecastTime").val(), false);
      });

      $("input[name=unitP]").on('change', function () {
          unitTable($("input[name=unitH]").val(), $("input[name=unitP]").val(), $("#forecastTime").val(), false);
      });

      function unitTable(uH, uP, time, auto){
          unitTemp = [];
          if( uH != '' && uP != '' &&
              uH > 0 && uP >= 0 ){
              var curTime = new Date(time);
              curTime = new Date(curTime.setHours(curTime.getHours() + 1));
              var p = (uP / uH).toFixed(1);
              for (var i = 1; i <= $("select[name=day]").val() * 24; i++) {
                  if( i > uH ){
                      p = 0;
                  }
                  var unit = {
                      id: i,
                      h: dateToStr(curTime),
                      p: p
                  };
                  unitTemp.push(unit);
                  curTime = new Date(curTime.setHours(curTime.getHours() + 1));
              }
          }
          table.reload('unit-table', {data: unitTemp});
          if( auto ){
              unitArr = unitTemp;
          }
      }

      function dateToStr(date) {
          var year = date.getFullYear();//年
          var month = date.getMonth();//月
          var day = date.getDate();//日
          var hours = date.getHours();//时
          var min = date.getMinutes();//分
          var second = date.getSeconds();//秒
          return year + "-" +
              ((month + 1) > 9 ? (month + 1) : "0" + (month + 1)) + "-" +
              (day > 9 ? day : ("0" + day)) + " " +
              (hours > 9 ? hours : ("0" + hours)) + ":" +
              (min > 9 ? min : ("0" + min)) + ":" +
              (second > 9 ? second : ("0" + second));
      }

      /* 预报OQ */
      form.on('submit(forecast3)', function(data){
          var box = layer.open({
              type: 1
              ,offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
              ,id: 'layerDemo1' //防止重复弹出
              ,content: $('#contentBox')
              ,title: '水库调度'
              ,area:["700px","480px"]
              ,btn: ['确定','关闭']
              ,btnAlign: 'c' //按钮居中
              ,shade: 0.2 //不显示遮罩
              ,btn1: function(index, layero){
                  if ($("select[name=model]").val() == "" ||
                      $("input[name=forecastTime]").val() == "" ||
                      $("input[name=affectTime]").val() == "" ||
                      $("select[name=day]").val() == "" ||
                      $("select[name=unit]").val() == "" ||
                      dataTree.length == 0
                  ) {
                      layer.msg('请填妥相关信息');
                      return false;
                  }
                  doPost(type, dataTree[0].stcd, dataTree, true, unitArr, currentStcd, oqObj);
                  layer.close(box);
              }
              ,cancel: function(){
                  layer.close(box);
              }
              ,success: function(layero, index){  //弹出成功的回调
                  $("#contentBox input[name=oqStcd]").val('');
                  $("#contentBox input[name=oqStname]").val('');
                  table.reload('see-table', {data: []});

                  var loading = layer.load(0);
                  $.post(
                      '${pageContext.request.contextPath}/forecast/oq',
                      {
                        stcd: currentStcd,
                        forecastTime: $("input[name=forecastTime]").val()
                      },
                      function (data) {
                          if( data.code == 200 ) {
                              oqObj = data.data;
                              $("#contentBox input[name=oqStcd]").val(data.data.stcd);
                              $("#contentBox input[name=oqStname]").val(data.data.stname);
                              table.reload('see-table', {data: data.data.data});
                          }
                          layer.close(loading);
                      }
                  );
              }
          });
      });

      /* 贡献 */
      form.on('submit(forecast4)', function(data){
          var box = layer.open({
              type: 1
              ,offset: 'auto' //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
              ,id: 'layerDemo2' //防止重复弹出
              ,content: $('#contentBox2')
              ,title: '输入贡献'
              ,area:["900px","480px"]
              ,btn: ['关闭']
              ,btnAlign: 'c' //按钮居中
              ,shade: 0.2 //不显示遮罩
              ,cancel: function(){
                  layer.close(box);
              }
              ,success: function(layero, index){  //弹出成功的回调
                  echarts.init(document.getElementById('chart3')).dispose();

                  var loading = layer.load(0);
                  $.post(
                      '${pageContext.request.contextPath}/forecast/devote',
                      {
                          stcd: currentStcd
                      },
                      function (data) {
                          if( data.code == 200 ) {
                              draw3(data.data);
                          }else{
                              layer.msg(data.msg);
                          }
                          layer.close(loading);
                      }
                  );
              }
          });
      });
      
      function doPost(type, stcd, data, updateModel, unitArr, oqStcd, oqStr) {
          var loading = layer.load(0);
          oqStcd = oqStcd != '' ? oqStcd : stcd;
          $.post({
              url: "${pageContext.request.contextPath}/forecast/compute",
              contentType: "application/x-www-form-urlencoded",
              data: {
                  show: ${show},
                  type: type,
                  stcd: stcd,
                  forecastTime: $("input[name=forecastTime]").val(),
                  affectTime: $("input[name=affectTime]").val(),
                  day: $("select[name=day]").val(),
                  unit: $("select[name=unit]").val(),
                  data: JSON.stringify(data),
                  oqStcd: oqStcd,
                  oqStr: JSON.stringify(oqStr),
                  unitArr: JSON.stringify(unitArr)
              },
              success : function(data) {
                  if( data.code == 200 ) {
                      currentStcd = data.data.stcd;
                      if( updateModel ){
                          dataTree = data.data.model;
                      }
                      if( data.data.hasChild ){
                          $("#forecast4").show();
                      }else{
                          $("#forecast4").hide();
                      }
                      if( data.data.sttp == 'RR' ) {
                          $("#forecast3").show();
                          draw2(data.data);
                      }else{
                          $("#forecast3").hide();
                          draw1(data.data);
                      }
                      donePost = true;
                  }else if( data.code == 500 ){
                      parent.layer.alert(data.msg, {title: '错误'});
                  }
                  layer.close(loading);
              }
          }).fail(function(response) {
              parent.layer.alert("计算出错，请重试", {title: '错误'});
              layer.close(loading);
          });
      }

  });

  function zhzs(value, fixed) {
      if(fixed == undefined) fixed = 3;
      value = parseFloat(value.replace(/^0{1,}/g, '')).toFixed(fixed);
      if( !isNaN(value) ){
          return value;
      }else{
          return parseFloat(0).toFixed(fixed);
      }
  }
  </script>
</body>
</html>

