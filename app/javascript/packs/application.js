// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import hljs from 'highlight.js'
// import 'css/site'
import 'jquery'
import('src/plugins') // note the function usage!

Rails.start()
Turbolinks.start()
ActiveStorage.start()
hljs.highlightAll()

document.addEventListener("load", function() {
    console.log('It works on each visit!');
    hljs.highlightAll();
})

document.addEventListener("turbolinks:load", function() {
    console.log('It works on each visit!');
    hljs.highlightAll();
})

document.addEventListener("ajax:success", function() {
    console.log('It works on each ajax!');
    hljs.highlightAll();
})

export {
    hljs
}
