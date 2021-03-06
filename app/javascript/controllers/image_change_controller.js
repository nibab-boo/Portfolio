import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form" ]
  connect() {
    console.log("hello");
    const imageBox = document.querySelector(".image-box");
    if (!imageBox) {
      const imageBox = document.createElement("div");
      imageBox.classList.add("image-box", "mt-5")
      this.formTarget.appendChild(imageBox);
    }
  }

  imageUpdate(e) {
    const files = e.target.files;
    const imageBox = document.querySelector(".image-box.mt-5");
    imageBox.innerHTML = ""
    Object.keys(files).forEach( function (key) {
      const reader = new FileReader();
      reader.addEventListener("load", ()=> {
        const img = document.createElement("img");
        img.src = reader.result;
        img.classList.add("project-image","m-2");
        imageBox.appendChild(img);
      });
      reader.readAsDataURL(files[key]);
    });
  }
}