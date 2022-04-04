<?php
    /* ESTADISTICAS ONLINE AO -  */
    /* CONFIGURACIÓN: */
    $key = '4568';
    $serverip = 'nabrianao.ddns.net';
    $serverport = '10300';
	$archivo5 = 'topgeneral3.html';
	
    $showrecord = true;
    $showstate = true;
   
   /* Seguridad Falsa (? */
    $segcode = $_GET['keyp'];
   
    if ($segcode == $key) {
       

$da101 = $_GET['da101'];
$da102 = $_GET['da102'];
$da103 = $_GET['da103'];
$da104 = $_GET['da104'];
$da105 = $_GET['da105'];
$da106 = $_GET['da106'];
$da107 = $_GET['da107'];
$da108 = $_GET['da108'];
$da109 = $_GET['da109'];
$da110 = $_GET['da110'];
$da111 = $_GET['da111'];
$da112 = $_GET['da112'];
$da113 = $_GET['da113'];
$da114 = $_GET['da114'];
$da115 = $_GET['da115'];
$da116 = $_GET['da116'];
$da117 = $_GET['da117'];
$da118 = $_GET['da118'];
$da119 = $_GET['da119'];
$da120 = $_GET['da120'];
$da121 = $_GET['da121'];
$da122 = $_GET['da122'];
$da123 = $_GET['da123'];
$da124 = $_GET['da124'];
$da125 = $_GET['da125'];
$da126 = $_GET['da126'];
$da127 = $_GET['da127'];
$da128 = $_GET['da128'];
$da129 = $_GET['da129'];
$da130 = $_GET['da130'];
$da131 = $_GET['da131'];
$da132 = $_GET['da132'];
$da133 = $_GET['da133'];
$da134 = $_GET['da134'];
$da135 = $_GET['da135'];
$da136 = $_GET['da136'];
$da137 = $_GET['da137'];
$da138 = $_GET['da138'];
$da139 = $_GET['da139'];
$da140 = $_GET['da140'];
$da141 = $_GET['da141'];
$da142 = $_GET['da142'];
$da143 = $_GET['da143'];
$da144 = $_GET['da144'];
$da145 = $_GET['da145'];
$da146 = $_GET['da146'];
$da147 = $_GET['da147'];
$da148 = $_GET['da148'];
$da149 = $_GET['da149'];
$da150 = $_GET['da150'];

$me101 = $_GET['me101'];
$me102 = $_GET['me102'];
$me103 = $_GET['me103'];
$me104 = $_GET['me104'];
$me105 = $_GET['me105'];
$me106 = $_GET['me106'];
$me107 = $_GET['me107'];
$me108 = $_GET['me108'];
$me109 = $_GET['me109'];
$me110 = $_GET['me110'];
$me111 = $_GET['me111'];
$me112 = $_GET['me112'];
$me113 = $_GET['me113'];
$me114 = $_GET['me114'];
$me115 = $_GET['me115'];
$me116 = $_GET['me116'];
$me117 = $_GET['me117'];
$me118 = $_GET['me118'];
$me119 = $_GET['me119'];
$me120 = $_GET['me120'];
$me121 = $_GET['me121'];
$me122 = $_GET['me122'];
$me123 = $_GET['me123'];
$me124 = $_GET['me124'];
$me125 = $_GET['me125'];
$me126 = $_GET['me126'];
$me127 = $_GET['me127'];
$me128 = $_GET['me128'];
$me129 = $_GET['me129'];
$me130 = $_GET['me130'];
$me131 = $_GET['me131'];
$me132 = $_GET['me132'];
$me133 = $_GET['me133'];
$me134 = $_GET['me134'];
$me135 = $_GET['me135'];
$me136 = $_GET['me136'];
$me137 = $_GET['me137'];
$me138 = $_GET['me138'];
$me139 = $_GET['me139'];
$me140 = $_GET['me140'];
$me141 = $_GET['me141'];
$me142 = $_GET['me142'];
$me143 = $_GET['me143'];
$me144 = $_GET['me144'];
$me145 = $_GET['me145'];
$me146 = $_GET['me146'];
$me147 = $_GET['me147'];
$me148 = $_GET['me148'];
$me149 = $_GET['me149'];
$me150 = $_GET['me150'];

	
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
<tr> <td><span id="estadosv">101</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da101.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me101.'</span></div></td> </tr>
<tr> <td><span id="estadosv">102</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da102.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me102.'</span></div></td> </tr>
<tr> <td><span id="estadosv">103</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da103.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me103.'</span></div></td> </tr>
<tr> <td><span id="estadosv">104</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da104.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me104.'</span></div></td> </tr>
<tr> <td><span id="estadosv">105</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da105.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me105.'</span></div></td> </tr>
<tr> <td><span id="estadosv">106</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da106.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me106.'</span></div></td> </tr>
<tr> <td><span id="estadosv">107</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da107.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me107.'</span></div></td> </tr>
<tr> <td><span id="estadosv">108</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da108.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me108.'</span></div></td> </tr>
<tr> <td><span id="estadosv">109</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da109.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me109.'</span></div></td> </tr>
<tr> <td><span id="estadosv">110</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da110.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me110.'</span></div></td> </tr>
<tr> <td><span id="estadosv">111</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da111.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me111.'</span></div></td> </tr>
<tr> <td><span id="estadosv">112</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da112.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me112.'</span></div></td> </tr>
<tr> <td><span id="estadosv">113</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da113.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me113.'</span></div></td> </tr>
<tr> <td><span id="estadosv">114</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da114.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me114.'</span></div></td> </tr>
<tr> <td><span id="estadosv">115</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da115.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me115.'</span></div></td> </tr>
<tr> <td><span id="estadosv">116</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da116.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me116.'</span></div></td> </tr>
<tr> <td><span id="estadosv">117</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da117.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me117.'</span></div></td> </tr>
<tr> <td><span id="estadosv">118</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da118.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me118.'</span></div></td> </tr>
<tr> <td><span id="estadosv">119</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da119.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me119.'</span></div></td> </tr>
<tr> <td><span id="estadosv">120</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da120.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me120.'</span></div></td> </tr>
<tr> <td><span id="estadosv">121</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da121.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me121.'</span></div></td> </tr>
<tr> <td><span id="estadosv">122</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da122.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me122.'</span></div></td> </tr>
<tr> <td><span id="estadosv">123</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da123.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me123.'</span></div></td> </tr>
<tr> <td><span id="estadosv">124</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da124.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me124.'</span></div></td> </tr>
<tr> <td><span id="estadosv">125</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da125.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me125.'</span></div></td> </tr>
<tr> <td><span id="estadosv">126</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da126.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me126.'</span></div></td> </tr>
<tr> <td><span id="estadosv">127</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da127.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me127.'</span></div></td> </tr>
<tr> <td><span id="estadosv">128</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da128.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me128.'</span></div></td> </tr>
<tr> <td><span id="estadosv">129</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da129.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me129.'</span></div></td> </tr>
<tr> <td><span id="estadosv">130</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da130.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me130.'</span></div></td> </tr>
<tr> <td><span id="estadosv">131</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da131.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me131.'</span></div></td> </tr>
<tr> <td><span id="estadosv">132</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da132.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me132.'</span></div></td> </tr>
<tr> <td><span id="estadosv">133</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da133.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me133.'</span></div></td> </tr>
<tr> <td><span id="estadosv">134</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da134.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me134.'</span></div></td> </tr>
<tr> <td><span id="estadosv">135</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da135.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me135.'</span></div></td> </tr>
<tr> <td><span id="estadosv">136</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da136.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me136.'</span></div></td> </tr>
<tr> <td><span id="estadosv">137</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da137.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me137.'</span></div></td> </tr>
<tr> <td><span id="estadosv">138</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da138.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me138.'</span></div></td> </tr>
<tr> <td><span id="estadosv">139</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da139.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me139.'</span></div></td> </tr>
<tr> <td><span id="estadosv">140</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da140.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me140.'</span></div></td> </tr>
<tr> <td><span id="estadosv">141</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da141.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me141.'</span></div></td> </tr>
<tr> <td><span id="estadosv">142</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da142.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me142.'</span></div></td> </tr>
<tr> <td><span id="estadosv">143</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da143.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me143.'</span></div></td> </tr>
<tr> <td><span id="estadosv">144</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da144.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me144.'</span></div></td> </tr>
<tr> <td><span id="estadosv">145</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da145.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me145.'</span></div></td> </tr>
<tr> <td><span id="estadosv">146</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da146.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me146.'</span></div></td> </tr>
<tr> <td><span id="estadosv">147</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da147.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me147.'</span></div></td> </tr>
<tr> <td><span id="estadosv">148</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da148.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me148.'</span></div></td> </tr>
<tr> <td><span id="estadosv">149</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da149.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me149.'</span></div></td> </tr>
<tr> <td><span id="estadosv">150</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da150.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me150.'</span></div></td> </tr>
</table>
';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo5,"w+")){
        fwrite($fp,stripslashes($contenidoformateado5));
    }
	
?>








