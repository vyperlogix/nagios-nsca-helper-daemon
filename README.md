nagios-nsca-helper-daemon
=========================

Nagios NSCA Helper (Daemon)

=========================

The Nagios NSCA Help Daemon performs the following functions:

A REST Web Service will be established for the IP-Address and port specified by the command line
found in run.sh, typically 0.0.0.0:15667.

The following creates a Nagios config file for the specified host given a set of services.

http://ip-address:15667/nsca/nagios/create/config

POST

	{"oper": "login",
	"username": "nscahelper",
	"password": "103136174d231aabe1de8feaf9afc92f",
	"target": "nagios.cfg",
	"cfg": "remote1_nagios2",
	"partitions": "awk '{print $4}' /proc/partitions | sed -e '/name/d' -e '/^$/d' -e '/[1-9]/!d'",
	"host1": {
		"use": "generic-host",
		"host_name": "remote1",
		"alias": "remote1",
		"address": "0.0.0.0"
	},
	"command1": {
		"command_name": "dummy_command_remote1",
		"command_line": "echo \"0\""
	          },
	  "service1": { "use":"generic-service",
	                "host_name":"remote1",
			"service_description":"CPULoad",
			"active_checks_enabled":"0",
			"passive_checks_enabled":"1",
			"check_command":"dummy_command_remote1"
	          },
	  "service2": { "use":"generic-service",
	                "host_name":"remote1",
			"service_description":"CurrentUsers",
			"active_checks_enabled":"0",
			"passive_checks_enabled":"1",
			"check_command":"dummy_command_remote1"
	          },
	  "service3": { "use":"generic-service",
	                "host_name":"remote1",
			"service_description":"PING",
			"active_checks_enabled":"0",
			"passive_checks_enabled":"1",
			"check_command":"dummy_command_remote1"
	          },
	  "service4": { "use":"generic-service",
	                "host_name":"remote1",
			"service_description":"SSH",
			"active_checks_enabled":"0",
			"passive_checks_enabled":"1",
			"check_command":"dummy_command_remote1"
	          },
	  "service5": { "use":"generic-service",
	                "host_name":"remote1",
			"service_description":"TotalProcesses",
			"active_checks_enabled":"0",
			"passive_checks_enabled":"1",
			"check_command":"dummy_command_remote1"
	          },
	  "service6": { "use":"generic-service",
	                "host_name":"remote1",
			"service_description":"ZombieProcesses",
			"active_checks_enabled":"0",
			"passive_checks_enabled":"1",
			"check_command":"dummy_command_remote1"
	          }
	  }


The following issues an NSCA message, as a convenience, to facilitate NSCA message handling.
The same NSCA message could also be sent using port 5667 assuming there is an NSCA daemon
listening on that port and Nagios has been properly configured to handle NSCA messages.

http://ip-address:15667/nsca/nagios/send/nsca

POST

	{ "oper":"login",
	  "username":"nscahelper",
	  "password":"103136174d231aabe1de8feaf9afc92f",
	  "send_nsca": "localhost\\tDummy Service\\t2\\tlocalhost Mon Dec 23 22:03:50 UTC 2013",
	  "cfg":"/etc/send_nsca.cfg"
	}


You should craft your own NSCA messages by replacing the value for "send_nsca" with your own
message content.


You can make your own Linux Service by following these instructions:

1 - Copy your script into /etc/init.d folder
2 - cd /etc/init.d
3 - chmod +x myscript
4 - Add these lines, including #, right after #!/bin/bash or #!/bin/sh:

# chkconfig: 2345 95 20
# description: Some description
# What your script does (not sure if this is necessary though)
# processname: myscript

5 - chkconfig –level 2345 myscript on


You can also make your own poor-man's Linux Service by adding a crontab to execute run.sh 
via nohup or the like.

