// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import "preline";
import "leaflet";
import "leaflet-providers";

document.addEventListener("turbo:load", function (_event) {
  HSAccordion.autoInit();
  HSDropdown.autoInit();
  HSOverlay.autoInit();
  HSSelect.autoInit();
});