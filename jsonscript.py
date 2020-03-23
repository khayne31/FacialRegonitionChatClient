import json
import argparse
import os


ap = argparse.ArgumentParser()
ap.add_argument("-m", "--message", required = True,
	help = "message to post to the server")
ap.add_argument("-u", "--user", required = True,
	help = "message to post to the server")
args = vars(ap.parse_args())
data = {"message": args['message'], "user": args["user"]}
with open('data.json', 'w') as outfile:
	json.dump(data, outfile)

#os.system(" curl --data @data.json -H \"Content-Type: application/json\" -X POST https://hs5cd09y1a.execute-api.us-east-2.amazonaws.com/default/chat")