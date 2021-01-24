/**
*
* Devuelve la versión actual de CORE.
*
* @const $CORE_VERSION
*
*/
alias CORE_VERSION { return 0.1.3 }

/**
*
* Devuelve la ruta de la carpeta MAIN
*
* @const $MAIN_FOLDER
*
* @global
*
*/
alias MAIN_FOLDER { return $deltok($scriptdir,-1,92) }
/**
*
* Devuelve la ruta que contiene los archivos de configuración.
*
* @const $DATA_FOLDER
*
* @global
*
*/
alias DATA_FOLDER { return $+($MAIN_FOLDER,\data\) }

/**
*
* Devuelve la ruta del archivo de configuración.
*
* @const $CONFIGURATION_FILE
*
* @global
*
*/
alias CONFIGURATION_FILE { return $+($DATA_FOLDER,config.ini) }

/**
*
* Devuelve el nombre del proyecto actual.
*
* @const $SERVICE_NAME
*
* @global
*
*/
alias SERVICE_NAME { return RadioDarkness }

/**
*
* Devuelve la versión actual del proyecto.
*
* @const $SERVICE_VERSION
*
* @global
*
*/
alias SERVICE_VERSION { return 0.0.1 }

/**
*
* Returns the current modules of the project.
*
* @const $MODULES_FOLDER
*
* @global
*
*/
alias MODULES_FOLDER { return $+($MAIN_FOLDER,\src\modules\) }

/**
*
*  Returns the current public folder of the project.
*
* @const $PUBLIC_FOLDER
*
* @global
*
*/
alias PUBLIC_FOLDER { return $+($MAIN_FOLDER,\src\public\) }

alias TEMPLATE_FOLDER { return $+($MAIN_FOLDER,\templates) }
alias TEMPLATE_FOLDER_PARRILLA { return $+($TEMPLATE_FOLDER,\parrilla) }
alias TEMPLATE_FOLDER_DOC { return $+($TEMPLATE_FOLDER_PARRILLA,\plantilla_parrilla.sql) }

/**
*
* Devuelve el texto en minusculas y con el color especificado para &primary (por defecto azul (12))
*
* @const _URL
*
* @param String URL  
*
* @global
*
*/
alias _url { return $theme(&primary;,$lower($1)) } 

/**
*
* Devuelve la URL interna del servicio.
*
* @const www
*
* @param String <URL>  
*
* @global
*
*/

alias www { 
  if ($1 == public) { return $_url($+(https://chatradiodarkness.blogspot.com/)) }
  if ($1 == locutores) { return $_url($+(https://chatradiodarkness.blogspot.com/#djs)) }
  if ($1 == horarios) { return $_url($+(https://chatradiodarkness.blogspot.com/#horarios)) }
}


/**
*
* Outputs error message and halts process.
*
* @command /errorservice
*
* @param <message>  The message to be displayed.
*
* @global
*
*/
alias errorservice {
  if (!$isid) { 
    if ($config(local_channels,debug) == $null) { echo -ces info * $1-  }
    else { msg $canal(debug) $theme([&danger;],ERROR) $1- }

    halt

    :error
    reseterror

    echo -ces info * $1-
  }
  else {
    echo -ces info * error: no es un identificador
  }

  halt
}
alias noaccess {
  if (!$isid) { 
    msg $1 $theme([&danger;],Acceso Denegado) 
    halt
    :noaccess
    resetnoaccess
    msg %c_debug $theme([&danger;],Acceso Denegado) $2-
  }
  else {
    echo -ces info * noaccess: No es un identificador
  }
  halt
}