/**
*
* Identifica al usuario que sale en la sala como administrador/a del bot.
*
* @event PART
*
*/
on 1:PART:#: {
  isADMIN $nick 
}