deploy:
	make powerdns/deploy
	make pdns-api/deploy
	make health-worker-db/deploy
	make health-worker-redis/deploy
	make health-worker/deploy
	make health-worker-api/deploy
	make health-worker-register/deploy

powerdns/deploy: powerdns-helm
	cd powerdns-helm
	helm upgrade powerdns powerdns-helm/

pdns-api/deploy:
	kubectl apply -k pdns-api

health-worker-db/deploy:
	kubectl apply -k health-worker-db

health-worker-redis/deploy:
	kubectl apply -k health-worker-redis

health-worker-api/deploy:
	kubectl apply -k health-worker-api

health-worker-register/deploy:
	kubectl apply -k health-worker-register

health-worker/deploy:
	kubectl apply -k health-worker

powerdns-helm:
	[ -d powerdns-helm ] || git clone https://github.com/cdwv/powerdns-helm

powerdns-install: powerdns-helm
	helm install powerdns-helm/ --name powerdns

docker_push: pdns-api/docker_push health-worker/docker_push

pdns-api/docker_push: pdns-api/build_image
	docker push pir5/pdns-api:latest

health-worker/docker_push: health-worker/build_image
	docker push pir5/health-worker:latest

pdns-api/build_image:
	docker build -t pir5/pdns-api --build-arg appname=pdns-api .

health-worker/build_image:
	docker build -t pir5/health-worker --build-arg appname=health-worker .
