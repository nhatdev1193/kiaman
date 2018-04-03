pipeline {
  agent any
  stages {
    stage('Test') {
      agent any
      steps {
        sh '''#!/bin/bash -l

rvm install 2.5.0'''
        sh 'ruby -v'
      }
    }
  }
}