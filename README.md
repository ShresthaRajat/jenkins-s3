1. Install `S3 publisher plugin` & `CloudBees AWS Credentials Plugin` plugin
2. Create s3 profile and check the permissions of access keys then save the profile. `http://localhost:8080/manage/configure` (note the profile name at the end of the page)
3. Create aws credentials `http://localhost:8080/user/admin/credentials/` and note the name
4. Create pipeline with customized jenkins file. (change the profile, bucketname, credentials id, and other details)
5. trigger build.