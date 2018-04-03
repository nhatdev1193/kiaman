pipeline {
  agent any
  stages {
    stage('Test') {
      agent any
      steps {
        sh '''#!/bin/bash -l

rvm install 2.5.0'''
        sh '''#!/bin/bash -l

gem install bundler'''
        sh '''#!/bin/bash -l

bundle install'''
        sh '''#!/bin/bash -l

rails db:create'''
        sh '''#!/bin/bash -l

rails db:migrate'''
        sh '''#!/bin/bash -l

rspec'''
      }
    }
  }
}