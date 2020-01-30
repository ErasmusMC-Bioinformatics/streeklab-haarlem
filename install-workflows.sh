set -e

galaxy_instance="http://localhost:8080"

# launch the instance
echo " - Starting Galaxy.. \n"
startup_lite

# wait until galaxy has started
galaxy-wait -g $galaxy_instance

# run tutorial install as user galaxy
su - $GALAXY_USER

# install workflows
echo "installing workflows"
workflow-install -v --publish_workflows \
                 --workflow_path $GALAXY_HOME/workflows/ \
                 -g $galaxy_instance \
                 -u $GALAXY_DEFAULT_ADMIN_USER \
                 -p $GALAXY_DEFAULT_ADMIN_PASSWORD

echo "installed workflows:"
ls $GALAXY_HOME/workflows/
