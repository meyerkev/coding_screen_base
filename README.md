# Meyerkev's interview 

To run the test suite on the Docker image:

```
make docker-build && make test
```

General commands: 

```
# Build
make docker-build

# Run
make up

# Test
# Currently, this is not multi-OS, so it needs to run on linux/amd64
make test

# Unit tests
make unit-test

# Get a Docker shell
make sh

# Reset the server to the beginning state
# Lit. make down && make up
make reset  
```
