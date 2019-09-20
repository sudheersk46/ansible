---
- hosts: oracle
  gather_facts: yes
#  remote_user: root
  
  tasks:

  - name: checking date
    shell: echo $(date +"%F %T")
    register: dat
  - debug: var=dat.stdout
  - debug: msg={{ ansible_default_ipv4.address }}
    delegate_to: 127.0.0.1
  
  - name: Getting logs
    shell: "ls -rt /home//oracle_logs | tail -n 1"
    register: logv
  - debug: var=logv.stdout
  
  - name: Getting logs1
    shell: "ls -rt /home//oracle_logs | tail -n 2 | head -n 1"
    register: logv1
  - debug: var=logv1.stdout
  
#  - name: files i\\ nlog
#    fetch: src="{{ logv.stdout }}" dest=/home//oracle_logs/mmmm
#    register: filec
#  - debug: var=filec.stdout
#    delegate_to: 127.0.0.1
  
#  - name: xe file
#    shell: "cat  /home//oracle_logs/mmmm | head -n 1"
#    register: xe
#  - debug: var=xe.stdout
#    delegate_to: 127.0.0.1



  
#  - name: 11g file
#    shell: "cat  /home//oracle_logs/mmmm | tail -n 1"
#    register: org
#  - debug: var=org.stdout
#    delegate_to: 127.0.0.1

#  - name: makedir
#    shell: mkdir /home//oracle_logs/{{ dat.stdout }}
#     ignore_errors: yes
#    register: mkd
#    delegate_to: 127.0.0.1
#  - debug: var=mkd.stdout
#  - name: make dir
  - name: Create a directory if it does not exist
    file:
     path: /home//oracle_logs/{{ dat.stdout }}
     force: yes
     state: directory
     mode: '0755'
    register: mkd
    delegate_to: 127.0.0.1    
  - debug: var=mkd.stdout
  
  - name: xe copy
    fetch: src=/home//oracle_logs/{{ item }} dest=/home//oracle_logs/{{ dat.stdout }}
    register: xec
    with_items:
       - "{{ logv1.stdout }}"
#    register: orgct
       - "{{ logv.stdout }}"
  - debug: var=xec.stdout

#  - name: 11g copy
#    fecth: src=/home//oracle_logs/{{ logv1.stdout }} dest=/tmp
#    register: orgc
#  - debug: var=orgc.stdout

#   - name: mkdir
##     shell: mkdir {{ dat.stdout }}
#     ignore_erros: yes


  - name: test logs
    shell: |           
            uu=$(ls -rt /home//oracle_logs | tail -n 1)
            echo $uu
    register: hh
    delegate_to: 127.0.0.1
  - debug: var=hh.stdout
  
  - name: cat logs
    shell: |
          ty=/home//oracle_logs
          uu=$(ls -rt /home//oracle_logs | tail -n 1)
          echo $uu
          echo hello
          echo > /tmp/testdb2

          echo >> /tmp/testdb2 
          echo >> /tmp/testdb2


          echo "###########################Oracle XE backup status######################" >> /tmp/testdb2


          cat "$ty"/"$uu"/192.168.6.34/*/*/*/backup_XE* | head -n 2 >> /tmp/testdb2

          cat "$ty"/"$uu"/192.168.6.34/*/*/*/backup_XE* | grep -A10 'database mounted' >> /tmp/testdb2 

          cat /"$ty"/"$uu"/*/*/*/*/backup_XE* | grep -i "number=" | cut -d '=' -f2,3 | sort | awk -F '/' '{print $1,$NF}' >> /tmp/testdb2

          cat "$ty"/"$uu"/192.168.6.34/*/*/*/backup_XE* | grep -i "finished" | tail -n 2 >> /tmp/testdb2

          cat "$ty"/"$uu"/192.168.6.34/*/*/*/backup_XE* | tail -n 2 >> /tmp/testdb2


          echo >> /tmp/testdb2
          echo >> /tmp/testdb2
          echo >> /tmp/testdb2
          echo >> /tmp/testdb2

          echo "##########################Oracle 11g backup status########################"  >> /tmp/testdb2


          cat /home//oracle_logs/"$uu"/192.168.6.34/*/*/*/backup_irtek* | head -n 2 >> /tmp/testdb2

          cat /home//oracle_logs/"$uu"/192.168.6.34/*/*/*/backup_irtek* | grep -A10 'database mounted' >> /tmp/testdb2

          cat "$ty"/"$uu"/*/*/*/*/backup_irtek* | grep -i "number=" | cut -d '=' -f2,3 | sort | awk -F '/' '{print $1,$NF}' >> /tmp/testdb2

          cat "$ty"/"$uu"/192.168.6.34/*/*/*/backup_irtek* | grep -i "finished" | tail -n 2 >> /tmp/testdb2

          cat "$ty"/"$uu"/192.168.6.34/*/*/*/backup_irtek* | tail -n 2 >> /tmp/testdb2    
          
    register: log
    delegate_to: 127.0.0.1
  - debug: var=log.stdout
    
    
    
  - name: log ouptut
    shell: cat /tmp/testdb2
    delegate_to: 127.0.0.1
    ignore_errors: yes
    register: out
  - debug: var=out.stdout_lines
  
  - name: Send e-mail to a bunch of users, attaching files
    mail:
     host: smtp.gmail.com
     port: 587
     username: username@gmail.com
     password: password@4321
     to: username <username@.com>
     subject: Ansible-oracle-report
#     from: username@.com 
#     to:
#     - username <username@.com>
#    - Suzie Something <sue@example.com>
#    cc: Charlie Root <root@localhost>
     attach:
     - /tmp/testdb2
#    - /tmp/avatar2.png
#    headers:
#    - Reply-To=john@example.com
#    - X-Special="Something or other"
#    charset: us-ascii
     delegate_to: localhost
     
     
     
     
     
     
     
     
     
     
     
     
     
