@Library('my-shared-library') _
pipeline
{
    agent any
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
    }
}