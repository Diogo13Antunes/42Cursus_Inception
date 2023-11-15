import subprocess
import os
import time

# DEVIDER
devider = "---------------------------------------------------------------"

ongoing_session_name = "ongoing_session"
normal_session = "normal_session"


def command_choose():
	while 1:
		os.system("clear")
		command_choose = ""
		session = ""
		print(devider)
		print("Manipulate docker\nChoose an option:")
		print(devider)
		print(" 1 | Build with docker-compose")
		print(" 2 | Start with docker-compose")
		print(" 3 | End with docker-compose")
		print(" 4 | Show all containers")
		print(" 5 | Access specific Conteiner")
		print(" 6 | Exit current Container")
		print(devider)
		print(" 0 | Exit")
		print("-1 | Clear Terminal 1 (ongoing)")
		print("-2 | Clear Terminal 2 (normal)")
		print(devider)
		opt = input("Option: ")
		if opt == "0":
			choosen_command = ""; exit(1)
		elif opt == "-1":
			choosen_command = f'"clear"'; session = ongoing_session_name
		elif opt == "-2":
			choosen_command = f'"clear"'; session = normal_session
		elif opt == "1":
			choosen_command = f'"clear && docker-compose build"'; session = normal_session
		elif opt == "2":
			choosen_command = f'"clear && docker-compose up -d"'; session = ongoing_session_name
		elif opt == "3":
			choosen_command = f'"clear && docker-compose down"'; session = normal_session
		elif opt == "4":
			choosen_command = f'"clear && docker ps && echo"'; session = normal_session
		elif opt == "5":
			choosen_command = "clear && docker exec -it " + input("Container Name: ") + " /bin/bash"
			choosen_command = f'"{choosen_command}"'
			session = normal_session
		elif opt == "6":
			choosen_command = f'"clear && exit"'; session = normal_session
		else:
			print("Invalid Option")
			time.sleep(1)
		print(choosen_command)
		print(session)
		if choosen_command != "":
			subprocess.run(['tmux', 'send-keys', '-t', session, f'"{choosen_command}"', 'C-m'])

command_choose()
