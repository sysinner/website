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
    <div class="_pnc_title">Package Center</div>
    <div>
      Explore the Sysinner packages
    </div>
  </div>
</div>
</div>
<!-- /start -->

<div class="pt_index_frame_dark_light">
<div class="container pt_node_content" style="padding: 20px 0;">
  <div id="ips-infols-alert"></div>
  <div id="ips-infols"></div>
  <div id="ips-infols-empty-alert" class="alert alert-warning" style="display:none">
    No more results ...
  </div>
</div>
</div>

<div id="inpack-info-show" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      ...
    </div>
  </div>
</div>

<script id="ips-infols-th-tpl" type="text/html">
<ul class="ips-pkginfo-tiles">
{[~it.items :v]}
<li class="ips-pkginfo-tile" onclick="sijs.InPackInfoView('{[=v.meta.name]}')">
  <div class="subtitle ct-content" id="status-{[=v.meta.name]}"
    style="background: url('{[=it._api_url]}/pkg-info/ico?name={[=v.meta.name]}&type=21&size=200') no-repeat center top; background-size: 200px 100px;">
  </div>
  <div class="status">
    <div class="title">{[=v.meta.name]}</div>
    Version: <strong>{[=v.last_version]}</strong> &nbsp;&nbsp;
    Updated: <strong>{[=l4i.MetaTimeParseFormat(v.meta.updated, "Y-m-d")]}</strong>
  </div>
</li>
{[~]}
<li class="ips-pkginfo-tile"></li>
<li class="ips-pkginfo-tile"></li>
<li class="ips-pkginfo-tile"></li>
<li class="ips-pkginfo-tile"></li>
<li class="ips-pkginfo-tile"></li>
<li class="ips-pkginfo-tile"></li>
</ul>
</script>

<style>
.ips_pkgview_p5 td {
  padding: 5px 0;
}
.ips_pkgview_p5 td.row_title {
  width: 190px;
  padding-right: 20px !important;
  font-weight: bold;
  text-align: right;
}
.ips_pkgview_p5 .logo_ico {
  padding: 2px;
  outline: #ccc 1px solid;
}
.ips_pkgview_p5 .ips-ipmls {
  padding-right: 5px;
}
.ips_pkgview_p5 .ips-ipmls td {
  font-size: 0.9em;
}
.ips_pkgview_p5 .ips-ipmls th,
.ips_pkgview_p5 .ips-ipmls td {
  padding: 3px 0;
}
</style>

<script id="ips-infols-view-tpl" type="text/html">
<table class="ips_pkgview_p5" width="100%">

<tr>
  <td class="row_title">Maintainer</td>
  <td>{[=it.meta.user]}</td>
</tr>

<tr>
  <td class="row_title">Updated</td>
  <td>
    {[=l4i.MetaTimeParseFormat(it.meta.updated, "Y-m-d")]}
  </td>
</tr>

<tr>
  <td class="row_title">Groups</td>
  <td>
  {[~it.groups :vg]}
    {[~it._groups :g]}
    {[if (vg == g.name) {]}
      <div>{[=g.value]}</div>
    {[}]}
    {[~]}
  {[~]}
  </td>
</tr>


<tr>
  <td class="row_title">Logo</td>
  <td>
    <table width="80%">
      <tr>
        <td width="40%">
          <img class="logo_ico" src="{[=it._api_url]}/pkg-info/ico?name={[=it.meta.name]}&type=11&size=96" width="96", height="96">
          1 x 1
        </td>
        <td>
          <img class="logo_ico" src="{[=it._api_url]}/pkg-info/ico?name={[=it.meta.name]}&type=21&size=192" width="192", height="96">
          2 x 1
        </td>
      </tr>
    </table>
  </td>
</tr>


{[? it.project.homepage]}
<tr>
  <td class="row_title">Homepage</td>
  <td><a href="{[=it.project.homepage]}" target="_blank">{[=it.project.homepage]}</a></td>
</tr>
{[?]}


{[? it.project.description]}
<tr>
  <td class="row_title">Description</td>
  <td>{[=it.project.description]}</td>
</tr>
{[?]}


{[if (it._packages.length > 0) {]}
<tr>
  <td class="row_title" valign="top">Packages</td>

  <td class="ips-ipmls">
    <table class="table table-hover">
      <thead><tr>
        <th>Version</th>
        <th>Release</th>
        <th>Dist</th>
        <th style="text-align:center">Arch</th>
        <th style="text-align:right">Size</th>
      </tr></thead>
      <tbody>
      {[~it._packages :v]}
      <tr>
        <td>{[=v.version.version]}</td>
        <td>{[=v.version.release]}</td>
        <td>{[=v.version.dist]}</td>
        <td align="center">{[=v.version.arch]}</td>
        <td align="right">{[=sijs.UtilResSizeFormat(v.size, 2)]}</td>
      </tr>
      {[~]}
      </tbody>
    </table>
  </td>
</tr>
{[}]}

</table>
</script>
    
{{pagelet . "core/general" "footer.tpl"}}
    
<script>

window.onload_hooks.push(function() {
  sijs.InPackInfoListRefresh("ips-infols"); 
});
</script>
    
{{pagelet . "core/general" "html-footer.tpl"}}
</body>
</html>

