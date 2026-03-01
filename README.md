Задание 1

Что нужно сделать:

    Разверните GitLab локально, используя Vagrantfile и инструкцию, описанные в этом репозитории.
    Создайте новый проект и пустой репозиторий в нём.
    Зарегистрируйте gitlab-runner для этого проекта и запустите его в режиме Docker. Раннер можно регистрировать и запускать на той же виртуальной машине, на которой запущен GitLab.

В качестве ответа в репозиторий шаблона с решением добавьте скриншоты с настройками раннера в проекте.

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

![runner](https://github.com/alexbudrik/github-homework/blob/main/screenshots/Screenshot%202026-02-28%20212645.png)

Задание 2

Что нужно сделать:

    Запушьте репозиторий на GitLab, изменив origin. Это изучалось на занятии по Git.
    Создайте .gitlab-ci.yml, описав в нём все необходимые, на ваш взгляд, этапы.

В качестве ответа в шаблон с решением добавьте:

    файл gitlab-ci.yml для своего проекта или вставьте код в соответствующее поле в шаблоне;
    скриншоты с успешно собранными сборками.

# origin указывает на локальный GitLab:
origin  http://localhost:8181/root/sdvps-materials.git

# изменить origin, команда была бы:
git remote set-url origin http://localhost:8181/root/sdvps-materials.git

# push
git push -u origin main

# Создать .gitlab-ci.yml

stages:
  - build
  - test

variables:
  DOCKER_DRIVER: overlay2

before_script:
  - echo "Pipeline started"

build_job:
  stage: build
  image: docker:latest
  services:
    - docker:dind
  script:
    - echo "Building project..."
    - docker info

test_job:
  stage: test
  image: alpine:latest
  script:
    - echo "Running tests..."
    - echo "Tests passed"


 
