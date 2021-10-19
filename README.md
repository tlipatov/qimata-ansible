# qimata-ansible
qimata ansible scripts

# Running ansible in docker
For development purposes ansible is run in a docker container. This allows for a clean ansible installation without having to use a python virtual-env.

#### To build the container
```
cd docker
make
```

will create the docker container: `ansible:latest`

#### To run ansible playbook using the container:

```
./bin/ansible-playbook.sh -i inventory/tlipatov-dev site.yml
```