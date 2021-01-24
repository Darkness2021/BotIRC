/**
*
* Identifica al usuario que entra en la sala como administrador/a del bot.
*
* @event CONNECT
*
*/
on 1:CONNECT:IRC-Hispano: {
  if ($nick == $isADMIN($nick)) {
    privmsg $canal(debug) $event(CONNECT) $NICK ha entrado a conectado a IRC-Hispano
    invite $nick $canal(locutores)
    invite $nick $canal(general)
    invite $nick $canal(debug)
  }
}