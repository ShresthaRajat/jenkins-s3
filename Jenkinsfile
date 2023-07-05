pipeline {
    agent any

    stages {
        stage('Archive Files') {
            steps {
                script {
                    // Create a tar archive of all repository files
                    sh 'ls -al && pwd && touch repo_files.tar.gz'
                    sh 'touch 1.zip 2.zip'
                    sh 'mkdir dist'
                    sh 'touch dist/3.zip'
                }
            }
        }

        stage('Push to S3') {
            steps {
                script {
                    withCredentials(
                        [[
                            $class: 'AmazonWebServicesCredentialsBinding',
                            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                            credentialsId: 'aws-s3-full-access',                        // Create this in credentials
                            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                        ]]
                    ){
                        // Upload the tar archive to S3
                        s3Upload consoleLogLevel: 'INFO',
                        dontSetBuildResultOnFailure: false,
                        dontWaitForConcurrentBuildCompletion: false,
                        entries: [[
                            bucket: 'jenkinsartifactbucket',                            // change bucket name
                            excludedFile: '',
                            flatten: false,
                            gzipFiles: false,
                            keepForever: false,
                            managedArtifacts: true,
                            noUploadOnFailure: false,
                            selectedRegion: 'eu-west-1',                                // select bucket region
                            showDirectlyInBrowser: true,
                            sourceFile: '**/*.zip',                                     // artifact files
                            storageClass: 'STANDARD',
                            uploadFromSlave: false,
                            useServerSideEncryption: false
                        ]],
                        pluginFailureResultConstraint: 'FAILURE',
                        profileName: 'latest-profile',                                  // create this after installing s3 plugin
                        userMetadata: []
                    }
                }
            }
        }
    }
}
