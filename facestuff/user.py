import pickle
import argparse


ap = argparse.ArgumentParser()
ap.add_argument("-u", "--user", required=True,
	help="path to usrname")

args = vars(ap.parse_args())

username = pickle.loads(open(args["user"], "rb").read())
print(username)