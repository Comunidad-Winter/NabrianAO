<?php
    /* ESTADISTICAS ONLINE AO -  */
    /* CONFIGURACIÓN: */
    $key = '4568';
    $serverip = 'nabrianao.ddns.net';
    $serverport = '10300';
	$archivo5 = 'topgeneral1.html';
	
    $showrecord = true;
    $showstate = true;
   
   /* Seguridad Falsa (? */
    $segcode = $_GET['keyp'];
   
    if ($segcode == $key) {
       
$da1 = $_GET['da1'];
$da2 = $_GET['da2'];
$da3 = $_GET['da3'];
$da4 = $_GET['da4'];
$da5 = $_GET['da5'];
$da6 = $_GET['da6'];
$da7 = $_GET['da7'];
$da8 = $_GET['da8'];
$da9 = $_GET['da9'];
$da10 = $_GET['da10'];
$da11 = $_GET['da11'];
$da12 = $_GET['da12'];
$da13 = $_GET['da13'];
$da14 = $_GET['da14'];
$da15 = $_GET['da15'];
$da16 = $_GET['da16'];
$da17 = $_GET['da17'];
$da18 = $_GET['da18'];
$da19 = $_GET['da19'];
$da20 = $_GET['da20'];
$da21 = $_GET['da21'];
$da22 = $_GET['da22'];
$da23 = $_GET['da23'];
$da24 = $_GET['da24'];
$da25 = $_GET['da25'];
$da26 = $_GET['da26'];
$da27 = $_GET['da27'];
$da28 = $_GET['da28'];
$da29 = $_GET['da29'];
$da30 = $_GET['da30'];
$da31 = $_GET['da31'];
$da32 = $_GET['da32'];
$da33 = $_GET['da33'];
$da34 = $_GET['da34'];
$da35 = $_GET['da35'];
$da36 = $_GET['da36'];
$da37 = $_GET['da37'];
$da38 = $_GET['da38'];
$da39 = $_GET['da39'];
$da40 = $_GET['da40'];
$da41 = $_GET['da41'];
$da42 = $_GET['da42'];
$da43 = $_GET['da43'];
$da44 = $_GET['da44'];
$da45 = $_GET['da45'];
$da46 = $_GET['da46'];
$da47 = $_GET['da47'];
$da48 = $_GET['da48'];
$da49 = $_GET['da49'];
$da50 = $_GET['da50'];


$me1 = $_GET['me1'];
$me2 = $_GET['me2'];
$me3 = $_GET['me3'];
$me4 = $_GET['me4'];
$me5 = $_GET['me5'];
$me6 = $_GET['me6'];
$me7 = $_GET['me7'];
$me8 = $_GET['me8'];
$me9 = $_GET['me9'];
$me10 = $_GET['me10'];
$me11 = $_GET['me11'];
$me12 = $_GET['me12'];
$me13 = $_GET['me13'];
$me14 = $_GET['me14'];
$me15 = $_GET['me15'];
$me16 = $_GET['me16'];
$me17 = $_GET['me17'];
$me18 = $_GET['me18'];
$me19 = $_GET['me19'];
$me20 = $_GET['me20'];
$me21 = $_GET['me21'];
$me22 = $_GET['me22'];
$me23 = $_GET['me23'];
$me24 = $_GET['me24'];
$me25 = $_GET['me25'];
$me26 = $_GET['me26'];
$me27 = $_GET['me27'];
$me28 = $_GET['me28'];
$me29 = $_GET['me29'];
$me30 = $_GET['me30'];
$me31 = $_GET['me31'];
$me32 = $_GET['me32'];
$me33 = $_GET['me33'];
$me34 = $_GET['me34'];
$me35 = $_GET['me35'];
$me36 = $_GET['me36'];
$me37 = $_GET['me37'];
$me38 = $_GET['me38'];
$me39 = $_GET['me39'];
$me40 = $_GET['me40'];
$me41 = $_GET['me41'];
$me42 = $_GET['me42'];
$me43 = $_GET['me43'];
$me44 = $_GET['me44'];
$me45 = $_GET['me45'];
$me46 = $_GET['me46'];
$me47 = $_GET['me47'];
$me48 = $_GET['me48'];
$me49 = $_GET['me49'];
$me50 = $_GET['me50'];

	
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

	
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo5,"w+")){
        fwrite($fp,stripslashes($contenidoformateado5));
    }

	    $contenidoformateado5 = $contenidoformateado5.'
<head>
<link href="stylestats.css" rel="stylesheet" type="text/css" />
</head>
<table width="739" height="244" border="1" style="table-layout: fixed">
  <tr>
  <td width="40"><div align="center"><span id="estadosv1x">P</span></div></td>
    <td width="550"><div align="center"><span id="estadosv1x">NOMBRE DEL USUARIO </span></div></td>
    <td><div align="center"><span id="estadosv1x">REPUTACIÓN</span></div></td>
  </tr>
