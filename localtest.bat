mvn clean install && docker build -t com.jlmaieron.rest/testrest .
docker rm -f testrest || true && docker run -d -p 8080:8080 -p 4848:4848 --name testrest com.jlmaieron.rest/testrest 
