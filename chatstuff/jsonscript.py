import json
import argparse
import os




def sendMessage(message, user):
	data = {"message": message, "user": user}

	with open('data.json', 'w') as outfile:
		json.dump(data, outfile)

#os.system(" curl --data @data.json -H \"Content-Type: application/json\" -X POST https://hs5cd09y1a.execute-api.us-east-2.amazonaws.com/default/chat")