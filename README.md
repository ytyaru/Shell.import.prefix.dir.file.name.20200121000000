[ja](./README.ja.md)

# Import on Bash 3

　Import a Bash file. Add a file and directory name as a prefix.

# Features

```sh
. ./moduled_import.sh dir/file.sh
dir.file.func
```

# Requirement

* <time datetime="2020-01-18T15:11:55+0900">2020-01-18</time>
* [Raspbierry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 4 Model B Rev 1.2
* [Raspbian](https://ja.wikipedia.org/wiki/Raspbian) buster 10.0 2019-09-26 <small>[setup](http://ytyaru.hatenablog.com/entry/2019/12/25/222222)</small>
* bash 5.0.3(1)-release

```sh
$ uname -a
Linux raspberrypi 4.19.75-v7l+ #1270 SMP Tue Sep 24 18:51:41 BST 2019 armv7l GNU/Linux
```

# Installation

```sh
git clone https://github.com/ytyaru/Shell.import.prefix.dir.file.name.20200121000000
```

# Usage

```sh
cd ./src
./main.sh
```

## setup `import`

1. Rename the `moduled_import.sh` file to` import`
2. Pass the `import` file through the environment variable` PATH`: `export PATH="/path/exist_import_dir:$PATH"`

## example call `import`

* repo/
    * main.sh
    * sub/
        * lib.sh

sub/lib.sh
```sh
Func() { echo 'Called sub/lib.sh Func()'; }
```
main.sh
```sh
. moduled_import sub/lib.sh
sub.lib.Func
```

# Note

* `import` itself must be read with the` .` (`source`) command
* Bug: When there is a space in the directory or file name
    * Cause: Space is a shell metacharacter
    * Solution: Change the space to another character such as a hyphen
* The import root directory is the directory where the `import` calling file resides

# Author

ytyaru

* [![github](http://www.google.com/s2/favicons?domain=github.com)](https://github.com/ytyaru "github")
* [![hatena](http://www.google.com/s2/favicons?domain=www.hatena.ne.jp)](http://ytyaru.hatenablog.com/ytyaru "hatena")
* [![mastodon](http://www.google.com/s2/favicons?domain=mstdn.jp)](https://mstdn.jp/web/accounts/233143 "mastdon")

# License

This software is CC0 licensed.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.en)

