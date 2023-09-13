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
