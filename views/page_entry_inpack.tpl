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
</style>

<!-- start/ -->
<div class="hp-container-full pt_index_frame_dark pt_node_content pt_bgimg_hexagons">
<div class="container" style="_padding: 20px 10px;text-align:center;">
  <div>
    <div class="_pnc_title">Package Center</div>
    <div>
      Explore the Sysinner packages
    </div>
  </div>
</div>
</div>
<!-- /start -->

<div class="hp-container-full pt_index_frame_dark_light">
<div class="container" style="padding: 20px 0;">
  <div id="ips-infols-alert"></div>
  <div id="ips-infols" class="columns is-multiline"></div>
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
{[~it.items :v]}
<div class="inpack-list-item-frame column is-3">
<div class="inpack-list-item-box card is-hoverable" onclick="sijs.InPackInfoView('{[=v.meta.name]}')">
  <div class="card-image">
    <figure class="image">
      <img src="{[=it._api_url]}/pkg-info/icon?name={[=v.meta.name]}&type=21&size=200" width="200" height="100">
    </figure>
  </div>
  <div class="card-content">
    <div class="media-content inpack-list-item-box-info">
	  <p class="title is-4">
        {[=v.meta.name]}
      </p>
	  <p class="subtitle is-6">
        Version: <strong>{[=v.last_version]}</strong>
      </p>
	</div>
  </div>
</div>
</div>
{[~]}
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
.ips_pkgview_p5 .logo_icon {
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
    <table class="table is-fullwidth is-hoverable">
      <thead><tr>
        <th>Version</th>
        <th>Release</th>
        <th style="text-align:center">Dist.Arch</th>
        <th style="text-align:right">Size</th>
      </tr></thead>
      <tbody>
      {[~it._packages :v]}
      <tr>
        <td>{[=v.version.version]}</td>
        <td>{[=v.version.release]}</td>
        <td align="center">{[=v.version.dist]}.{[=v.version.arch]}</td>
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
    
{{pagelet . "core/general" "v2/footer.tpl"}}
    
<script>

window.onload_hooks.push(function() {
  sijs.InPackInfoListRefresh("ips-infols"); 
});
</script>
    
{{pagelet . "core/general" "html-footer.tpl"}}
</body>
</html>

