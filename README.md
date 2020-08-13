# README
This app produce saving an array of visited links and getting an array of uniq domains of visited links

Preinstall:
* Ruby version 2.6.5

* Redis, install and run it(redis-server)

* Copy app, go to the app folder, run bundle install, run rails server(rs)

For save links you need to make a POST request
to  "http://127.0.0.1:3000/links/visited_links" with
body JSON  is formated and looks like
  { "links": [
  "https://ya.ru",
  "https://ya.ru?q=123",
  "funbox.ru",
  "https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor",
  ]}

For get domains, you need to make a GET request
to "http://127.0.0.1:3000/links//visited_domains?from=2020060813&to=2020060822"

'from' and 'to' should be in the following format year(2020)mount(06)day(09)hour(13)
