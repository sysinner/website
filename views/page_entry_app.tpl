<!DOCTYPE html>
<html lang="en">
{{pagelet . "core/general" "v2/html-header.tpl"}}
<script src="/hp/-/static/si/js/main.js?v={{.sys_version_sign}}"></script>
<link rel="stylesheet" href="{{HttpSrvBasePath "hp/-/static/pt/css/main.css"}}?v={{.sys_version_sign}}" type="text/css">
<link rel="stylesheet" href="{{HttpSrvBasePath "hp/-/static/si/css/main.css"}}?v={{.sys_version_sign}}" type="text/css">
<body id="hp-body">
{{pagelet . "core/general" "v2/nav-header.tpl" "topnav"}}

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
<div class="hp-container-full pt_index_frame_dark pt_node_content pt_bgimg_hexagons">
<div class="container" style="_padding: 20px 10px;text-align:center;">
  <div>
    <div class="_pnc_title">App Spec Center</div>
    <div>
      Explore the Sysinner application templates
    </div>
  </div>
</div>
</div>
<!-- /start -->

<div class="hp-container-full pt_index_frame_dark_light">
<div class="container pt_node_content" style="padding: 20px 0;">
  <div id="incp-app-specls-alert" class="alert">loading</div>
  <div class="incp-div-light" id="incp-app-specls"></div>
</div>
</div>


<script id="incp-app-specls-tpl" type="text/html"> 
<table class="table is-fullwidth is-hoverable">
<thead>
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Packages</th>
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
  <td align="right">
    <button class="button is-dark xsmall" onclick="sijs.InAppSpecInfo('{[=v.meta.id]}')">
      Detail
    </button>
  </td>
</tr>
{[~]}
</tbody>
</table>
</script>


<script id="incp-appspec-info-view-tpl" type="text/html">
<table class="incp-formtable">
<tbody>
<tr>
  <td width="200px">ID</td>
  <td>{[=it.meta.id]}</td>
</tr>

{[? it.meta.name]}
<tr>
  <td>Name</td>
  <td>{[=it.meta.name]}</td>
</tr>
{[?]}

{[? it.description]}
<tr>
  <td>Description</td>
  <td>{[=it.description]}</td>
</tr>
{[?]}

{[if (it.packages.length > 0) {]}
<tr>
  <td>Import Package</td>
  <td id="incp-app-specset-ipmls">
    <table>
      <thead><tr>
        <th>Name</th>
        <th>Version</th>
        <th>Volume</th>
      </tr></thead>
      <tbody>
      {[~it.packages :v]}
      <tr id="incp-app-specset-ipmls-name{[=v.name]}">
        <td>{[=v.name]}</td>
        <td>{[=v.version]}</td>
        <td>/usr/sysinner/{[=v.name]}/{[=v.version]}</td>
      </tr>
      {[~]}
      </tbody>
    </table>
  </td>
</tr>
{[}]}


{[if (it.depends.length > 0) {]}
<tr>
  <td>Import AppSpec</td>
  <td id="incp-app-specset-depls">
    <table>
      <thead><tr>
        <th>ID</th>
        <th>Name</th>
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
  </td>
</tr>
{[}]}


{[if (it.dep_remotes && it.dep_remotes.length > 0) {]}
<tr>
  <td>Remotely dependent AppSpec</td>
  <td id="incp-app-specset-depremotes">
    <table>
      <thead><tr>
        <th>ID</th>
        <th>Name</th>
        <th>Version</th>
        <th>Configs</th>
      </tr></thead>
      <tbody>
      {[~it.dep_remotes :v]}
      <tr id="incp-app-specset-depremotes-id{[=v.id]}">
        <td>{[=v.id]}</td>
        <td>{[=v.name]}</td>
        <td>{[=v.version]}</td>
        <td>{[? v.configs]}{[=v.configs.join(", ")]}{[?]}</td>
      </tr>
      {[~]}
      </tbody>
    </table>
  </td>
</tr>
{[}]}

<tr>
  <td>Minimum Requirements</td>
  <td>
    <table>
      <thead><tr>
        <th width="33%">CPU</th>
        <th width="33%">Memory</th>
        <th>System Volume</th>
      </tr></thead>
      <tbody>
      <tr id="incp-app-specset-depls-id{[=v.id]}">
        <td>{[=it.exp_res._cpu_min]} cores</td>
        <td>{[=it.exp_res.mem_min]} MB</td>
        <td>{[=it.exp_res.vol_min]} GB</td>
      </tr>
      </tbody>
    </table>
  </td>
</tr>

<tr>
  <td>Deploy Requirements</td>
  <td>
    <table>
      <thead><tr>
        <th width="33%">Number of Replicas</th>
        <th width="33%">State</th>
        <th></th>
      </tr></thead>
      <tbody>
      <tr>
        <td>Min/Max: {[=it.exp_deploy.rep_min]} / {[=it.exp_deploy.rep_max]}</td>
        <td>{[=it.exp_deploy._sys_state]}</td>
        <td></td>
      </tr>
      </tbody>
    </table>
  </td>
</tr>



</tbody>
</table>


</script>

<script>
window.onload_hooks.push(function() {
  sijs.InAppSpecListDataRefresh("incp-app-specls"); 
});
</script>

{{pagelet . "core/general" "v2/footer.tpl"}}
    
{{pagelet . "core/general" "html-footer.tpl"}}
</body>
</html>

