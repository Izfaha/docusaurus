---
sidebar_title: Networking Kubernetes 
sidebar_position: 3
---

# Networking Kubernetes Configuration LAB

## Activate Virsh Default

In this step, you need to start default virsh uses this command :

```sh
# start default nat
sudo virsh net-start default
# set becoming autostart
sudo virsh net-autostart default
```

Verifying whether`ip_forward` active or not, through :

```sh
cat /proc/sys/net/ipv4/ip_forward
```

The output must be 1 if it is stil 0 means that ip forward is still inactive, just use this : 

```sh 
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```

## Add ip-tables rule

After we sure that ip forward is active, we must add a rule to ip-tables for `virbr0`.

```sh 
sudo iptables -t nat -A POSTROUTING -s 192.168.122.0/24 ! -d 192.168.122.0/24 -j MASQUERADE
```

The output should be :

```sh {7}
Chain POSTROUTING (policy ACCEPT 6367 packets, 527K bytes)
 pkts bytes target     prot opt in     out     source               destination         
 6202  517K ts-postrouting  all  --  *      *       0.0.0.0/0            0.0.0.0/0           
    1   152 MASQUERADE  all  --  *      !docker0  172.17.0.0/16        0.0.0.0/0           
    0     0 MASQUERADE  all  --  *      !br-b6a100db3f3d  172.26.0.0/16        0.0.0.0/0           
    0     0 MASQUERADE  all  --  *      !br-224ec488b766  172.25.0.0/16        0.0.0.0/0           
    0     0 MASQUERADE  all  --  *      *       192.168.122.0/24    !192.168.122.0/24  
```

Do not forget to allow trafic in and out through interface `virbr0` in `FORWARD` chain.

```sh
# allow packet coming in from virbr0 (traffic from VM to outside) for being forwarded
sudo iptables -I FORWARD -i virbr0 -j ACCEPT

# allow packet coming out from virbr0 (traffic from outside to VM, for instance reply from internet) for being forwarded
sudo iptables -I FORWARD -o virbr0 -j ACCEPT
```

This is the flow :

```
VM → virbr0 → [FORWARD -i virbr0] → eth0 host → [MASQUERADE] → internet

internet → eth0 host → [FORWARD -o virbr0] → virbr0 → VM
```

You can save the rule become permanent using this command :

```sh
sudo iptables-save | sudo tee /etc/iptables/iptables.rules
sudo systemctl enable iptables
```

:::note

before adding a new rule, please verify using command :

```sh
sudo iptables -t nat -L POSTROUTING -n -v
```

and check wehther this line exist or not. 

```
0     0 MASQUERADE  all  --  *      *       192.168.122.0/24    !192.168.122.0/24
```

:::

