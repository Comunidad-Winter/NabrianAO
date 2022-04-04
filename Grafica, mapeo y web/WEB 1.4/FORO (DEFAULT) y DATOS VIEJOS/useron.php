<?php
    /* ESTADISTICAS ONLINE AO -  */
    /* CONFIGURACIÓN: */
    $key = '4568';
    $serverip = 'nabrianao.ddns.net';
    $serverport = '10300';
    $archivo = 'estadisticas.html';
    $archivo1 = 'topusers.html';
    $archivo2 = 'topretos.html';
	$archivo3 = 'toptorneos.html';
	$archivo4 = 'topfrags.html';
	
    $showrecord = true;
    $showstate = true;
   
   /* Seguridad Falsa (? */
    $segcode = $_GET['keyp'];
   
    if ($segcode == $key) {
       
    /* Obtenemos los usuarios máximos del servidor, y la cantidad de usuarios Online */
    $pjscreados = $_GET['max'];
    $usersonl = $_GET['min'];
   
    /* Obtenemos el record de usuarios Online */
    $recordonl = $_GET['rec'];
	
    $user1 = $_GET['user1'];
    $user2 = $_GET['user2'];
    $user3 = $_GET['user3'];
    $user4 = $_GET['user4'];
    $user5 = $_GET['user5'];
    $user6 = $_GET['user6'];
    $user7 = $_GET['user7'];
    $user8 = $_GET['user8'];
    $user9 = $_GET['user9'];
    $user10 = $_GET['user10'];
	$user11 = $_GET['user11'];
	$user12 = $_GET['user12'];
	$user13 = $_GET['user13'];
	$user14 = $_GET['user14'];
	$user15 = $_GET['user15'];
	$user16 = $_GET['user16'];
	$user17 = $_GET['user17'];
	$user18 = $_GET['user18'];
	$user19 = $_GET['user19'];
	$user20 = $_GET['user20'];
	
	$LEVELUSER1 = $_GET['LEVELUSER1'];
    $LEVELUSER2 = $_GET['LEVELUSER2'];
    $LEVELUSER3 = $_GET['LEVELUSER3'];
    $LEVELUSER4 = $_GET['LEVELUSER4'];
    $LEVELUSER5 = $_GET['LEVELUSER5'];
    $LEVELUSER6 = $_GET['LEVELUSER6'];
    $LEVELUSER7 = $_GET['LEVELUSER7'];
    $LEVELUSER8 = $_GET['LEVELUSER8'];
    $LEVELUSER9 = $_GET['LEVELUSER9'];
    $LEVELUSER10 = $_GET['LEVELUSER10'];
	$LEVELUSER11 = $_GET['LEVELUSER11'];
	$LEVELUSER12 = $_GET['LEVELUSER12'];
	$LEVELUSER13 = $_GET['LEVELUSER13'];
	$LEVELUSER14 = $_GET['LEVELUSER14'];
	$LEVELUSER15 = $_GET['LEVELUSER15'];
	$LEVELUSER16 = $_GET['LEVELUSER16'];
	$LEVELUSER17 = $_GET['LEVELUSER17'];
	$LEVELUSER18 = $_GET['LEVELUSER18'];
	$LEVELUSER19 = $_GET['LEVELUSER19'];
	$LEVELUSER20 = $_GET['LEVELUSER20'];
	
    $userr1 = $_GET['userr1'];
    $userr2 = $_GET['userr2'];
    $userr3 = $_GET['userr3'];
    $userr4 = $_GET['userr4'];
    $userr5 = $_GET['userr5'];
    $userr6 = $_GET['userr6'];
    $userr7 = $_GET['userr7'];
    $userr8 = $_GET['userr8'];
    $userr9 = $_GET['userr9'];
    $userr10 = $_GET['userr10'];
	$userr11 = $_GET['userr11'];
	$userr12 = $_GET['userr12'];
	$userr13 = $_GET['userr13'];
	$userr14 = $_GET['userr14'];
	$userr15 = $_GET['userr15'];
	$userr16 = $_GET['userr16'];
	$userr17 = $_GET['userr17'];
	$userr18 = $_GET['userr18'];
	$userr19 = $_GET['userr19'];
	$userr20 = $_GET['userr20'];
	
	$userrr1 = $_GET['userrr1'];
    $userrr2 = $_GET['userrr2'];
    $userrr3 = $_GET['userrr3'];
    $userrr4 = $_GET['userrr4'];
    $userrr5 = $_GET['userrr5'];
    $userrr6 = $_GET['userrr6'];
    $userrr7 = $_GET['userrr7'];
    $userrr8 = $_GET['userrr8'];
    $userrr9 = $_GET['userrr9'];
    $userrr10 = $_GET['userrr10'];
	$userrr11 = $_GET['userrr11'];
	$userrr12 = $_GET['userrr12'];
	$userrr13 = $_GET['userrr13'];
	$userrr14 = $_GET['userrr14'];
	$userrr15 = $_GET['userrr15'];
	$userrr16 = $_GET['userrr16'];
	$userrr17 = $_GET['userrr17'];
	$userrr18 = $_GET['userrr18'];
	$userrr19 = $_GET['userrr19'];
	$userrr20 = $_GET['userrr20'];
	
	
	$UserRX1 = $_GET['UserRX1'];
    $UserRX2 = $_GET['UserRX2'];
    $UserRX3 = $_GET['UserRX3'];
    $UserRX4 = $_GET['UserRX4'];
    $UserRX5 = $_GET['UserRX5'];
    $UserRX6 = $_GET['UserRX6'];
    $UserRX7 = $_GET['UserRX7'];
    $UserRX8 = $_GET['UserRX8'];
    $UserRX9 = $_GET['UserRX9'];
    $UserRX10 = $_GET['UserRX10'];
	$UserRX11 = $_GET['UserRX11'];
	$UserRX12 = $_GET['UserRX12'];
	$UserRX13 = $_GET['UserRX13'];
	$UserRX14 = $_GET['UserRX14'];
	$UserRX15 = $_GET['UserRX15'];
	$UserRX16 = $_GET['UserRX16'];
	$UserRX17 = $_GET['UserRX17'];
	$UserRX18 = $_GET['UserRX18'];
	$UserRX19 = $_GET['UserRX19'];
	$UserRX20 = $_GET['UserRX20'];
	
	
	$usuario1 = $_GET['usuario1'];
    $usuario2 = $_GET['usuario2'];
    $usuario3 = $_GET['usuario3'];
    $usuario4 = $_GET['usuario4'];
    $usuario5 = $_GET['usuario5'];
    $usuario6 = $_GET['usuario6'];
    $usuario7 = $_GET['usuario7'];
    $usuario8 = $_GET['usuario8'];
    $usuario9 = $_GET['usuario9'];
    $usuario10 = $_GET['usuario10'];
	$usuario11 = $_GET['usuario11'];
	$usuario12 = $_GET['usuario12'];
	$usuario13 = $_GET['usuario13'];
	$usuario14 = $_GET['usuario14'];
	$usuario15 = $_GET['usuario15'];
	$usuario16 = $_GET['usuario16'];
	$usuario17 = $_GET['usuario17'];
	$usuario18 = $_GET['usuario18'];
	$usuario19 = $_GET['usuario19'];
	$usuario20 = $_GET['usuario20'];
	
	$userio1 = $_GET['userio1'];
    $userio2 = $_GET['userio2'];
    $userio3 = $_GET['userio3'];
    $userio4 = $_GET['userio4'];
    $userio5 = $_GET['userio5'];
    $userio6 = $_GET['userio6'];
    $userio7 = $_GET['userio7'];
    $userio8 = $_GET['userio8'];
    $userio9 = $_GET['userio9'];
    $userio10 = $_GET['userio10'];
	$userio11 = $_GET['userio11'];
	$userio12 = $_GET['userio12'];
	$userio13 = $_GET['userio13'];
	$userio14 = $_GET['userio14'];
	$userio15 = $_GET['userio15'];
	$userio16 = $_GET['userio16'];
	$userio17 = $_GET['userio17'];
	$userio18 = $_GET['userio18'];
	$userio19 = $_GET['userio19'];
	$userio20 = $_GET['userio20'];

	
    if ($showstate == true) {
        $checkstate = fsockopen($serverip,$serverport);
       
            if (!$checkstate) {
                /*OFFLINE */
                $online=true;
            } else {
                /* ONLINE */
                $online=false;
                fclose($checkstate);
            }
        }
   
    /* Generamos la información formateada en HTML */
        
        if ($online == true) {
            
        } else {
            
        }
    }

     $contenidoformateado = $contenidoformateado.' <html>
