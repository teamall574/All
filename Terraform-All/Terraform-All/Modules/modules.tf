module "jenkins_pipeline" {
  source = "./path/to/your/module"

  jenkins_job_name         = "my-pipeline"
  jenkins_job_description  = "My Jenkins pipeline"
  jenkins_job_repository   = "https://github.com/your/repo.git"
  jenkins_job_branch       = "main"
  jenkins_job_credentials_id = "your-jenkins-credentials-id"
  jfrog_repository_url     = "https://your.jfrog.repo"
  nexus_repository_url     = "https://your.nexus.repo"
  rollback_script          = <<EOF
// Your rollback script here
EOF
}
