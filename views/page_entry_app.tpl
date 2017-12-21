<!DOCTYPE html>
<html lang="en">
{{pagelet . "core/general" "bs4/html-header.tpl"}}
<script src="/hp/-/static/si/js/main.js?v={{.sys_version_sign}}"></script>
<link rel="stylesheet" href="{{HttpSrvBasePath "hp/-/static/pt/css/main.css"}}?v={{.sys_version_sign}}" type="text/css">
<link rel="stylesheet" href="{{HttpSrvBasePath "hp/~/open-iconic/font/css/open-iconic-bootstrap.css"}}?v={{.sys_version_sign}}" type="text/css">
<link rel="stylesheet" href="{{HttpSrvBasePath "hp/-/static/si/css/main.css"}}?v={{.sys_version_sign}}" type="text/css">
<body>
{{pagelet . "core/general" "bs4/nav-header.tpl" "topnav"}}

<style>
.pt_node_content ._pnc_title {
  font-size: 28pt;
  line-height: 120%;
}
.pt_node_content ._ft_card {
  margin: 10px 0;
  z-index: 100 !important;
}
.pt_node_content .card {
  min-height: 200px;
}
.pt_node_content ._ft_card a {
  color: #fff !important;
}
.pt_node_content ._ft_pb_0 {
  padding-bottom: 0 !important;
}
.pt_node_content .card-footer {
  border-top: 0 !important;
  padding: 0 1.25rem 1.25rem 1.25rem !important;
}
</style>

<!-- start/ -->
<div class="pt_index_frame_dark pt_node_content pt_bgimg_hexagons">
<div class="container" style="padding: 20px 10px;text-align:center;">
  <div>
    <div class="_pnc_title">App Spec Center</div>
    <div>
      Explore the Sysinner application templates
    </div>
  </div>
</div>
</div>
<!-- /start -->

<div class="pt_index_frame_dark_light">
<div class="container pt_node_content" style="padding: 20px 0;">
  <div id="incp-app-specls-alert" class="alert">loading</div>
  <div class="incp-div-light" id="incp-app-specls"></div>
</div>
</div>


<script id="incp-app-specls-tpl" type="text/html"> 
<table class="table table-hover">
<thead>
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Packages</th>
    <th>Executors</th>
    <th></th>
  </tr>
</thead>
<tbody>
{[~it.items :v]}
<tr>
  <td class="incp-font-fixspace">
    <strong>{[=v.meta.id]}</strong>
  </td>
  <td>{[=v.meta.name]}</td>
  <td>{[=v._ipm_num]}</td>
  <td>{[=v._executor_num]}</td>
  <td align="right">
    <button class="btn btn-default btn-xsmall" onclick="sijs.InAppSpecInfo('{[=v.meta.id]}')">
      Detail
    </button>
  </td>
</tr>
{[~]}
</tbody>
</table>
</script>


<script id="incp-appspec-info-view-tpl" type="text/html">
{[if (it.meta.name && it.meta.name.length > 0) {]}
<div class="l4i-form-group">
  <label>Name</label>
  <p>{[=it.meta.name]}</p>
</div>
{[}]}

{[? it.description]}
<div class="l4i-form-group">
  <label>Description</label>
  <p>{[=it.description]}</p>
</div>
{[?]}

<div class="l4i-form-group">
  <label>Resource Requirements</label>

  <div>
    <table width="100%" class="_table_right_space">
    <tr>
      <td>
        <div>CPU units (minimum)</div>
        <div class="input-group">
          {[=it.exp_res.cpu_min]} m
        </div>
      </td>
      <td>
        <div>Memory Size (minimum)</div>
        <div class="input-group">
          {[=sijs.UtilResSizeFormat(it.exp_res.mem_min)]}
        </div>
      </td>
      <td>
        <div>System Volume Size (minimum)</div>
        <div class="input-group">
          {[=sijs.UtilResSizeFormat(it.exp_res.vol_min, 1)]}
        </div>
      </td>
    </tr>
    </table>
  </div>
</div>

{[if (it.depends.length > 0) {]}
<div class="l4i-form-group">
  <label>Depends</label>

  <div id="incp-app-specset-depls">
    <table class="table table-hover">
      <thead><tr>
        <th>ID</th>
        <th></th>
        <th>Version</th>
      </tr></thead>
      <tbody>
      {[~it.depends :v]}
      <tr id="incp-app-specset-depls-id{[=v.id]}">
        <td>{[=v.id]}</td>
        <td>{[=v.name]}</td>
        <td>{[=v.version]}</td>
      </tr>
      {[~]}
      </tbody>
    </table>
  </div>
</div>
{[}]}


{[if (it.service_ports.length > 0) {]}
<div class="l4i-form-group">
  <label>Service Ports</label>

  <div>
    <table class="table table-hover">
      <thead>
        <tr>
          <th>Name</th>
          <th>Box Port</th>
        <tr>
      </thead>
      <tbody>
        {[~it.service_ports :vp]}
        <tr>
          <td>{[=vp.name]}</td>
          <td>{[=vp.box_port]}</td>
        </tr>
        {[~]}
      </tbody>
    </table>
  </div>
</div>
{[}]}

{[if (it.packages.length > 0) {]}
<div class="l4i-form-group">
  <label>Packages</label>

  <div id="incp-app-specset-ipmls">
    <table class="table table-hover">
      <thead><tr>
        <th>Name</th>
        <th>Version</th>
        <th>Release</th>
        <th>Dist / Arch</th>
      </tr></thead>
      <tbody>
      {[~it.packages :v]}
      <tr id="incp-app-specset-ipmls-name{[=v.name]}">
        <td>{[=v.name]}</td>
        <td>{[=v.version]}</td>
        <td>{[=v.release]}</td>
        <td>{[=v.dist]} / {[=v.arch]}</td>
      </tr>
      {[~]}
      </tbody>
    </table>
  </div>
</div>
{[}]}

{[if (it.executors.length > 0) {]}
<div class="l4i-form-group">
  <label>Executors</label>

  <div id="incp-app-specset-executorls">
    {[~it.executors :v]}
    <div class="incp-app-specset-gn-box">
      <div class="head">
        <span class="title">{[=v.name]}</span>
      </div>
      <div class="body">
        <table width="100%">
          <tbody>
          <tr>
            <td width="120">ExecStart</td>
            <td><pre><code class="language-shell">{[=v.exec_start.trim()]}</code></pre></td>
          </tr>
          {[if (v.exec_stop.trim().length > 0) {]}
          <tr>
            <td>ExecStop</td>
            <td><pre><code class="language-shell">{[=v.exec_stop.trim()]}</code></pre></td>
          </tr>
          {[}]}
          <tr>
            <td>Plan</td>
            <td>
              {[if (v.plan.on_boot) {]}
                On Boot
              {[}]}
              {[if (v.plan.on_tick > 0) {]}
                On Tick {[=v.plan.on_tick]}
              {[}]}
            </td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
    {[~]}
  </div>
</div>
{[}]}

</script>

<script>
window.onload_hooks.push(function() {
  sijs.InAppSpecListDataRefresh("incp-app-specls"); 
});
</script>

{{pagelet . "core/general" "footer.tpl"}}
    
{{pagelet . "core/general" "html-footer.tpl"}}
</body>
</html>

