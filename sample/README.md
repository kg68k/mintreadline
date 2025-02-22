# mintreadlineサンプル

## サンプルコード

### sample/src/mrl_asm.s

アセンブリ言語によるサンプルです。
引数を指定するとそれを初期文字列とします。ファイル名の補完ができます。

### sample/src/mrl_c.c

C言語によるサンプルです。
引数を指定するとそれを補完侯補リストと見なします。

mrl_asm.s とは違い、ファイル名の補完をしない設定です。これは「E-mail アドレスを入力する」
といった場合など、ファイル名を入力する可能性がない場合に有効な動作です
(補完侯補リストにない文字列を補完しようとしても、ファイル名を補完することはないので)。
もちろん、リストにない場合にファイル名を補完する動作もできます。


## Build
リリースパッケージに含まれるファイルはShift_JISに変換されているので、そのままビルドできます。

リポジトリ内のファイルについては、PCやネット上での取り扱いを用意にするためにUTF-8で記述されています。  
X68000上でビルドする際には、UTF-8からShift_JISへの変換が必要です。

### u8tosjを使用する方法

あらかじめ、[u8tosj](https://github.com/kg68k/u8tosj)をビルドしてインストールしておいてください。

トップディレクトリで`make`を実行してください。以下の処理が行われます。
1. build/ディレクトリの作成。
2. src/内の各ファイルをShift_JISに変換してbuild/へ保存。

次に、カレントディレクトリをbuild/に変更し、`make`を実行してください。  
実行ファイルが作成されます。

### u8tosjを使用しない方法

ファイルを適当なツールで適宜Shift_JISに変換してから`make`を実行してください。  
UTF-8のままでは正しくビルドできませんので注意してください。


## License
GNU GENERAL PUBLIC LICENSE Version 3 or later.


## Author
TcbnErik / 立花@桑島技研  
https://github.com/kg68k/mintreadline
