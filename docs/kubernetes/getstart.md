---
sidebar_title: Get start to Kubernetes
sidebar_position: 2
---

# Get start to Kubernetes

## Quick Installation using Play with Kubernetes

### 1. Create New Cluster

Initialing new cluster using this command.

```sh showLineNumbers
kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.244.0.0/16
```

After you run that command it will show you what you should do. Like this

```sh showLineNumbers {2-3}
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u);$(id -g) $HOME/.kube/config
```

:::warning[Disclaimer]
If you have been initializing a cluster and it is broken, you must reset the cluster first bcz there is 
configuration saved.

```sh
kubeadm reset
```

Don't forget to save this kubeadm join token.

```sh {1-2} showLineNumbers
kubeadm join 192.168.0.8:6443 --token ql1g9g.touegzcr30vvqq1r \
    --discovery-token-ca-cert-hash sha256:b0d68bda92a40c27c11631ed96b6e94cbbf443d5a1d33333078b90ecb1bb8d4b
```

:::

### 2. Verify the cluster created

To verify the cluster just type 

```sh
kubectl get nodes
```

This is output, your a single-node kubernetes cluster or control plane/master but the status node is `NotReady`. This is bcz you haven't configured the pod network yet. 

```
[node1 ~]$ kubectl get nodes
NAME    STATUS     ROLES           AGE     VERSION
node1   NotReady   control-plane   8m10s   v1.27.2
```

### 3. Initializing Kubernetes Pod Network

let's we initialize our pod network

```sh
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```

After you initialize pod network the status node will chage to `Ready`.

```
NAME    STATUS   ROLES           AGE   VERSION
node1   Ready    control-plane   16m   v1.27.2
```

### 3. Create Kubeadm Join

first, you need to create an instace one more, intentionally for being joined to node 1 (in instance one).
You require an join token that has been popping up after executig `kubeadm init ...`.

Open node 2 and hit your join token in your terminal.

```sh 
kubeadm join 192.168.0.8:6443 --token ql1g9g.touegzcr30vvqq1r \
    --discovery-token-ca-cert-hash sha256:b0d68bda92a40c27c11631ed96b6e94cbbf443d5a1d33333078b90ecb1bb8d4b
```

Going back to your node 1, hit this command

```sh
kubectl get nodes
```

it will be shown.

```sh {4}
[node1 ~]$ kubectl get nodes
NAME    STATUS   ROLES           AGE     VERSION
node1   Ready    control-plane   38m     v1.27.2
node2   Ready    <none>          4m30s   v1.27.2
```