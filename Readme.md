# RotBlur_M
AviUtl拡張編集用、GPUを使用した高速回転ブラースクリプト

## 導入方法
1. karoterra氏の[GLShaderKit](https://github.com/karoterra/aviutl-GLShaderKit)を導入
2. exedit.aufと同一ディレクトリにあるscriptフォルダ内、またはそのフォルダの1階層下に`RotBlur_M.anm`,`RotBlur_M.frag`,`RotBlur_M.vert`を配置

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
