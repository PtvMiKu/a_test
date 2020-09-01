#!/usr/bin/env bash
image_version=`date +%Y%m%d%H%M`;
# 关闭a_test容器
docker stop a_test || true;
# 删除a_test容器
docker rm a_test || true;
# 删除a/test镜像
docker rmi --force $(docker images | grep a/test | awk '{print $3}')

pwd
ls /var/jenkins_home/workspace/A_test

# 构建a/test:$image_version镜像
docker build . -t a/test:$image_version;
# 查看镜像列表
docker images;
# 基于a/test 镜像 构建一个容器 a_test
docker run -p 9527:80 -d --name a_test a/test:$image_version;
# 查看日志
docker logs a_test;
# 对空间进行自动清理
docker system prune -a -f