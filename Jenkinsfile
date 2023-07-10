@Library('my-shared-library') _
pipeline
{
    agent any
    tools{
        maven 'maven3'
    }
    parameters
    {
        string(name: 'branch', defaultValue: 'main', description: 'Specify git branch')
        string(name: 'url', defaultValue: 'https://github.com/hhk14/jenkins-maven-web-app.git', description: 'Specify git repo url')
    }

    stages
    {
        stage('Git :Checkout')
        {
            steps
            {
                script
                {
                    gitCheckOut(
                        branch: "${params.branch}",
                        url: "${params.url}"
                    )
                }
                
            }   
        }

        stage('MVN: UnitTest'){
            steps{
                script{
                    mvnTest()
                }
            }
            post{
                always{
                    junit "target/surefire-reports/*.xml"
                    jacoco execPattern: "target/jacoco.exec"
                }
            }
                
        }

        stage('MVN: IntegrationTest'){
            steps{
                script{
                    mvnIntegrationTest()
                }
            }
                
        }

        stage('StaticCodeAnanalysis: SonarQube'){
            steps{
                
                script{
                    def sonartoken='sonar-jenkins'
                    staticCodeCheck(sonartoken)
                }
            }
        }

        stage('Quality Gate Status: SonarQube'){
            steps{
                script{
                    def sonartoken='sonar-jenkins'
                    def sonarqualitygatetoken='sonar-quality-gate-id'
                    sonarQualityGateCheck(sonartoken,sonarqualitygatetoken)
                }
            }
        }

        stage('MVN: Build'){
            steps{
                script{
                    mvnBuild()
                }
            }
        }

    }
}