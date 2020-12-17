for x in $(ls Data/*)
do
	file=$(basename $x | cut -d'_' -f1)
	rm $file
done

for x in $(ls Data/*)
do
	file=$(basename $x | cut -d'_' -f1)
	echo "putting $x to $file"
	tail -n +2 $x >> $file
	echo "$(wc -l $file)"
done
