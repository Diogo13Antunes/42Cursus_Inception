#!/usr/bin/env python3

import os
import time

env_variables = os.environ

for key, value in env_variables.items():
	if key == "MARIADB_DATABASE_NAME":
		db_name = value
	elif key == "MARIADB_DATABASE_ADMIN":
		db_admin_name = value
	elif key == "MARIADB_DATABASE_ADMIN_PASS":
		db_admin_pass = value

db_directory = "/var/lib/mysql/" + db_name

def directory_exists(dir_path):
	if os.path.exists(dir_path) and os.path.isdir(dir_path):
		return True
	return False

def start_mariabd():
	os.system("/etc/init.d/mariadb start")

def stop_mariadb():
	os.system("/etc/init.d/mariadb stop")

def create_database():
	cmd = "mysql -u root -e \"CREATE DATABASE " + db_name + ";\""
	os.system(cmd)

def create_database_user():
	cmd = "mysql -u root -e \"CREATE USER '" + db_admin_name + "'@'%' IDENTIFIED BY '" + db_admin_pass + "';\""
	os.system(cmd)

def grant_all_privileges():
	cmd = "mysql -u root -e \"GRANT ALL PRIVILEGES ON *.* TO '" + db_admin_name + "'@'%';\""
	os.system(cmd)

def apply_privileges():
	cmd = "FLUSH PRIVILEGES;"
	os.system(cmd)

print("DB_NAME     -> " + db_name)
print("DB_ADM_NAME -> " + db_admin_name)
print("DB_ADM_PASS -> " + db_admin_pass)

if directory_exists(db_directory):
	start_mariabd()
	time.sleep(2)
	create_database()
	create_database_user()
	grant_all_privileges()
	apply_privileges()
	stop_mariadb()
else:
	start_mariabd()
	time.sleep(2)
	stop_mariadb()
	print("Database is already benn configured.")

print("Database status -> OK")

os.system("mysqld --bind-address=0.0.0.0")
