## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Azure Network Diagram](../../tree/main/Diagrams/Azure-LB-WS-ELK-Deployment.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, subsets of these files may be used to install only certain pieces of it, such as Filebeat.

  - Ansible/install-dvwa-playbook.yml
  - Ansible/install-elk-playbook.yml
  - Ansible/install-filebeat-playbook.yml
  - Ansible/install-metricbeat-playbook.yml
  - ansible.cfg
  - hosts

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- The Azure Load Balancer in this deployment ensures access to the DWVA instances is highly available through a health probe, which probes port 80 of Web-1, Web-2 and Web-3 every 5 seconds as that is the port DVWA runs on. 
- In addition, the Azure Load Balancer prevents direct access to the VMs hosting the DVWA, reducing the attack surface.  
- The deployment also includes a jumb box. Remote access (via SSH) to the rest of the deployment is only allowed through the jump box, which again reduces the attack surface. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the filesystem and system resources.
- Filebeat watches for changes in system by monitoring log files or specific filesystem locations, collecting log events and forwarding to Elasticsearch for indexing. 
- Metricbeat periodically collects metrics from the operating system and from services running on the server, and ships them to Elasticsearch. 

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function  | IP Address | Operating System |
|----------|-----------|------------|------------------|
| Jump Box | Gateway   | 10.0.0.4   | Ubuntu 20.04 LTS |
| Web-1    | Webserver | 10.0.0.5   | Ubuntu 20.04 LTS |
| Web-2    | Webserver | 10.0.0.6   | Ubuntu 20.04 LTS |
| Web-3    | Webserver | 10.0.0.8   | Ubuntu 20.04 LTS |
| ELK      | ELK stack | 10.1.0.6   | Ubuntu 20.04 LTS |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 69.216.98.214 (local workstation public IP)

Machines within the 10.0.0.0/24 network can only be accessed by the jump host.
- The ELK VM, residing on a different virtual network (10.1.0.0/24), can be accessed by the jump host over SSH; this is made possible by virtual network peerings that forward traffic between 10.0.0.0/24 and 10.1.0.0/24 bidirectionally. 
- Additionally, the Kibana service on the ELK VM can accept connections from the Internet on port 5601. Access to Kibana is only allowed from 69.216.98.214 (local workstation public IP). 

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 69.216.98.214        |
| Web-1    | No                  | 10.0.0.4             |
| Web-2    | No                  | 10.0.0.4             |
| Web-3    | No                  | 10.0.0.4             |
| ELK      | Yes                 | 69.216.98.214        |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- Ansible is fast, consistent, and reliable (less error prone) compared to manual configuration. 

The playbook implements the following tasks:
- Configure sysctl to maximize the memory (or memory map areas) a process may have. 
- Udpate apt cache. 
- Install docker, PIP, and the docker python package.
- Install ELK stack container (sebp/elk image, version 761), start it, and make sure it's always restarted. 
- Configure systemd to always start the docker service when the VM boots. 

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![ELK Container Running](../../tree/main/Diagrams/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5
- 10.0.0.6
- 10.0.0.8

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat is configured to collect and parse syslog data from each machine, which, for example, allows us to track user logon events. 
- Metricbeat is configured to collect metrics about Docker containers, which, for example, allow us to monitor system resource utilization (e.g. CPU, memory and network bandwidth) by containers running on these machines.   

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the install-elk-playbook.yml, install-filebeat-playbook.yml, and install-metricbeat-playbook.yml files to /etc/ansible.
- Update the hosts file to include the IP address of the ELK server under the label "ELK" and the IP addresses of the machines to monitor under the label "webservers". 
- Update the ansible.cfg file with the username to use to login to the machines. 
- Run the playbook (ansible-playbook install-elk-playbook.yml), and navigate to http://<ELK_server_IP_address>:5601 to check that the installation worked as expected.