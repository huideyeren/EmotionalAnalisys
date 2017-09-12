#!/bin/bash
#
T_ARRAY=(huideyeren AmeliaTsao)
F_ARRAY=(Xiandai_Fenshu)
POLITICIAN=(ogino_otaku onoda_kimi moritakayuki)
ENGINEER=(chomado)
RELIGIOUS=(kamiumach bozu_108)
FLYING_TIGER=(フライングタイガー)

echo get tweet data of user
for item in ${T_ARRAY[@]} ${F_ARRAY[@]} ${POLITICIAN[@]} ${ENGINEER[@]} ${RELIGIOUS[@]}; do
echo "get tweet data: "$item
python getTweet.py $item
sleep 3
done

echo get tweet data by keyword
for item in ${FLYING_TIGER[@]}; do
echo "get tweet data: "$item
python getTweetByHashtag.py $item
sleep 3
done

bash regexp.sh ${T_ARRAY[@]} ${F_ARRAY[@]} ${POLITICIAN[@]} ${ENGINEER[@]} ${RELIGIOUS[@]} ${FLYING_TIGER[@]}

echo convert tweet data to wakati
for item in ${T_ARRAY[@]} ${F_ARRAY[@]} ${POLITICIAN[@]} ${ENGINEER[@]} ${RELIGIOUS[@]} ${FLYING_TIGER[@]}; do
echo "converting data: "$item
python createLearningData.py ${item}.txt -n 2
done

echo evaluating tweet data
for item in ${T_ARRAY[@]} ${F_ARRAY[@]} ${POLITICIAN[@]} ${ENGINEER[@]} ${RELIGIOUS[@]} ${FLYING_TIGER[@]}; do
echo "converting data: "$item
python judgePositive.py w_${item}.pkl negaposi.bin
done

# 自分のアカウント
varray=()
for item in ${T_ARRAY[@]}; do
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

# その他のアカウント
varray=()
for item in ${F_ARRAY[@]}; do
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

varray=()
for item in ${POLITICIAN[@]}; do
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

varray=()
for item in ${ENGINEER[@]}; do
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

varray=()
for item in ${RELIGIOUS[@]}; do
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}

varray=()
for item in ${FLYING_TIGER[@]}; do
varray+=(result_w_$item.pkl)
done
python visualizeResult.py ${varray[@]}