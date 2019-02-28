Simple bash script to send messages with Pushover service (https://pushover.net), designed for IoT devices like routers or Raspberry PI. Works well on BuzyBox.

Usage:

```
./pushover.sh "message" "title" "sound"
```

- "message" is mandatory
- "title" is optional, otherwize local username and host will be shown
- "sound" is optional, see https://pushover.net/api#sounds for available sounds

Examples:

```
	`./pushover.sh "This is a test message"`
		only message
	./pushover.sh "Test message" "Test title" "echo"
		message with title and echo sound
	./pushover.sh "\`ls -la\`"
		output of command "ls -la"
```

You can customize script for other settings, like priority or device to send.
