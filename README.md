# README
0. first, lets clone the repository and get into the directory:
```
git clone .... 
cd nnodes
```
1. To get started install the required gems:
```
bundle install
```

2. Migrate the database:
```
rails db:migrate
```

3. install webpacker
 ```
 rails webpacker:install
 ```
 and hit enter till webpacker gets succesfully installed
4. run the test suite:

```
rails test
```

5. if tests are ok, run the local server:
```
rails server
```
6. optionally, you can poblate the db
```
rails db:seed
```

Dada las limitaciones de Heroku, el cron-job que juega a la ruleta corre cada 10 minutos.

El cron-job que se encarga de agregar dinero en el balance de cada jugador lo hace 1 vez por día.