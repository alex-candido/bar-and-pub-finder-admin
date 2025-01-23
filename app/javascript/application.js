// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import "mapkick/bundle";
import "preline";

document.addEventListener("turbo:load", function (_event) {
  HSAccordion.autoInit();
  HSDropdown.autoInit();
  HSOverlay.autoInit();
  HSSelect.autoInit();
});