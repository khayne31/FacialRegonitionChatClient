input="requirements.txt"
while IFS= read -r line
do
	if [ $OSTYPE == "linux-gnu" ]
	then
		sudo apt-install $line
	else
		pip install $line
	fi
done < "$input"