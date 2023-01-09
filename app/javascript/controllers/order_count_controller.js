import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order-count"
export default class extends Controller {
  static targets = ['view', 'count'];
  static values = { num: Number };

  connect() {
    console.log("connected")
  }

  plus(evt) {
    evt.preventDefault();
    ++this.numValue;
  }

  minus(evt) {
    evt.preventDefault();
    if (this.numValue > 0) {
      --this.numValue;
    }
  }
  numValueChanged() {
    this.viewTarget.textContent = this.numValue;
    this.countTarget.value = this.numValue;
    this.dispatch("changed", { detail: { content: this.numValue } })
  }
}
