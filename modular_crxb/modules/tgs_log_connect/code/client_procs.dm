/datum/config_entry/string/chat_log_connects
	config_entry_value = "admin"

/datum/config_entry/string/chat_log_disconnects
	config_entry_value = "admin"

/client/New(TopicData)
	. = ..()
	//Useful for very small servers that might get one or two players a day & you want to know about them
	if(CONFIG_GET(string/chat_log_connects))
		send2chat("[key_name(src)] has connected", CONFIG_GET(string/chat_log_connects))

/client/Destroy()
	if(CONFIG_GET(string/chat_log_disconnects))
		send2chat("[key_name(src)] has disconnected", CONFIG_GET(string/chat_log_disconnects))
	. = ..()
