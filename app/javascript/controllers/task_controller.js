import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs";
// Connects to data-controller="task"
export default class extends Controller {
  static targets = [ "status" ]

  connect() {
    // console.log("hello from stimulus");
  }
  change() {
    // const value = document.querySelector('input[name="option"]:checked').value;
    // console.log(`change from stimulus, ${value}`)
    var form = document.getElementById('status-form');
    Rails.fire(form, 'submit');
  }
}
