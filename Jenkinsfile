pipeline {
  agent any
  stages {
    stage('Test') {
      steps {
        sh '''rvm use 2.5.0
set -e
bundle install'''
        sh '''rails db:create
rails db:migrate'''
        sh 'rspec'
      }
    }
  }
}