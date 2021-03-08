# install_clair

## Prerequisite

* [registry-operator 설치가이드 Prerequisite](https://github.com/tmax-cloud/install-registry-operator/tree/5.0#Step-1-%EC%9D%B8%EC%A6%9D%EC%84%9C-%EC%83%9D%EC%84%B1)로 생성된 인증서 및 키(ca.crt, ca.key)


## 폐쇄망 구축

1. 도커 이미지 파일시스템에 저장

    ```bash
    SCANNER=quay.io/coreos/clair
    sudo docker pull ${SCANNER}
    sudo docker save ${SCANNER} > ${SCANNER}.tar
    ```

2. 저장한 이미지 파일을 설치할 폐쇄망 환경으로 복사

3. 폐쇄망 Registry 서버에 이미지를 푸시

    ```bash
    REGISTRY={REGISTRY}   # ex: REGISTRY=192.168.6.100:5000
    SCANNER=quay.io/coreos/clair
    
    sudo docker load < ${SCANNER}.tar
    sudo docker tag ${SCANNER} ${REGISTRY}/${SCANNER}
    sudo docker push ${REGISTRY}/${SCANNER}
    ```

4. 아래 설치 가이드 수행

## 설치
   
1. Clair 설치 git repo clone

    ```bash
    git clone https://github.com/tmax-cloud/install_clair
    ```

2. 설정

    ```bash
    cd install_clair
    kubectl config set-context --current --namespace=<to_install_namespace>
    make deploy
    ```

## clair 삭제 가이드

* 아래의 명령어를 clair 디렉터리에서 실행

    ```bash
    make clean
    ```
