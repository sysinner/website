var sijs = {
    inpack_api: "/ips/p1/",
    in_api: "/in/p1/",
    inCpAppSpec_deploySysStateful: 1,
    inCpAppSpec_deploySysStateless: 2,
    inCpAppSpec_deploySysStates: [{
        title: "Stateful",
        value: 1,
    }, {
        title: "Stateless",
        value: 2,
    }],

};

sijs.inpack_apipath = function(path) {
    return sijs.inpack_api + path;
}

sijs.InPackInfoListRefresh = function(tplid) {
    if (!tplid) {
        return;
    }
    var alert_id = "#" + tplid + "-alert",
        uri = "?";

    if (document.getElementById(tplid)) {
        var q = $("#" + tplid + "-qry-text").val();
        if (q) {
            uri += "q=" + q;
        }
        if (sijs.inpack_infols_grpactive && sijs.inpack_infols_grpactive != "") {
            uri += "&group=" + sijs.inpack_infols_grpactive;
        }
    }

    seajs.use(["ep"], function(EventProxy) {

        var ep = EventProxy.create("channels", "groups", "info", function(channels, groups, info) {

            if (!channels || !channels.items || channels.items.length < 1) {
                return l4i.InnerAlert(alert_id, 'alert-danger', "No available, or authorized channels can be accessed");
            }

            if (!groups.items || groups.items.length < 1) {
                return $("#" + tplid + "-empty-alert").css({
                    "display": "block"
                });
            }

            if (!info || (!info.error && !info.kind)) {
                return l4i.InnerAlert(alert_id, 'alert-danger', "Network Error");
            }

            if (info.kind != "PackInfoList" || !info.items) {
                info.items = [];
            }

            if (info.items.length > 0) {
                $("#" + tplid + "-empty-alert").css({
                    "display": "none"
                });
            } else {
                $("#" + tplid + "-empty-alert").css({
                    "display": "block"
                });
            }
            for (var i in info.items) {
                if (!info.items[i].op_perm) {
                    info.items[i].op_perm = 0;
                }
                var gs = [];
                for (var j in info.items[i].groups) {
                    for (var k in groups.items) {
                        if (info.items[i].groups[j] == groups.items[k].name) {
                            gs.push(groups.items[k].value);
                            break;
                        }
                    }
                }
                info.items[i]._groups_value = gs;
            }

            // refresh info list
            var tplid_style = tplid + "-th-tpl";
            l4iTemplate.Render({
                dstid: tplid,
                tplid: tplid_style,
                data: {
                    _api_url: sijs.inpack_api,
                    items: info.items,
                    groups: groups.items,
                },
            });

            if (!sijs.inpack_cc_channels) {
                sijs.inpack_cc_channels = channels;
            }
            if (!sijs.inpack_cc_groups) {
                sijs.inpack_cc_groups = groups;
            }
        });

        ep.fail(function(err) {
            alert("Network Abort, Please try again later");
        });

        if (sijs.inpack_cc_channels && sijs.inpack_cc_channels.items.length > 0) {
            ep.emit("channels", sijs.inpack_cc_channels);
        } else {
            l4i.Ajax(sijs.inpack_apipath("channel/list"), {
                callback: ep.done("channels"),
            });
        }

        if (sijs.inpack_cc_groups && sijs.inpack_cc_groups.items.length > 0) {
            ep.emit("groups", sijs.inpack_cc_groups);
        } else {
            l4i.Ajax(sijs.inpack_apipath("group/list"), {
                callback: ep.done("groups"),
            });
        }

        l4i.Ajax(sijs.inpack_apipath("pkg-info/list" + uri), {
            callback: ep.done("info"),
        });
    });
}

sijs.InPackInfoView = function(name) {
    seajs.use(["ep"], function(EventProxy) {

        var ep = EventProxy.create("data", "pkgs", "groups", function(data, pkgs, groups) {

            if (!data || data.kind != "PackInfo") {
                return;
            }

            if (pkgs.items) {
                data._packages = pkgs.items;
            } else {
                data._packages = [];
            }

            if (!data.project.description) {
                data.project.description = "";
            }
            if (groups.items) {
                data._groups = groups.items;
            } else {
                data._groups = [];
            }
            data._api_url = sijs.inpack_api;

            l4iModal.Open({
                title: "Package Info : " + data.meta.name,
                width: 900,
                height: 600,
                tplid: "ips-infols-view-tpl",
                data: data,
                buttons: [
                    {
                        onclick: "l4iModal.Close()",
                        title: "Close",
                    },
                ],
            });
        });

        ep.fail(function(err) {
            alert("Network Abort, Please try again later");
        });

        l4i.Ajax(sijs.inpack_apipath("pkg-info/entry?name=" + name), {
            callback: ep.done("data"),
        });

        l4i.Ajax(sijs.inpack_apipath("pkg/list?name=" + name), {
            callback: ep.done("pkgs"),
        });

        if (sijs.inpack_cc_groups && sijs.inpack_cc_groups.items.length > 0) {
            ep.emit("groups", sijs.inpack_cc_groups);
        } else {
            l4i.Ajax(sijs.inpack_apipath("group/list"), {
                callback: ep.done("groups"),
            });
        }
    });
}

