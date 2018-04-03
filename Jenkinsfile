pipeline {
  agent any
  stages {
    stage('Test') {
      steps {
        sh '''#!/bin/bash -l

type rvm | head -1'''
      }
    }
  }
}