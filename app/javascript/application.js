// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import "preline";

document.addEventListener("turbo:load", function (_event) {
  HSStaticMethods.autoInit();
  HSAccordion.autoInit();
  HSDropdown.autoInit();
  HSOverlay.autoInit();
  HSSelect.autoInit();
  HSCollapse.autoInit();
  HSThemeSwitch.autoInit();
});
