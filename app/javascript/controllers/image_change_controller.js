import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form" ]
  connect() {
    console.log("hello");
  }

  imageUpdate(e) {
    console.log("changed");
    // console.log(e);
    const file = e.target.files[0];
    const reader = new FileReader();

    reader.addEventListener("load", ()=> {
      const img = document.querySelector(".project-image");
      if (img) {
        img.src = reader.result;
      } else {
        const img = document.createElement("img");
        img.src = reader.result;
        img.classList.add("project-image","mt-5", "d-block");
        // img.classList.add("mt-5"); 
        console.log(img);
        this.formTarget.appendChild(img);
      }
    });
    reader.readAsDataURL(file);
  }
}