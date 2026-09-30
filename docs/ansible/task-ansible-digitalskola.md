---
sidebar_title: Ansible Playbook
---

# Ansible Playbook

Inventory :

```ini title=inventory.ini
[mysql_servers]
worker1 ansible_host=192.168.56.11
worker2 ansible_host=192.168.56.12

[mysql_servers:vars]
ansible_user=ubuntu
ansible_python_interpeter=/usr/bin/python3
```

```yaml title=install-mysql.yaml
- name: Install and Run MySQL
  hosts: ansible_servers
  become: true

  tasks:
    - name: Install MySQL Server
      ansible.builtin.apt:
        name: mysql-server
        state: present
        update_cache: true
        cache_valid_time: 3600
    
    - name: Verify MySQL is active and running automatically
      ansible.builtin.service:
        name: mysql
        state: started
        enable: true

    - name: Check MySQL remains response
      ansible.builtin.command:
        argv:
          - mysqladmin
          - --protocol=socket
          - --user=root
          - ping
      register: mysql_status
      change_when: false

    - name: Give a result to verify
      ansible.builtin.debug:
        msg: "{{ inventory_hostname }}: {{ mysql_status.stdout }}"
```