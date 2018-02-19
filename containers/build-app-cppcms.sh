docker build -f containers/Dockerfile.app-cppcms  -t ohrsan/app-cppcms:latest . || exit 1

docker login -u=ohrsan -p=bomdia01

docker push ohrsan/app-cppcms:latest
