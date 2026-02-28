# GitLab

Alex Budrik


    Разверните GitLab локально, используя Vagrantfile и инструкцию, описанные в этом репозитории.
    Создайте новый проект и пустой репозиторий в нём.
    Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме Docker. Раннер можно регистрировать и запускать на той же виртуальной машине, на которой запущен GitLab.


# Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian13"
  config.vm.network "forwarded_port", guest: 80, host: 8080
end

# curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

# sudo EXTERNAL_URL="http://localhost:8080" apt-get install gitlab-ee -y

# sudo gitlab-ctl reconfigure

# Установка Docker
sudo apt install -y docker.io
sudo usermod -aG docker gitlab-runner

# Регистрация раннера
Sudo gitlab-runner register

# Создаем .gitlab-ci.yml

В проект добавляем:
image: alpine:latest
stages:
  - test
test_job:
  stage: test
  script:
    - echo "CI Runner успешно работает"
