env.POSTGRES_USER = 'postgres'
env.POSTGRES_PASSWORD = '123456789'
env.PORT = 3000

node {
  stage("Set up RVM Component") {
    sh '''#!/bin/bash -l

      rvm use 2.5.0'''
  }

  stage("Bundle Install") {
    sh '''#!/bin/bash -l

      rvm use 2.5.0

      gem install bundler

      bundle install

      rails db:create

      rails db:migrate

      rspec'''
  }

  stage("Build Staging") {
    environment { 

    }
    try {
      if(env.BRANCH_NAME == 'develop') {
        sh "docker-compose build"
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
