<!-- # twitterの内容の感情分析 -->
# はじめに
Twitterのつぶやき内容を感情分析するためのソース群。

# 手順
基本的には、[全てここを参照してください](http://boomin.yokohama/archives/667)。

1. `python3 -m venv env`
2. `source env/bin/activate`
3. `pip install -r packages.txt`
4. `getTweet.py`と`getTweetByHashtag`の編集
5. 対象のアカウントやハッシュタグを`analyzeTweet.sh`に設定
6. `bash analyzeTweet.sh`
