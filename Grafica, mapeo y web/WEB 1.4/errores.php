<head>
<link rel="shortcut icon" href="favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>NabrianAO Fixes</title>
<style type="text/css">.rojoneg{color:#F00;font-weight:bold;}.verdeneg{color:#0C0;font-weight:bold;}body,td,th{font-family:Arial,sans-serif;font-size:14px;color:#000;}body{background-color:#FFF;}#container{width:800px;margin:0 auto;}#solucion{width:800px;background-color:#F00;font-size:18px;padding-top:20px;padding-bottom:20px;color:#FFF;text-align:center;font-weight:bold;}</style>
</head>
<body>
<div id="container">
<div id="solucion">FIX 1: NabrianAO Client dejó de funcionar / El juego se cierra cuando termina de cargar</div>
<br>
Problema: Al abrir el juego, NabrianAO deja de responder. (Error común Windows 7/8)<br>
Solución:<br>
1. Ve a las Propiedades del ejecutable de NabrianAO, haciendo click derecho sobre este y eligiendo Propiedades, tal como se ve en la ilustración.<br>
<br>
<img src="files/fix1.jpg" width="475" height="157"> <br>
<br>
2. Ve a la pestaña Compatibilidad en el menú de Propiedades y tilda Ejecutar este programa en modo de compatibilidad para: Windows XP (Service Pack 2) (o Windows Vista si este no resulta) y tilda Ejecutar este programa como administrador. (Si tiene Windows 8 o 10, hacer click en "Cambiar configuración para todos los usuarios" y tildar las mismas opciones)<br>
<br>
<img src="files/fix2.jpg" width="376" height="517"><br>
<br>
3. Presione aceptar e inicie el juego nuevamente. Si este método no solucionó el problema, pida ayuda en el <a href="http://foro.nabrianao.com/" target="_new">foro</a>.<br>
<br>
<hr>
<div id="solucion">FIX 2: Error Fatal: ActiveX Component cant create object / otros errores fatales</div>
<br>
Problema: Al iniciar el juego, ocurren errores como "Component X doesn't work" o un error grave mientras carga.<br>
Solución: Ejecute el Launcher (ErroresFIX.exe), Una vez que finalice el proceso, ejecute el juego nuvamente. Si este método no solucionó el problema, pida ayuda en el <a href="http://foro.nabrianao.com/" target="_new">foro</a>.<br>
<br>
<hr>
<div id="solucion">FIX 3: Problemas de actualización del juego</div>
<br>
Problema: El AutoUpdater no actualizó correctamente y el juego no funciona. - El juego no funciona luego de una actualización o hay errores - Al conectarme me pide actualizar, y cuando actualizo no hay actualizaciones nuevas<br>
Solución:<a href="http://nabrianservidor.ddns.net/aup/"> Baje los parches manuales desde aquí,</a> Si este método no solucionó el problema, pida ayuda en el <a href="http://foro.nabrianao.com/" target="_new">foro</a>.
<hr>
<div id="solucion">FIX 4: DD3DDevice no puede iniciar</div>
<br>
Problema: DD3Device no puede iniciar<br>
Solución: Este error puede tener diferentes causas. Una es que la librería de DX8 no este registrada (realizá la solucion del problema Nº2 "Error Fatal: Activex...") o que tu computadora no soporte esta versión de DirectX, y no haya forma de que juegues si no lo soporta.
<hr>
<div id="solucion">FIX 5: Al logear, el juego se cierra y me dice que ya está abierto y no es posible correr otra instancia</div>
<br>
Para solucionar este error comun al intentar logear, debe cerrar el proceso NABRIANAO.exe del administrador de tareas y luego intentar nuevamente entrar. Si no funciona, intente reiniciar su equipo.