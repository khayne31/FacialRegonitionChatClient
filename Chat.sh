userSave=facestuff/output/user.pickle
dataset=facestuff/dataset
embeddings=facestuff/output/embeddings.pickle
recognizer=facestuff/output/recognizer.pickle
detector=facestuff/face_detection_model
#embedding-model=facestuff/openface_nn4.small2.v1.t7
le=facestuff/output/le.pickle
while :
do
	
	read -p "What would you like to do 1) login 2) create new user 3) remove user ?: " decision
	if [ $decision == "1" ]
	then 
		echo "Logging In..."
		access=$(python facestuff/recognize_video_2.py --detector $detector --embedding-model facestuff/openface_nn4.small2.v1.t7 --recognizer $recognizer --le $le --user $userSave --seconds 3 --script True)
		if  [ $access == "True" ]
		then 

			echo "Access Granted"
			name=$(python facestuff/user.py --user $userSave)
			python chatstuff/GUI2.py --user "$name"
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
		python facestuff/face_scan.py --folder facestuff\\dataset\\$name --seconds 10
		echo  "Processing..."
		python facestuff/extract_embeddings.py --dataset $dataset --embeddings $embeddings --detector $detector --embedding-model facestuff/openface_nn4.small2.v1.t7
    	python facestuff/train_model.py --embeddings $embeddings --recognizer $recognizer --le $le
    	
    	while :
    	do
    		read -p "Great You now have access. Would you like to login (y/n)?: " newLogin
    		if [ $newLogin == "y" ]
    		then
    			access=$(python facestuff/recognize_video_2.py --detector $detector --embedding-model facestuff/openface_nn4.small2.v1.t7 --recognizer $recognizer --le $le --user $userSave --seconds 10 --script True)
    			if [ $access == "True" ] 
    			then
    				python chatstuff/GUI2.py --user "$name"
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
	elif [ $decision == "3" ]
	then
		
		read -p "Which user would you like to remove?: " delUser

		rm -r "dataset\\$delUser"  2> errlog.txt
		python facestuff/extract_embeddings.py --dataset $dataset --embeddings $embeddings --detector $detector --embedding-model facestuff/openface_nn4.small2.v1.t7
		python facestuff/train_model.py --embeddings $embeddings --recognizer $recognizer --le $le
		echo "User $delUser Removed"
   
    	break
	fi
done

for load in $(seq 1 12); 
do
	n=$((load % 4))
	if [ $n == 0 ]; then 
		echo -ne "\033[2K"
		echo -ne "Exiting \r"
	elif [ $n == 1 ]; then
		echo -ne "Exiting. \r"
	elif [ $n == 2 ]; then
		echo -ne "Exiting.. \r"
	else
		echo -ne "Exiting...\r"
	fi
	sleep 1
done

