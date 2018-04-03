pipeline {
  agent any
  stages {
    stage('Test') {
      steps {
        sh 'rvm use 2.5.0'
        sh 'set -e'
        sh 'rails db:create'
        sh 'rails db:migrate'
        sh 'rspec'
      }
    }
  }
}