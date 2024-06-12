#!/bin/bash

#function to clone github code
clone_code() {
        if git clone https://github.com/LondheShubham153/django-notes-app.git; then
                return 0
        else
                if [ -d "django-notes-app" ]; then
                        cd django-notes-app
                        return 0
                else
                        echo "Failed to clone the repository"
                        return 1
                fi
        fi
}

#function to install requirements
install_req() {
        echo "Installing requirements..."
        sudo apt-get update
        if sudo apt install -y docker.io docker-compose nginx; then
                return 0
        else
                return 1
        fi
}

#function to enable docker services
start_services() {
        sudo systemctl enable docker
        sudo chown $USER /var/run/docker.sock
}

#function to deploy app
deploy_app() {
        echo "Deploying app..."
        #docker build -t django_app .
        if docker-compose up -d; then
                return 0
        else
                echo "App deployment is failing"
                return 1
        fi
}

#Exit if clone_code() failing
if ! clone_code; then
        exit 1
fi

#Exit if install_req() failing
if ! install_req; then
        exit 1
fi

#Exit if start_services() failing
if ! start_services; then
        exit 1
fi

#Exit if deploy_app() function
if ! deploy_app; then
        exit 1
fi
