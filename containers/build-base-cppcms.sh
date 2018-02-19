docker build -f containers/Dockerfile.base-cppcms  -t ohrsan/base-cppcms:latest .

docker login -u=ohrsan -p=bomdia01

docker push ohrsan/base-cppcms:latest
