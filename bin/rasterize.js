"use strict";
var page = require("webpage").create(),
  system = require("system"),
  address,
  output,
  zoom;

address = system.args[1];
output = system.args[2];
zoom = system.args[3];

page.paperSize = {
  format: "A4",
  orientation: "portrait",
  margin: "0cm"
};

page.viewportSize = { width: 1280, height: 600 };
page.settings.userAgent = 'Mozilla/5.0 (Windows NT 6.0; WOW64) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7';

page.open(address, function(status) {
  if (status !== "success") {
    console.log("Unable to load the address!");
    phantom.exit(1);
  } else {
    page.evaluate(function(zoom) {
      return (document.querySelector("body").style.zoom = zoom);
    }, zoom);

    window.setTimeout(function() {
      page.render(output);
      phantom.exit();
    }, 200);
  }
});
