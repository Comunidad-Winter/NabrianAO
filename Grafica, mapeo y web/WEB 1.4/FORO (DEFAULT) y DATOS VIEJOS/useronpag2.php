<?php
    /* ESTADISTICAS ONLINE AO -  */
    /* CONFIGURACIÓN: */
    $key = '4568';
    $serverip = 'nabrianao.ddns.net';
    $serverport = '10300';
	$archivo5 = 'topgeneral2.html';
	
    $showrecord = true;
    $showstate = true;
   
   /* Seguridad Falsa (? */
    $segcode = $_GET['keyp'];
   
    if ($segcode == $key) {
       
$da51 = $_GET['da51'];
$da52 = $_GET['da52'];
$da53 = $_GET['da53'];
$da54 = $_GET['da54'];
$da55 = $_GET['da55'];
$da56 = $_GET['da56'];
$da57 = $_GET['da57'];
$da58 = $_GET['da58'];
$da59 = $_GET['da59'];
$da60 = $_GET['da60'];
$da61 = $_GET['da61'];
$da62 = $_GET['da62'];
$da63 = $_GET['da63'];
$da64 = $_GET['da64'];
$da65 = $_GET['da65'];
$da66 = $_GET['da66'];
$da67 = $_GET['da67'];
$da68 = $_GET['da68'];
$da69 = $_GET['da69'];
$da70 = $_GET['da70'];
$da71 = $_GET['da71'];
$da72 = $_GET['da72'];
$da73 = $_GET['da73'];
$da74 = $_GET['da74'];
$da75 = $_GET['da75'];
$da76 = $_GET['da76'];
$da77 = $_GET['da77'];
$da78 = $_GET['da78'];
$da79 = $_GET['da79'];
$da80 = $_GET['da80'];
$da81 = $_GET['da81'];
$da82 = $_GET['da82'];
$da83 = $_GET['da83'];
$da84 = $_GET['da84'];
$da85 = $_GET['da85'];
$da86 = $_GET['da86'];
$da87 = $_GET['da87'];
$da88 = $_GET['da88'];
$da89 = $_GET['da89'];
$da90 = $_GET['da90'];
$da91 = $_GET['da91'];
$da92 = $_GET['da92'];
$da93 = $_GET['da93'];
$da94 = $_GET['da94'];
$da95 = $_GET['da95'];
$da96 = $_GET['da96'];
$da97 = $_GET['da97'];
$da98 = $_GET['da98'];
$da99 = $_GET['da99'];
$da100 = $_GET['da100'];

$me51 = $_GET['me51'];
$me52 = $_GET['me52'];
$me53 = $_GET['me53'];
$me54 = $_GET['me54'];
$me55 = $_GET['me55'];
$me56 = $_GET['me56'];
$me57 = $_GET['me57'];
$me58 = $_GET['me58'];
$me59 = $_GET['me59'];
$me60 = $_GET['me60'];
$me61 = $_GET['me61'];
$me62 = $_GET['me62'];
$me63 = $_GET['me63'];
$me64 = $_GET['me64'];
$me65 = $_GET['me65'];
$me66 = $_GET['me66'];
$me67 = $_GET['me67'];
$me68 = $_GET['me68'];
$me69 = $_GET['me69'];
$me70 = $_GET['me70'];
$me71 = $_GET['me71'];
$me72 = $_GET['me72'];
$me73 = $_GET['me73'];
$me74 = $_GET['me74'];
$me75 = $_GET['me75'];
$me76 = $_GET['me76'];
$me77 = $_GET['me77'];
$me78 = $_GET['me78'];
$me79 = $_GET['me79'];
$me80 = $_GET['me80'];
$me81 = $_GET['me81'];
$me82 = $_GET['me82'];
$me83 = $_GET['me83'];
$me84 = $_GET['me84'];
$me85 = $_GET['me85'];
$me86 = $_GET['me86'];
$me87 = $_GET['me87'];
$me88 = $_GET['me88'];
$me89 = $_GET['me89'];
$me90 = $_GET['me90'];
$me91 = $_GET['me91'];
$me92 = $_GET['me92'];
$me93 = $_GET['me93'];
$me94 = $_GET['me94'];
$me95 = $_GET['me95'];
$me96 = $_GET['me96'];
$me97 = $_GET['me97'];
$me98 = $_GET['me98'];
$me99 = $_GET['me99'];
$me100 = $_GET['me100'];

	
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
<tr> <td><span id="estadosv">51</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da51.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me51.'</span></div></td> </tr>
<tr> <td><span id="estadosv">52</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da52.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me52.'</span></div></td> </tr>
<tr> <td><span id="estadosv">53</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da53.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me53.'</span></div></td> </tr>
<tr> <td><span id="estadosv">54</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da54.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me54.'</span></div></td> </tr>
<tr> <td><span id="estadosv">55</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da55.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me55.'</span></div></td> </tr>
<tr> <td><span id="estadosv">56</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da56.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me56.'</span></div></td> </tr>
<tr> <td><span id="estadosv">57</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da57.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me57.'</span></div></td> </tr>
<tr> <td><span id="estadosv">58</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da58.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me58.'</span></div></td> </tr>
<tr> <td><span id="estadosv">59</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da59.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me59.'</span></div></td> </tr>
<tr> <td><span id="estadosv">60</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da60.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me60.'</span></div></td> </tr>
<tr> <td><span id="estadosv">61</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da61.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me61.'</span></div></td> </tr>
<tr> <td><span id="estadosv">62</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da62.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me62.'</span></div></td> </tr>
<tr> <td><span id="estadosv">63</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da63.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me63.'</span></div></td> </tr>
<tr> <td><span id="estadosv">64</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da64.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me64.'</span></div></td> </tr>
<tr> <td><span id="estadosv">65</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da65.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me65.'</span></div></td> </tr>
<tr> <td><span id="estadosv">66</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da66.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me66.'</span></div></td> </tr>
<tr> <td><span id="estadosv">67</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da67.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me67.'</span></div></td> </tr>
<tr> <td><span id="estadosv">68</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da68.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me68.'</span></div></td> </tr>
<tr> <td><span id="estadosv">69</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da69.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me69.'</span></div></td> </tr>
<tr> <td><span id="estadosv">70</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da70.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me70.'</span></div></td> </tr>
<tr> <td><span id="estadosv">71</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da71.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me71.'</span></div></td> </tr>
<tr> <td><span id="estadosv">72</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da72.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me72.'</span></div></td> </tr>
<tr> <td><span id="estadosv">73</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da73.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me73.'</span></div></td> </tr>
<tr> <td><span id="estadosv">74</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da74.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me74.'</span></div></td> </tr>
<tr> <td><span id="estadosv">75</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da75.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me75.'</span></div></td> </tr>
<tr> <td><span id="estadosv">76</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da76.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me76.'</span></div></td> </tr>
<tr> <td><span id="estadosv">77</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da77.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me77.'</span></div></td> </tr>
<tr> <td><span id="estadosv">78</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da78.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me78.'</span></div></td> </tr>
<tr> <td><span id="estadosv">79</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da79.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me79.'</span></div></td> </tr>
<tr> <td><span id="estadosv">80</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da80.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me80.'</span></div></td> </tr>
<tr> <td><span id="estadosv">81</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da81.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me81.'</span></div></td> </tr>
<tr> <td><span id="estadosv">82</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da82.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me82.'</span></div></td> </tr>
<tr> <td><span id="estadosv">83</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da83.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me83.'</span></div></td> </tr>
<tr> <td><span id="estadosv">84</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da84.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me84.'</span></div></td> </tr>
<tr> <td><span id="estadosv">85</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da85.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me85.'</span></div></td> </tr>
<tr> <td><span id="estadosv">86</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da86.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me86.'</span></div></td> </tr>
<tr> <td><span id="estadosv">87</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da87.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me87.'</span></div></td> </tr>
<tr> <td><span id="estadosv">88</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da88.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me88.'</span></div></td> </tr>
<tr> <td><span id="estadosv">89</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da89.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me89.'</span></div></td> </tr>
<tr> <td><span id="estadosv">90</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da90.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me90.'</span></div></td> </tr>
<tr> <td><span id="estadosv">91</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da91.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me91.'</span></div></td> </tr>
<tr> <td><span id="estadosv">92</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da92.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me92.'</span></div></td> </tr>
<tr> <td><span id="estadosv">93</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da93.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me93.'</span></div></td> </tr>
<tr> <td><span id="estadosv">94</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da94.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me94.'</span></div></td> </tr>
<tr> <td><span id="estadosv">95</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da95.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me95.'</span></div></td> </tr>
<tr> <td><span id="estadosv">96</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da96.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me96.'</span></div></td> </tr>
<tr> <td><span id="estadosv">97</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da97.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me97.'</span></div></td> </tr>
<tr> <td><span id="estadosv">98</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da98.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me98.'</span></div></td> </tr>
<tr> <td><span id="estadosv">99</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da99.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me99.'</span></div></td> </tr>
<tr> <td><span id="estadosv">100</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da100.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me100.'</span></div></td> </tr>
</table>
';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo5,"w+")){
        fwrite($fp,stripslashes($contenidoformateado5));
    }
	
?>








