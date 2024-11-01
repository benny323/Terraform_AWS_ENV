#!/bin/bash

# 更新系统软件包
sudo yum update -y
sudo yum install wget -y
# 安装 Java（Jenkins 依赖 Java）
sudo yum install fontconfig java-17-openjdk -y
# 添加 Jenkins 的官方存储库并导入 GPG 密钥
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
# 安装 Jenkins
sudo yum install jenkins -y
sudo systemctl daemon-reload

# 启动并启用 Jenkins 服务
sudo systemctl enable jenkins
sudo systemctl start jenkins
# 检查 Jenkins 状态（可选）
sudo systemctl status jenkins


#--Terraform
# 下载 Terraform 的最新版本（在 HashiCorp 官方页面查看最新版本号替换）
TERRAFORM_VERSION="1.6.0"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
# 解压 Terraform 并移动到系统路径
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
# 检查 Terraform 安装版本
terraform -version
# 清理下载的文件
echo "Terraform 安装完成！"

#--awsCLi
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# 解压安装包
unzip awscliv2.zip
# 安装 AWS CLI
sudo ./aws/install
# 检查安装是否成功
aws --version
#after install: $aws configure (then give accessKey and ID)