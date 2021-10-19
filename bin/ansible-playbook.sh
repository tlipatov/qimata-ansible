#!/bin/bash

WORK_DIR=${HOME}/dev/workspace/qimata/qimata-ansible
ANSIBLE_WORK_DIR=${WORK_DIR}/ansible
ANSIBLE_SSH_PRIVATE_KEY_NAME=ansible-dev_id_rsa
ANSIBLE_SSH_PRIVATE_KEY_DIR=${HOME}/dev/workspace/qimata/ssh

docker run -it \
  -v ${ANSIBLE_WORK_DIR}:/ansible \
  -v ${ANSIBLE_SSH_PRIVATE_KEY_DIR}/${ANSIBLE_SSH_PRIVATE_KEY_NAME}:/${ANSIBLE_SSH_PRIVATE_KEY_NAME}  \
  --rm ansible:latest \
  ansible-playbook ${@} #-i inventory/tlipatov-dev site.yml
