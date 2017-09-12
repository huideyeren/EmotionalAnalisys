#!/bin/bash
#
T_ARRAY=(huideyeren AmeliaTsao)
F_ARRAY=(Eve_pbw urum_lue AmeliaTsao)
POLITICIAN=(ogino_otaku onoda_kimi moritakayuki)
ENGINEER=(chomado ayatokura hirokiky shimizukawa shyouhei takahashim hatochan)
RELIGIOUS=(kamiumach bozu_108 semimaruP HASSANKONAKATA fukuinnomura matsuzakichikai senjuin1010)
KEYWORDS=(フライングタイガー ロンハーマン flyingtiger)

echo get tweet data of user
for item in ${T_ARRAY[@]} ${F_ARRAY[@]} ${POLITICIAN[@]} ${ENGINEER[@]} ${RELIGIOUS[@]}; do
echo "get tweet data: "$item
python getTweet.py $item
sleep 3
done

echo get tweet data by keyword
for item in ${KEYWORDS[@]}; do
echo "get tweet data: "$item
python getTweetByHashtag.py $item
sleep 3
done

bash regexp.sh ${T_ARRAY[@]} ${F_ARRAY[@]} ${POLITICIAN[@]} ${ENGINEER[@]} ${RELIGIOUS[@]} ${KEYWORDS[@]}

echo convert tweet data to wakati
for item in ${T_ARRAY[@]} ${F_ARRAY[@]} ${POLITICIAN[@]} ${ENGINEER[@]} ${RELIGIOUS[@]} ${KEYWORDS[@]}; do
echo "converting data: "$item
python createLearningData.py ${item}.txt -n 2
done

echo evaluating tweet data
for item in ${T_ARRAY[@]} ${F_ARRAY[@]} ${POLITICIAN[@]} ${ENGINEER[@]} ${RELIGIOUS[@]} ${KEYWORDS[@]}; do
echo "converting data: "$item
python judgePositive.py w_${item}.pkl negaposi.bin
done

# 自分のアカウント
varray=()
for item in ${T_ARRAY[@]}; do
echo "visualize data: "$item
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

# その他のアカウント
varray=()
for item in ${F_ARRAY[@]}; do
echo "visualize data: "$item
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

varray=()
for item in ${POLITICIAN[@]}; do
echo "visualize data: "$item
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

varray=()
for item in ${ENGINEER[@]}; do
echo "visualize data: "$item
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

varray=()
for item in ${RELIGIOUS[@]}; do
echo "visualize data: "$item
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

varray=()
for item in ${KEYWORDS[@]}; do
echo "visualize data: "$item
varray+=(result_w_$item.pkl)
done
python visualizeResult2.py ${varray[@]}