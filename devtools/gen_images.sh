
if [[ -n "$1" ]] && [[ -r $1 ]] ;
then

  width=$(sips -g pixelWidth "$1" | tail -n  1 | awk -F:\  '{print $2}')
  oneX=$(( width / 3 ))
  twoX=$(( oneX * 2 ))
  sizes=( $oneX $twoX $width )
  echo "$1"
  for size in ${sizes[@]}; do
    sips -Z "$size" "$1" --out "${size}-${1}";
  done
else
  echo "Please enter a valid file."
fi


