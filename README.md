# https://lab.stouffcapital.com

based on http://zero-to-jupyterhub.readthedocs.io/en/latest/index.html

`helm install jupyterhub/jupyterhub --version=v0.5 --name=jupyterhub --namespace=jupyterhub -f config.yaml --timeout=10000`


## `config.yaml`

```
hub:
  cookieSecret: "<openssl rand -hex 32>"
  db:
    type: sqlite-pvc
    pvc:
      accessModes:
        - ReadWriteOnce
      storage: 1Gi
      storageClassName: rook-block

singleuser:
  image:
    name: jupyter/all-spark-notebook
    tag: c7fb6660d096
  storage:
    type: dynamic
    capacity: 50Gi
    dynamic:
      storageClass: rook-block

proxy:
  secretToken: "<openssl rand -hex 32>"
  service:
    type: NodePort

auth:
  type: github
  github:
    clientId: "<clientId>"
    clientSecret: "<clientSecret>"
    callbackUrl: "https://lab.stouffcapital.com/hub/oauth_callback"
    org_whitelist:
      - "stouff-capital"
  scopes:
    - "read:user"

```

