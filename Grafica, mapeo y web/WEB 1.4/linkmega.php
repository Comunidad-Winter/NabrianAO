<?php
//determin la direccion de descarga
$url_descarga="https://mega.nz/#!bUthCapA!jEDx-wfJAzDoTt58r45TAjrl3OnH2dd-7L0hbta_dDY";
 
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