<head>
<link href="stylestats.css" rel="stylesheet" type="text/css" />
</head>
<p><span id="estadosv">Estado:</span><span id="estadosv1">Online</span><br></p>
<p><span id="estadosv1">Usuarios jugando: '.$usersonl.'<br><span></p>
<p><span id="estadosv1">Usuarios Creados: '.$pjscreados.'<br></span></p>';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo,"w+")){
        fwrite($fp,stripslashes($contenidoformateado));
    }
	
     $contenidoformateado1 = $contenidoformateado1.' <!doctype html>
<html>
<head>
<link href="statsindex.css" rel="stylesheet" type="text/css" />
</head>
<table width="212" height="244" border="0" style="table-layout: fixed">
  <tr>
    <td width="3"><span id="estadosv">P</span></td>
   <td width="10"><div align="left"><span id="estadosv1">-Nick</span></div></td>
    <td width="10"><span id="estadosv1">Lvl</span></td>
  </tr>
  <tr>
    <td><span id="estadosv"><img src="files/oro.png" width="32" height="32"> </span></td>
    <td><div align="left"><span id="estadosv">'.$user1.'</span></div></td>
    <td><div align="left"><span id="estadosv">'.$LEVELUSER1.'</span></td>
  </tr>
  <tr>
    <td><span id="estadosv"><img src="files/plata.png" width="32" height="32"> </span></td>
    <td><div align="left"><span id="estadosv">'.$user2.'</span></div></td>
    <td><div align="left"><span id="estadosv">'.$LEVELUSER2.'</span></td>
  </tr>
  <tr>
    <td><span id="estadosv"><img src="files/bronce.png" width="32" height="32"> </span></td>
    <td><div align="left"><span id="estadosv">'.$user3.'</span></div></td>
    <td><div align="left"><span id="estadosv">'.$LEVELUSER3.'</span></td>
  </tr>
  <tr>
    <td><span id="estadosv">4º</span></td>
    <td><div align="left"><span id="estadosv1">'.$user4.'</span></div></td>
    <td><div align="left"><span id="estadosv1">'.$LEVELUSER4.'</span></td>
  </tr>
  <tr>
    <td><span id="estadosv">5º</span></td>
    <td><div align="left"><span id="estadosv1">'.$user5.'</span></div></td>
    <td><div align="left"><span id="estadosv1">'.$LEVELUSER5.'</span></td>
  </tr>
  <tr>
    <td><span id="estadosv">6º</span></td>
    <td><div align="left"><span id="estadosv1">'.$user6.'</span></div></td>
    <td><div align="left"><span id="estadosv1">'.$LEVELUSER6.'</span></td>
  </tr>
  <tr>
    <td><span id="estadosv">7º</span></td>
    <td><div align="left"><span id="estadosv1">'.$user7.'</span></div></td>
    <td><div align="left"><span id="estadosv1">'.$LEVELUSER7.'</span></td>
  </tr>
  <tr>
    <td><span id="estadosv">8º</span></td>
    <td><div align="left"><span id="estadosv1">'.$user8.'</span></div></td>
    <td><div align="left"><span id="estadosv1">'.$LEVELUSER8.'</span></td>
  </tr>
  <tr>
    <td><span id="estadosv">9º</span></td>
    <td><div align="left"><span id="estadosv1">'.$user9.'</span></div></td>
    <td><div align="left"><span id="estadosv1">'.$LEVELUSER9.'</span></td>
  </tr>
  <tr>
    <td><span id="estadosv">10º</span></td>
    <td><div align="left"><span id="estadosv1">'.$user10.'</span></div></td>
    <td><div align="left"><span id="estadosv1">'.$LEVELUSER10.'</span></td>
  </tr>
