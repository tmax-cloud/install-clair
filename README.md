# Hypercloud clair 환경구성 가이드

## 폐쇄망 구축
1. 다음 이미지 목록을 파일로 저장([참조](https://github.com/tmax-cloud/install-registry/blob/5.0/podman.md#%EC%9D%B4%EB%AF%B8%EC%A7%80-%ED%91%B8%EC%8B%9C%ED%95%98%EA%B8%B0))
    * arminc/clair-local-scan:latest
    * arminc/clair-db:latest
2. 저장한 이미지 파일(*clair-local-scan.tar, clair-db.tar*)을 설치할 폐쇄망 환경으로 복사
3. 폐쇄망 레지스트리에 이미지 푸시([참조](https://github.com/tmax-cloud/install-registry/blob/5.0/podman.md#%EC%9D%B4%EB%AF%B8%EC%A7%80-%ED%91%B8%EC%8B%9C%ED%95%98%EA%B8%B0))
4. 아래 설치 가이드 수행

## 설치
1. Git repo 클론
    ```bash
    git clone https://github.com/tmax-cloud/install-clair -b 5.0
    cd install_clair/operator-subsystem
    ```

2. 패키지 설치
    ```bash
    sudo yum install -y make
    sudo cp ../resources/kustomize /usr/local/bin/
    ```
   
3. registry-operator가 신뢰하는 인증서 준비
    * [registry-operator 설치가이드](https://github.com/tmax-cloud/install-registry-operator/tree/5.0)를 수행하지 않은 경우 
        1. [registry-operator 설치가이드 - Step01 인증서 생성](https://github.com/tmax-cloud/install-registry-operator/tree/5.0#Step-1-%EC%9D%B8%EC%A6%9D%EC%84%9C-%EC%83%9D%EC%84%B1) 수행
        2. 위 과정을 통해 발급된 ca.crt, ca.key를 현재 디렉터리(install_clair/operator-subsystem)로 복사
        3. 복사한 인증서 및 키 파일의 소유권을 현재 사용자로 수정
            ```bash
            chown <사용자>:<사용자그룹> ca.crt ca.key
            ```

    * [registry-operator 설치가이드](https://github.com/tmax-cloud/install-registry-operator/tree/5.0)를 수행한 경우
        * 설치된 namespace에 registry-ca 시크릿이 이미 존재한다면, kustomization.template 파일의 secretGenerator절 삭제 후 다음 스텝 진행


4. 디플로이
   * 폐쇄망 레지스트리에 업로드된 이미지를 사용할 경우 
       ```bash 
       REGISTRY=${REGISTRY} make deploy
       ```
   * Dockerhub에서 이미지를 받아올 경우
       ```bash 
       make deploy
       ```
     
## 제거
* 아래의 명령어를 git base 디렉터리에서 실행
    ```bash
    make clean
    kubectl remove namespace [NAMESPACE] 
    ```
