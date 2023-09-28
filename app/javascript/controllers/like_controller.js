import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["count"];
  
  toggle(e){
    e.preventDefault();
    const currentCount = +this.countTarget.textContent
    this.countTarget.textContent = currentCount + 1;

    if (currentCount >= 5){
      const o = { detail: { cc: currentCount}}
      const evt = new CustomEvent("abc", o);
      window.dispatchEvent(evt);
    }
  }
}
