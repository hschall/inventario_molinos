// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "rails-ujs"  // <- Add this
Rails.start()       // <- Start Rails UJS
