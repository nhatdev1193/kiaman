pipeline {
  agent any
  stages {
    stage('Test') {
      agent any
      steps {
        sh '''#!/bin/bash -l

# Use the correct ruby

rvm install 2.5.0

# Set "fail on error" in bash

set -e

# Do any setup

# e.g. possibly do \'rake db:migrate db:test:prepare\' here

bundle install

# Finally, run your tests
rails db:migrate'''
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