</table>';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo1,"w+")){
        fwrite($fp,stripslashes($contenidoformateado1));
    }
	    $contenidoformateado2 = $contenidoformateado2.'
<head>
<link href="stylestats.css" rel="stylesheet" type="text/css" />
</head>
<table width="739" height="244" border="1" style="table-layout: fixed">
  <tr>
  <td width="40"><div align="center"><span id="estadosv1x">P</span></div></td>
    <td width="550"><div align="center"><span id="estadosv1x">NOMBRE DEL USUARIO </span></div></td>
    <td><div align="center"><span id="estadosv1x">RG</span></div></td>
  </tr>
  <tr>
   <td><span id="estadosv"><IMG SRC="files/oro.png"></span></td>
    <td width="509"><div align="center"><span id="estadosvx">'.$userr1.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr1.'</span></div></td>
  </tr>
  <tr>
   <td><span id="estadosv"><IMG SRC="files/plata.png"></span></td>
    <td height="23"><div align="center"><span id="estadosvx">'.$userr2.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userrr2.'</span></div></td>
  </tr>
  <tr>
   <td><span id="estadosv"><IMG SRC="files/bronce.png"></span></td>
    <td><div align="center"><span id="estadosvx">'.$userr3.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userrr3.'</span></div></td>
  </tr>
  <tr>
      <td><span id="estadosv">4º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$userr4.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userrr4.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">5º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$userr5.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userrr5.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">6º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$userr6.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userrr6.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">7º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$userr7.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userrr7.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">8º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$userr8.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userrr8.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">9º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr9.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr9.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">10º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr10.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr10.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">11º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr11.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr11.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">12º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr12.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr12.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">13º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr13.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr13.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">14º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr14.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr14.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">15º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr15.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr15.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">16º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr16.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr16.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">17º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr17.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr17.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">18º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr18.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr18.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">19º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr19.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr19.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">20º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$userr20.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userrr20.'</span></div></td>
  </tr>
