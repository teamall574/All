variable "jenkins_job_name" {
  type = string
}

variable "jenkins_job_description" {
  type = string
}

variable "jenkins_job_repository" {
  type = string
}

variable "jenkins_job_branch" {
  type = string
}

variable "jenkins_job_credentials_id" {
  type = string
}

variable "jfrog_repository_url" {
  type = string
}

variable "nexus_repository_url" {
  type = string
}

variable "rollback_script" {
  type = string
}

resource "jenkins_job" "pipeline_job" {
  name         = var.jenkins_job_name
  description  = var.jenkins_job_description
  keep_dependencies = false

  configuration = <<EOF
<flow-definition plugin="workflow-job@2.40">
  <description>${var.jenkins_job_description}</description>
  <definition class="org.jenkinsci.plugins.workflow.cps.CpsFlowDefinition" plugin="workflow-cps@2.85">
    <script>${var.jenkins_job_script}</script>
    <sandbox>true</sandbox>
  </definition>
  <triggers />
  <quietPeriod>0</quietPeriod>
  <properties />
  <disabled>false</disabled>
  <dsl>
    <scriptApproval plugin="script-security@1.80">
      <approvedScriptHashes />
      <approvedScripts />
      <approvedSignatures />
      <pendingScripts />
      <pendingSignatures />
    </scriptApproval>
  </dsl>
  <additionalClasspath />
  <ignoreMissingFiles>false</ignoreMissingFiles>
</flow-definition>
EOF
}

resource "jenkins_multibranch_pipeline" "pipeline_multibranch" {
  name = var.jenkins_job_name

  branch_source {
    source {
      type             = "git"
      id               = var.jenkins_job_credentials_id
      credentials_id   = var.jenkins_job_credentials_id
      remote           = var.jenkins_job_repository
      includes         = var.jenkins_job_branch
      excludes         = "*"
      build_strategies = ["jenkins.pipeline.BehaviorBranchMergeStrategy"]
    }
  }
}

resource "jenkins_job_trigger" "pipeline_job_trigger" {
  job_name = jenkins_job.pipeline_job.name
  trigger {
    upstream_job     = var.jenkins_upstream_job_name
    upstream_project = var.jenkins_upstream_project
    threshold        = "SUCCESS"
  }
}

resource "jenkins_multibranch_pipeline_trigger" "pipeline_multibranch_trigger" {
  pipeline_job_id = jenkins_multibranch_pipeline.pipeline_multibranch.id
  triggers        = [jenkins_job_trigger.pipeline_job_trigger.id]
}

locals {
  jenkins_job_script = <<-EOF
    pipeline {
      agent any
      stages {
        stage('Checkout') {
          steps {
            checkout scm
          }
        }
        stage('Build') {
          steps {
            // Your build steps here
          }
        }
        stage('Push Artifacts to JFrog') {
          steps {
            // Your steps to push artifacts to JFrog here
          }
        }
        stage('Push to Nexus') {
          steps {
            // Your steps to push to Nexus here
          }
        }
        stage('Execute Script') {
          steps {
            // Your steps to execute the script here
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
