import { Application } from "@hotwired/stimulus"
import consumer from "channels/consumer"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
application.consumer = consumer
window.Stimulus   = application

// const context = require.context("controllers", true, /\.js$/);
// application.load(definitionsFromContext(context));

export { application }
