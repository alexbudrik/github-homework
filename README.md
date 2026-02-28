# Домашнее задание к занятию "GitHub" - Alex Budrik

# Добавляем репозиторий GitLab
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh

# Устанавливаем GitLab
sudo EXTERNAL_URL="http://localhost:8080" apt-get install gitlab-ee -y

# Запускаем:
sudo gitlab-ctl reconfigure

# Настройка gitlab-runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt install gitlab-runner -y

# Установка Docker
sudo apt install -y docker.io
sudo usermod -aG docker gitlab-runner

# Регистрация раннера
Sudo gitlab-runner register

# Создаем .gitlab-ci.yml
image: alpine:latest

stages:
  - test

test_job:
  stage: test
  script:
    - echo "CI Runner успешно работает"
