instance_configs = {
  instance1 = {
    ami_id         = "ami-0dee22c13ea7a9a67"
    instance_type  = "t3a.medium"
    key_name       = "renuka"
    user_data      = <<-EOF
        # #!/bin/bash

        # # Update ubuntu
        # sudo apt update -y
        # sudo hostname jenkins

        # # Install git
        # sudo apt install git -y

        # # Install Java OpenJDK 17
        # sudo apt install fontconfig openjdk-17-jre -y

        # # Install Jenkins
        # sudo apt update -y
        # sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
        # https://pkg.jenkins.io/debian/jenkins.io-2023.key
        # echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
        # https://pkg.jenkins.io/debian binary/ | sudo tee \
        # /etc/apt/sources.list.d/jenkins.list > /dev/null
        # sudo apt-get update
        # sudo apt-get install jenkins -y


        # # Install trivy
        # sudo apt-get install wget apt-transport-https gnupg lsb-release -y
        # wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
        # echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
        # sudo apt-get update
        # sudo apt-get install trivy -y

        # # Install Docker
        # sudo apt install docker.io -y

        # # Start Jenkins and Docker services
        # sudo systemctl start jenkins
        # sudo systemctl start docker

        # # Enable Jenkins and Docker to start on boot
        # sudo systemctl enable jenkins
        # sudo systemctl enable docker

        # # Add Jenkins user to the Docker group
        # sudo usermod -aG docker jenkins

        # # Restart Jenkins to apply changes (optional)
        # sudo systemctl restart jenkins

        # # Permissions for docker
        # sudo chmod 777 /var/run/docker.sock

        # # Install unzip and awscli
        # sudo apt install unzip -y
        # curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        # unzip awscliv2.zip
        # sudo ./aws/install

        # Sync jenkins backup bucket with jenkins home directory
        # sudo systemctl stop jenkins
        # sudo tar -zcvf backupname.tar.gz /var/lib/jenkins/
        # sudo aws s3 cp backupname.tar.gz s3://jenkins-backup-shubham/ --recursive

        # On New instance
        # sudo systemctl stop jenkins
        # sudo aws s3 sync s3://jenkins-backup-shubham/  /var/lib/jenkins/
        # sudo rm -rf /var/lib/jenkins/
        # sudo tar -zxvf backupname.tar.gz -C /
        # sudo systemctl start jenkins

        # cd /usr/lib/systemd/system/
        # vim jenkins.service to increase storage
        # sudo mkdir /mnt/jenkins-data
        # 18  sudo mount /dev/nvme1n1 /mnt/jenkins-data
        # 19  sudo systemctl stop jenkins
        # 20  sudo rsync -av /var/lib/jenkins/ /mnt/jenkins-data/
        # sudo chown -R jenkins:jenkins /mnt/jenkins-data
        # sudo systemctl start jenkins
        # 28  df -h /var/lib/jenkins
        # sudo ln -s /mnt/jenkins-data /var/lib/jenkins

        # sudo mkdir tmp
        # sudo chown -R jenkins:jenkins /mnt/jenkins-data/tmp
        # sudo mount --bind /mnt/jenkins-data/tmp /tmp
        # sudo rsync -av /tmp/ /mnt/jenkins-data/tmp/
        # 126  sudo umount /tmp
        # 127  sudo mount --bind /mnt/jenkins-data/tmp /tmp
        # 128  sudo systemctl restart jenkins
        # 129  sudo systemctl daemon-reload
        # 130  sudo systemctl restart jenkins
    EOF
    my_environment = "jenkins"
    enable_root_volume = true
    vpc_security_group_ids = [""]
  }
  instance2 = {
    ami_id         = "ami-0dee22c13ea7a9a67"
    instance_type  = "t2.medium"
    key_name       = "renuka"
    user_data      = <<-EOF
        # #!/bin/bash
        # set -e  # Exit on error
        # sudo apt update -y

        # # Install git
        # sudo apt install git -y
        # sudo groupadd --system prometheus
        # sudo useradd -s /sbin/nologin --system -g prometheus prometheus
        # sudo mkdir /etc/prometheus
        # sudo mkdir /var/lib/prometheus
        # wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz
        # tar vxf prometheus*.tar.gz
        # cd prometheus*/
        # sudo mv prometheus /usr/local/bin
        # sudo mv promtool /usr/local/bin
        # sudo chown prometheus:prometheus /usr/local/bin/prometheus
        # sudo chown prometheus:prometheus /usr/local/bin/promtool
        # sudo mv consoles /etc/prometheus
        # sudo mv console_libraries /etc/prometheus
        # sudo mv prometheus.yml /etc/prometheus
        # sudo chown prometheus:prometheus /etc/prometheus
        # sudo chown -R prometheus:prometheus /etc/prometheus/consoles
        # sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
        # sudo chown -R prometheus:prometheus /var/lib/prometheus
        # cat <<EOL | sudo tee /etc/prometheus/prometheus.yml
        # global:
        #   scrape_interval: 15s

        # scrape_configs:
        #   - job_name: 'prometheus'
        #     static_configs:
        #       - targets: ['localhost:9090']
        # EOL

        # cat <<EOL | sudo tee /etc/systemd/system/prometheus.service

        # [Unit]
        # Description=Prometheus
        # Wants=network-online.target
        # After=network-online.target

        # [Service]
        # User=prometheus
        # Group=prometheus
        # Type=simple
        # ExecStart=/usr/local/bin/prometheus \
        #     --config.file /etc/prometheus/prometheus.yml \
        #     --storage.tsdb.path /var/lib/prometheus/ \
        #     --web.console.templates=/etc/prometheus/consoles \
        #     --web.console.libraries=/etc/prometheus/console_libraries

        # [Install]
        # WantedBy=multi-user.target
        # EOL

        # # Start Prometheus
        # sudo hostname prom
        # sudo systemctl start prometheus
        # sudo systemctl enable prometheus

        # sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
        # sudo tar xzf node_exporter-1.7.0.linux-amd64.tar.gz
        # #Remove node_exporter-1.7.0.linux-amd64.tar.gz
        # # sudo rm -rf node_exporter-1.7.0.linux-amd64.tar.gz
        # sudo mkdir /etc/node_exporter
        # sudo mv node_exporter-1.7.0.linux-amd64 /etc/node_exporter/
        # # sudo touch /etc/systemd/system/node_exporter.service
        # cat <<EOL | sudo tee /etc/systemd/system/node_exporter.service
        # [Unit]
        # Description=Node Exporter
        # Wants=network-online.target
        # After=network-online.target

        # [Service]
        # ExecStart=/etc/node_exporter/node_exporter-1.7.0.linux-amd64/node_exporter
        # Restart=always

        # [Install]
        # WantedBy=multi-user.target
        # EOL

        # sudo systemctl daemon-reload
        # sudo systemctl enable node_exporter
        # sudo systemctl restart node_exporter
        # sudo apt install net-tools -y
        # sudo apt-get install -y apt-transport-https software-properties-common wget
        # sudo mkdir -p /etc/apt/keyrings/
        # wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
        # echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
        # echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
        # # Updates the list of available packages
        # sudo apt-get update
        # # Installs the latest OSS release:
        # sudo apt-get install grafana -y
        # sudo systemctl start grafana-server
        # sudo systemctl enable grafana-server
        EOF 
    my_environment = "prom"
    enable_root_volume = false
    vpc_security_group_ids = [""]
  }
  instance3 = {
    ami_id         = "ami-0dee22c13ea7a9a67"
    instance_type  = "t2.small"
    key_name       = "renuka"
    user_data      = <<-EOF
        
    EOF
    my_environment = "sonar"
    enable_root_volume = false
    vpc_security_group_ids = [""]
  }
  # instance4 = {
  #   ami_id         = "ami-0dee22c13ea7a9a67"
  #   instance_type  = "t2.small"
  #   key_name       = "renuka"
  #   user_data      = <<-EOF
        
  #   EOF
  #   my_environment = "ansible"
  #   enable_root_volume = false
  #   vpc_security_group_ids = [""]
  # }
  
}

bucket_configs = {
  bucket1 = {
    bucket_name = "jenkins-backup-shubham"
  }
}

vpc_cidr = "10.1.0.0/16"
subnet_cidr = "10.1.0.0/24"