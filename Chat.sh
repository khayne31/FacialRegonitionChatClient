while :
do
	read -p "What would you like to do 1) login 2) create new user?: " decision
	if [ $decision == "1" ]
	then 
		echo "Logging In..."
		access=$(python recognize_video_2.py --detector face_detection_model --embedding-model openface_nn4.small2.v1.t7 --recognizer output/recognizer.pickle --le output/le.pickle --access output/access.pickle --seconds 3 --script True)
		if  [ $access == "True" ]
		then 
			echo "Access Granted"
			python GUI2.py --user "Kellen"
			break
		else
			echo "Access Denied"
		fi
		break
	elif [ $decision == "2" ]
	then
		echo "Creating New User..."
		read -p "What would you like your name to be?: " name
		echo "Great! When the webcam turns on $name slowly move your head back and forth until scanning is complete."
		echo "Scanning..."
		python face_scan.py --folder dataset\\$name --seconds 10
		echo  "Processing..."
		python extract_embeddings.py --dataset dataset --embeddings output/embeddings.pickle --detector face_detection_model --embedding-model openface_nn4.small2.v1.t7
    	python train_model.py --embeddings output/embeddings.pickle --recognizer output/recognizer.pickle --le output/le.pickle
    	
    	while :
    	do
    		read -p "Great You now have access. Would you like to login (y/n)?: " newLogin
    		if [ $newLogin == "y" ]
    		then
    			access=$(python recognize_video_2.py --detector face_detection_model --embedding-model openface_nn4.small2.v1.t7 --recognizer output/recognizer.pickle --le output/le.pickle --access output/access.pickle --seconds 10 --script True)
    			if [ $access == "True" ] 
    			then
    				python GUI2.py --user "$name"
    				break
    			else
    				break
    			fi
    			break
    		elif [ $newLogin == "n" ]
    		then
    			break
    		fi
    	done
		break
	fi
done

for load in $(seq 1 12); do
	n=$((load % 4))
	if [ $n == 0 ]; then 
		echo -ne "\033[2K"
		echo -ne "Loading \r"
	elif [ $n == 1 ]; then
		echo -ne "Loading. \r"
	elif [ $n == 2 ]; then
		echo -ne "Loading.. \r"
	else
		echo -ne "Loading...\r"
	fi
	sleep 1
done

