module "jenkins_pipeline" {
  source = "./path/to/your/module"

  jenkins_job_name        = "my-pipeline"
  jenkins_job_description = "My Jenkins pipeline"
  jfrog_repository_url    = "https://your.jfrog.repo"
  nexus_repository_url    = "https://your.nexus.repo"
  rollback_script         = <<EOF
// Your rollback script here
EOF
  jenkins_job_script = <<-EOF
pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        // Checkout from source control
        git 'https://github.com/teamall574/test.git'
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean install'
      }
    }
    stage('Push Artifacts to JFrog') {
      steps {
        sh 'mvn clean package sonar:sonar' #it will send the code into the sonarqube
      }
    }
    stage('Push to Nexus') {
      steps {
        sh 'mvn clean package sonar:sonar' #it will send the code into the sonarqube
      }
    }
    stage('Execute Script') {
      steps {
        sh 'bash test.sh'
      }
    }
  }
  post {
    always {
      script {
        // Your rollback script here
        ${var.rollback_script}
      }
    }
  }
}
EOF
}
