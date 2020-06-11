# Online learning website

## Resources

* Ruby version: '2.6.5'

* Rails version: '6.0.3'

* Database Mysql 

## Docker

To start up the application in your local Docker environment:

```bash
git clone git@github.com:awesome-academy/pr1909-group1.git
cd pr1909-group1
```
Copy .env-sample to .env and change password

```bash
cp .env-sample .env
```

Clean Gemfile.lock

```bash
sudo docker-compose build
```
Install Figaro 

```bash
sudo docker-compose run app_cms bundle exec figaro install
```
And change application.yml follow application.yml.example, next

```bash
sudo docker-compose up --build
sudo docker-compose up -d
sudo docker-compose run app_cms rails db:create
sudo docker-compose run app_cms rails db:migrate
```
