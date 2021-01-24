/**
*
* Carga todos los archivos necesarios.
*
* @event load
*
*/
on *:load: {
  .load -rs $qt($scriptdirdefinitions.mrc)
  .load -rs $qt($scriptdirlistener.mrc)
}