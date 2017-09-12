#!/bin/bash
#
# ポジティブ名言アカウントとネガティブ名言アカウントを配列にしておいて、一気に取得する
# P_ARRAY=(positive_bot3 posi_tive_sp_ kami_positive positivekk_bot maemukikotoba1 Plus_bot heart_meign bot10586321 mege_positive positive_enrenb matsuoka_shuzo mottoatuku)
P_ARRAY=(positive_bot3 heart_meign positive_enrenb matsuoka_shuzo)
# N_ARRAY=(n_siko nega_bot Mostnegative cynicalbot UnluckyBot Antinatalismbot)
N_ARRAY=(nega_bot Mostnegative cynicalbot)
echo get tweet data
for item in ${P_ARRAY[@]} ${N_ARRAY[@]}; do
echo "get tweet data: "$item
python getTweet.py $item
sleep 3
done

echo regexp
bash regexp.sh ${P_ARRAY[@]} ${N_ARRAY[@]}

echo convert tweet data to wakati
for item in ${P_ARRAY[@]} ${N_ARRAY[@]}; do
echo "converting data: "$item
python createLearningData.py ${item}.txt -n 2
done

export LANG=C

for item in ${P_ARRAY[@]}; do
echo $item
awk -F"\t" 'NR>1 {if ( $3!~/^$/ ) print $3}' w_${item}.tsv | sed -e "s/^/__label__1, /g" > label_negaposi.tsv
done

for item in ${N_ARRAY[@]}; do
echo $item
awk -F"\t" 'NR>1 {if ( $3!~/^$/ ) print $3}' w_${item}.tsv | sed -e "s/^/__label__2, /g" >> label_negaposi.tsv
done

sort -f label_negaposi.tsv -b | uniq > traindata.tsv
# sort -f label_negaposi.tsv -b > traindata.tsv

python learning.py traindata.tsv negaposi