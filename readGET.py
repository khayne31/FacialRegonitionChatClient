import json
import requests
import sys
import argparse





def highestID():
	return requests.get("https://0ym0hvjsll.execute-api.us-east-2.amazonaws.com/default/chat/highestid").json()



def newMessage(msgID = None):

	i = highestID()
	if msgID == None:
		message_id = i
	else:
		message_id = str(msgID)

	r = requests.get("https://0ym0hvjsll.execute-api.us-east-2.amazonaws.com/default/chat?id="+message_id)

	messages = r.json()["Items"]
	print(len(messages))
	if len(messages) > 0:
		with open("messages.txt", "w") as f:
			for item in messages:
				reponse = item['user']+ ": "+ item['message'] + "\n"
				f.write(reponse)
				#print(reponse)

	return len(messages) > 0


def getMessages():
	f = open("messages.txt","r")
	lines = f.readlines()
	for line in lines:
		print(line)


# print(highestID())
# print(newMessage(-1))
