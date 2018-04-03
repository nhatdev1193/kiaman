pipeline {
  agent any
  stages {
    stage('Test') {
      agent any
      steps {
        sh '''#!/bin/bash -l

rvm use 2.5.0

gem install bundler

bundle install

rails db:create

rails db:migrate

rspec'''
        sh 'ruby -v'
      }
    }
  }
}