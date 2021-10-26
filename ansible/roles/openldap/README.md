# OpenLdap for debian

This role is used to manage OpenLdap on debain 10+

## Features

- LDAP producer
- LDAP consumers (syncrel)
- TLS configureation
- Create databases
- Create Organizational units
- Create users

## Usage

At least one database must bedefined in the `openldap_bases` list

#### openldap_bases

List of dicts. Each dict defines a single database.

- database: Database ID. Each DB must have a unique ID.
- org: organization
- tld: domain
- bind_user: the DB bind user name
- bind_password: the DB bind user password
- admin_user_name: the DB admin user (default=admin)
- admin_user_password: the DB admin user name
- users: list of users tocreate, see users
- units: list of organizational units to create
- syncrepl: turn on sync for this db: true|false (default=false)

```
openldap_bases:
  - database: "1"
    org: "qimata"
    tld: "com"
    bind_user: admin
    bind_password: ld@p123!
    admin_user_password: f00b@r
    users:
      - FirstName: John
        LastName: Doe
        ou: users
        password: q1w2e3r4
        attributes: 
        uidNumber: 10000
        gidNumber: 10000
        loginShell: /bin/bash
        homeDirectory: /home/john
        sn: Doe
        uid: 10000
        cn: John Doe
    units:
      - users
      - groups
    syncrepl: true
```

### TLS

To enable TLS you will need to set the `openldap_tls` varibale to `true`

`openldap_tls=true`

and define the TLS certificates using either variables or files.

###### TLS Variables

TLS certificates can be passed as variables. This allows them to be setup as environmnet variables on the ansible runner.

The variables are bas64 encoded strings. These can also be vault encrypted.

To generate the base64 encoded one line strings:

```
cat ca.cert.pem | base64 -w 0
cat tls.crt | base64 -w 0
cat tls.key | base64 -w 0
```

To encrypt the string using vault: 

See vault documentation: https://docs.ansible.com/ansible/latest/user_guide/vault.html

```
cat ca.cert.pem | base64 -w 0 | ansible-vault encrypt_string --vault-id ../../vault/vault_pass.txt --stdin-name 'tls_ca_cert'

cat tls.crt | base64 -w 0 | ansible-vault encrypt_string --vault-id ../../vault/vault_pass.txt --stdin-name 'openldap_tls_key'

cat tls.key | base64 -w 0 | ansible-vault encrypt_string --vault-id ../../vault/vault_pass.txt --stdin-name 'openldap_tls_key'
```

###### TLS Files


Plase the certificate, key and ca into the top `files` folder such as `files/openldap/tls`

The TLS files should be Ansible Vault encrypted in real world application.

Define the variables with the relative file paths:

```
openldap_tls_ca_cert_file: files/openldap/tls/ca.cert.pem
openldap_tls_crt_file: files/openldap/tls/tls.crt
openldap_tls_key_file: files/openldap/tls/tls.key
```

### Sync


To enable synchronization you will need at least two servers. One to acet as the producer and one to act as the consumer (replica)

The global variable: `openldap_syncrepl_provider_host` needs to define the producer hostname

```
openldap_syncrepl_provider_host: ldap-01.dev.qimata
```

Producers and consumer servers cannot be combined. You need at least two separate servers.

##### Producer

Only one server can be designated as the producer.

In the producer server `group_vars` or host inventory set:

```
openldap_syncrepl_provider: true
```

Then for each DB in `openldap_bases` that you want replicated set `syncrepl=true`

##### Consumer

You can create as many consumer replicas as needed.

In the consumer server `group_vars` or host inventory set:

```
openldap_syncrepl_consumer: true

```

### Logging
https://www.openldap.org/doc/admin24/slapdconfig.html

set the vat `openldap_syslog_level` to desired log level as described in documentation

