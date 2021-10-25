#!/bin/bash

WORK_DIR=${HOME}/dev/workspace/qimata

ANSIBLE_WORK_DIR=${WORK_DIR}/qimata-ansible/ansible
SSH_PRIVATE_KEY=ansible-dev_id_rsa
SSH_KEY_DIR=${HOME}/dev/workspace/qimata/ssh
REMOTE_USER=ansible
ANSIBLE_VAULT_DIR=${WORK_DIR}

ANSIBLE_VAULT_PASSWORD_FILE=vault_pass.txt
ANSIBLE_VAULT_DIR=${WORK_DIR}/vault
docker run -it \
  -v ${ANSIBLE_WORK_DIR}:/ansible \
  -v ${ANSIBLE_VAULT_DIR}/${ANSIBLE_VAULT_PASSWORD_FILE}:/${ANSIBLE_VAULT_PASSWORD_FILE} \
  -v ${SSH_KEY_DIR}/${SSH_PRIVATE_KEY}:/${SSH_PRIVATE_KEY}  \
  -e SSH_PRIVATE_KEY=/${SSH_PRIVATE_KEY} \
  -e REMOTE_USER=${REMOTE_USER} \
  -e ANSIBLE_HOST_KEY_CHECKING=False \
  -e ANSIBLE_VAULT_PASSWORD_FILE=/${ANSIBLE_VAULT_PASSWORD_FILE} \
  --rm ansible:latest \
  ansible-playbook ${@}
