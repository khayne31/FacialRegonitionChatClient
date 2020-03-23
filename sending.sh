# rm messages.txt
# while :
# do
# 	user="Kellen"
	
	
# 	if [ $first == "1" ]
# 	then
# 		read -p "$user: " text
# 		first="0"
# 	else
# 		clear& 
# 		python readGET.py; id=$((id+ 1))&
# 		echo "$(<messages.txt)";
# 		read -p "$user: " text;
# 	fi



# 	python jsonscript.py --message "$text" --user $user

user="Kellen"
read -p "text: " text
python jsonscript.py --message "$text" --user $user
response= curl --silent --output nul --data @data.json -H "Content-Type: application/json" -X POST https://0ym0hvjsll.execute-api.us-east-2.amazonaws.com/default/chat
echo "sent"	


	
	
# done

#( read test) | for load in $(seq 1 12); do echo $load; if [ $load == 12 ]; then echo -n "Kellen: "; sleep 4; echo -e "\e[0K\rNew line"; echo -n "Kellen"; fi; done


# while true
# do
#     echo "$var"
#     IFS= read -r -t 0.5 -n 1 -i "what" -s holder && var="$holder"
# done
# echo -n "Old line";  sleep 1; echo -e "\e[0K\rNew line"
