#!/bin/bash

WORK_DIR=${HOME}/dev/workspace/qimata/qimata-ansible
ANSIBLE_WORK_DIR=${WORK_DIR}/ansible
SSH_PRIVATE_KEY=ansible-dev_id_rsa
SSH_KEY_DIR=${HOME}/dev/workspace/qimata/ssh
REMOTE_USER=ansible

docker run -it \
  -v ${ANSIBLE_WORK_DIR}:/ansible \
  -v ${SSH_KEY_DIR}/${SSH_PRIVATE_KEY}:/${SSH_PRIVATE_KEY}  \
  -e SSH_PRIVATE_KEY=${SSH_PRIVATE_KEY} \
  -e REMOTE_USER=${REMOTE_USER} \
  -e ANSIBLE_HOST_KEY_CHECKING=False \
  --rm ansible:latest \
  ansible-playbook ${@}
