[project]
name = sysinner-website
version = 0.1.4
vendor = sysinner.com
homepage = https://www.sysinner.com
groups = app/other

%build


%files
spec.json
inpack.spec
views/
static/


%js_compress
#static/


%css_compress
#static/


%html_compress


%png_compress
#static/

