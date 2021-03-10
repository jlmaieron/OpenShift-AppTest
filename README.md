# OpenShift-AppTest

# Build

mvn clean package && docker build -t com.jlmaieron.rest/testrest .


# RUN

docker rm -f testrest || true && docker run -d -p 8080:8080 -p 4848:4848 --name testrest com.jlmaieron.rest/testrest


# Test

http://localhost:8010/testrest/resources/ping