<?php
//determin la direccion de descarga
$url_descarga="http://www.mediafire.com/file/6jw00hv0gw0va2g/setupNAO%20v.1.4b.exe";
 
if (is_writeable("contador.txt"))//contador
{
	$arrayfichero=file("contador.txt");
	$arrayfichero[0]++;
	$fichero=fopen("contador.txt","w");
	$grabar=fwrite($fichero,$arrayfichero[0]);
	$cerrar=fclose($fichero);
}
header("location:$url_descarga");
?>