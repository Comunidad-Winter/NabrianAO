<?php
    /* ESTADISTICAS ONLINE AO -  */
    /* CONFIGURACIÓN: */
    $key = '4568';
    $serverip = 'nabrianao.ddns.net';
    $serverport = '10300';
	$archivo5 = 'topgeneral5.html';
	
    $showrecord = true;
    $showstate = true;
   
   /* Seguridad Falsa (? */
    $segcode = $_GET['keyp'];
   
    if ($segcode == $key) {
   
$da201 = $_GET['da201'];
$da202 = $_GET['da202'];
$da203 = $_GET['da203'];
$da204 = $_GET['da204'];
$da205 = $_GET['da205'];
$da206 = $_GET['da206'];
$da207 = $_GET['da207'];
$da208 = $_GET['da208'];
$da209 = $_GET['da209'];
$da210 = $_GET['da210'];
$da211 = $_GET['da211'];
$da212 = $_GET['da212'];
$da213 = $_GET['da213'];
$da214 = $_GET['da214'];
$da215 = $_GET['da215'];
$da216 = $_GET['da216'];
$da217 = $_GET['da217'];
$da218 = $_GET['da218'];
$da219 = $_GET['da219'];
$da220 = $_GET['da220'];
$da221 = $_GET['da221'];
$da222 = $_GET['da222'];
$da223 = $_GET['da223'];
$da224 = $_GET['da224'];
$da225 = $_GET['da225'];
$da226 = $_GET['da226'];
$da227 = $_GET['da227'];
$da228 = $_GET['da228'];
$da229 = $_GET['da229'];
$da230 = $_GET['da230'];
$da231 = $_GET['da231'];
$da232 = $_GET['da232'];
$da233 = $_GET['da233'];
$da234 = $_GET['da234'];
$da235 = $_GET['da235'];
$da236 = $_GET['da236'];
$da237 = $_GET['da237'];
$da238 = $_GET['da238'];
$da239 = $_GET['da239'];
$da240 = $_GET['da240'];
$da241 = $_GET['da241'];
$da242 = $_GET['da242'];
$da243 = $_GET['da243'];
$da244 = $_GET['da244'];
$da245 = $_GET['da245'];
$da246 = $_GET['da246'];
$da247 = $_GET['da247'];
$da248 = $_GET['da248'];
$da249 = $_GET['da249'];
$da250 = $_GET['da250'];

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
$me201 = $_GET['me201'];
$me202 = $_GET['me202'];
$me203 = $_GET['me203'];
$me204 = $_GET['me204'];
$me205 = $_GET['me205'];
$me206 = $_GET['me206'];
$me207 = $_GET['me207'];
$me208 = $_GET['me208'];
$me209 = $_GET['me209'];
$me210 = $_GET['me210'];
$me211 = $_GET['me211'];
$me212 = $_GET['me212'];
$me213 = $_GET['me213'];
$me214 = $_GET['me214'];
$me215 = $_GET['me215'];
$me216 = $_GET['me216'];
$me217 = $_GET['me217'];
$me218 = $_GET['me218'];
$me219 = $_GET['me219'];
$me220 = $_GET['me220'];
$me221 = $_GET['me221'];
$me222 = $_GET['me222'];
$me223 = $_GET['me223'];
$me224 = $_GET['me224'];
$me225 = $_GET['me225'];
$me226 = $_GET['me226'];
$me227 = $_GET['me227'];
$me228 = $_GET['me228'];
$me229 = $_GET['me229'];
$me230 = $_GET['me230'];
$me231 = $_GET['me231'];
$me232 = $_GET['me232'];
$me233 = $_GET['me233'];
$me234 = $_GET['me234'];
$me235 = $_GET['me235'];
$me236 = $_GET['me236'];
$me237 = $_GET['me237'];
$me238 = $_GET['me238'];
$me239 = $_GET['me239'];
$me240 = $_GET['me240'];
$me241 = $_GET['me241'];
$me242 = $_GET['me242'];
$me243 = $_GET['me243'];
$me244 = $_GET['me244'];
$me245 = $_GET['me245'];
$me246 = $_GET['me246'];
$me247 = $_GET['me247'];
$me248 = $_GET['me248'];
$me249 = $_GET['me249'];
$me250 = $_GET['me250'];

	
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
<tr> <td><span id="estadosv">201</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da201.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me201.'</span></div></td> </tr>
<tr> <td><span id="estadosv">202</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da202.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me202.'</span></div></td> </tr>
<tr> <td><span id="estadosv">203</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da203.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me203.'</span></div></td> </tr>
<tr> <td><span id="estadosv">204</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da204.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me204.'</span></div></td> </tr>
<tr> <td><span id="estadosv">205</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da205.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me205.'</span></div></td> </tr>
<tr> <td><span id="estadosv">206</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da206.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me206.'</span></div></td> </tr>
<tr> <td><span id="estadosv">207</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da207.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me207.'</span></div></td> </tr>
<tr> <td><span id="estadosv">208</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da208.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me208.'</span></div></td> </tr>
<tr> <td><span id="estadosv">209</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da209.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me209.'</span></div></td> </tr>
<tr> <td><span id="estadosv">210</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da210.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me210.'</span></div></td> </tr>
<tr> <td><span id="estadosv">211</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da211.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me211.'</span></div></td> </tr>
<tr> <td><span id="estadosv">212</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da212.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me212.'</span></div></td> </tr>
<tr> <td><span id="estadosv">213</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da213.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me213.'</span></div></td> </tr>
<tr> <td><span id="estadosv">214</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da214.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me214.'</span></div></td> </tr>
<tr> <td><span id="estadosv">215</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da215.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me215.'</span></div></td> </tr>
<tr> <td><span id="estadosv">216</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da216.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me216.'</span></div></td> </tr>
<tr> <td><span id="estadosv">217</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da217.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me217.'</span></div></td> </tr>
<tr> <td><span id="estadosv">218</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da218.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me218.'</span></div></td> </tr>
<tr> <td><span id="estadosv">219</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da219.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me219.'</span></div></td> </tr>
<tr> <td><span id="estadosv">220</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da220.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me220.'</span></div></td> </tr>
<tr> <td><span id="estadosv">221</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da221.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me221.'</span></div></td> </tr>
<tr> <td><span id="estadosv">222</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da222.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me222.'</span></div></td> </tr>
<tr> <td><span id="estadosv">223</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da223.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me223.'</span></div></td> </tr>
<tr> <td><span id="estadosv">224</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da224.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me224.'</span></div></td> </tr>
<tr> <td><span id="estadosv">225</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da225.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me225.'</span></div></td> </tr>
<tr> <td><span id="estadosv">226</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da226.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me226.'</span></div></td> </tr>
<tr> <td><span id="estadosv">227</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da227.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me227.'</span></div></td> </tr>
<tr> <td><span id="estadosv">228</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da228.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me228.'</span></div></td> </tr>
<tr> <td><span id="estadosv">229</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da229.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me229.'</span></div></td> </tr>
<tr> <td><span id="estadosv">230</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da230.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me230.'</span></div></td> </tr>
<tr> <td><span id="estadosv">231</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da231.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me231.'</span></div></td> </tr>
<tr> <td><span id="estadosv">232</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da232.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me232.'</span></div></td> </tr>
<tr> <td><span id="estadosv">233</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da233.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me233.'</span></div></td> </tr>
<tr> <td><span id="estadosv">234</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da234.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me234.'</span></div></td> </tr>
<tr> <td><span id="estadosv">235</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da235.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me235.'</span></div></td> </tr>
<tr> <td><span id="estadosv">236</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da236.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me236.'</span></div></td> </tr>
<tr> <td><span id="estadosv">237</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da237.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me237.'</span></div></td> </tr>
<tr> <td><span id="estadosv">238</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da238.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me238.'</span></div></td> </tr>
<tr> <td><span id="estadosv">239</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da239.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me239.'</span></div></td> </tr>
<tr> <td><span id="estadosv">240</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da240.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me240.'</span></div></td> </tr>
<tr> <td><span id="estadosv">241</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da241.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me241.'</span></div></td> </tr>
<tr> <td><span id="estadosv">242</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da242.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me242.'</span></div></td> </tr>
<tr> <td><span id="estadosv">243</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da243.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me243.'</span></div></td> </tr>
<tr> <td><span id="estadosv">244</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da244.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me244.'</span></div></td> </tr>
<tr> <td><span id="estadosv">245</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da245.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me245.'</span></div></td> </tr>
<tr> <td><span id="estadosv">246</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da246.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me246.'</span></div></td> </tr>
<tr> <td><span id="estadosv">247</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da247.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me247.'</span></div></td> </tr>
<tr> <td><span id="estadosv">248</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da248.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me248.'</span></div></td> </tr>
<tr> <td><span id="estadosv">249</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da249.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me249.'</span></div></td> </tr>
<tr> <td><span id="estadosv">250</span></td> <td width="509"><div align="center"><span id="estadosv1x">'.$da250.'</span></div></td><td width="214"><div align="center"><span id="estadosv1x">'.$me250.'</span></div></td> </tr>
</table>
';
    if ($showrecord == true) {
      

    }
    /* Guardamos la información en un archivo html */
    if($fp = fopen($archivo5,"w+")){
        fwrite($fp,stripslashes($contenidoformateado5));
    }
	
?>








