# Prerequisites

## Install Ansible for your operation system!
Follow the [Ansible installation guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html) on how to install Ansible on your local machine.

Please note that Ansible does not work well on Windows. If you are using Windows, please set up [WSL](https://ubuntu.com/wsl) on your local machine.  

## Requirements:

1. Ubuntu 20.04
2. port 80 and 81 opened

## Step 1
Edit **/etc/ansible/hosts** file , as a **root** user
<br /> Below is the example, cite from [ansible/ansible GitHub](https://github.com/ansible/ansible/blob/devel/examples/hosts.yaml):
```
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

1. In the **sdc** section, replace host to your own host.
2. In the **sdc:vars** section, 
   * replace "github username", with your own github username
   * replace "password", with your own passsowrd
   * replace "personal_access_token_generated_from_github", with your own github personal token. For creating github person token, please follow the [GitHub Docs](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token#:~:text=Personal%20access%20tokens%20(PATs)%20are,you%20must%20authorize%20the%20PAT.)

## Step 2 (Enabling "world readable tempfiles")
<br /> Due to us using an unprivileged user to log in and switching which user account we're using to run certain commands (for the database work), we need to enable world-readable tempfiles. To do this, edit the line 

```
#allow_world_readable_tmpfiles = False
```
to
```
allow_world_readable_tmpfiles = True
```
in **ansible.cfg**. More information about why this is necessary is available in the [Ansible Docs](https://docs.ansible.com/ansible/latest/user_guide/become.html#becoming-an-unprivileged-user).

## Step 3 (Instructions to add authorized keys to known_hosts)
Run the following command: 
```
ssh-keyscan -H "host" >> ~/.ssh/known_hosts
```
Please replace **host** to your own host

## Step 4 (Test your Ansible setup)
1. Run ```ansible sdc -m ping```
2. Run ```ansible sdc -a "/bin/echo hello"```

<br /> Both should print non error results

## Step 5 (Run the Ansible playbook)

* Master Branch
  1. cd to the root of our repository (cloned on your control node, your local laptop)
  2. Run ```ansible-playbook ansible/_all.yml```
* Other Branch
  1. cd to the root of our repository (cloned on your control node, your local laptop)
  2. Run ```ansible-playbook ansible/_all.yml --extra-vars "branch=branchname"``` replacing branchname with your preferred branch name
  
 
 # Verification Plan
 The followins are the options to verify the installation is successful:
 
 1. Browse to the application endpoit and make sure the application is up and running.
 2. Run the postman API test
 3. Postgres testing
    * ssh into the vm
    * sudo su postgres
    * psql awesome
    * run some test queries. 
       * For example: select * from api.awesome_python;
 4. run verify scripts
    * sudo su postgres
    * cd db
    * sqitch verify db:pg:awesome -f awesome.plan
