--- 
sidebar_label: Pre-Requests
sidebar_position: 1
---

# Pre-requisites SSO Captive Portal Implementation

:::caution[Disclaimer]
The information provided below stems solely from my personal experiences. Should any errors or misconfigurations arise, leading to unforeseen issues, it is strongly advised to consult official documentation for accurate guidance.
:::

## QEMU Virtual Environment Components

This section details the essential virtual machines (VMs) and their respective roles within our QEMU-based network simulation:

1. **MikroTik CHR (Cloud Hosted Router) running RouterOS:**
    * This critical instance will be responsible for orchestrating network connectivity and traffic flow between the FreeRADIUS server and the client machines. Management will primarily be conducted via the RouterOS command-line interface (CLI) or the WinBox utility.

2. **FreeRADIUS Server on Ubuntu Server:**
    * Operating as the central authentication gateway, this server will process user authentication requests originating from the MikroTik CHR.

3. **Client Machines (Debian and Arch Linux):**
    * These distinct Linux distributions will function as the network endpoints, or "clients," within our simulated environment, allowing for comprehensive testing of authentication and network access protocols.
    