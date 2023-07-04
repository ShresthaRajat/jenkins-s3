pipeline {
    agent any

    stages {
        stage('Archive Files') {
            steps {
                script {
                    // Create a tar archive of all repository files
                    sh 'ls -al && pwd && touch repo_files.tar.gz'
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
                            credentialsId: 'aws-s3-full-access',        // Create this in credentials
                            // Create a credentails from (http://localhost:8080/user/admin/credentials/)
                            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                        ]]
                    )
                    /* groovylint-disable-next-line NestedBlockDepth */
                    {
                        // Upload the tar archive to S3
                        s3Upload consoleLogLevel: 'INFO',
                        dontSetBuildResultOnFailure: false,
                        dontWaitForConcurrentBuildCompletion: false,
                        entries: [[
                            bucket: 'jenkinsartifactbucket',            // change bucket name
                            excludedFile: '',
                            flatten: false,
                            gzipFiles: false,
                            keepForever: false,
                            managedArtifacts: true,
                            noUploadOnFailure: false,
                            selectedRegion: 'eu-west-1',                // select bucket region
                            showDirectlyInBrowser: true,
                            sourceFile: 'repo_files.tar.gz',                         // artifact files
                            storageClass: 'STANDARD',
                            uploadFromSlave: false,
                            useServerSideEncryption: false
                        ]],
                        pluginFailureResultConstraint: 'FAILURE',
                        profileName: 'latest-profile',                  // create this after installing s3 plugin
                        // create profile from this link, look at the end(http://localhost:8080/manage/configure)
                        userMetadata: []
                    }
                }
            }
        }
    }
}
