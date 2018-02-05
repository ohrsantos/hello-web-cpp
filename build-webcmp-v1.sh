docker build -f Dockerfile.webcmp  -t ohrsan/webcmp:v1 .

docker login -u=ohrsan -p=bomdia01

docker push ohrsan/webcmp:v1
