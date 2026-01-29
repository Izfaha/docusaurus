# The Basics of Google Cloud Compute

## Create a Virtual Machine

### Step 1 Create a new instance from the Cloud console

1. In the **Cloud Console**, open the **Navigation menu (☰)**, click **Compute Engine → VM Instances**.

> ⏳ *This may take a minute to initialize the first time.*



2. To create a new instance, click **Create Instance**.



3. In the **Machine configuration** section, fill in the following fields:

| Field        | Value        | Additional Information |
|-------------|-------------|------------------------|
| **Name**    | `gcelab`    | Name for the VM instance |
| **Region**  | `<REGION>`  | See Compute Engine documentation: **Regions and Zones** |
| **Zone**    | `<ZONE>`    | Remember the selected zone for later use |
| **Series**  | `E2`        | Cost-optimized machine family |
| **Machine type** | `e2-medium` | 2 vCPU, 4 GB RAM |

> ⚠️ **Note**: A new project has a default **resource quota** which may limit the number of CPU cores. You can request more quota when working outside this lab.



4. Click **OS and storage**.
Click **Change** to configure the boot disk.
Set the following values:

- **Operating system**: Debian  
- **Version**: Debian GNU/Linux 12 (bookworm)  
- **Boot disk type**: Balanced persistent disk  
- **Size**: 10 GB  

> ℹ️ Several images are available, including Debian, Ubuntu, CoreOS, and premium images such as Red Hat Enterprise Linux and Windows Server.



5. Click **Networking**.
In the **Firewall** section, enable:
   - ✅ **Allow HTTP traffic**

> 🛡️ **Note**: This automatically creates a firewall rule to allow HTTP traffic on port **80**.



6. Once all sections are configured, scroll down and click **Create**.

The VM instance **`gcelab`** will be created in about one minute.  
After creation, it will appear on the **VM Instances** page.



7. On the **VM Instances** page, click **SSH** next to the instance name **`gcelab`**.

This will open an SSH session directly in your browser.

> 📘 **Note**: For more information, see the Compute Engine guide:  
> **Connect to Linux VMs using Google tools**

---

### Step 2 Install an NGINX web server

1. Run the following command to update the OS:

```
sudo apt-get update
```

2. Run the following command to install NGINX:

```
sudo apt-get install -y nginx
```

3. Run the following command to confirm that NGINX is running:

```
ps auwx | grep nginx
```

4. To see the web page, return to the Cloud console and click the External IP link in the row for your machine, or add the External IP value to http://EXTERNAL_IP/ in a new browser window or tab.

### Step 3 Create a new instance with gcloud