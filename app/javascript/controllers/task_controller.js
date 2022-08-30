import { Controller } from "@hotwired/stimulus"
import Rails from "@rails/ujs";
// Connects to data-controller="task"
export default class extends Controller {
  static targets = [ "form" ]

  connect() {
  }
  change() {
    this.formTarget.submit();
  }
}
