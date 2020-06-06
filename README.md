# Online learning website

## Resources

* Ruby version: '2.6.5'

* Rails version: '6.0.3'

* Database Mysql 

## Docker

* To start up the application in your local Docker environment:

```bash
git clone git@github.com:awesome-academy/pr1909-group1.git
cd pr1909-group1
```
Clearn Gemfile.lock

```bash
sudo docker-compose build
sudo docker-compose up -d
sudo docker-compose run app_cms rails db:create
```
