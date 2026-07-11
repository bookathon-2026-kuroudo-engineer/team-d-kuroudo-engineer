# Re:VIEW 5.9原稿 記法早見表

このリポジトリの `.re` 原稿を書くときに使う。Re:VIEWの全命令を列挙せず、本文執筆で頻繁に使う記法と間違いやすい点に絞る。

## 最重要ルール

- 段落同士は1行以上の空行で区切る。空行なしの改行は同じ段落として連結される。
- 見出しは行頭から `=` を書き、`=` の直後に半角空白を置く。
- 箇条書きは行頭に1文字以上の空白が必要。
- ブロック命令は `//command[...]` で始め、内容を持つものは `//}` で閉じる。
- インライン命令は `@<command>{content}` と書く。
- Markdownの `#` 見出し、`-` リスト、バッククォートフェンス、`[text](url)` は使わない。

## 段落

```review
これは第1段落の1行目です。
空行がないため、この行も第1段落です。

これは第2段落です。
```

2行以上空けても段落区切りとしての意味は同じ。段落の途中で表示上の改行が必要な場合のみ `@<br>{}` を使う。

## 見出し

```review
= 章タイトル

== 節タイトル

=== 項タイトル

==== 目タイトル
```

見出しの前後には空行を置く。見出しに参照用ラベルを付ける場合は次のように書く。

```review
=={setup} セットアップ

詳しくは@<hd>{setup}を参照してください。
```

コラムは同じ数の `=` で開始・終了する。

```review
===[column] 補足

コラム本文です。

===[/column]
```

## 箇条書き

### 順序なし

`*` の前に半角空白を置く。`*` の数で深さを表す。

```review
 * 第1項目
 ** 第1項目の子項目
 * 第2項目
```

### 番号付き

番号の前にも半角空白を置く。出力形式による差を避けるため、原稿上も連番を書く。

```review
 1. 最初の手順
 2. 次の手順
 3. 最後の手順
```

リストの前後には空行を置く。複雑な入れ子や、リスト項目内へのブロック挿入が必要なら、公式ガイドの `//beginchild` と `//endchild` を確認する。

### 用語リスト

```review
 : API
    Application Programming Interfaceの略です。
 : SDK
    開発に必要なツール群です。
```

用語行は「半角空白 + `:` + 半角空白」で始め、説明行は字下げする。

## インライン表現

```review
@<b>{太字}
@<strong>{強調}
@<code>{someFunction()}
@<href>{https://example.com/, 表示文字列}
@<href>{https://example.com/}
@<fn>{footnote-id}
@<img>{image-id}
@<list>{list-id}
@<table>{table-id}
```

インライン命令は原則として入れ子にしない。内容中の `}` は `\}`、末尾の `\` は `\\` とエスケープする。記号が多いコードではフェンス記法も使える。

```review
@<code>|if (value) { return true; }|
```

## コードとコマンド

番号・キャプション・本文からの参照が必要なコードは `//list` を使う。

```review
@<list>{hello-code}に実装例を示します。

//list[hello-code][Hello Worldの実装]{
func main() {
    print("Hello, world!")
}
//}
```

参照不要のコード例は `//emlist`、ファイル名を示すコードは `//source`、端末操作は `//cmd` を使う。

```review
//emlist[短いコード例]{
let enabled = true
//}

//source[Sources/App/main.swift]{
print("Hello")
//}

//cmd{
$ npm test
//}
```

ブロック内部に別のブロック命令を入れない。コード中にRe:VIEWの特殊記法が現れ、意図せず解釈される場合は、ビルドで必ず確認する。

## 画像

画像ファイルを `articles/images/` に置き、拡張子を除いた識別子で指定する。このリポジトリには `articles/images/sample-diagram.jpeg` の例がある。

```review
@<img>{architecture}に全体構成を示します。

//image[architecture][システム全体の構成][scale=0.8]{
//}
```

識別子、キャプション、必要な場合のみ `scale` を指定する。本文中では「下図」のような位置依存表現を避け、`@<img>{architecture}` で参照する。

## 脚注

```review
本文から脚注を参照します。@<fn>{term-note}

//footnote[term-note][ここに脚注の本文を書きます。]
```

参照側と定義側で同じ識別子を使う。識別子は章内で一意にする。

## 表

セルはタブで区切り、見出し行と本文をハイフンの行で区切る。

```review
@<table>{format-comparison}に比較を示します。

//table[format-comparison][記法の比較]{
用途	Re:VIEW
--------------------
見出し	== 見出し
強調	@<strong>{強調}
//}
```

列数を揃え、表のセルを複雑な文章やコードの置き場にしない。

## 引用と注意枠

```review
//quote{
引用する文章です。
//}

//note[補足]{
本文を理解するための補足です。
//}

//warning[注意]{
誤操作につながる注意事項です。
//}
```

注意枠には `note`、`memo`、`tip`、`info`、`warning`、`important`、`caution`、`notice` などがある。装飾目的で多用せず、出力先での見た目をビルドして確認する。

## コメント

変換結果に出さない作業メモは `#@#` で始める。

```review
#@# TODO: 図を最新のものに差し替える
```

`//comment` と `@<comment>` はドラフト出力時の表示用であり、通常の非表示メモとは用途が異なる。

## 仕上げチェック

- 段落を分けたい箇所に空行があるか。
- 見出し階層を飛ばしていないか。
- 箇条書きの先頭に半角空白があるか。
- すべての内容付きブロックが `//}` で閉じているか。
- 参照識別子と定義識別子が一致し、重複していないか。
- Markdown記法が混入していないか。
- `npm test` で変換エラーが出ないか。

## 情報源

- このリポジトリの `README.md`、`Gemfile`、`package.json`、`articles/*.re`
- Re:VIEW公式フォーマットガイド: https://github.com/kmuto/review/blob/master/doc/format.ja.md
- TechBooster『技術書をかこう！〜はじめてのRe:VIEW〜第3版』: https://github.com/TechBooster/FirstStepReVIEW-v3
- TechBooster ReVIEW-Template: https://github.com/TechBooster/ReVIEW-Template
