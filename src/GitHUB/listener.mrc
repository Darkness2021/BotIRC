/**
*
* Creates a listening server.
*
* @command /createListener
*
* @global
*
*/
alias createListener {
  if (!$isid) && (!$sock(listener)) socklisten listener 7777
  else error createListener: is not an identifier
}

/**
*
* Verifies that incoming connection's IP is that of the project host.
*
* @event socklisten
*
*/
on *:socklisten:listener: {
  sockaccept listener_temp
  echo -s : $sock(listener_temp).ip
  if ($sock(listener_temp).ip == $config(project,host)) && (!$sock(listener_check)) {
    sockrename listener_temp listener_check
  }
  else {
    sockclose listener_temp
  }
}

/**
*
* Reads the information being transfered and puts it in a temp file
*
* @event sockread
*
*/
on *:sockread:listener_check: {
  set -l %temp

  sockread %temp

  tokenize 32 $sock(listener_check).mark

  if (%temp == $null) {
    if ($1 == header) {
      sockmark listener_check body $2 $3
    }
    else {
      sockmark listener_check eof $2 $3

      sockwrite -tn listener_check HTTP/1.1 200 OK
      sockwrite -tn listener_check Date: $asctime(ddd $+ $chr(44) d m yyyy h:n:s) GTM
      sockwrite -tn listener_check Content-Type: text/html
      sockwrite -tn listener_check Content-Length: 80
      sockwrite -tn listener_check
      sockwrite -tn listener_check <html>
      sockwrite -tn listener_check <body>
      sockwrite -tn listener_check <h1>You must construct additional pylons!</h1>
      sockwrite -tn listener_check </body>
      sockwrite -tn listener_check </html>
      sockwrite -tn listener_check
    }
  }
  elseif ($0 == 0) {
    tokenize 32 %temp

    if ($1 == X-Gitea-Event:) {
      sockmark listener_check header $2 $ticks
    }
  }
  elseif ($1 == body) 
  write $qt($+($DATA_FOLDER,temp_,$2,_,$3)) %temp
  echo -s $qt($+($DATA_FOLDER,temp_,$2,_,$3))
}

/**
*
* Verifies that the date file exists upon connection closing.
*
* @event sockclose
*/
on *:sockclose:listener_check: {
  tokenize 32 $sock(listener_check).mark

  set -l %file $+($DATA_FOLDER,temp_,$2,_,$3)

  if ($isfile(%file)) {
    set -l %status $config(system,status)

    if ((%status == dev) && ($2 == push)) || ($2 == release) {
      ; this line adds a { at the end of the file, which should not be necessary but it is
      write $qt(%file) $chr(125)

      if ($jsonCreate(update,%file)) {
        echo -a Repository: $jsonGet(update,repository,name)
        echo -a Contributed by: $jsonGet(update,pusher,username)

        noop $jsonDestroy(update)
      }
      else error JSON Failed $v1
    }

    .remove $qt(%file)
  }
}
