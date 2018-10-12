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
