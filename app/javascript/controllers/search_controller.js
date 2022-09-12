import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  initialize() {
    this.element.setAttribute("data-action", "click->search#click")
  }

  click(e) {
    e.preventDefault()
    console.log(this.element)
    this.url = this.element.getAttribute("action")
    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      },
      params: {
        zip_code: 123
      }
    })
      .then(r => r.text())
      .then( html => Turbo.renderStreamMessage(html))
  }
}
