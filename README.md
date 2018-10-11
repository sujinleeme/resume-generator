# Resume Maker 사용법 : 한글

본 Resume Maker 리퍼지토리를 활용해 마크다운으로 이력서 작성하고 깃허브 페이지(GitHub Pages)에 배포하는 방법을 소개합니다.

## 준비
* Git/GitHub
로컬 컴퓨터에 Git/GitHub이 설치와 설정이 되어 있는지 확인합니다.
설치가 되어 있지 않다면 [Pro GitBook 한국어 튜토리얼](https://git-scm.com/book/ko/v2) 1-6 장까지 참고해 설치를 완료합니다.

* 코드 에디터
마크다운 문법을 작성하고 미리보기 할 수 있는 코드 에디터가 필요합니다. 마이크로소프트 사의 [비주얼 스튜디오 코드](https://code.visualstudio.com)는 무료이며, 마크다운 미리보기 기능이 있어 이를 추천합니다.

## 문서 작성 도구
이 프로그램은 [Pandoc 2.x](https://pandoc.org), [Phantomjs](http://phantomjs.org/download.html)을 사용해 이력서 pdf와 html 문서를 생성합니다.

### 도구 설명
#### Pandoc
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

GuiWin32 설치 경로를 확인한 후 `setx` 명령어로 환경 변수 설정 경로를 설정합니다.

```
> setx /M PATH "%PATH%;C:\[경로...]\bin"
```

 예를 들면 `C:\Program Files (x86)`라면 `setx /M PATH "%PATH%;C:\Program Files (x86)\bin`가 되겠습니다. 끝에 바이너리 폴더인 `\bin`를 추가하는 것을 잊지 마세요. 환경 변수가 잘 설정되었는지 다시 확인합니다. 맨 마지막 부분에 `C:\Program Files (x86)\GnuWin32\bin`가 추가되어 있는 것을 확인할 수 있을 것입니다.

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

### 4. phantomjs 설치하기
[다운로드 페이지](http://phantomjs.org/download.html)에서 `phantomjs-2.1.1-windows.zip`을 다운받고 압축을 푼 다음 설치를 진행합니다. `phantomjs.exe` 파일을 실행합니다.

### MacOSX

#### 1. brew 설치
MacOSX에서는 homebrew로 설치를 진행합니다. `brew -v`를 콘솔에 입력해 설치가 이미 되었는지 확인해보세요.

```
$ brew -v
Homebrew 1.7.7
```

설치가 되어 있지 않으면 아래 스크립트를 복사해 콘솔에 붙여 넣고 실행하세요.
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

#### 2. Pandoc 설치하기
콘솔에서 `brew install pandoc` 입력해 설치합니다. `pandoc -v`를 콘솔에 입력해 설치가 잘 되었는지 확인해보세요.

```
$ pandoc -v
pandoc 2.3.1
```

#### 3. BasicTeX 설치하기
Te MacTeX 또는 ConTeXt Suite를 설치해 사용할 수 있습니다만, MacTeX의 용량이 크기 때문에, 저용량 버전인 BasicTeX를 설치하는 것이 좋습니다. BasicTeX를 설치하고 TeX 폰트 설치를 진행합니다.

BasicTeX [다운로드 페이지](https://www.tug.org/mactex/morepackages.html)에서 `BasicTeX.pkg` 파일을 다운받아 설치합니다.

콘솔을 열어 tlmgr를 업데이트 한 후 TeX 폰트를 설치합니다.
```
$ tlmgr update --self
$ tlmgr install collection-fontsrecommended
```

만약 `Please run this program as administrator, or contact your local admin.` 라는 메시지가 나오면 명령어 앞에 `sudo`를 붙여 실행하세요.

```
$ sudo tlmgr install collection-fontsrecommended
```

콘솔에서 `tex -v` 명령어를 입력해 설치가 잘 되었는지 확인해봅시다.

```
$ tex -v
TeX 3.14159265 (TeX Live 2018)
```
### 4. phantomjs 설치하기

```
$ brew cask install phantomjs
```

`phantomjs -v`를 콘솔에 입력해 설치가 잘 되었는지 확인해보세요.

```
$ phantomjs -v
2.1.1
```

## 내 GitHub 리퍼지토리에 올리고 배포하기

이 리퍼지토리를 보일러플레이트(boilerplate)로 사용해 GitHub 페이지에 호스팅할 수 있습니다.
`make` 명령어를 사용해 간단하게 gh-pages 브랜치 생성, 자동 커밋 및 배포를 할 수 있습니다. 아래 `resume-generator` 레파지토리 이름을 `my-resume`로 바꾸고, GitHub Pages에 이력서 웹 사이트를 호스팅 하는 방법을 소개합니다.

1. 리퍼지토리를 클론합니다.
```
$ git clone https://github.com/sujinleeme/resume-generator.git
```

2. 전 하위 폴더로 들어가 현재 로컬 폴더 이름인 `resume-generator`를 `my-resume`로 바꿉니다. 리퍼지토리 이름이 `my-resume`이기 때문에 편의상 폴더 이름을 바꾸겠습니다.

* Windows
```
$ cd ..
$ Rename resume-generator [프로젝트 이름]
```
* MacOSX
```
$ cd ..
$ mv resume-generator [프로젝트 이름]
```

3. 프로젝트 폴더로 들어가 숨김 폴더인 `.git`을 지우고 초기화 합니다.
* Windows
```
> cd resume-generator
> del .git
> git init
```

* MacOSX
```
$ cd resume-generator
$ rm -rf .git
$ git init
```

4. [깃허브 홈페이지](https://github.com/sujinleeme/resume-generator)에서 `my-resume`라는 빈 리퍼지토리를 생성합니다. `readme.md`, `.gitignore`, `license` 파일을 추가하지 말고 완전히 비어있는 상태여야 합니다. 로컬 리퍼지토리에 원격 리퍼지토리를 추가합니다. 

```
$ git remote add origin https://github.com/[내 사용자 이름]/my-resume.git
$ git add .
$ git commit -m "Add Resume Maker boilerplate"
$ git push --set-upstream origin master
```

이제 전체 코드가 리퍼지토리에 푸쉬되어 반영되었을 것입니다.

4. `make gh-pages` 명령어를 실행합니다. 자동으로 신규 gh-pages 라는 이름의 로컬/원격 브랜치가 생성됩니다.

```
$ make gh-pages

git checkout -b gh-pages
M       Makefile
M       installation.md
[....]
To https://github.com/sujinleeme/resume-generator.git
 * [new branch]      gh-pages -> gh-pages
Branch 'gh-pages' set up to track remote branch 'gh-pages' from 'origin'.
git checkout master
M       Makefile
M       installation.md
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
```

5. 이제 gh-pages 브랜치에 빌드하기 위해 `make deploy` 명령어를 입력합니다. `index.html` 빌드되고 자동 커밋되어 웹사이트가 배포됩니다.

```
Cleaning
[....]
To https://github.com/sujinleeme/resume-generator.git
   48ef1b2..e673f27  gh-pages -> gh-pages
git checkout master
Switched to branch 'master'
```

`https://[사용자 이름].github.io/my-resume/` 주소로 들어가서 내용이 잘 반영되었는지 확인해보세요.
