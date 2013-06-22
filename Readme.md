## Sarafannoe radio peredaiot po sarafanu!

The gist of it: `rake -P` to see all the tasks (someone, make it work with `rake -T`)

## Setting it up

* First, setup the postgres
* Then, run the specs. There aren't many but those that are there are all right
* Launch sidekiq with `sidekiq -r ./db_setup.rb`
* Write the `whenever` cron file to the crontab
* Relax for a couple of days.
* :cocktail: :tada: :cocktail: :tada: :cocktail: PARSY!!! :cocktail: :tada: :cocktail: :tada: :cocktail:

