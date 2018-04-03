node {

  checkout scm

  stage("Set up RVM Component") {
    sh '''#!/bin/bash -l

      rvm use 2.5.0'''
  }

  stage("Bundle Install") {
    sh '''#!/bin/bash -l

      gem install bundler

      bundle install'''
  }

  stage("Create DB") {
    sh '''#!/bin/bash -l

      rails db:create'''
  }

  stage("Migrate DB") {
    sh '''#!/bin/bash -l

      rails db:migrate'''
  }

  stage("Testing") {
    sh '''#!/bin/bash -l

      rspec'''
  }

  stage("Build Staging") {
    try {
      if(env.BRANCH_NAME == 'develop') {
        sh "docker build -t app ."
        sh "docker rm -f app || true"
        sh "docker run -e PORT=3000 -e DB_HOST=192.168.12.187 -d -p 3000:3000 --name=app app"
      }
    }
    catch(e) {
      error "Build Staging server failed"
    }
  }

  stage("Build Production") {
    try {
      if(env.BRANCH_NAME == 'master') {
        sh "docker-compose build"
      }
    }
    catch(e) {
      error "Build production server failed"
    }
  }
}
