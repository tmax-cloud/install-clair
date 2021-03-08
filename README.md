# install_clair

## clair 폐쇄망 구축 가이드

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

4. 아래 clair 설치 가이드에 따라 Clair 서버 배치

## clair 설치 가이드
   
1. 작업 디렉터리에 Clair 설치 git clone

    ```bash
    git clone https://github.com/tmax-cloud/install_clair
    cd install_clair && make deploy
    ```

## clair 삭제 가이드

* 아래의 명령어를 clair 디렉터리에서 실행

    ```bash
    make clean
    ```
