<?php
    /* ESTADISTICAS ONLINE AO -  */
    /* CONFIGURACIÓN: */
    $key = '4568';
    $serverip = 'nabrianao.ddns.net';
    $serverport = '10300';
	$archivo5 = 'topgeneral4.html';
	
    $showrecord = true;
    $showstate = true;
   
   /* Seguridad Falsa (? */
    $segcode = $_GET['keyp'];
   
    if ($segcode == $key) {
  
$da151 = $_GET['da151'];
$da152 = $_GET['da152'];
$da153 = $_GET['da153'];
$da154 = $_GET['da154'];
$da155 = $_GET['da155'];
$da156 = $_GET['da156'];
$da157 = $_GET['da157'];
$da158 = $_GET['da158'];
$da159 = $_GET['da159'];
$da160 = $_GET['da160'];
$da161 = $_GET['da161'];
$da162 = $_GET['da162'];
$da163 = $_GET['da163'];
$da164 = $_GET['da164'];
$da165 = $_GET['da165'];
$da166 = $_GET['da166'];
$da167 = $_GET['da167'];
$da168 = $_GET['da168'];
$da169 = $_GET['da169'];
$da170 = $_GET['da170'];
$da171 = $_GET['da171'];
$da172 = $_GET['da172'];
$da173 = $_GET['da173'];
$da174 = $_GET['da174'];
$da175 = $_GET['da175'];
$da176 = $_GET['da176'];
$da177 = $_GET['da177'];
$da178 = $_GET['da178'];
$da179 = $_GET['da179'];
$da180 = $_GET['da180'];
$da181 = $_GET['da181'];
$da182 = $_GET['da182'];
$da183 = $_GET['da183'];
$da184 = $_GET['da184'];
$da185 = $_GET['da185'];
$da186 = $_GET['da186'];
$da187 = $_GET['da187'];
$da188 = $_GET['da188'];
$da189 = $_GET['da189'];
$da190 = $_GET['da190'];
$da191 = $_GET['da191'];
$da192 = $_GET['da192'];
$da193 = $_GET['da193'];
$da194 = $_GET['da194'];
$da195 = $_GET['da195'];
$da196 = $_GET['da196'];
$da197 = $_GET['da197'];
$da198 = $_GET['da198'];
$da199 = $_GET['da199'];
$da200 = $_GET['da200'];

$me151 = $_GET['me151'];
$me152 = $_GET['me152'];
$me153 = $_GET['me153'];
$me154 = $_GET['me154'];
$me155 = $_GET['me155'];
$me156 = $_GET['me156'];
$me157 = $_GET['me157'];
$me158 = $_GET['me158'];
$me159 = $_GET['me159'];
$me160 = $_GET['me160'];
$me161 = $_GET['me161'];
$me162 = $_GET['me162'];
$me163 = $_GET['me163'];
$me164 = $_GET['me164'];
$me165 = $_GET['me165'];
$me166 = $_GET['me166'];
$me167 = $_GET['me167'];
$me168 = $_GET['me168'];
$me169 = $_GET['me169'];
$me170 = $_GET['me170'];
$me171 = $_GET['me171'];
$me172 = $_GET['me172'];
$me173 = $_GET['me173'];
$me174 = $_GET['me174'];
$me175 = $_GET['me175'];
$me176 = $_GET['me176'];
$me177 = $_GET['me177'];
$me178 = $_GET['me178'];
$me179 = $_GET['me179'];
$me180 = $_GET['me180'];
$me181 = $_GET['me181'];
$me182 = $_GET['me182'];
$me183 = $_GET['me183'];
$me184 = $_GET['me184'];
$me185 = $_GET['me185'];
$me186 = $_GET['me186'];
$me187 = $_GET['me187'];
$me188 = $_GET['me188'];
$me189 = $_GET['me189'];
$me190 = $_GET['me190'];
$me191 = $_GET['me191'];
$me192 = $_GET['me192'];
$me193 = $_GET['me193'];
$me194 = $_GET['me194'];
$me195 = $_GET['me195'];
$me196 = $_GET['me196'];
$me197 = $_GET['me197'];
$me198 = $_GET['me198'];
$me199 = $_GET['me199'];
$me200 = $_GET['me200'];

	
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
<tr> <td><span id="estadosv">151</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da151.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me151.'</span></div></td> </tr>
<tr> <td><span id="estadosv">152</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da152.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me152.'</span></div></td> </tr>
<tr> <td><span id="estadosv">153</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da153.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me153.'</span></div></td> </tr>
<tr> <td><span id="estadosv">154</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da154.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me154.'</span></div></td> </tr>
<tr> <td><span id="estadosv">155</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da155.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me155.'</span></div></td> </tr>
<tr> <td><span id="estadosv">156</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da156.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me156.'</span></div></td> </tr>
<tr> <td><span id="estadosv">157</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da157.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me157.'</span></div></td> </tr>
<tr> <td><span id="estadosv">158</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da158.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me158.'</span></div></td> </tr>
<tr> <td><span id="estadosv">159</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da159.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me159.'</span></div></td> </tr>
<tr> <td><span id="estadosv">160</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da160.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me160.'</span></div></td> </tr>
<tr> <td><span id="estadosv">161</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da161.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me161.'</span></div></td> </tr>
<tr> <td><span id="estadosv">162</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da162.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me162.'</span></div></td> </tr>
<tr> <td><span id="estadosv">163</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da163.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me163.'</span></div></td> </tr>
<tr> <td><span id="estadosv">164</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da164.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me164.'</span></div></td> </tr>
<tr> <td><span id="estadosv">165</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da165.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me165.'</span></div></td> </tr>
<tr> <td><span id="estadosv">166</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da166.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me166.'</span></div></td> </tr>
<tr> <td><span id="estadosv">167</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da167.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me167.'</span></div></td> </tr>
<tr> <td><span id="estadosv">168</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da168.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me168.'</span></div></td> </tr>
<tr> <td><span id="estadosv">169</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da169.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me169.'</span></div></td> </tr>
<tr> <td><span id="estadosv">170</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da170.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me170.'</span></div></td> </tr>
<tr> <td><span id="estadosv">171</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da171.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me171.'</span></div></td> </tr>
<tr> <td><span id="estadosv">172</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da172.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me172.'</span></div></td> </tr>
<tr> <td><span id="estadosv">173</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da173.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me173.'</span></div></td> </tr>
<tr> <td><span id="estadosv">174</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da174.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me174.'</span></div></td> </tr>
<tr> <td><span id="estadosv">175</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da175.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me175.'</span></div></td> </tr>
<tr> <td><span id="estadosv">176</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da176.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me176.'</span></div></td> </tr>
<tr> <td><span id="estadosv">177</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da177.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me177.'</span></div></td> </tr>
<tr> <td><span id="estadosv">178</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da178.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me178.'</span></div></td> </tr>
<tr> <td><span id="estadosv">179</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da179.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me179.'</span></div></td> </tr>
<tr> <td><span id="estadosv">180</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da180.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me180.'</span></div></td> </tr>
<tr> <td><span id="estadosv">181</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da181.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me181.'</span></div></td> </tr>
<tr> <td><span id="estadosv">182</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da182.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me182.'</span></div></td> </tr>
<tr> <td><span id="estadosv">183</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da183.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me183.'</span></div></td> </tr>
<tr> <td><span id="estadosv">184</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da184.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me184.'</span></div></td> </tr>
<tr> <td><span id="estadosv">185</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da185.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me185.'</span></div></td> </tr>
<tr> <td><span id="estadosv">186</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da186.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me186.'</span></div></td> </tr>
<tr> <td><span id="estadosv">187</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da187.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me187.'</span></div></td> </tr>
<tr> <td><span id="estadosv">188</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da188.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me188.'</span></div></td> </tr>
<tr> <td><span id="estadosv">189</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da189.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me189.'</span></div></td> </tr>
<tr> <td><span id="estadosv">190</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da190.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me190.'</span></div></td> </tr>
<tr> <td><span id="estadosv">191</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da191.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me191.'</span></div></td> </tr>
<tr> <td><span id="estadosv">192</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da192.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me192.'</span></div></td> </tr>
<tr> <td><span id="estadosv">193</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da193.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me193.'</span></div></td> </tr>
<tr> <td><span id="estadosv">194</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da194.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me194.'</span></div></td> </tr>
<tr> <td><span id="estadosv">195</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da195.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me195.'</span></div></td> </tr>
<tr> <td><span id="estadosv">196</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da196.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me196.'</span></div></td> </tr>
<tr> <td><span id="estadosv">197</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da197.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me197.'</span></div></td> </tr>
<tr> <td><span id="estadosv">198</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da198.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me198.'</span></div></td> </tr>
<tr> <td><span id="estadosv">199</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da199.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me199.'</span></div></td> </tr>
<tr> <td><span id="estadosv">200</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da200.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me200.'</span></div></td> </tr>
</table>
';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo5,"w+")){
        fwrite($fp,stripslashes($contenidoformateado5));
    }
	
?>








