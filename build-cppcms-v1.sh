docker build -f Dockerfile.cppcms  -t ohrsan/cppcms:v1 .

docker login -u=ohrsan -p=bomdia01

docker push ohrsan/cppcms:v1
