Planet 9
========

App for testing meteor (0.9) and packages.


## Notes

###How to install a local package

```
  mrt link-package /absoloute/path/to/package
  
  meteor add namespace:package

```

### [Add Oplog Tailing on Ubuntu](https://medium.com/meteor-secret/adding-oplog-tailing-with-meteor-up-mup-and-ubuntu-efa644f397e9)

* connect to your Ubuntu server

* edit mongod config file `/etc/mongod.conf` (note it’s not the same as `/etc/mongodb.conf`)

* uncomment the line `port = 27017` (if you don’t see this commented line, you edit the wrong file)

* uncomment the line starting with `replSet` and set the variable to meteor. It should be: `replSet=meteor`

* save the file

* restart mongod: `service mongod restart`

* connect to mongod: `mongo`

* copy paste the following code
```
var config = {_id: "meteor", members: [{_id: 0, host: "127.0.0.1:27017"}]}
rs.initiate(config)
```
It should output something like:
```
{
 "info" : "Config now saved locally. Should come online in about a minute.",
 "ok" : 1
}
```
*Note: Be sure your mongod is only accessible from localhost (it’s the case by default on meteor up). If mongod is accessible outside and you don’t setup role-based access control, everybody will be able to access and edit your database!*

* find the name of the database used by your Meteor app (you’ll need it later) with this command: show dbs

Now, locally, on your dev computer:

* open mup.json and add these 2 lines in the “env” object:
```
"MONGO_URL": "mongodb://127.0.0.1:27017/XXXXXXXXXX",
"MONGO_OPLOG_URL": "mongodb://127.0.0.1:27017/local",
```

Be sure to replace XXXXXXXXXX with the name of your database (found by show dbs command)

* deploy: mup deploy

Now your server should use oplog tailing.