</table>
';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo2,"w+")){
        fwrite($fp,stripslashes($contenidoformateado2));
    }
	
	    $contenidoformateado3 = $contenidoformateado3.'
<head>
<link href="stylestats.css" rel="stylesheet" type="text/css" />
</head>
<table width="739" height="244" border="1" style="table-layout: fixed">
  <tr>
  <td width="40"><div align="center"><span id="estadosv1x">P</span></div></td>
    <td width="550"><div align="center"><span id="estadosv1x">NOMBRE DEL USUARIO </span></div></td>
    <td><div align="center"><span id="estadosv1x">TORNEOS G</span></div></td>
  </tr>
  <tr>
  <td><span id="estadosv"><IMG SRC="files/oro.png"></span></td>
    <td width="509"><div align="center"><span id="estadosvx">'.$user1.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX1.'</span></div></td>
  </tr>
  <tr>
  <td><span id="estadosv"><IMG SRC="files/plata.png"></span></td>
    <td height="23"><div align="center"><span id="estadosvx">'.$user2.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$UserRX2.'</span></div></td>
  </tr>
  <tr>
  <td><span id="estadosv"><IMG SRC="files/bronce.png"></span></td>
    <td><div align="center"><span id="estadosvx">'.$user3.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$UserRX3.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">4º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$user4.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$UserRX4.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">5º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$user5.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$UserRX5.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">6º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$user6.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$UserRX6.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">7º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$user7.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$UserRX7.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">8º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$user8.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$UserRX8.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">9º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user9.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX9.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">10º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user10.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX10.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">11º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user11.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX11.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">12º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user12.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX12.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">13º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user13.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX13.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">14º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user14.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX14.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">15º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user15.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX15.'</span></div></td>
  </tr>
  <tr>
  <td><span id="estadosv">16º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user16.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX16.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">17º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user17.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX17.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">18º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user18.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX18.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">19º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user19.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX19.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv">20º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$user20.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$UserRX20.'</span></div></td>
  </tr>
</table>
';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo3,"w+")){
        fwrite($fp,stripslashes($contenidoformateado3));
    }
	
	    $contenidoformateado4 = $contenidoformateado4.'
<head>
<link href="stylestats.css" rel="stylesheet" type="text/css" />
</head>
<table width="739" height="244" border="1" style="table-layout: fixed">
  <tr>
  <td width="40"><div align="center"><span id="estadosv1x">P</span></div></td>
    <td width="550"><div align="center"><span id="estadosv1x">NOMBRE DEL USUARIO </span></div></td>
    <td><div align="center"><span id="estadosv1x">MATADOS</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv"><IMG SRC="files/oro.png"></span></td>
    <td width="509"><div align="center"><span id="estadosvx">'.$usuario1.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio1.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv"><IMG SRC="files/plata.png"></span></td>
    <td height="23"><div align="center"><span id="estadosvx">'.$usuario2.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userio2.'</span></div></td>
  </tr>
  <tr>
    <td><span id="estadosv"><IMG SRC="files/bronce.png"></span></td>
    <td><div align="center"><span id="estadosvx">'.$usuario3.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userio3.'</span></div></td>
  </tr>
  <tr>
      <td><span id="estadosv">4º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$usuario4.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userio4.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">5º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$usuario5.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userio5.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">6º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$usuario6.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userio6.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">7º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$usuario7.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userio7.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">8º</span></td>
    <td height="21"><div align="center"><span id="estadosv1x">'.$usuario8.'</span></div></td>
    <td><div align="center"><span id="estadosv1x">'.$userio8.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">9º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario9.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio9.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">10º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario10.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio10.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">11º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario11.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio11.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">12º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario12.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio12.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">13º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario13.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio13.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">14º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario14.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio14.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">15º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario15.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio15.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">16º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario16.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio16.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">17º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario17.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio17.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">18º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario18.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio18.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">19º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario19.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio19.'</span></div></td>
  </tr>
  <tr>
        <td><span id="estadosv">20º</span></td>
    <td width="509"><div align="center"><span id="estadosv1x">'.$usuario20.'</span></div></td>
    <td width="214"><div align="center"><span id="estadosv1x">'.$userio20.'</span></div></td>
  </tr>
</table>
';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo4,"w+")){
        fwrite($fp,stripslashes($contenidoformateado4));
    }

	
?>








