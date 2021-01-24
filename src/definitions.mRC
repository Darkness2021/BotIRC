/**
*
* Returns the current name of the project.
*
* @const $SERVICE_NAME
*
* @global
*
*/
alias SERVICE_NAME { return RadioPrincesas }

/**
*
* Returns the current version of the project.
*
* @const $SERVICE_VERSION
*
* @global
*
*/
alias SERVICE_VERSION { return 0.0.3 }

/**
*
* Returns the current modules of the project.
*
* @const $MODULES_FOLDER
*
* @global
*
*/
alias MODULES_FOLDER { return $+($MAIN_FOLDER,\src\ $+ $SERVICE_NAME $+ \modules\) }

/**
*
*  Returns the current public folder of the project.
*
* @const $PUBLIC_FOLDER
*
* @global
*
*/
alias PUBLIC_FOLDER { return $+($MAIN_FOLDER,\src\ $+ $SERVICE_NAME $+ \public\) }

/**
*
*  Returns the folder where the local configuration file for the current project is stored.
*
* @const $LOCAL_CONFIG
*
* @global
*
*/
alias LOCAL_CONFIG { return $+($DATA_FOLDER,$SERVICE_NAME) }

/**
*
*  Returns the current config local file of the project.
*
* @const $LOCAL_CONFIG
*
* @global
*
*/
alias LOCAL_CONFIG_FILE { return $+($LOCAL_CONFIG,\config.ini) }
alias TEMPLATE_FOLDER { return $+($MAIN_FOLDER,\templates) }
alias TEMPLATE_FOLDER_PARRILLA { return $+($TEMPLATE_FOLDER,\parrilla) }
alias TEMPLATE_FOLDER_DOC { return $+($TEMPLATE_FOLDER_PARRILLA,\plantilla_parrilla.sql) }
/**
*
* Devuelve la versión del comando ACL
*
* @const $ACL_VERSION
*
* @global
*
*/
alias ACL_VERSION { return 0.0.11 }

/*
*
* Devuelve el número hash del último commit para el comando ACL
*
* @const $ACL_COMMIT
*
* @global
*
*/

alias ACL_COMMIT { return 75d26a2971 }


/*
*
* Devuelve el mensaje del último commit para el comando ACL
*
* @const $ACL_COMMIT_MESSAGE
*
* @global
*
*/

alias ACL_COMMIT_MESSAGE { return ACL DEL fix }


/**
*
* Devuelve la fecha de publicación del último commit para el comando ACL
*
* @const $ACL_COMMIT_DATE
*
* @global
*
*/
alias ACL_COMMIT_DATE { return 2020-06-09 }


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
  if ($1 == public) { return $_url($+(https://iradio.ircservices.cloud/public/,$SERVICE_NAME)) }
  if ($1 == podcast) { return $_url($+(https://iradio.ircservices.cloud/public/,$SERVICE_NAME,/ondemand)) }
}
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
    else { msg %lc_debug $theme([&danger;],ERROR) $1- }

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
