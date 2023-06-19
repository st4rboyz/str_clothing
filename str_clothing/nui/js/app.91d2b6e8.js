(function(t) {
    function e(e) {
        for (var n, s, i = e[0], c = e[1], u = e[2], h = 0, f = []; h < i.length; h++) s = i[h], Object.prototype.hasOwnProperty.call(a, s) && a[s] && f.push(a[s][0]), a[s] = 0;
        for (n in c) Object.prototype.hasOwnProperty.call(c, n) && (t[n] = c[n]);
        l && l(e);
        while (f.length) f.shift()();
        return r.push.apply(r, u || []), o()
    }

    function o() {
        for (var t, e = 0; e < r.length; e++) {
            for (var o = r[e], n = !0, i = 1; i < o.length; i++) {
                var c = o[i];
                0 !== a[c] && (n = !1)
            }
            n && (r.splice(e--, 1), t = s(s.s = o[0]))
        }
        return t
    }
    var n = {},
        a = {
            app: 0
        },
        r = [];

    function s(e) {
        if (n[e]) return n[e].exports;
        var o = n[e] = {
            i: e,
            l: !1,
            exports: {}
        };
        return t[e].call(o.exports, o, o.exports, s), o.l = !0, o.exports
    }
    s.m = t, s.c = n, s.d = function(t, e, o) {
        s.o(t, e) || Object.defineProperty(t, e, {
            enumerable: !0,
            get: o
        })
    }, s.r = function(t) {
        "undefined" !== typeof Symbol && Symbol.toStringTag && Object.defineProperty(t, Symbol.toStringTag, {
            value: "Module"
        }), Object.defineProperty(t, "__esModule", {
            value: !0
        })
    }, s.t = function(t, e) {
        if (1 & e && (t = s(t)), 8 & e) return t;
        if (4 & e && "object" === typeof t && t && t.__esModule) return t;
        var o = Object.create(null);
        if (s.r(o), Object.defineProperty(o, "default", {
                enumerable: !0,
                value: t
            }), 2 & e && "string" != typeof t)
            for (var n in t) s.d(o, n, function(e) {
                return t[e]
            }.bind(null, n));
        return o
    }, s.n = function(t) {
        var e = t && t.__esModule ? function() {
            return t["default"]
        } : function() {
            return t
        };
        return s.d(e, "a", e), e
    }, s.o = function(t, e) {
        return Object.prototype.hasOwnProperty.call(t, e)
    }, s.p = "";
    var i = window["webpackJsonp"] = window["webpackJsonp"] || [],
        c = i.push.bind(i);
    i.push = e, i = i.slice();
    for (var u = 0; u < i.length; u++) e(i[u]);
    var l = c;
    r.push([0, "chunk-vendors"]), o()
})({
    0: function(t, e, o) {
        t.exports = o("56d7")
    },
    "034f": function(t, e, o) {
        "use strict";
        o("85ec")
    },
    "1b78": function(t, e, o) {
        "use strict";
        o("3023")
    },
    "2ccc": function(t, e, o) {},
    3023: function(t, e, o) {},
    "4b79": function(t, e, o) {
        "use strict";
        o("527d")
    },
    "527d": function(t, e, o) {},
    "56d7": function(t, e, o) {
        "use strict";
        o.r(e);
        o("e260"), o("e6cf"), o("cca6"), o("a79d");
        var n = o("2b0e"),
            a = function() {
                var t = this,
                    e = t.$createElement,
                    o = t._self._c || e;
                return t.opened ? o("div", {
                    attrs: {
                        id: "App"
                    }
                }, [t.isFreeroaming ? o("div", {
                    staticClass: "freeroam-container"
                }, [t._m(0)]) : t._e(), t.isFreeroaming ? t._e() : o("div", {
                    staticClass: "rotate-container"
                }, [o("div", {
                    staticClass: "rotate-wrapper"
                }, [o("button", {
                    on: {
                        click: function(e) {
                            return t.RotateCamera("left")
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-angle-double-left"
                })]), o("button", {
                    staticClass: "middle",
                    on: {
                        click: function(e) {
                            return t.ToggleFreeRoam(!0)
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-video"
                })]), o("button", {
                    on: {
                        click: function(e) {
                            return t.RotateCamera("right")
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-angle-double-right"
                })])])]), o("div", {
                    staticClass: "clothing"
                }, [o("div", {
                    staticClass: "clothing-container"
                }, [t.isTattoShop ? t._e() : o("div", {
                    staticClass: "clothing-header"
                }, [t.hasStoreItems("body") ? o("button", {
                    class: "body" === t.selectedMenu ? "clothing-button active" : "clothing-button",
                    on: {
                        click: function(e) {
                            t.selectedMenu = "body"
                        }
                    }
                }, [t._v("Ansigt")]) : t._e(), t.hasStoreItems("clothing") ? o("button", {
                    class: "clothing" === t.selectedMenu ? "clothing-button active" : "clothing-button",
                    on: {
                        click: function(e) {
                            t.selectedMenu = "clothing"
                        }
                    }
                }, [t._v("Tøj")]) : t._e(), t.hasStoreItems("accessories") ? o("button", {
                    class: "accessories" === t.selectedMenu ? "clothing-button active" : "clothing-button",
                    on: {
                        click: function(e) {
                            t.selectedMenu = "accessories"
                        }
                    }
                }, [t._v("Tilbehør")]) : t._e(), !0 === t.hasWardrobe ? o("button", {
                    class: "wardrobe" === t.selectedMenu ? "clothing-button active" : "clothing-button",
                    on: {
                        click: function(e) {
                            t.selectedMenu = "wardrobe"
                        }
                    }
                }, [t._v("Garderobe")]) : t._e()]), t.isTattoShop ? t._e() : o("div", {
                    staticClass: "clothing-body"
                }, [o("CameraMenu", {
                    attrs: {
                        NameResource: t.NameResource,
                        isTattoShop: t.isTattoShop,
                        selectedMenu: t.selectedMenu,
                        close: t.close
                    }
                }), t.isClothing() ? o("ModuleMenu", {
                    attrs: {
                        Components: t.Components,
                        NameResource: t.NameResource,
                        selectedMenu: t.selectedMenu,
                        selectedStore: t.selectedStore,
                        close: t.close
                    }
                }) : t._e(), "wardrobe" === t.selectedMenu ? o("WardrobeMenu", {
                    attrs: {
                        NameResource: t.NameResource,
                        Wardrobe: t.Wardrobe,
                        selectedMenu: t.selectedMenu,
                        close: t.close
                    }
                }) : t._e()], 1), t.isTattoShop ? o("div", {
                    staticClass: "tatto-body"
                }, [o("CameraMenu", {
                    attrs: {
                        NameResource: t.NameResource,
                        isTattoShop: t.isTattoShop,
                        selectedMenu: t.selectedMenu,
                        close: t.close
                    }
                }), o("TattoModuleMenu", {
                    attrs: {
                        Tattos: t.Tattos,
                        PlayerJob: t.PlayerJob,
                        PlayerIdentifier: t.PlayerIdentifier,
                        NameResource: t.NameResource,
                        close: t.close
                    }
                })], 1) : t._e()])])]) : t._e()
            },
            r = [function() {
                var t = this,
                    e = t.$createElement,
                    o = t._self._c || e;
                return o("div", {
                    staticClass: "freeroam-wrapper"
                }, [o("h1", [t._v("Klik på N for at fjerne Freeroam")])])
            }],
            s = (o("b0c0"), o("bc3a")),
            i = o.n(s),
            c = o("3d20"),
            u = o.n(c),
            l = function() {
                var t = this,
                    e = t.$createElement,
                    o = t._self._c || e;
                return o("div", {
                    staticClass: "camera-menu"
                }, [t.isTattoShop ? t._e() : o("button", {
                    staticClass: "camera-button",
                    on: {
                        click: function(e) {
                            return t.ToggleClothing("hat")
                        }
                    }
                }, [o("i", {
                    staticClass: "fab fa-redhat"
                })]), t.isTattoShop ? t._e() : o("button", {
                    staticClass: "camera-button",
                    on: {
                        click: function(e) {
                            return t.ToggleClothing("glasses")
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-glasses"
                })]), t.isTattoShop ? o("button", {
                    staticClass: "camera-button",
                    on: {
                        click: function(e) {
                            return t.ToggleClothing("mask")
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-theater-masks"
                })]) : t._e(), t.isTattoShop ? o("button", {
                    staticClass: "camera-button",
                    on: {
                        click: function(e) {
                            return t.ToggleClothing("pants")
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-socks"
                })]) : t._e(), o("button", {
                    staticClass: "camera-button",
                    on: {
                        click: function(e) {
                            return t.ToggleClothing("shirt")
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-tshirt"
                })]), o("button", {
                    staticClass: "camera-button",
                    on: {
                        click: function(e) {
                            return t.Handsup()
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-praying-hands"
                })]), o("button", {
                    staticClass: "camera-button",
                    on: {
                        click: function(e) {
                            return t.SetCamera("face")
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-smile-beam"
                })]), o("button", {
                    staticClass: "camera-button",
                    on: {
                        click: function(e) {
                            return t.SetCamera("normal")
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-user-tie"
                })]), o("button", {
                    staticClass: "camera-button",
                    on: {
                        click: function(e) {
                            return t.SetCamera("feet")
                        }
                    }
                }, [o("i", {
                    staticClass: "fas fa-socks"
                })])])
            },
            h = [],
            f = {
                props: {
                    isTattoShop: {},
                    selectedMenu: {},
                    NameResource: {},
                    close: {}
                },
                methods: {
                    SetCamera: function(t) {
                        var e = this.NameResource[0];
                        i.a.post("https://".concat(e, "/SetCamera"), {
                            type: t,
                            isTattoShop: this.isTattoShop
                        }).catch((function(t) {
                            console.log(t + " : Error at SetCamera")
                        }))
                    },
                    ToggleClothing: function(t) {
                        var e = this.NameResource[0];
                        i.a.post("https://".concat(e, "/ToggleClothing"), {
                            type: t
                        }).catch((function(t) {
                            console.log(t + " : Error at ToggleClothing")
                        }))
                    },
                    Handsup: function() {
                        var t = this.NameResource[0];
                        i.a.post("https://".concat(t, "/Handsup")).catch((function(t) {
                            console.log(t + " : Error at Handsup")
                        }))
                    }
                }
            },
            d = f,
            m = (o("f30d"), o("2877")),
            v = Object(m["a"])(d, l, h, !1, null, null, null),
            p = v.exports,
            b = function() {
                var t = this,
                    e = t.$createElement,
                    o = t._self._c || e;
                return o("div", {
                    staticClass: "elements"
                }, t._l(t.SortedSkinList, (function(e, n) {
                    return o("div", {
                        key: n,
                        class: n === t.SortedSkinList.length - 1 ? "element end" : "element"
                    }, [o("div", {
                        staticClass: "element-header"
                    }, [o("h1", [t._v(t._s(e.label))])]), o("div", {
                        staticClass: "element-body"
                    }, [o("div", {
                        class: t.hasItemTextures(e) ? "element-item has-textures" : "element-item"
                    }, [o("h3", [t._v("Maks Numre: " + t._s(e.max))]), o("div", {
                        staticClass: "element-buttons"
                    }, [o("button", {
                        on: {
                            click: function(o) {
                                return t.removeItemValue(e, !1)
                            }
                        }
                    }, [o("i", {
                        staticClass: "fas fa-chevron-left"
                    })]), o("input", {
                        directives: [{
                            name: "model",
                            rawName: "v-model",
                            value: e.value,
                            expression: "item.value"
                        }],
                        attrs: {
                            type: "number"
                        },
                        domProps: {
                            value: e.value
                        },
                        on: {
                            change: function(o) {
                                return t.onChangeItemValue(e, !1)
                            },
                            input: function(o) {
                                o.target.composing || t.$set(e, "value", o.target.value)
                            }
                        }
                    }), o("button", {
                        on: {
                            click: function(o) {
                                return t.addItemValue(e, !1)
                            }
                        }
                    }, [o("i", {
                        staticClass: "fas fa-chevron-right"
                    })])])]), t.hasItemTextures(e) ? o("div", {
                        class: t.hasItemTextures(e) ? "element-item has-textures" : "element-item"
                    }, [o("h3", [t._v("Maks Textures: " + t._s(e.texturemax))]), o("div", {
                        staticClass: "element-buttons"
                    }, [o("button", {
                        on: {
                            click: function(o) {
                                return t.removeItemValue(e, !0)
                            }
                        }
                    }, [o("i", {
                        staticClass: "fas fa-chevron-left"
                    })]), o("input", {
                        directives: [{
                            name: "model",
                            rawName: "v-model",
                            value: e.texturevalue,
                            expression: "item.texturevalue"
                        }],
                        attrs: {
                            type: "number"
                        },
                        domProps: {
                            value: e.texturevalue
                        },
                        on: {
                            change: function(o) {
                                return t.onChangeItemValue(e, !0)
                            },
                            input: function(o) {
                                o.target.composing || t.$set(e, "texturevalue", o.target.value)
                            }
                        }
                    }), o("button", {
                        on: {
                            click: function(o) {
                                return t.addItemValue(e, !0)
                            }
                        }
                    }, [o("i", {
                        staticClass: "fas fa-chevron-right"
                    })])])]) : t._e()])])
                })), 0)
            },
            g = [],
            C = {
                props: {
                    Components: {},
                    selectedStore: {},
                    selectedMenu: {},
                    NameResource: {},
                    close: {}
                },
                methods: {
                    hasItemTextures: function(t) {
                        return void 0 !== t.texturename && "" !== t.texturename
                    },
                    onChangeItemValue: function(t, e) {
                        0 == e && (t.max <= t.value && (t.value = t.max), t.min >= t.value && (t.value = t.min), this.hasItemTextures(t) && (t.texturevalue = 0, this.SetClothingItem(t.texturename, t.texturevalue)), this.SetClothingItem(t.name, t.value)), 1 == e && (t.texturemax <= t.texturevalue && (t.texturevalue = t.texturemax), t.texturemin >= t.texturevalue && (t.texturevalue = t.texturemin), this.SetClothingItem(t.texturename, t.texturevalue))
                    },
                    addItemValue: function(t, e) {
                        if (0 == e) {
                            if (t.max <= t.value) return;
                            t.value++, this.hasItemTextures(t) && (t.texturevalue = 0, this.SetClothingItem(t.texturename, t.texturevalue)), this.SetClothingItem(t.name, t.value)
                        }
                        if (1 == e) {
                            if (t.texturemax <= t.texturevalue) return;
                            t.texturevalue++, this.SetClothingItem(t.texturename, t.texturevalue)
                        }
                    },
                    removeItemValue: function(t, e) {
                        if (0 == e) {
                            if (t.min >= t.value) return;
                            t.value--, this.hasItemTextures(t) && (t.texturevalue = 0, this.SetClothingItem(t.texturename, t.texturevalue)), this.SetClothingItem(t.name, t.value)
                        }
                        if (1 == e) {
                            if (t.texturemin >= t.texturevalue) return;
                            t.texturevalue--, this.SetClothingItem(t.texturename, t.texturevalue)
                        }
                    },
                    SetClothingItem: function(t, e) {
                        var o = this.NameResource[0];
                        i.a.post("https://".concat(o, "/SetClothing"), {
                            name: t,
                            value: e
                        }).catch((function(t) {
                            console.log(t + " : Error at SetClothing")
                        }))
                    }
                },
                computed: {
                    SortedSkinList: function() {
                        var t = [];
                        for (var e in this.Components) {
                            var o = this.Components[e];
                            if (o.category === this.selectedMenu) {
                                if ("" !== this.selectedStore && o.store !== this.selectedStore) continue;
                                t.push(o)
                            }
                        }
                        return t
                    }
                }
            },
            T = C,
            x = (o("4b79"), Object(m["a"])(T, b, g, !1, null, null, null)),
            S = x.exports,
            y = function() {
                var t = this,
                    e = t.$createElement,
                    o = t._self._c || e;
                return o("div", {
                    staticClass: "wardrobe-elements"
                }, [o("div", {
                    staticClass: "wardrobe-element actions"
                }, [o("h3", [t._v("Handlinger")]), o("div", {
                    staticClass: "wardrobe-buttons"
                }, [o("button", {
                    on: {
                        click: function(e) {
                            return t.SaveOutfit()
                        }
                    }
                }, [t._v("Gem Outfit")]), o("button", {
                    on: {
                        click: function(e) {
                            return t.ResetOutfit()
                        }
                    }
                }, [t._v("Reset Outfit")])])]), t._l(t.sortedWardrobe, (function(e, n) {
                    return o("div", {
                        key: e.index,
                        class: n === t.Wardrobe.length - 1 ? "wardrobe-element end" : "wardrobe-element"
                    }, [o("h3", [t._v(t._s(e.label))]), o("div", {
                        staticClass: "wardrobe-buttons"
                    }, [o("button", {
                        on: {
                            click: function(o) {
                                return t.ChooseOutfit(e)
                            }
                        }
                    }, [t._v("Vælg Outfit")]), o("button", {
                        on: {
                            click: function(o) {
                                return t.OverrideOutfit(e)
                            }
                        }
                    }, [t._v("Override Outfit")]), o("button", {
                        on: {
                            click: function(o) {
                                return t.DeleteOutfit(e)
                            }
                        }
                    }, [t._v("Slet Outfit")])])])
                }))], 2)
            },
            _ = [],
            R = o("1da1"),
            k = (o("96cf"), {
                props: {
                    Wardrobe: {},
                    selectedMenu: {},
                    NameResource: {},
                    close: {}
                },
                methods: {
                    SaveOutfit: function() {
                        var t = this;
                        Object(R["a"])(regeneratorRuntime.mark((function e() {
                            var o, n, a, r;
                            return regeneratorRuntime.wrap((function(e) {
                                while (1) switch (e.prev = e.next) {
                                    case 0:
                                        return e.next = 2, u.a.fire({
                                            title: "Navn på dit Outfit",
                                            input: "text",
                                            inputPlaceholder: "Skriv navnet på dit Outfit her...",
                                            showCancelButton: !0
                                        });
                                    case 2:
                                        o = e.sent, n = o.value, n && (a = n, r = t.NameResource[0], i.a.post("https://".concat(r, "/SaveOutfit"), {
                                            outfit_name: a
                                        }).catch((function(t) {
                                            console.log(t + " : Error at SaveOutfit")
                                        })));
                                    case 5:
                                    case "end":
                                        return e.stop()
                                }
                            }), e)
                        })))()
                    },
                    ResetOutfit: function() {
                        var t = this.NameResource[0];
                        i.a.post("https://".concat(t, "/ResetOutfit")).catch((function(t) {
                            console.log(t + " : Error at ResetOutfit")
                        }))
                    },
                    ChooseOutfit: function(t) {
                        var e = t.index,
                            o = this.NameResource[0];
                        i.a.post("https://".concat(o, "/ChooseOutfit"), {
                            index: e
                        }).catch((function(t) {
                            console.log(t + " : Error at ChooseOutfit")
                        }))
                    },
                    OverrideOutfit: function(t) {
                        var e = this,
                            o = t.index;
                        u.a.fire({
                            title: "Er du sikker på at overskrive dette outfit?",
                            showDenyButton: !1,
                            showCancelButton: !0,
                            confirmButtonText: "Ja",
                            cancelButtonText: "Nej"
                        }).then((function(t) {
                            if (t.isConfirmed) {
                                var n = e.NameResource[0];
                                i.a.post("https://".concat(n, "/OverrideOutfit"), {
                                    index: o
                                }).catch((function(t) {
                                    console.log(t + " : Error at OverrideOutfit")
                                }))
                            }
                        }))
                    },
                    DeleteOutfit: function(t) {
                        var e = this,
                            o = t.index;
                        u.a.fire({
                            title: "Er du sikker på at slette dette outfit?",
                            showDenyButton: !1,
                            showCancelButton: !0,
                            confirmButtonText: "Ja",
                            cancelButtonText: "Nej"
                        }).then((function(t) {
                            if (t.isConfirmed) {
                                var n = e.NameResource[0];
                                i.a.post("https://".concat(n, "/DeleteOutfit"), {
                                    index: o
                                }).catch((function(t) {
                                    console.log(t + " : Error at DeleteOutfit")
                                }))
                            }
                        }))
                    }
                },
                computed: {
                    sortedWardrobe: function() {
                        var t = [];
                        for (var e in this.Wardrobe) {
                            var o = this.Wardrobe[e];
                            t.push({
                                index: e,
                                label: o.label
                            })
                        }
                        return t;
                    }
                }
            }),
            I = k,
            w = (o("1b78"), Object(m["a"])(I, y, _, !1, null, null, null)),
            M = w.exports,
            O = function() {
                var t = this,
                    e = t.$createElement,
                    o = t._self._c || e;
                return o("div", {
                    staticClass: "tatto-elements"
                }, [t._l(t.SortedTattoList, (function(e, n) {
                    return o("div", {
                        key: n,
                        class: n === t.SortedTattoList.length - 1 ? "tatto-element end" : "tatto-element"
                    }, [o("div", {
                        staticClass: "tatto-element-header"
                    }, [o("h1", [t._v(t._s(e.title))]), 0 !== e.current ? o("div", {
                        staticClass: "header-buttons"
                    }, [t.hasAcquiredNumber(e) ? o("button", {
                        on: {
                            click: function(o) {
                                return t.RemoveTatto(e)
                            }
                        }
                    }, [t._v("fjern")]) : t._e(), t.hasAcquiredNumber(e) ? t._e() : o("button", {
                        staticClass: "green",
                        on: {
                            click: function(o) {
                                return t.AddTatto(e)
                            }
                        }
                    }, [t._v("tilføj")])]) : t._e()]), o("div", {
                        staticClass: "tatto-element-body"
                    }, [o("div", {
                        staticClass: "tatto-item"
                    }, [o("h3", [t._v("Maks Numre: " + t._s(e.qty))]), o("div", {
                        staticClass: "tatto-buttons"
                    }, [o("button", {
                        on: {
                            click: function(o) {
                                return t.removeTattoItemValue(e)
                            }
                        }
                    }, [o("i", {
                        staticClass: "fas fa-chevron-left"
                    })]), o("input", {
                        directives: [{
                            name: "model",
                            rawName: "v-model",
                            value: e.current,
                            expression: "item.current"
                        }],
                        attrs: {
                            type: "number"
                        },
                        domProps: {
                            value: e.current
                        },
                        on: {
                            change: function(o) {
                                return t.onChangeTattoItemValue(e)
                            },
                            input: function(o) {
                                o.target.composing || t.$set(e, "current", o.target.value)
                            }
                        }
                    }), o("button", {
                        on: {
                            click: function(o) {
                                return t.addTattoItemValue(e)
                            }
                        }
                    }, [o("i", {
                        staticClass: "fas fa-chevron-right"
                    })])])])])])
                })), o("div", {
                    staticClass: "reset-button"
                }, [o("button", {
                    on: {
                        click: function(e) {
                            return t.ResetAllTattos()
                        }
                    }
                }, [t._v("RESET ALT")])])], 2)
            },
            N = [],
            P = {
                props: {
                    Tattos: {},
                    PlayerJob: {},
                    PlayerIdentifier: {},
                    NameResource: {},
                    close: {}
                },
                methods: {
                    onChangeTattoItemValue: function(t) {
                        t.qty <= t.current && (t.current = t.qty), 0 >= t.current && (t.current = 0), this.SetTattoItem(t)
                    },
                    removeTattoItemValue: function(t) {
                        0 >= t.current || (t.current--, this.SetTattoItem(t))
                    },
                    addTattoItemValue: function(t) {
                        t.qty <= t.current || (t.current++, this.SetTattoItem(t))
                    },
                    SetTattoItem: function(t) {
                        var e = this.NameResource[0];
                        i.a.post("https://".concat(e, "/SetTatto"), {
                            item: t
                        }).catch((function(t) {
                            console.log(t + " : Error at SetTatto")
                        }))
                    },
                    hasAcquiredNumber: function(t) {
                        for (var e in t.acquired) {
                            var o = t.acquired[e];
                            if (t.current === o) return !0
                        }
                        return !1
                    },
                    RemoveTatto: function(t) {
                        var e = this.NameResource[0];
                        i.a.post("https://".concat(e, "/RemoveTatto"), {
                            item: t
                        }).catch((function(t) {
                            console.log(t + " : Error at RemoveTatto")
                        }))
                    },
                    AddTatto: function(t) {
                        var e = this.NameResource[0];
                        i.a.post("https://".concat(e, "/AddTatto"), {
                            item: t
                        }).catch((function(t) {
                            console.log(t + " : Error at AddTatto")
                        }))
                    },
                    ResetAllTattos: function() {
                        var t = this;
                        u.a.fire({
                            title: "Vil reset alle Tattoveringer?",
                            showDenyButton: !1,
                            showCancelButton: !0,
                            confirmButtonText: "Ja",
                            cancelButtonText: "Annullere"
                        }).then((function(e) {
                            if (e.isConfirmed) {
                                var o = t.NameResource[0];
                                i.a.post("https://".concat(o, "/ResetAllTattos")).catch((function(t) {
                                    console.log(t + " : Error at ResetAllTattos")
                                }))
                            }
                        }))
                    }
                },
                computed: {
                    SortedTattoList: function() {
                        var t = [];
                        for (var e in this.Tattos) {
                            var o = this.Tattos[e],
                                n = !0;
                            if (void 0 !== o.requiredJobs && o.requiredJobs.length > 0) {
                                n = !1;
                                for (var a = 0; a < o.requiredJobs.length; a++) {
                                    var r = o.requiredJobs[a];
                                    r === this.PlayerJob && (n = !0)
                                }
                            }
                            var s = !0;
                            if (void 0 !== o.whitelistedPlayers && o.whitelistedPlayers.length > 0) {
                                s = !1;
                                for (var i = 0; i < o.whitelistedPlayers.length; i++) {
                                    var c = o.whitelistedPlayers[i];
                                    c === this.PlayerIdentifier && (s = !0)
                                }
                            }
                            n && s && t.push(o)
                        }
                        return t
                    }
                }
            },
            E = P,
            W = (o("6dce"), Object(m["a"])(E, O, N, !1, null, null, null)),
            j = W.exports,
            J = {
                components: {
                    CameraMenu: p,
                    ModuleMenu: S,
                    WardrobeMenu: M,
                    TattoModuleMenu: j
                },
                data: function() {
                    return {
                        opened: !1,
                        isFreeroaming: !1,
                        hasWardrobe: !1,
                        isTattoShop: !1,
                        selectedMenu: "",
                        selectedStore: "",
                        Components: [],
                        Wardrobe: [],
                        Tattos: [],
                        PlayerJob: "none",
                        PlayerIdentifier: "none",
                        NameResource: "esx_clothing"
                    }
                },
                methods: {
                    receiveLua: function(t) {
                        if (t && t.data) {
                            var e = t.data;
                            e.init && (this.PlayerJob = e.PlayerJob, this.PlayerIdentifier = e.Identifier, this.NameResource = e.NameResource), e.open && (this.opened = !0, this.Components = e.Components, this.Wardrobe = e.Wardrobe, this.setStarterItem()), e.openStore && (this.Components = e.Components, this.Wardrobe = e.Wardrobe, this.selectedStore = e.store, this.hasWardrobe = e.hasWardrobe, this.opened = !0, this.setStarterItem()), e.openTatto && (this.Tattos = e.Tattos, this.opened = !0, this.isTattoShop = !0), e.refreshComponents && (this.Components = e.Components), e.refreshWardrobe && (this.Wardrobe = e.Wardrobe), e.refreshPlayerJob && (this.PlayerJob = e.PlayerJob), e.refreshTattos && (this.Tattos = e.Tattos), e.updateTexture && this.updateTextureMax(e.name, e.value), e.ToggleFreeRoam && this.ToggleFreeRoam(!1)
                        }
                    },
                    SelectMenu: function(t) {
                        this.selectedMenu = t
                    },
                    isClothing: function() {
                        return "body" === this.selectedMenu || "clothing" === this.selectedMenu || "accessories" === this.selectedMenu
                    },
                    FindItem: function(t) {
                        for (var e in this.Components) {
                            var o = this.Components[e];
                            if (o.name == t) return o
                        }
                        return null
                    },
                    hasStoreItems: function(t) {
                        var e = [];
                        for (var o in this.Components) {
                            var n = this.Components[o];
                            if (t === n.category) {
                                if ("" !== this.selectedStore && n.store !== this.selectedStore) continue;
                                e.push(n)
                            }
                        }
                        return e.length > 0
                    },
                    setStarterItem: function() {
                        for (var t in this.Components) {
                            var e = this.Components[t];
                            if (this.hasStoreItems(e.category)) return void(this.selectedMenu = e.category)
                        }
                    },
                    updateTextureMax: function(t, e) {
                        var o = this.FindItem(t);
                        null != o && void 0 != o.texturemax && (o.texturemax = e)
                    },
                    RotateCamera: function(t) {
                        var e = this.NameResource[0];
                        i.a.post("https://".concat(e, "/RotateCamera"), {
                            direction: t
                        }).catch((function(t) {
                            console.log(t + " : Error at RotateCamera")
                        }))
                    },
                    ToggleFreeRoam: function(t) {
                        this.isFreeroaming = t;
                        var e = this.NameResource[0];
                        i.a.post("https://".concat(e, "/ToggleFreeRoam"), {
                            isFreeroaming: this.isFreeroaming
                        }).catch((function(t) {
                            console.log(t + " : Error at ToggleFreeRoam")
                        }))
                    },
                    close: function() {
                        var t = this;
                        if (!this.closed && (this.isTattoShop || u.a.fire({
                                title: "Vil gemme dit tøj?",
                                showDenyButton: !0,
                                showCancelButton: !0,
                                confirmButtonText: "Ja",
                                cancelButtonText: "Annullere",
                                denyButtonText: "Nej"
                            }).then((function(e) {
                                if (e.isConfirmed) {
                                    var o = t.NameResource[0];
                                    i.a.post("https://".concat(o, "/saveClose")).catch((function(t) {
                                        console.log(t + " : Error at saveClose")
                                    })), t.selectedStore = "", t.opened = !1, t.hasWardrobe = !1
                                }
                                if (e.isDenied) {
                                    var n = t.NameResource[0];
                                    i.a.post("https://".concat(n, "/nosaveClose")).catch((function(t) {
                                        console.log(t + " : Error at nosaveClose")
                                    })), t.selectedStore = "", t.opened = !1, t.hasWardrobe = !1
                                }
                            })), this.isTattoShop)) {
                            var e = this.NameResource[0];
                            i.a.post("https://".concat(e, "/closeTattoShop")).catch((function(t) {
                                console.log(t + " : Error at closeTattoShop")
                            })), this.opened = !1, this.isTattoShop = !1
                        }
                    },
                    keyPress: function(t) {
                        var e = t.key;
                        "Escape" == e && this.close()
                    }
                },
                created: function() {
                    window.addEventListener("message", this.receiveLua), window.addEventListener("keydown", this.keyPress)
                },
                destroyed: function() {
                    window.removeEventListener("message", this.receiveLua), window.removeEventListener("keydown", this.keyPress)
                }
            },
            B = J,
            V = (o("034f"), Object(m["a"])(B, a, r, !1, null, null, null)),
            A = V.exports,
            F = o("f9d5"),
            L = o.n(F);
        n["a"].config.productionTip = !1, n["a"].use(L.a), new n["a"]({
            render: function(t) {
                return t(A)
            }
        }).$mount("#app")
    },
    "6dce": function(t, e, o) {
        "use strict";
        o("2ccc")
    },
    "85ec": function(t, e, o) {},
    f30d: function(t, e, o) {
        "use strict";
        o("f4fc")
    },
    f4fc: function(t, e, o) {}
});
//# sourceMappingURL=app.91d2b6e8.js.map