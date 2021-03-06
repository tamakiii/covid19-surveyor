#!/bin/bash
set -e

###
### About
### ./www-dataに収集した全サイトから新型コロナウイルスに関連するHTMLファイルの一覧を取得するスクリプト
###
### Usage
### ./grep.sh
###

# 配列初期化
words=`cat <<EOM
助成
補助
給付
収入
減額
支援
資金
税金
税制
納税
県税
融資
貸付
制度
相談
窓口
猶予
延長
学校
授業
労働
特例
措置
雇用
事業
休業
リモートワーク
テレワーク
EOM
`


rm -f www-data/index.html

set +e
# www-data内の全HTMLファイルをコロナでgrepして中間ファイルに出力
grep -r コロナ --include="*.html" ./www-data |\
# 長過ぎる行は無視
sed '/^.\{1,200\}$/!d' |\
# 半角スペース除去
sed 's/ //g' |\
# 全角スペース除去
sed 's/　//g' |\
# タブ除去
sed 's/[ \t]*//g' |\
# HTMLタグ除去
sed -e 's/<[^>]*>//g' >\
./tmp/grep_コロナ.txt.tmp
set -e


set +e
for word in ${words}; do
	echo $word
	# 中間ファイルを各キーワードでgrepして結果を出力
	grep $word ./tmp/grep_コロナ.txt.tmp > ./tmp/grep_コロナ_$word.txt.tmp
done
set -e
