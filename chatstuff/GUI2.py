from tkinter import (Tk, BOTH, Text, E, W, S, N, END, 
    NORMAL, DISABLED, StringVar)
from tkinter.ttk import Frame, Label, Button, Progressbar, Entry
from tkinter import scrolledtext
import readGET
import argparse
import os
import jsonscript
root = Tk()

#l2.grid(row=0, columnspan = 2,  sticky= W+E)

ap = argparse.ArgumentParser()

ap.add_argument("-u", "--user",  required = True,
	help = "name of the current user")


args = vars(ap.parse_args())

idCount = readGET.highestID()

def push():
	global args
	global idCount
	message = args["user"] + " : "+E1.get()
	jsonscript.sendMessage(E1.get(), args["user"])
	#os.system("python jsonscript.py --message \""+ str(E1.get())+"\" --user "+args["user"])
	os.system("curl --silent --output nul --data @data.json -H \"Content-Type: application/json\" -X POST https://0ym0hvjsll.execute-api.us-east-2.amazonaws.com/default/chat")
	idCount  += 1
	txt.configure(state = "normal")
	txt.insert(END, message+ "\n") # Instead of returning it, why not just insert it here?
	txt.configure(state = "disabled")
	E1.delete(0, 'end')
	txt.see("end")

def loop():
	
	global idCount
	if readGET.newMessage(idCount):
		f = open("messages.txt", "r")
		lines = f.readlines()
		for line in lines:
			txt.configure(state = "normal")
			txt.insert(END, line) # Instead of returning it, why not just insert it here?
			txt.configure(state = "disabled")
			txt.see("end")
		f.close()
		idCount += len(lines)


	root.after(1000, loop)





#l1select = l1.bind('<<ListboxSelect>>',lambda event: onselect(event, 'Test'))
txt = scrolledtext.ScrolledText(root)  
txt.grid(row=0, column=0, rowspan=3, padx=10, pady=5,
		columnspan=3, sticky=E+W+S+N)
txt.configure(state = "disabled")
E1 = Entry(root)
E1.grid(row = 4, columnspan = 3, sticky = E+W)


E1.bind("<Return>", lambda event = None: push())
E1.focus()




root.after(1000, loop)
root.mainloop()