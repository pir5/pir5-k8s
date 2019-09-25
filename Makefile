deploy: powerdns/deploy pdns-api/deploy health-worker-db/deploy health-worker-redis/deploy health-worker/deploy health-worker-api/deploy health-worker-register/deploy

powerdns/deploy:
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
	if [ ! -d powerdns-helm ]; then git clone https://github.com/cdwv/powerdns-helm; fi

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
