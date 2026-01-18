/datum/tgs_chat_command/ooc
	name = "ooc"
	help_text = "Sends an OOC message to the server."

/datum/tgs_chat_command/ooc/Run(datum/tgs_chat_user/sender, params)
	TgsOoc(params, sender.friendly_name)
	send2chat("IRC: <[sender.friendly_name]> [params]","ooc")
	return new /datum/tgs_message_content("")


#define TGS_OOC_USAGE "Usage: ooc <message>"
/proc/TgsOoc(msg,sender)
	var/keyname = "<font color='green'><i title='This user is connected to IRC and may not be in game.'>[sender]</i></font>"

	var/message = strip_html(msg) // Why this is needed: https://transfur.science/ql46uynr
	//The linkify span classes and linkify=TRUE below make ooc text get clickable chat href links if you pass in something resembling a url
	for(var/client/C in GLOB.clients)
		if(C.prefs.chat_toggles & CHAT_OOC)
			if(sender in C.prefs.ignoring)
				continue

			if(!(sender in C.prefs.ignoring))
				if(GLOB.OOC_COLOR)
					to_chat(C, "<span class='oocplain'><font color='[GLOB.OOC_COLOR]'><b><span class='prefix'>IRC:</span> <EM>[keyname]:</EM> <span class='message linkify'>[message]</span></b></font></span>", MESSAGE_TYPE_OOC)
				else
					to_chat(C, "<span class='ooc'><span class='prefix'>IRC:</span> <EM>[keyname]:</EM> <span class='message linkify'>[message]</span></span>", MESSAGE_TYPE_OOC)

/client/ooc(msg as text)
	. = ..()
	var/raw_msg = trim(copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN))
	send2chat("OOC: <[key]> [raw_msg]", "ooc")
