# UFW Role

This is a simple role used to allow ports on a server.

The ports to allow are managed by a list var: `ufw_allow_portss`

```
ufw_allow_ports:
  - 80
  - 53
```

SSH Is allowed by default.
