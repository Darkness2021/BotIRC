/**
*
* Changes/adds information to the configuration file.
*
* @command /config
*
* @param <section>  Information section
* @param <data>     Data name
* @param <value>    Data's value
*
* @global
*
*/
/**
*
* Gets information from the configuration file.
*
* @identifier $config
*
* @param <section>  Information section
* @param <data>     Data name
*
* @returns  Information from the specified section and data name.
*
* @global
*
*/
alias config {
  if ($exists($LOCAL_CONFIG_FILE)) { 
    set %file $LOCAL_CONFIG_FILE
  }
  else { 
    set %file $CONFIGURATION_FILE
  }
  if (!$isid) {
    write -n %file $$1 $$2 $$3-
  }
  else {
    return $readini(%file,n,$$1,$$2)
  }
}

/**
*
* Colorizes text.
*
* @identifier $colorize
*
* @param <color>  Type of color &primary;, &secondary;, &success;, &danger;, &warning;, &info;, &light;, or &dark;.
* @param <text>   Text to be colorized.
*
* @returns  The colorized text.
*
* @global
*
*/
alias colorize {
  if ($isid) {
    set -l %color $color(text)

    if ($1 == $+($chr(38),primary,$chr(59))) set -l %color $config(theme,primary)
    elseif ($1 == $+($chr(38),secondary,$chr(59))) set -l %color $config(theme,secondary)
    elseif ($1 == $+($chr(38),success,$chr(59))) set -l %color $config(theme,success)
    elseif ($1 == $+($chr(38),danger,$chr(59))) set -l %color $config(theme,danger)
    elseif ($1 == $+($chr(38),warning,$chr(59))) set -l %color $config(theme,warning)
    elseif ($1 == $+($chr(38),info,$chr(59))) set -l %color $config(theme,info)
    elseif ($1 == $+($chr(38),light,$chr(59))) set -l %color $config(theme,light)
    elseif ($1 == $+($chr(38),dark,$chr(59))) set -l %color $config(theme,dark)
    elseif ($1 == $+($chr(38),bold,$chr(59))) return $+($chr(2),$chr(32),$chr(36),+,$chr(32),$2,$chr(15))
    elseif ($1 == $+($chr(38),underline,$chr(59))) return $+($chr(31),$chr(32),$chr(36),+,$chr(32),$2,$chr(15))

    return $+($chr(3),%color,$chr(32),$chr(36),+,$chr(32),$2,$chr(15))
  }
  else {
    echo -ces info * colorize: is not a command

    halt
  }
}

/**
*
* Replaces text with theme. 
*
* @identifier $theme
*
* @param <text>                         The text to be replaced, utilize color type.
* @param <replacement[, replacement]>   The replacement text to replace the color type.
*
* @returns  The colorized text.
*
* @global
*
*/
alias theme {
  if ($isid) {
    set -l %reg /(&(?:primary|secondary|success|danger|warning|info|light|dark|normal|bold|underline);)/g

    return [ [ $regsubex($1,%reg, $colorize(\t,$chr(36) $+ $calc(\n + 1))) ] ] 
  }
  else {
    echo -ces info * theme: is not a command

    halt
  }
}

/**
*
* Outputs error message and halts process.
*
* @command /error
*
* @param <message>  The message to be displayed.
*
* @global
*
*/
alias error {
  if (!$isid) { 
    if ($config(channels,debug) == $null) { echo -ces info * $1-  }
    else { msg %c_debug $theme([&danger;],ERROR) $1- }

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
/**
*
* @command /icons 
* 
* @param <path> ruta de la carpeta donde se almacenan los iconos del proyecto principal
* @param <archivo> devuelve la ruta completa del archivo *.ico 
*
* @global
*/
alias icons { 
  if ($isid) {
    set %path $+($MAIN_FOLDER,\icons\)
    set %archivo $+(%path,$1)
    if (!%archivo) { error Debe especificar un archivo *.ico }
    if ($exists(%archivo) == $false) { error El archivo $1 no existe. }
    if ($isfile(%archivo) == $false) { error $1 no es un archivo, especifique un archivo *.ico }
    if ($exists(%archivo) == $true) && $isfile(%archivo) == $true) && $right(%archivo,4) != .ico)) { error la extensión $right(%archivo,4) no es válida. El archivo debe contener la extensión *.ico }
    return %archivo
    unset %path %archivo
  }
  else {
    echo -ces info * icons: no es un identificador
  }
}
alias serialpassword { 
  var %letters = $rand(A,Z) $+ $rand(0,9) $+ $rand(A,Z) $+ $rand(A,Z)
  var %numbers = $rand(0,9) $+ $rand(A,Z) $+ $rand(0,9) $+ $rand(0,9)
  var %letters2 = $rand(R,Z) $+ $rand(a,z) $+ $rand(A,Z) $+ $rand(A,Z)
  var %numbers2 = $rand(0,9) $+ $rand(0,9) $+ $rand(0,9) $+ $rand(0,9)
  set %serial %letters $+ %numbers $+ %letters2 $+ %numbers2 
  msg $active %serial
  unset %serial %letter* %number*
}
