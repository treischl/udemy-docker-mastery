docker network create --driver overlay backend
docker network create --driver overlay frontend
docker service create --name vote -p 80:80 --network frontend --replicas 2 --detach bretfisher/examplevotingapp_vote
docker service create --name redis --network frontend --replicas 1 --detach redis:3.2
docker service create --name worker --network frontend --network backend --replicas 1 --detach bretfisher/examplevotingapp_worker:java
docker service create --name db --mount type=volume, source=db-data, target=/var/lib/postgresql/data --network backend --replicas 1 --detach postgres:9.4
docker service create --name result -p 5001:80 --network backend --replicas 1 --detach bretfisher/examplevotingapp_result
