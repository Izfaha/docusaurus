---
sidebar_title: JuaraGCP season 12
sidebar_position: 1
---

# JuaraGCP season 12

## Initialisation 

Setup project ID

```sh 
gcloud config set project <project-id>
```

List the active account name

```sh
gcloud auth list
```

Output :

```
ACTIVE: *
ACCOUNT: "ACCOUNT"

To set the active account, run:
    $ gcloud config set account `ACCOUNT`
```


List project ID

```sh
gcloud config list project
```