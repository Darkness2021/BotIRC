ON 1:INVITE:#: { 
  if ($nick == $isADMIN($nick)) { 
    privmsg $canal(debug) $event(INVITE) He invitado al usuario $nick a $1
  }
}