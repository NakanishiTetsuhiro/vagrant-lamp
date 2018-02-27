# お手軽LAMP環境

これであなたもLAMP環境が手に入る！

## How to use

1. プロジェクトのルートディレクトリをVagrantfileで指定してください
2. `vagrant up`

## tools

* Apache2.2
* php7.1
* composer
* mysql5.7

## tips
### Vagrant
* guest private IP: 192.168.33.11

### Apache
* port: 80

### mysql
* encoding: utf-8mb4
* port: 3306

- vagrant-vbguestがvagrantにインストールされているとうまくいかない場合がありますその場合は下記コマンドでプラグインを削除して再度実行してみてください

```
vagrant plugin uninstall vagrant-vbguest
```