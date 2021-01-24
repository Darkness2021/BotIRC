/**
*
* Identifica al usuario que sale del servidor.
*
* @event DISCONNECT
*
*/
on 1:DISCONNECT: {
  if ($network == IRC-Hispano) { 
  if ($nick == $isADMIN($nick)) {
    privmsg $canal(debug) $event(CONNECT) $NICK ha desconectado de $network
    }
  }
}