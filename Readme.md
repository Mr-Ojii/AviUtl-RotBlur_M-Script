# RotBlur_M
AviUtl拡張編集用、GPUを使用した高速回転ブラースクリプト

## 導入方法
1. karoterra氏の[GLShaderKit](https://github.com/karoterra/aviutl-GLShaderKit)を導入
2. exedit.aufと同一ディレクトリにあるscriptディレクトリ内、またはそのディレクトリの1階層下に`RotBlur_M.anm`,`RotBlur_M.frag`,`RotBlur_M.lua`を配置

## パラメータ説明
### X
回転の中心となるX座標
### Y
回転の中心となるY座標
### amount
回転ブラーの角度
### r_pos
基準座標
### keep_size
サイズを保持したままエフェクトをかけるか
### quality
描画回数 / 2  
数字が大きければ大きいほどブラーとしての精度は向上するが、重くなります。
### reload
シェーダーを都度リロードするか  
主にデバッグ用なので、オフのままを推奨
### PI
トラックバーのパラメータインジェクション用

## 外部スクリプトから呼ぶためのドキュメント
### 呼び出し方
`package.path`変数を編集し、requireで読めるようにしてから、
```
local RotBlur_M = require("RotBlur_M")
RotBlur_M.RotBlur_M(x, y, amount, r_pos, keep_size, quality, reload)
```
と呼び出すことにより、objバッファにエフェクトがかけられます。

### パラメーター説明
|変数名   |説明                  |型     |単位    |
|---------|----------------------|-------|--------|
|x        |X座標                 |number |ピクセル|
|y        |Y座標                 |number |ピクセル|
|amount   |角度                  |number |ラジアン|
|r_pos    |基準座標              |number |なし    |
|keep_size|サイズ保持            |boolean|なし    |
|quality  |描画回数/2            |number |回      |
|reload   |シェーダーの再読み込み|boolean|なし    |
