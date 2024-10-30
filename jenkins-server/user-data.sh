#!/bin/bash

# 更新系统软件包
sudo yum update -y
# 安装 Java（Jenkins 依赖 Java）
sudo amazon-linux-extras install java-openjdk11 -y
# 添加 Jenkins 的官方存储库并导入 GPG 密钥
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# 安装 Jenkins
sudo yum install jenkins -y
# 启动并启用 Jenkins 服务
sudo systemctl start jenkins
sudo systemctl enable jenkins
# 检查 Jenkins 状态（可选）
sudo systemctl status jenkins
# 输出初始管理员密码位置
echo "Jenkins 安装完成！初始管理员密码位于 /var/lib/jenkins/secrets/initialAdminPassword 文件中。"

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