<tr> <td><span id="estadosv"><IMG SRC="files/oro.png"></span></td> <td width="509"><div align="center"><span id="estadosv">'.$da1.'</span></div></td><td width="214"><div align="center"><span id="estadosv">'.$me1.'</span></div></td> </tr>
<tr> <td><span id="estadosv"><IMG SRC="files/plata.png"></span></td> <td width="509"><div align="center"><span id="estadosv">'.$da2.'</span></div></td><td width="214"><div align="center"><span id="estadosv">'.$me2.'</span></div></td> </tr>
<tr> <td><span id="estadosv"><IMG SRC="files/bronce.png"></span></td> <td width="509"><div align="center"><span id="estadosv">'.$da3.'</span></div></td><td width="214"><div align="center"><span id="estadosv">'.$me3.'</span></div></td> </tr>
<tr> <td><span id="estadosv">4</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da4.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me4.'</span></div></td> </tr>
<tr> <td><span id="estadosv">5</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da5.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me5.'</span></div></td> </tr>
<tr> <td><span id="estadosv">6</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da6.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me6.'</span></div></td> </tr>
<tr> <td><span id="estadosv">7</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da7.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me7.'</span></div></td> </tr>
<tr> <td><span id="estadosv">8</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da8.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me8.'</span></div></td> </tr>
<tr> <td><span id="estadosv">9</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da9.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me9.'</span></div></td> </tr>
<tr> <td><span id="estadosv">10</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da10.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me10.'</span></div></td> </tr>
<tr> <td><span id="estadosv">11</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da11.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me11.'</span></div></td> </tr>
<tr> <td><span id="estadosv">12</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da12.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me12.'</span></div></td> </tr>
<tr> <td><span id="estadosv">13</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da13.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me13.'</span></div></td> </tr>
<tr> <td><span id="estadosv">14</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da14.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me14.'</span></div></td> </tr>
<tr> <td><span id="estadosv">15</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da15.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me15.'</span></div></td> </tr>
<tr> <td><span id="estadosv">16</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da16.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me16.'</span></div></td> </tr>
<tr> <td><span id="estadosv">17</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da17.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me17.'</span></div></td> </tr>
<tr> <td><span id="estadosv">18</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da18.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me18.'</span></div></td> </tr>
<tr> <td><span id="estadosv">19</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da19.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me19.'</span></div></td> </tr>
<tr> <td><span id="estadosv">20</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da20.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me20.'</span></div></td> </tr>
<tr> <td><span id="estadosv">21</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da21.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me21.'</span></div></td> </tr>
<tr> <td><span id="estadosv">22</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da22.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me22.'</span></div></td> </tr>
<tr> <td><span id="estadosv">23</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da23.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me23.'</span></div></td> </tr>
<tr> <td><span id="estadosv">24</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da24.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me24.'</span></div></td> </tr>
<tr> <td><span id="estadosv">25</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da25.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me25.'</span></div></td> </tr>
<tr> <td><span id="estadosv">26</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da26.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me26.'</span></div></td> </tr>
<tr> <td><span id="estadosv">27</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da27.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me27.'</span></div></td> </tr>
<tr> <td><span id="estadosv">28</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da28.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me28.'</span></div></td> </tr>
<tr> <td><span id="estadosv">29</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da29.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me29.'</span></div></td> </tr>
<tr> <td><span id="estadosv">30</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da30.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me30.'</span></div></td> </tr>
<tr> <td><span id="estadosv">31</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da31.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me31.'</span></div></td> </tr>
<tr> <td><span id="estadosv">32</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da32.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me32.'</span></div></td> </tr>
<tr> <td><span id="estadosv">33</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da33.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me33.'</span></div></td> </tr>
<tr> <td><span id="estadosv">34</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da34.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me34.'</span></div></td> </tr>
<tr> <td><span id="estadosv">35</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da35.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me35.'</span></div></td> </tr>
<tr> <td><span id="estadosv">36</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da36.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me36.'</span></div></td> </tr>
<tr> <td><span id="estadosv">37</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da37.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me37.'</span></div></td> </tr>
<tr> <td><span id="estadosv">38</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da38.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me38.'</span></div></td> </tr>
<tr> <td><span id="estadosv">39</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da39.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me39.'</span></div></td> </tr>
<tr> <td><span id="estadosv">40</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da40.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me40.'</span></div></td> </tr>
<tr> <td><span id="estadosv">41</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da41.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me41.'</span></div></td> </tr>
<tr> <td><span id="estadosv">42</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da42.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me42.'</span></div></td> </tr>
<tr> <td><span id="estadosv">43</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da43.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me43.'</span></div></td> </tr>
<tr> <td><span id="estadosv">44</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da44.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me44.'</span></div></td> </tr>
<tr> <td><span id="estadosv">45</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da45.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me45.'</span></div></td> </tr>
<tr> <td><span id="estadosv">46</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da46.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me46.'</span></div></td> </tr>
<tr> <td><span id="estadosv">47</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da47.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me47.'</span></div></td> </tr>
<tr> <td><span id="estadosv">48</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da48.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me48.'</span></div></td> </tr>
<tr> <td><span id="estadosv">49</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da49.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me49.'</span></div></td> </tr>
<tr> <td><span id="estadosv">50</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da50.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me50.'</span></div></td> </tr>
</table>
';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo5,"w+")){
        fwrite($fp,stripslashes($contenidoformateado5));
    }
	
?>








