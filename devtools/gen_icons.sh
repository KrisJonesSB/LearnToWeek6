
sizes=( 40 60 58 87 80 120 180 1024 )

if [[ -n "$1" ]] && [[ -r $1 ]] ;
then
  echo "$1"
  for size in ${sizes[@]}; do
    sips -Z "$size" "$1" --out "${size}-${1}";
  done
else
  echo "Please enter a valid file."
fi


# sips -Z 40 swift.png --out swift-40.png

