variable "jenkins_job_name" {
  type        = string
  description = "The name of the Jenkins pipeline job."
}

variable "jenkins_job_description" {
  type        = string
  description = "The description of the Jenkins pipeline job."
}

variable "jfrog_repository_url" {
  type        = string
  description = "The URL of the JFrog repository to push artifacts."
}

variable "nexus_repository_url" {
  type        = string
  description = "The URL of the Nexus repository to push artifacts."
}

variable "rollback_script" {
  type        = string
  description = "The script to execute for rollback in case of failure."
}

variable "jenkins_job_script" {
  type        = string
  description = "The Jenkins pipeline script to define the stages."
}
