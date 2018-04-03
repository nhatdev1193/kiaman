pipeline {
  agent any
  stages {
    stage('Test') {
      agent any
      steps {
        sh '''#!/bin/bash -l

type rvm | head -1'''
        sh 'rvm install 2.5.0'
        sh 'gem install bundler'
        sh 'bundle'
        sh 'rails db:create'
        sh 'rails db:migrate'
        sh 'rspec'
      }
    }
  }
}