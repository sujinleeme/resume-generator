# resume-maker

마크다운으로 이력서 작성를 작성합니다.

## 준비
로컬 컴퓨터에 Git/GitHub이 설치와 설정이 되어 있는지 확인합니다.
코드 에디터로는 마이크로소프트 사의 비주얼 스튜디오 코드를 추천합니다.

* 참고
  * [Pro GitBook 한국어 튜토리얼](https://git-scm.com/book/ko/v2)

## 문서 작성 도구
* [Pandoc 2.x](https://pandoc.org)
* [Phantomjs](http://phantomjs.org/download.html)

## 도구 설명
### Pandoc
존 팩프랜드(John Macfarlane)가 하스켈 언어로 제작한 오픈 소스로 하나의 문서를 여러 다른 형태의 문서로 변환하는 유틸리티입니다. Pandoc(판독)으로 마크다운(Markdown), HTML, LaTeX, Word docx, epub 등 다양한 형식으로 문서를 변환할 수 있습니다.

### Markdown
마크다운(Markdown) 문법은 특수문자를 활용해 각 행과 텍스트를 스타일링하는 것이 특징입니다. 2004년 존 그루버(John Gruber)가 창안한 것으로 쉽게 쓰고 읽을 수 있고 특수기호와 문자를 이용한 매우 간단한 구조의 문법을 사용하여 웹에서도 보다 빠르게 컨텐츠를 작성하고 보다 직관적으로 인식할 수 있습니다. 깃허브와 스택오브플로우 등 내 텍스트 에디터는 모두 마크다운 문법을 사용하고 있습니다. 마크다운 문법은 30분 내면 배울 수 있을 정도로 어렵지 않습니다. 

### LaTeX
LaTeX('레이텍'. 또는 TeX, '텍'이라고 한다)은 오픈소스 조판시스템(Typesetting System)으로 글, 수식, 그래프 작성이 필요한 문서 작업에 많이 사용합니다. 가장 널리 알려진 논문 작성 도구로 수학 수식이 필요한 이공학 논문 작성에 널리 쓰이고 있습니다.  수학 수식은 LaTeX 문법을 이용해서 이미지로 렌더링 후 문서에 첨부됩니다.

먼저 pdf로 변환 시, LaTeX 엔진인 XeTeX을 설치해야 합니다. XeTeX는 TTF 및 OTF와 같은 많은 시스템 폰트를 TeX 폰트로 쓸 수 있게 해주는 TeX 조판 시스템 엔진(TeX typesetting engine)입니다.

윈도우에서는 Tex Live, MiKTeX 둘 중 하나를, MAC에서는 Tex Live의 MAC버전인 MacTeX를 사용하는 것이 좋습니다. MacTeX는 용량이 크기 때문에 저용량 버전인 BasicTex을 설치하는 것이 좋습니다.

## 설치하기
### Windows
각 홈페이지에서 설치 파일을 다운로드 후 설치합니다.

#### 1. Pandoc 설치하기
Pandoc [다운로드](https://github.com/jgm/pandoc/releases/tag/2.2.1)에서 운영 체제에 맞는 msi 파일을 다운받고 설치하세요. 32bit 운영 체제라면 `pandoc-2.3.1-windows-i386.msi` 파일을 다운받으면 됩니다.
```
Windows 운영 체제 버전 확인은 `제어판 > 시스템`에서, 내 컴퓨터가 32bit 인지 64bit 인지 확인할 수 있습니다.
```

콘솔에서 `pandoc --version` 또는 `pandc -v` 명령어를 입력해 설치가 잘 되었는지 확인해봅시다.
```
> pandoc --version
pandoc 2.2.1
```

#### 2. MiKTeX 설치하기
MiKTeX [다운로드 페이지](https://miktex.org/howto/install-miktex) 다운받습니다.

#### 3. GuiWin32 설치
Makefile 빌드 자동화 스크립트 파일을 사용해 명령어를 실행할 것입니다. 복잡한 명령어 대신 `make`라는 명령어로 빌드 과정을 간단히 자동화 할 수 있습니다. 단 이 명령어는 리눅스 명령어인데 GuiWin32을 설치하면 윈도우에서도 리눅스 명령어를 사용할 수 있습니다.
GuiWin32 [다운로드 페이지](https://sourceforge.net/projects/gnuwin32/)에서 설치 파일을 다운받습니다.

다음으로는 환경 설정 변수를 설정해야 합니다. 환경 변수는 운영 체재가 콘솔 창에서 필요한 실행 파일을 찾는데 사용하는 시스템 변수입니다.

환경 설정 변수 설정은 콘솔에서 또는 제어판(시스템)에서 설정 가능합니다.

먼저 `시작 > 메뉴 > 콘솔` 아이콘에 오른쪽 버튼을 클릭해 관리자 권한으로 열기를 선택해 콘솔 창을 엽니다.

`path` 명령어로 현제 환경 설정 변수를 확인합니다.

```
> path
```

GuiWin32 설치 경로를 확인한 후 환경 변수 설정 경로를 설정합니다.

```
> setx /M PATH "%PATH%;C:\[경로...]\bin"
```

`C:\Program Files (x86)`라면 `setx /M PATH "%PATH%;C:\Program Files (x86)\bin`가 되겠습니다. 끝에 바이너리 폴더인 `\bin`를 추가하는 것을 잊지 마세요. 환경 변수가 잘 설정되었는지 확인합니다.

```
> path
PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Git\cmd;C:\Program Files (x86)\Pandoc\;C:\Ruby24-x64\bin;C:\Users\sujin\AppData\Local\Microsoft\WindowsApps;C:\Users\sujin\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files (x86)\GnuWin32\bin
```

콘솔에서 `make --version` 또는 `make -v` 명령어를 입력해 설치가 잘 되었는지 확인해봅시다.

```
> make --version
GNU Make 3.81
Copyright (C) 2006  Free Software Foundation, Inc.
```

#### 4. node.js 와 npm 설치
[Node.js 다운로드 페이지](http://nodejs.org/)에서 설치 파일을 다운 받고 설치를 완료합니다. 컴퓨터를 재부팅해야 node.js를 사용할 수 있습니다.

콘솔에서 `node --version` 또는 `node -v` 명령어를 입력해 설치가 잘 되었는지 확인해봅시다.

```
> node --version
v10.11.0
```

### 5. phantomjs 설치하기
```
> npm install -g phantomjs-prebuilt
```

### MacOSX

#### 1. Pandoc 설치하기
콘솔에서 `brew install pandoc` 입력해 설치합니다. 

### 2. BasicTeX 설치하기
Te MacTeX 또는 ConTeXt Suite를 설치해 사용할 수 있습니다만, MacTeX의 용량이 크기 때문에, 저용량 버전인 BasicTeX를 설치하는 것이 좋습니다.

BasicTeX [다운로드 페이지](https://www.tug.org/mactex/morepackages.html)에서 BasicTeX.pkg 파일을 다운받아 설치합니다.

콘솔을 열어 tlmgr를 업데이트 한 후 TeX 폰트를 설치합니다.
```
$ tlmgr update --self
$ tlmgr install collection-fontsrecommended
```

만약 `Please run this program as administrator, or contact your local admin.` 라는 메시지가 나오면 명령어 앞에 `sudo`를 붙여 실행하세요.

```
$ sudo tlmgr install collection-fontsrecommended
```

콘솔에서 `tex --version` 또는 `tex -v` 명령어를 입력해 설치가 잘 되었는지 확인해봅시다.

```
$ tex --version
TeX 3.14159265 (TeX Live 2018)
```

### 보일러플레이트를 깃허브 리퍼지토리에 연결하기 

이 리퍼지토리를 보일러플레이트(boilerplate)로 사용해 깃허브 페이지에 호스팅할 것입니다.

1. 리퍼지토리를 클론합니다.
```
$ git clone https://github.com/sujinleeme/resume-maker.git
```

2. 프로젝트 폴더로 들어가 숨김 폴더인 `.git`을 지우세요.
* Windows
```
$ cd resume-maker
$ del .git
```

* MacOSX
```
$ cd resume-maker
$ rm -rf .git
```

3. 깃을 초기화 합니다.
```
$ git init
```

4. 전체 브랜치 목록을 확인합니다. `master` 브랜치에서 `gh-pages`로 변경합니다. `gh-pages` 브랜치가 깃헙 페이지 배포 브랜치입니다.

```
$ git branch -all 
$ git checkout -b gh-pages
```

5. 깃허브 홈페이지에서 빈 리퍼지토리를 생성합니다. `readme.md`, `.gitignore`, `license` 파일을 추가하지 말고 완전히 비어있는 상태여야 합니다. 로컬 리퍼지토리에 원격 리퍼지토리를 추가합니다. 

```
$ git remote add origin <your-new-github-repo-url>)
$ git add .
$ git commit -m "Add Resume Maker boilerplate"
$ git push --set-upstream origin master
```


6. 이전 하위 폴더로 들어가 현재 로컬 폴더 이름인 `resume-maker`를 원하는 이름으로 바꿉니다.
* Windows
```
$ cd ..
$ Rename resume-maker [프로젝트 이름]
```
* MacOSX
```
$ cd ..
$ mv resume-maker [프로젝트 이름]
```


### 이력서 작성하기
코드 에디터를 열고 `resume/index.md` 파일을 열고, 이력서 내용을 수정합니다.

```
$ code resume/index.md
```

작성이 끝난 후 콘솔에서 `make` 명령어를 입력해 여러 문서 파일을 생성합니다.

```
$ make
```
`output`디렉터리 내 `docx`, `html`, `pdf`, `rtf`, `tex`, `tuc` 파일 생성되고, 루트 디렉터리에 `index.html` 파일이 생성된 것을 확인할 수 있을 것입니다. `index.html` 파일은 깃허브 페이지로 배포되는 파일입니다.

### 배포하기
이제 생성된 `index.html`파일을 깃허브 페이지로 배포하겠습니다. `gh-pages` 브랜치를 생성하고 커밋 후 푸쉬합니다.

```
$ git checkout -b gh-pages
$ git add . 
$ git commit -m "커밋 메시지"
$ git push
```

`https://[사용자 이름].github.io/[프로젝트 이름]/` 주소로 들어가서 내용이 잘 반영되었는지 확인해보세요.