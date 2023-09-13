resource "jenkins_job" "pipeline_job" {
  name        = var.jenkins_job_name
  description = var.jenkins_job_description

  configuration = templatefile("${path.module}/pipeline_job.xml", {
    jenkins_job_script      = var.jenkins_job_script
    jfrog_repository_url    = var.jfrog_repository_url
    nexus_repository_url    = var.nexus_repository_url
    rollback_script         = var.rollback_script
  })
}
