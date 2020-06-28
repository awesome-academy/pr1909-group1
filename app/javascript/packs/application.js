// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

var jQuery = require("jquery");

// import jQuery from "jquery";
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

require("jquery");
require("bootstrap");
require("admin-lte");
var jQuery = require("jquery");

// import jQuery from "jquery";
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

require('webpack-jquery-ui');
require('webpack-jquery-ui/css');

require("packs/preloader");
require("packs/backToTop");
require("packs/pagination");
require("packs/courseLike");
require("packs/admin_course");
require("packs/disable");
require("packs/add_option");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
