# pir5-k8s

## deploy

### init

Run only first

```
helm init
make powerdns-install
```

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

## build and push images

### build and push all images

```
make docker_push
```

