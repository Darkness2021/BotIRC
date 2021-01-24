/**
*
* Description...
*
* @command /event
*
* @global
*
*/
alias -l event {
  if (!$isid) {
    if ($1 == CONNECT) || ($1 == JOIN) || ($1 == INVITE) { 
      return $theme(&success;,$1)
    }
    elseif ($1 == DISCONNECT) || ($1 == PART) || ($1 == KICK) { 
      return $theme(&danger;,$1)
    }
    elseif ($1 == NOTIFY) || ($1 == UNOTIFY) || ($1 == NOTICE) { 
      return $theme(&warning;,$1)
    }
  }
  else {
    echo -ces info * event: No es un identificador
    halt
  }
}