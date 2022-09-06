import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="task"
export default class extends Controller {
  static targets = [ "form" ]

  change() {
    this.formTarget.submit();
  }
}
