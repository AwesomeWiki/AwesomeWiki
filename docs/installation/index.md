# Prerequisites

We use [Ansible](https://ansible.com) to provision a server to run AwesomeWiki.

## Install Ansible

The [Ansible installation guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html) should provide some instructions on how to install Ansible on your local machine. You'll need to run the Ansible control node locally to set up a remote server

Please note that Ansible does not work natively on Windows. If you are using Windows, please set up the [Windows Subsystem for Linux](https://ubuntu.com/wsl) on your local machine, and then follow the installation instructions for Ubuntu.

# Requirements:

To run an AwesomeWiki server, you'll need a server running Ubuntu 20.04, with ports 80 and 443 opened, to allow incoming HTTP(S) traffic.

# High-Level Overview

The Ansible playbook contains many different plays that set up the application. The following is a high level overview of what these plays do when configuring the server. If you'd like to skip this overview and go straight to installation, [click here](#installation).

### \_all.yml

This is the yaml file you will use directly when running `ansible-playbook`.
The line _hosts: sdc_ references the configuration in your Installation Step 1, where you specify your host.
Below the host are the tasks that Ansible is going to run.

### setup-postgres.yml

This will update apt to use postgres repository and then install Postgres and Multicorn. Once they are installed, it will create the `awesome` database, the `api` schema, and then install the Multicorn extension on the database and schema you just created.

### setup-postgrest.yml

This will download and extract PostgREST our REST API for Postgres. It will also create Postgres roles and user accounts (creates the web_anon group, grant permissions to that group, create authenticator user, and add authenticator to the web_anon group) to handle PostgREST requests. Next, it will copy the PostgREST configuration file from `setup-postgrest/awesome.conf` to `/var/postgrest/awesome.conf`. Last, it will add PostgREST as a systemd service that runs on startup.

### setup-redis.yml

This will download Redis, copy configuration from `setup-redis/redis.conf` to `/etc/redis/redis.conf` (with proper permissions), and ensure it is running as a systemd service.

### install-sqitch.yml

This will install sqitch (our SQL dependency management tool).

### clone-application.yml

This will clone the AwesomeWiki repository to `/var/Awesome`. Before cloning the repository, it will install git. Moreover, it will grab the `ansible_user` and `github_personal_token` from your Installation Step 1 configuration. The defualt branch it will clone is master.

### install-application-fdw.yml

This will overwrite remote FDW with the local version you currently have in your local machine. Afterward, it will install pip, python libraries (setuptools, requests, redis, and python-slugify), and AwesomeWiki FDWs.

### provision-db.yml

This will overwrite remote Sqitch with the local version you currently have in your local machine. Next, it will run deploy the database and then rebase (revert and redeploy) the database.

### setup-client-app.yml

This will clone the AwesomeWiki repository to `/var/Awesome`. Before cloning the repository, it will install git. Moreover, it will grab the `ansible_user` and `github_personal_token` from your Installation Step 1 configuration. The defualt branch it will clone is master.

### setup-nginx.yml

This install Nginx, configure open firewall ports, enable firewall. Then disable default site, copy Nginx congifuration for awesome-client, enable site for awesome-client, and restart nginx to pick up the changes.

### \_redeploy-fdw.yml

This will run the install-application-fdw.yml, provision-db.yml, restart PostgreSQL and PostgREST to pick up the new changes that developer made without running setup for difference services.

### \_setup-nginx.yml

This will run the setup-nginx.yml to set up the nginx.

# Installation

## Step 1

Edit **/etc/ansible/hosts** file (on your local machine), as a **root** user
<br /> Below is the example, cite from [ansible/ansible GitHub](https://github.com/ansible/ansible/blob/devel/examples/hosts.yaml):

```ansible
# This is the default ansible 'hosts' file.
#
# It should live in /etc/ansible/hosts
#
#   - Comments begin with the '#' character
#   - Blank lines are ignored
#   - Groups of hosts are delimited by [header] elements
#   - You can enter hostnames or ip addresses
#   - A hostname/ip can be a member of multiple groups

# Ex 1: Ungrouped hosts, specify before any group headers.

## green.example.com
## blue.example.com
## 192.168.100.1
## 192.168.100.10

# Ex 2: A collection of hosts belonging to the 'webservers' group

## [webservers]
## alpha.example.org
## beta.example.org
## 192.168.1.100
## 192.168.1.110
[sdc]
#XXX uncomment only your own host
"host"

[sdc:vars]
ansible_user="github username"
ansible_password="password"
ansible_become_password={{ansible_password}}
github_personal_token="personal_access_token_generated_from_github"

# If you have multiple hosts following a pattern you can specify
# them like this:

## www[001:006].example.com

# Ex 3: A collection of database servers in the 'dbservers' group

## [dbservers]
##
## db01.intranet.mydomain.net
## db02.intranet.mydomain.net
## 10.25.1.56
## 10.25.1.57

# Here's another example of host ranges, this time there are no
# leading 0s:

## db-[99:101]-node.example.com
```

1. In the **sdc** section, replace `"host"` with the hostname of the server you're provisioning.
2. In the **sdc:vars** section,
    - replace "github username", with your own github username
    - replace "password", with your own passsowrd
    - replace "personal_access_token_generated_from_github", with your own github personal token. For creating a GitHub personal access token, please reference the [GitHub Docs](<https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token#:~:text=Personal%20access%20tokens%20(PATs)%20are,you%20must%20authorize%20the%20PAT.>)

## Step 2 (Enabling "world readable tempfiles")

Due to our practice using an unprivileged user to log in and switching which user account we're using to run certain commands (for the database work), we need to enable Ansible's world-readable tempfiles setting. To do this, edit the line

```
#allow_world_readable_tmpfiles = False
```

to

```
allow_world_readable_tmpfiles = True
```

in **ansible.cfg**. More information about why this is necessary is available in the [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/become.html#becoming-an-unprivileged-user).

## Step 3 (Instructions to add authorized keys to known_hosts)

If you've never SSHed into the server you're provisioning, run the following command:

```
ssh-keyscan -H "host" >> ~/.ssh/known_hosts
```

This will save the host keys for the `"host"` server as a "known host", allowing Ansible to log into it during provisioning without any errors. (Please replace `"host"` to your own host.)

## Step 4 (Test your Ansible setup)

1. Run `ansible sdc -m ping`
2. Run `ansible sdc -a "/bin/echo hello"`

Both should print non error results

## Step 5 (Run the Ansible playbook)

-   Master Branch
    1. cd to the root of our repository (cloned on your control node, your local laptop)
    2. Run `ansible-playbook ansible/_all.yml`
-   Other Branch
    1. cd to the root of our repository (cloned on your control node, your local laptop)
    2. Run `ansible-playbook ansible/_all.yml --extra-vars "branch=branchname"` replacing branchname with your preferred branch name

# Verification Plan

To verify that the installation is successful, complete one or more of the following options:

1.  Browse to the server in your browser and make sure the application is up and running.
2.  Run the Postman API tests (located in the `postman/` directory in the root of the repository)
3.  Test the PostgreSQL database directly:
    -   SSH into the VM
    -   `sudo su postgres`
        ` `psql awesome`
    -   Run some test queries.
        -   For example: `select \* from api.awesome_python;`
4.  Run the Sqitch verify scripts
    -   SSH into the VM
    -   `sudo su postgres`
    -   `cd /var/AwesomeWiki/db`
    -   `sqitch verify db:pg:awesome -f awesome.plan`
