# Resume Generator Guide : 한글

본 가이드는 Resume Generator 저장소를 활용해 [마크다운(Markdown)](https://ko.wikipedia.org/wiki/%EB%A7%88%ED%81%AC%EB%8B%A4%EC%9A%B4)으로 이력서, 커버레터, 레퍼런스 문서를 만들고 이력서 웹사이트를 깃허브 페이지(GitHub Pages)에 배포하는 방법을 소개합니다.

## 준비

**Git/GitHub** 로컬 컴퓨터에 Git/GitHub 이 설치와 설정이 되어 있는지 확인합니다.
설치가 되어 있지 않다면 [Pro GitBook 한국어 튜토리얼](https://git-scm.com/book/ko/v2) 1-6 장까지 참고해 설치를 완료합니다. CLI(Command Line Interface)에 익숙하지 않다면, [GitHub Desktop](https://desktop.github.com/)을 다운받아 설치하면 조금 쉽게 설치를 완료할 수 있습니다.

**코드 에디터** 마크다운 문법을 작성하고 미리보기 할 수 있는 코드 에디터가 필요합니다. 시중에 Sublime Text, Atom, Visual Studio Code 등 무료 오픈 소스 에디터가 많이 있습니다. 마크다운 미리보기 기능 플러그인을 설치하면 실시간으로 문서를 작성하면서 결과물을 확인할 수 있습니다. Visual Studio Code 의 경우 기본적으로 마크다운 미리보기 기능을 제공합니다.

## 문서 작성 도구

이 프로그램은 [Pandoc 2.x](https://pandoc.org), [Phantomjs](http://phantomjs.org/download.html)을 사용해 이력서 pdf 와 html 문서를 생성합니다. 리눅스 프로그램 빌드 도구인 [make](https://www.gnu.org/software/make/)로 명령어를 관리합니다.

### 도구 설명

#### Pandoc

[Pandoc](https://pandoc.org/)은 존 팩프랜드(John Macfarlane)가 하스켈 언어로 제작한 오픈 소스로 하나의 문서를 여러 다른 형태의 문서로 변환하는 유틸리티입니다. Pandoc(판독)으로 마크다운, HTML, LaTeX, Word docx, epub 등 다양한 형식으로 문서를 변환할 수 있습니다.

#### Markdown

마크다운(Markdown) 문법은 특수문자를 활용해 각 행과 텍스트를 스타일링합니다. 2004 년 존 그루버(John Gruber)가 창안한 것으로 쉽게 쓰고 읽을 수 있고 특수기호와 문자를 이용한 매우 간단한 구조의 문법을 사용하여 웹에서도 보다 빠르게 컨텐츠를 작성하고 보다 직관적으로 인식할 수 있습니다. 깃허브와 스택오브플로우(Stackoverflow) 등 내 텍스트 에디터는 모두 마크다운 문법을 사용하고 있습니다. [마크다운 문법은 30 분 내면 배울 수 있을 정도로 어렵지 않고](https://guides.github.com/features/mastering-markdown/) 작성도 매우 간편해 많은 프로그래머들이 즐겨 쓰고 있는 문서 형식입니다.

### LaTeX

LaTeX('레이텍'. 또는 TeX, '텍'이라고 한다)은 오픈소스 조판시스템(Typesetting System)으로 글, 수식, 그래프 작성이 필요한 문서 작업에 많이 사용합니다. 가장 널리 알려진 논문 작성 도구로 수학 수식이 필요한 이공학 논문 작성에 널리 쓰이고 있습니다. 수학 수식은 LaTeX 문법을 이용해서 이미지로 렌더링 후 문서에 첨부됩니다.

Pandoc 에서 pdf 를 생성할 때 LaTeX 이 필요합니다. 이 프로그램에서는 LaTeX 를 쓰지 않습니다만, Pandoc 명령어로 `tex`, `docx`, `pdf` 문서를 생성하는 경우 엔진인 XeTeX 을 설치해야 합니다. XeTeX 이란 TTF 및 OTF 와 같은 많은 시스템 폰트를 TeX 폰트로 쓸 수 있게 해주는 TeX 조판 시스템 엔진(TeX typesetting engine)입니다.

윈도우에서는 Tex Live, MiKTeX 엔진 중 하나를, MAC 에서는 Tex Live 의 MAC 버전인 MacTeX 를 사용하는 것이 좋습니다. MacTeX 는 용량이 커 저용량 버전인 BasicTex 을 설치하는 것이 좋습니다.

간단히 도구들에 대해 알아봤으니 이제 설치를 진행하겠습니다.

## 설치하기

### Windows

#### 1. Pandoc 설치하기

[Pandoc 다운로드 페이지](https://github.com/jgm/pandoc/releases/tag/2.2.1)에서 운영 체제에 맞는 zip 파일을 다운받고 설치하세요.
32bit 운영 체제라면 `pandoc-2.3.1-windows-i386.zip` 파일을 다운받으면 됩니다.

내 컴퓨터가 32bit 인지 64bit 인지 모른다면, `(Settings) > 시스템(System)`에서 컴퓨터 종류(System Type)에서 확인할 수 있습니다.

윈도우 검색창에 cmd 를 치면 명령 프롬프트가 열립니다. 단축키는 `Win + S` 입니다.

프롬프트에 `pandoc --version` 또는 `pandc -v` 명령어를 입력해 설치가 잘 되었는지 확인합니다.

```
> pandoc --version
pandoc 2.2.1
```

#### 2. GuiWin32 설치

Makefile 빌드 자동화 스크립트 파일을 사용해 명령어를 실행할 것입니다. 복잡한 명령어 대신 `make`라는 명령어로 빌드 과정을 간단히 자동화 할 수 있습니다. 단 이 명령어는 리눅스 명령어인데 GuiWin32 을 설치하면 윈도우에서도 리눅스 명령어를 사용할 수 있습니다. GuiWin32 중 make 패키지가 포함된 설치파일을 다운받겠습니다.

[Make for Windows GuiWin32 다운로드 페이지](https://sourceforge.net/projects/gnuwin32/files/make/3.81/make-3.81.exe/download?use_mirror=jaist&download=)에서 설치 파일을 다운받아 설치를 완료합니다. 환경 변수 설정을 위해 어느 경로에 설치했는지 설치 경로를 꼭 기억해주세요. 메모장에 설치경로를 적어두는 것을 추천드립니다. (예: `C:\Program Files (x86)`)

다음으로 환경 설정 변수를 설정해야 합니다. 환경 변수(Environment Variables)란 운영 체제가 콘솔 창에서 필요한 실행 파일을 찾는데 사용하는 시스템 변수입니다. 즉 환경 변수라는 곳에 바로가기 경로를 지정해, 아무 곳에서도 명령어를 실행할 수 있습니다.

##### 환경 변수 설정하기

환경변수를 설정하는 방법은 2 가지가 있습니다. [명령 프롬프트(커맨드라인, 콘솔)](https://tutorial.djangogirls.org/ko/intro_to_command_line/)을 통해 설치하는 방법과 제어판의 고급 시스템 설정을 통해 설정 가능합니다. 프롬프트를 이용해 설정하는 방법은 여러창을 이동하지 않고 한 창(프롬프트)에서 몇 가지 명령어를 입력하는 방법으로 환경 변수를 설정할 수 있어 많은 개발자들이 선호하는 방법입니다.

##### 명령 프롬프트로 환경변수 설정하기

먼저 `명령 프롬프트` 아이콘의 오른쪽 버튼을 클릭해 `관리자 권한으로 열기`를 선택해 프롬프트 창을 엽니다.

`path` 명령어로 현재의 환경 설정 변수를 확인합니다.

```
> path
PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Git\cmd;C:\Program Files (x86)\Pandoc\;C:\Ruby24-x64\bin;C:\Users\sujin\AppData\Local\Microsoft\WindowsApps;C:\Users\sujin\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files
```

GuiWin32 설치 경로를 확인한 후 `setx` 명령어로 환경 변수 설정 경로를 설정합니다. 끝에 바이너리 폴더인 `\bin`를 추가하는 것을 잊지 마세요.

```
setx <환경_변수_이름> "<환경 변수_설정할_경로>" -m
setx path "%<환경_변수_이름>%;%PATH%" -m
```

```
> setx GuiWin32 "C:\Program Files (x86)\GnuWin32\bin" -m
> setx path "%GuiWin32%;%PATH%" -m
```

`path` 명령어로 환경 변수가 잘 설정되었는지 다시 확인합니다. 맨 마지막 부분에 `C:\Program Files (x86)\GnuWin32\bin`가 추가되어 있는 것을 확인할 수 있을 것입니다.

```
> path
PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Git\cmd;C:\Program Files (x86)\Pandoc\;C:\Ruby24-x64\bin;C:\Users\sujin\AppData\Local\Microsoft\WindowsApps;C:\Users\sujin\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files (x86)\GnuWin32\bin
```

프롬프트에서 `make --version` 또는 `make -v` 명령어를 입력해 설치가 잘 되었는지 확인해봅시다.

```
> make --version
GNU Make 3.81
Copyright (C) 2006  Free Software Foundation, Inc.
```

##### 제어판에서 환경변수 설정하기

제어판에서도 환경변수를 설정할 수 있습니다.

`제어판(Settings) > 시스템(System) > 정보(About)`로 들어가 우측에 `시스템 정보(System Info) > 고급 시스템 설정(Advance system settings)`를 클릭합니다. 그리고 맨 아래에 `환경 변수(Environment Variables)`를 클릭합니다.

`환경 변수(Environment Variables)` 에서 `000에 대한 사용자 변수(User variables for 000)` 항목 아래, `Path`를 클릭하고 `편집(Edit)` 버튼을 클릭합니다. 위의 **명령 프롬프트로 환경변수 설정하기**를 통해 환경변수 설정을 마쳤다면 `C:\Program Files (x86)\GnuWin32\bin`가 있는 것을 확인할 수 있을 것입니다.

만약 위에서 설정을 하지 못하였다면 여기서 환경 변수를 추가하면 됩니다. `찾아보기(Browse)` 버튼을 클릭해 `GnuWin32`의 설치 경로를 선택합니다. 여기서 반드시 `GnuWin32\bin` 경로를 선택해야 합니다.

#### 3. phantomjs 설치하기

[phantomjs 다운로드 페이지](http://phantomjs.org/download.html)에서 `phantomjs-2.1.1-windows.zip`을 다운받고 압축을 풉니다. 압축을 푼 `phantomjs-2.1.1-windows`폴더에 들어가 `phantomjs`를 복사해 (만약 이름이 `phantomjs-2.1.1-windows`라면 `phantomjs`로 변경하세요) `C:\Program Files (x86)`폴더에 붙여넣기 하세요.

이번에도 마찬가지로 환경변수 설정이 필요합니다.

`명령 프롬프트` 아이콘의 오른쪽 버튼을 클릭해 `관리자 권한으로 열기`를 선택해 프롬프트 창을 엽니다.

`setx` 명령어로 `phantomjs`의 환경 변수 설정 경로를 설정합니다. 끝에 바이너리 폴더인 `\bin`를 추가하는 것을 잊지 마세요.

```
> setx phantomjs "C:\Program Files (x86)\phantomjs\bin" -m
> setx path "%phantomjs%;%PATH%" -m
```

`path` 명령어로 환경 변수가 잘 설정되었는지 다시 확인합니다. 맨 마지막 부분에 `C:\Program Files (x86)\phantomjs\bin`가 추가되어 있는 것을 확인할 수 있을 것입니다.

```
> path
PATH=C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Git\cmd;C:\Program Files (x86)\Pandoc\;C:\Ruby24-x64\bin;C:\Users\sujin\AppData\Local\Microsoft\WindowsApps;C:\Users\sujin\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files (x86)\GnuWin32\bin;C:\Program Files (x86)\phantomjs\bin;
```

프롬프트에서 `phantomjs --version` 또는 `phantomjs -v` 명령어를 입력해 설치가 잘 되었는지 확인해봅시다.

```
> phantomjs --version
2.1.1
```

#### 4. MiKTeX 설치하기 (옵션)

MiKTeX [다운로드 페이지](https://miktex.org/howto/install-miktex) 다운받습니다.

### MacOSX

#### 1. brew 설치

MacOSX 에서는 homebrew 로 설치를 진행합니다. `brew -v`를 콘솔에 입력해 설치가 이미 되었는지 확인해보세요.

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
$ brew install pandoc
$ pandoc -v
pandoc 2.3.1
```

#### 3. phantomjs 설치하기

콘솔에서 `brew install phantomjs` 입력해 설치합니다. `phantomjs -v`를 콘솔에 입력해 설치가 잘 되었는지 확인해보세요.

```
$ brew install phantomjs
$ phantomjs -v
2.1.1
```

#### 4. BasicTeX 설치하기 (옵션)

Te MacTeX 또는 ConTeXt Suite 를 설치해 사용할 수 있습니다만, MacTeX 의 용량이 크기 때문에, 저용량 버전인 BasicTeX 를 설치하는 것이 좋습니다. BasicTeX 를 설치하고 TeX 폰트 설치를 진행합니다.

BasicTeX [다운로드 페이지](https://www.tug.org/mactex/morepackages.html)에서 `BasicTeX.pkg` 파일을 다운받아 설치합니다.

콘솔을 열어 tlmgr 를 업데이트 한 후 TeX 폰트를 설치합니다.

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

## 내 깃허브 저장소(GitHub Repository)에 소스코드 올리기

이 저장소를 보일러플레이트(boilerplate)로 사용해 [깃허브 페이지(GitHub Pages)](https://pages.github.com/)에 호스팅 해보겠습니다. 보일러플레이트란 자주 사용되는 코드를 미리 만들어두고 그 안에 사용자가 필요한 코드를 수정 및 추가하여 완전한 소프트웨어를 만들 수 있도록 도와주는 프레임워크나 소스코드 등을 말합니다. 이 저장소를 활용해 문서 본문을 수정하거나 스타일링을 추가하는 등 자유롭게 커스터마이징하여 배포할 수 있습니다.

이 프로그램은 `make` 명령어를 사용해 간단하게 gh-pages 브랜치 생성, 자동 커밋 및 배포를 합니다.

#### 1. 저장소 클론하기

프롬프트를 다시 열고 이 저장소를 클론합니다.

```
$ git clone https://github.com/sujinleeme/resume-generator.git
```

#### 2. 프로젝트 폴더 이름 바꾸기

현재 로컬 폴더 이름인 `resume-generator`를 `my-resume`로 바꿉니다. 앞으로 우리가 만들 저장소 이름은 `my-resume`이기 때문에 편의 상 폴더 이름을 바꾸겠습니다.

- Windows

```
$ Rename resume-generator my-resume
```

- MacOSX

```
$ mv resume-generator my-resume
```

#### 3. 깃 초기화 하기

프로젝트 폴더인 `my-resume`로 들어가 숨김 폴더인 `.git`을 지우고 git init 명령어를 사용해 git 을 초기화 합니다. 지금 경로를 잘 모르겠다면 `pwd` 를 입력해 경로를 확인해보세요.

- Windows

```
> cd my-resume
> rd /s /q "C:\<경로>\my-resume\.git"
> git init
```

- MacOSX

```
$ cd my-resume
$ rm -rf .git
$ git init
```

아래와 같이 깃 저장소를 다시 초기화했다는 메시지가 보일 것입니다..

```
Reinitialized existing Git repository in /Users/sujin/Desktop/resume-generator/.git/
```

#### 4. 깃허브 저장소 만들기

깃허브 홈페이지에서 `my-resume`라는 빈 저장소를 생성합니다. `readme.md`, `.gitignore`, `license` 파일을 추가하지 말고 완전히 비어있는 상태여야 합니다. 로컬 저장소에 원격 저장소를 추가합니다.

```
$ git remote add origin https://github.com/<사용자-이름>/my-resume.git
$ git remote -v
origin	https://github.com/<사용자-이름>/my-resume.git (fetch)
origin	https://github.com/<사용자-이름>/my-resume.git (push)
```

원격 저장소 주소가 잘 바뀌었는지 확인하세요.

이제 `add`, `commit`, `push` 명령어를 사용해 로컬 저장소 내 코드를 원격 저장소로 올리겠습니다.

아직 git 사용에 익숙하지 않다면 [git 튜토리얼 - 2. 코드를 수정하고 저장소에 저장하기](https://git-scm.com/book/ko/v1/Git%EC%9D%98-%EA%B8%B0%EC%B4%88-%EC%88%98%EC%A0%95%ED%95%98%EA%B3%A0-%EC%A0%80%EC%9E%A5%EC%86%8C%EC%97%90-%EC%A0%80%EC%9E%A5%ED%95%98%EA%B8%B0)를 참고하세요.

그리고 README.md 파일에 있는 내용을 모두 지우세요.

```
$ git status
$ git add .
$ git status
$ git commit -m "Add Resume Generator boilerplate"
$ git push --set-upstream origin master
```

https://github.com/<사용자-이름>/my-resume 에서 커밋이 잘 올라갔는지 확인해보세요.

#### 5. gh-pages 브랜치 만들기

지금부터는 웹 사이트를 빌드하고 배포해보겠습니다. 기본적으로 `gh-pages`에 푸쉬하면 깃허브 페이지가 자동으로 배포됩니다.

`git branch -a`을 입력해 현재 브랜치 목록을 확인해봅시다.
`*` 표시는 현재 브랜치를 가리키는 표시입니다.

```
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
```

사실 **브랜치 변경-추가-커밋-푸쉬 단계**까지 git 명령어를 여러 번 쳐야하기 때문에 꽤 번거롭습니다. 때문에 이 명령어 집합을 모아 [Makefile](https://github.com/sujinleeme/resume-generator/blob/master/Makefile)에 정의했습니다.

우리는 `master` 브랜치가 아닌 `gh-pages` 브랜치에 에 웹 사이트 관련 소스인 html, css 파일만 브랜치에 올릴 것입니다.

먼저 배포 브랜치인 `gh-pages`를 만들어보겠습니다.
`make gh-pages` 명령어를 실행하면 자동으로 `gh-pages` 라는 새 로컬/원격 브랜치가 생성됩니다. 물론 make 명령어 대신 git 명령어를 입력할 수 있습니다.

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

다시 전체 브랜치 목록을 확인해봅시다. 로컬과 원격 모두 `gh-pages` 브랜치가 만들어졌습니다.

```
$ git branch -a
  gh-pages
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/gh-pages
  remotes/origin/master
```

`https://github.com/<사용자-이름>/my-resume/tree/gh-pages` 주소로 들어가서 내용이 잘 반영되었는지 확인해보세요. master 브랜치와 똑같은 내용이 그대로 올라가 있어야 합니다.

#### 6. 깃허브 페이지 배포하기

지금 현재 로컬 브랜치가 `master` 인지 다시 확인해봅시다.

```
$ git branch
  gh-pages
* master
```

만약 `gh-pages`에 있다면 `git checkout master`을 입력해 master 브랜치로 돌아오세요.

이제 `gh-pages` 브랜치에 빌드하기 위해 `make deploy` 명령어를 입력합니다. `index.html` 빌드되고 자동 커밋되어 `gh-pages`에 푸쉬되고 최종적으로 웹 사이트가 배포됩니다. 물론 make 명령어 대신 git 명령어를 입력할 수 있습니다.

```
$ make deploy

Cleaning
[....]
To https://github.com/sujinleeme/resume-generator.git
   48ef1b2..e673f27  gh-pages -> gh-pages
git checkout master
Switched to branch 'master'
```

https://github.com/sujinleeme/resume-generator/tree/gh-pages 와 같이 `style.css`, `.gitignore`, `index.html` 파일만 올라가 있어야 합니다. 이 폴더와 파일은 정적인 웹 사이트를 만드는데 필요한 파일입니다.

`https://github.com/<사용자-이름>/my-resume/tree/gh-pages` 주소로 들어가서 내용이 잘 반영되었는지 확인해보세요.

**오류가 생겼나요?**
만약 `gh-pages` 브랜치를 만들지 않고 `make deploy`로 배포를 했다면 오류 메시지가 나올 것입니다.

```
git checkout gh-pages
error: pathspec 'gh-pages' did not match any file(s) known to git
make: *** [deploy] Error 1
```

로컬과 원격 모두 gh-pages 브랜치를 만들지 않았기 때문입니다. `make gh-pages` 명령어를 먼저 입력하세요.

만약 로컬과 원격 gh-pages 브랜치 둘 다 모두를 삭제하고 싶다면 `make del-gh-pages` 명령어를 입력하세요.

## 이력서 문서 작성하기

#### 1. 비주얼 스튜디오 코드 에디터 열기

프롬프트에서 프로젝트 경로에서 `code .` 명령어를 입력하면 비주얼 스튜디오 코드 에디터 창이 열립니다. 윈도우와 맥 모두 동일합니다.

```
$ pwd
/Users/sujin/Desktop/my-resume

$ code .
```

#### 2. 이력서 작성하고 문서 생성하기

`content` 폴더에 있는 마크다운 문서를 열고 이력서, 레퍼런스, 커버레터를 작성합니다.

이후 프롬프트에서 `make <명령어>`를 실행해 out 폴더 내 각 문서가 생성 되었는지 확인해보세요.

- `make all`: `out` 폴더 안에 `html`, `pdf`, 'docx' 문서를 생성합니다.
- `make pdf`: `out/pdf` 폴더 안에 `pdf` 문서만 생성합니다.
- `make docx`: `out/docx` 폴더 안에 `docx` 문서만 생성합니다.
- `make html`: `out/html` 폴더 안에 `html` 문서만 생성합니다.

프롬프트에서 바로 파일 탐색기를 열려면 아래 명령어를 입력합니다.
프로젝트 폴더인 `my-resume`에 있는지 경로를 확인하세요.

- Windows

```
> pwd
/Users/sujin/Desktop/my-resume

> start .
```

- MacOSX

```
$ pwd
/Users/sujin/Desktop/my-resume

$ open .
```

#### 3. 깃 수정 커밋하기

`master` 브랜치에 수정한 파일을 커밋하겠습니다. 수정한 내역을 커밋 메시지로 간결하게 적어봅시다.

```
$ git checkout master
$ git status
$ git add .
$ git status
$ git commit -m "Edit my name"
$ git push
```

#### 4. 배포하기

새로 수정한 내용이 웹 사이트에도 반영이 되어야겠지요?
프롬프트에서 `make deploy`를 실행해 웹 사이트를 배포합니다.

```
$ make deploy
```

https://<사용자-이름>.github.io/my-resume/ 주소로 들어가서 잘 반영되었는지 확인해보세요.
