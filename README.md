# pir5-k8s

## deploy

### deploy all compornents

```
make deploy
```

### deploy powerdns + mariadb

```
make powerdns/deploy
```

### deploy pdns-api

```
make pdns-api/deploy
```

### deploy health-workers

```
make health-worker-db/deploy
make health-worker-redis/deploy

make health-worker/deploy
make health-worker-api/deploy
make health-worker-register/deploy
```
