import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
    console.log("navbar")
  }

  toggle_lan() {
    const menu = document.getElementById("language_menu");
    if (menu.classList.contains('hidden')) {
        menu.classList.remove('hidden');
    } else {
        menu.classList.add('hidden');
    }
  }

  toggle_main() {
    const menu = document.getElementById("mobile-menu-language-select");
    if (menu.classList.contains('hidden')) {
        menu.classList.remove('hidden');
    } else {
        menu.classList.add('hidden');
    }
  }
}
