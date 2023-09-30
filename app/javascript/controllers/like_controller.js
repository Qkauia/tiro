import { Controller } from "@hotwired/stimulus"
import xxx from "dayjs";
console.log(xxx);

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["likebtn"];
  connect() {
    const { id, liked } = this.element.dataset;
    this.id = id;
    if (liked == "true"){
      this.likebtnTarget.textContent = "♥♥♥♥♥"
    }else {
      this.likebtnTarget.textContent = "♡♡♡♡♡";
    }

  }
  
  toggle(e){
    e.preventDefault();
    const url = `/api/v1/articles/${this.id}/like`;
    const token = document.querySelector('meta[name="csrf-token"]').content
    console.log(token);
    fetch(url, {
       method: "PATCH" ,
       headers: {
        "X-CSRF-Token": token, 
       },
      })
    .then((resp) =>{
      return resp.json();
    })
    .then(({ liked }) =>{
      if (liked) {
        this.likebtnTarget.textContent = "♥♥♥♥♥";
      }else {
        this.likebtnTarget.textContent = "♡♡♡♡♡";
      }
    })
    .catch((err) => {
      console.log(err);
    })
  } 
}
