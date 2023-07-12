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
        string(name: 'reponame', defaultValue: 'hhk14', description: 'Specify docker repo name')
        string(name: 'imagename', defaultValue: 'my_java_app', description: 'Specify docker image name')
        string(name: 'imagetag', defaultValue: 'v1.0', description: 'Specify docker image tag')
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
        // stage('MVN: PI Test'){
        //     steps{
        //         script{
        //             piTest()
        //         }
        //     }
        //     post{
        //         always{
        //             pimutation mutationStatsFile: '**/target/pit-reports/**/mutations.xml'
        //         }
        //     }
        // }

        
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
        stage('MVN:DependencyCheck'){
            steps{
                
                    dependencyCheck additionalArguments: ' -o target/ -s ./target/*.jar -f ALL --prettyPrint', odcInstallation: 'DP-Check'
                    dependencyCheckPublisher pattern: 'target/dependency-check-report.xml'
                
            }
        }

        stage('DockerImage: Build'){
            steps{
                script{
                    dockerImageBuild("${params.reponame}","${params.imagename}", "${params.imagetag}")
                }
            }
            
        }

    }
}