sijs.InAppSpecListDataRefresh = function(tplid) {
    var uri = "";
    var alert_id = "#" + tplid + "-alert";

    var el = document.getElementById(tplid + "-qry-text");
    if (el && el.value.length > 0) {
        uri = "qry_text=" + el.value;
    }
    uri += "&fields=meta/id|name|version,depends/name,packages/name,executors/name";

    l4i.Ajax(sijs.in_api + "app-spec/list?" + uri, {
        timeout: 3000,
        callback: function(err, rsj) {

            if (err || !rsj || rsj.kind != "AppSpecList" || !rsj.items) {
                return l4i.InnerAlert(alert_id, "alert-info", "No more results ...");
            } else {
                $(alert_id).css({
                    "display": "none"
                });
            }

            for (var i in rsj.items) {

                if (!rsj.items[i].meta.name) {
                    rsj.items[i].meta.name = "";
                }

                if (!rsj.items[i].depends) {
                    rsj.items[i].depends = [];
                }

                if (rsj.items[i].packages) {
                    rsj.items[i]._ipm_num = rsj.items[i].packages.length;
                } else {
                    rsj.items[i]._ipm_num = 0;
                }

                if (rsj.items[i].executors) {
                    rsj.items[i]._executor_num = rsj.items[i].executors.length;
                } else {
                    rsj.items[i]._executor_num = 0;
                }

                if (!rsj.items[i].description) {
                    rsj.items[i].description = "";
                }
            }

            l4iTemplate.Render({
                dstid: tplid,
                tplid: tplid + "-tpl",
                data: {
                    items: rsj.items,
                },
            });
        }
    });
}

sijs.InAppSpecInfo = function(id) {
    seajs.use(["ep"], function(EventProxy) {

        var ep = EventProxy.create("data", function(rsj) {

            if (!rsj || rsj.error || rsj.kind != "AppSpec") {
                return
            }

            if (!rsj.depends) {
                rsj.depends = [];
            }

            if (!rsj.dep_remotes) {
                rsj.dep_remotes = [];
            }

            if (!rsj.packages) {
                rsj.packages = [];
            }

            if (!rsj.vcs_repos) {
                rsj.vcs_repos = [];
            }

            for (var i in rsj.depends) {
                if (!rsj.depends[i].name) {
                    rsj.depends[i].name = "";
                }
            }

            for (var i in rsj.dep_remotes) {
                if (!rsj.dep_remotes[i].name) {
                    rsj.dep_remotes[i].name = "";
                }
                if (!rsj.dep_remotes[i].configs) {
                    rsj.dep_remotes[i].configs = [];
                }
            }

            if (!rsj.exp_deploy) {
                rsj.exp_deploy = {};
            }
            if (!rsj.exp_deploy.rep_min) {
                rsj.exp_deploy.rep_min = 1;
                rsj.exp_deploy.rep_max = 1;
            }
            if (!rsj.exp_deploy.failover_time) {
                rsj.exp_deploy.failover_time = 300;
            }
            if (!rsj.exp_deploy.failover_num_max) {
                rsj.exp_deploy.failover_num_max = 0;
            } else if (rsj.exp_deploy.failover_num_max > 0) {
                rsj.exp_deploy._failover_enable = true;
            }
            if (!rsj.exp_deploy.failover_rate_max) {
                rsj.exp_deploy.failover_rate_max = 0;
            } else if (rsj.exp_deploy.failover_rate_max > 0) {
                rsj.exp_deploy._failover_enable = true;
            }

            if (!rsj.exp_deploy.sys_state) {
                rsj.exp_deploy.sys_state = sijs.inCpAppSpec_deploySysStateful;
            }
            for (var i in sijs.inCpAppSpec_deploySysStates) {
                if (sijs.inCpAppSpec_deploySysStates[i].value == rsj.exp_deploy.sys_state) {
                    rsj.exp_deploy._sys_state = sijs.inCpAppSpec_deploySysStates[i].title;
                    break;
                }
            }
            if (!rsj.exp_deploy._sys_state) {
                rsj.exp_deploy._sys_state = "";
            }
            rsj.exp_res._cpu_min = (rsj.exp_res.cpu_min / 10).toFixed(1);


            l4iModal.Open({
                title: "AppSpec Information : " + rsj.meta.id,
                width: 1200,
                height: 800,
                tplid: "incp-appspec-info-view-tpl",
                data: rsj,
                buttons: [{
                    onclick: "l4iModal.Close()",
                    title: "Close",
                }],
                callback: function() {
                    // hp.CodeRender({
                    //     theme: "monokai"
                    // });
                },
            });
        });

        ep.fail(function(err) {
            // TODO
            alert("SpecSet error, Please try again later (EC:incp-app-specset)");
        });

        // data
        l4i.Ajax(sijs.in_api + "app-spec/entry?id=" + id, {
            callback: ep.done("data"),
        });
    });
}

sijs.InAppSpecDownload = function(id) {
    if (!id) {
        return;
    }
    window.open(sijs.in_api + "app-spec/entry?id=" + id + "&download=true&ct=toml", "Download");
}

sijs.UtilResSizeFormat = function(size, tofix) {
    var ms = [
        [7, "ZB"],
        [6, "EB"],
        [5, "PB"],
        [4, "TB"],
        [3, "GB"],
        [2, "MB"],
        [1, "KB"],
    ];

    if (!tofix || tofix < 0) {
        tofix = 0;
    } else if (tofix > 3) {
        tofix = 3;
    }

    for (var i in ms) {
        if (size >= Math.pow(1024, ms[i][0])) {
            return (size / Math.pow(1024, ms[i][0])).toFixed(tofix) + " " + ms[i][1];
        }
    }

    if (size == 0) {
        return size;
    }

    return size + " B";
}
