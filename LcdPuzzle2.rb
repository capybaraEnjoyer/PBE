require 'gtk3'
require 'i2c/drivers/lcd'
require_relative "Lcd"

app = Gtk::Application.new("org.gtk.example", :flags_none)

app.signal_connect "activate" do |application|
  window = Gtk::ApplicationWindow.new(application)
  window.set_title("Text view")
  window.set_default_size(300, 400)
  window.set_border_width(10)

  grid = Gtk::Grid.new
  window.add(grid)

  scrolled = Gtk::ScrolledWindow.new
  scrolled.show
  view = Gtk::TextView.new
  view.show
  scrolled.add(view)
  grid.attach(scrolled, 0, 0, 2, 1)


  button_box = Gtk::ButtonBox.new(:horizontal)
  button = Gtk::Button.new(label: "Display!")
  button.signal_connect "clicked" do |widget|
	myLcd = Lcd.new(20,4)
	myLcd.writeTextview(view.buffer.text)
  end
  button_box.add(button)
  grid.attach(button_box, 0, 1, 2, 1)
  
  window.show_all

end
  
puts app.run([$0] + ARGV)
