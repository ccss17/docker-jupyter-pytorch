# torch-notebook

이 레포지토리는 https://github.com/jxcodetw/docker-jupyter-pytorch 을 포크하였습니다. 자세한 설명은 오리지널 레포지토리의 `README.md` 를 참조해주세요. 

이 레포지토리는 `pytorch` 를 비롯하여 `jupyter notebook`, `tensorflow`, `tensorboardx` 등등 기계학습을 공부할 때 유용한 패키지들이 설치되어 있는 도커 이미지를 제작하기 위한 빌드 스크립트(`Dockerfile`) 을 관리하고 있습니다.

## 오리지널 레포지토리로부터 달라진 내용

- `torchtext` 패키지를 추가하였습니다. 

- 윈도우에서 원활한 동작을 위하여 `jupyter` 실행옵션에 `--allow-root` 옵션을 추가하였습니다. 

# 사용법

## 이미지 시작

- `nvidia-docker` 가 설치되어 있는 리눅스 유저의 사용법

  ```shell
  $ NV_GPU=0,1 nvidia-docker run -d \
  --name torch-notebook \
  -p 8888:8888 \
  -p 6006:6006 \
  ccss17/torch-notebook
  # arguments
  # NV_GPU controls gpu isolation
  # --name [your custom name]
  # -u save file with permission as current user
  # $PWD mount current directory to jupyter's startup folder (/workspace)
  ```

- 일반적인 유저의 사용법

  ```shell
  $ docker run -d \
  --name torch-notebook \
  -p 8888:8888 \
  -p 6006:6006 \
  ccss17/torch-notebook
  ```

## 주피터 노트북의 인증 토큰 가져오기

- 주피터 노트북의 인증 토큰이 부여된 `URL` 을 알아낸다.

  ```shell
  docker logs torch-notebook
  ```

- `GET` 로그가 너무 많이 생겨서 토큰이 묻혀버린 경우 다음 명령어를 실행한다.

  ```shell
  docker exec torch-notebook jupyter notebook list
  ```

## **VSCode** 와 연동하기 

1. **vscode** 에서 [python 확장](https://marketplace.visualstudio.com/items?itemName=ms-python.python) 을 설치한다.

2. 명령 팔레트(`Ctrl+Shift+P`)에서 `Python: Specify local or remote Jupyter server for connections` 을 선택하고 주피터 노트북의 인증 토큰이 부여된 `URL` 을 붙혀넣는다. 

3. 이제 로컬에서 `.ipynb` 파일을 만들고 주피터 노트북을 실행하면 **vscode** 가 도커에서 격리되어 실행중인 원격 주피터 노트북 서버에 셀을 보내고 실행한 다음 출력만 가져와서 보여주게 된다.
