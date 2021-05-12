# Hypercloud clair 환경구성 가이드

## 폐쇄망 구축

1. 도커 이미지 파일시스템에 저장

    ```bash
    sudo docker pull arminc/clair-local-scan:latest
    sudo docker save arminc/clair-local-scan:latest > clair_img.tar
    sudo docker pull arminc/clair-db:latest
    sudo docker save arminc/clair-db:latest > clairdb_img.tar
    ```

2. 저장한 이미지 파일(*clair_img.tar, clairdb_img.tar*)을 설치할 폐쇄망 환경으로 복사

3. 폐쇄망 Registry서버에 이미지를 푸시

    ```bash
    REGISTRY={{enter_your_registry_address}}  # ex) 192.168.6.100:5000
    
    sudo docker load < clair_img.tar
    sudo docker tag arminc/clair-local-scan:latest ${REGISTRY}/clair-local-scan:latest
    sudo docker push ${REGISTRY}/clair-local-scan:latest

    sudo docker load < clairdb_img.tar
    sudo docker tag arminc/clair-db:latest ${REGISTRY}/clair-db:latest
    sudo docker push ${REGISTRY}/clair-db:latest
    ```

4. 아래 설치 가이드 수행

## 설치

1. 패키지 설치
    ```bash
    sudo yum install -y make
    ```

2. Clair 설치 git repo clone
    ```bash
    git clone https://github.com/tmax-cloud/install-clair
    cd install_clair/operator-subsystem
    ```

2.  registry-operator가 신뢰하는 인증서 준비

    CASE 1) [registry-operator 설치가이드](https://github.com/tmax-cloud/install-registry-operator/tree/5.0)를 수행하지 않은 경우 
    
    2.1 [registry-operator 설치가이드 - Step01 인증서 생성](https://github.com/tmax-cloud/install-registry-operator/tree/5.0#Step-1-%EC%9D%B8%EC%A6%9D%EC%84%9C-%EC%83%9D%EC%84%B1) 수행
    
    2.2 위 과정을 통해 발급된 ca.crt, ca.key를 현재 디렉터리(install_clair/operator-subsystem)로 복사

    2.3 복사한 인증서 및 키 파일의 소유권을 사용자로 수정 (루트 사용자 권한 X)
    ```bash
    chown <사용자>:<사용자그룹> ca.crt ca.key
    ```
   
    
    CASE 2) [registry-operator 설치가이드](https://github.com/tmax-cloud/install-registry-operator/tree/5.0)를 수행한 경우

    설치된 namespace에 registry-ca 시크릿이 이미 존재한다면, kustomization.template 파일의 secretGenerator절 삭제 후 다음 스텝 진행


3. 디플로이

    ```bash    
    REGISTRY=${REGISTRY} make deploy
    ```

## 제거

* 아래의 명령어를 git base 디렉터리에서 실행

    ```bash
    make clean
    ```