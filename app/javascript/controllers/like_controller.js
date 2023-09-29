import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="like"
export default class extends Controller {
  static targets = ["likebtn"];
  connect() {
    const { id, liked } = this.element.dataset;
    this.id = id;
    if (liked == "true"){
      this.likebtnTarget.textContent = "喜歡大雕讚"
    }else {
      this.likebtnTarget.textContent = "不喜歡小雕雕";
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
        this.likebtnTarget.textContent = "喜歡大雕讚";
      }else {
        this.likebtnTarget.textContent = "不喜歡小雕雕";
      }
    })
    .catch((err) => {
      console.log(err);
    })
  } 
}
