oc new-app --template=eap73-basic-s2i \
 -p IMAGE_STREAM_NAMESPACE=testrest \
 -p SOURCE_REPOSITORY_URL=https://github.com/jlmaieron/OpenShift-AppTest \
 -p SOURCE_REPOSITORY_REF=7.3.x-openshift \
 -p CONTEXT_DIR=bpm-test-proj \
 -e ADMIN_USERNAME=myspecialuser \
 -e ADMIN_PASSWORD=myspecialp@ssw0rd