// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("jquery");
require('moment');
require("bootstrap");
require("admin-lte");
require("chartkick");
require("chart.js");
require ("daterangepicker")

var moment = require('moment');
global.moment = moment;
window.moment = moment;

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
require("packs/disable");
require("packs/admin_course");
require("packs/collapse");
require("packs/edit_course")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
