# install_clair

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
   
### [registry-operator](https://github.com/tmax-cloud/install-registry-operator/tree/5.0)의 서브시스템으로 설치하는 경우

1. Clair 설치 git repo clone

    ```bash
    git clone https://github.com/tmax-cloud/install-clair
    cd install_clair/operator-subsystem
    ```

2.  registry-operator가 신뢰하는 인증서 준비 (이미 설치했으면 skip)
   
    [registry-operator 설치가이드 - Step01 인증서 생성](https://github.com/tmax-cloud/install-registry-operator/tree/5.0#Step-1-%EC%9D%B8%EC%A6%9D%EC%84%9C-%EC%83%9D%EC%84%B1) 수행


3. 디플로이

    ```bash    
    REGISTRY=${REGISTRY} make deploy
    ```

### 별도로 설치하는 경우

1. Clair 설치 git repo clone

    ```bash
    git clone https://github.com/tmax-cloud/install-clair
    cd install_clair
    ```

2. (optional) 네임스페이스 생성 - 이 step을 skip할 경우 `registry-system`에 생성
   
    ```bash
    kubectl create namespace {{enter_namespace_to_deploy}}
    ```

3. 디플로이
   
    ```bash    
    NAMESPACE={{enter_namespace_to_deploy}} REGISTRY=${REGISTRY} make deploy
    ```

## 제거

* 아래의 명령어를 git base 디렉터리에서 실행

    ```bash
    make clean
    ```