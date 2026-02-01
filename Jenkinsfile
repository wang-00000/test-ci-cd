pipeline {
    agent any

    tools {
        // Jenkins 全局工具里配置过的 Maven 名称
        maven 'maven3'
    }

    environment {
        // 可选：统一 Maven 本地仓库，避免每次重新下依赖
        MAVEN_OPTS = "-Dmaven.repo.local=/var/jenkins_home/.m2/repository"
        IMAGE_NAME = "test-ci-cd"
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh '''
                mvn clean package -Dmaven.test.skip=true
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                docker version
                docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker rm -f test-ci-cd || true
                docker run -d \
                  --name test-ci-cd \
                  -p 9001:8080 \
                  test-ci-cd:${IMAGE_TAG}
                '''
            }
        }
    }

    post {
        success {
            echo '✅ 构建成功'
        }
        failure {
            echo '❌ 构建失败'
        }
    }
}
