# ANOVA with ART
<img src="https://img.shields.io/badge/R-4.0.2-blue?&logo=R">
<img src="https://img.shields.io/badge/License-CC BY 4.0-lightgray">


ANOVA with ART (aligned rank transformation) procedure (Wobbrock, Findlater, Gergle, & Higgins, 2011)のためのRサンプルです。

正規性の検定を行なった際、要因、水準にどれか1つでも正規分布に従わないデータがあった場合、ノンパラメトリック検定を使用することが推奨されます。
ANOVAの場合は、このARTというものを使う方法があります。

one-wayとtwo-wayのサンプルがあります。
どちらも被験者内計画を想定しています。
two-wayは，sABデザイン (被験者内2要因) を使用しています。


# Environment
- R                4.0.2 or later


# Installation
いくつかのパッケージを使用しますので、インストールがまだの場合は以下を実行してください。

```bash
install.packages("ARTool")
install.packages("phia")
install.packages("emmeans")
install.packages("effsize") # Optional
```


# Usage
サンプルデータ (oneway_sample.csv, twoway_sample.csv) を使用した手順です。

## One-way ANOVA with ART
1. `ANOVA_ART_one-way.R`を開いてください。
1. そのまま実行すると、Result/Onewayフォルダが作成され、解析結果がテキストファイルで出力されます。
1. `effsize_cliff`を`T`にすることで、効果量Cliff's deltaの計算結果も出力します。

## Two-way ANOVA with ART
1. `ANOVA_ART_two-way.R`を開いてください。
1. そのまま実行すると、Result/Twowayフォルダが作成され、解析結果がテキストファイルで出力されます。


# Description
- データはRファイルと同じ階層から読み込まれます。
    - 任意のデータに変更する場合は、`read.csv`を適宜書き換えてください。
- 解析結果はResultフォルダにテキストファイルで出力されます。
    - フォルダは自動で生成されます。
    - ファイルは上書き保存されます。
- 解析結果ファイル
    - one-way
        - ANOVA_oneway.txt: ANOVA table
        - ANOVA_posthoc_oneway.txt: 多重比較
        - effsize_cliff_12.txt: 条件1と条件2に対する効果量 (Cliff's delta)
        - effsize_cliff_13.txt: 条件1と条件3に対する効果量 (Cliff's delta)
        - effsize_cliff_23.txt: 条件2と条件3に対する効果量 (Cliff's delta)
    - two-way
        - ANOVA_twoway.txt: ANOVA table
        - ANOVA_posthoc_twoway_condition.txt: 要因1に対する多重比較
        - ANOVA_posthoc_twoway_session.txt: 要因2に対する多重比較
        - ANOVA_posthoc_twoway_condition_session.txt: 要因1と2の交互作用
- 出力結果の自由度に注意し、解析結果の妥当性を検討してください。


# References
- Wobbrock, J. O., Findlater, L., Gergle, D., & Higgins, J. J. (2011). The aligned rank transform for nonparametric factorial analyses using only ANOVA procedures. In Proceedings of the SIGCHI Conference on Human Factors in Computing Systems, 143-146.

- https://rcompanion.org/handbook/F_16.html

- https://depts.washington.edu/acelab/proj/art/index.html

- https://www.youtube.com/watch?v=gAAwPoI1wNA

- https://www.slideshare.net/masarutokuoka/ss-42957963


# Versions
- 1.0: 2021/2/11
- 1.1: 2021/6/4
    - two-way ANOVA with ARTの混合モデルデザインのプログラムの問題を修正。
- 1.2: 2021/12/28
    - Cliff's deltaの読み込み部分を修正


# Author
- Takayoshi Hagiwara
    - Graduate School of Media Design, Keio University
    - Toyohashi University of Technology


# License
- CC BY 4.0