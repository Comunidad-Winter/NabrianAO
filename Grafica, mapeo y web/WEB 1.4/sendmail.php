<?php


// Debes editar las próximas dos líneas de código de acuerdo con tus preferencias
$email_to = "nabrianao@gmail.com";
$email_subject = "NabrianAO DONACIONES";

// Aquí se deberían validar los datos ingresados por el usuario
if(!isset($_POST['first_name']) ||
!isset($_POST['telephone'])) {

echo "

<!doctype html>
<html>
<head>
<link href='stylecssrank.css' rel='stylesheet' type='text/css' />
</head>

<div id='ranking'><center>

<span id='texto'><p><b>Ocurrió un error y el formulario no ha sido enviado. </b></p></span>
<span id='texto'><p>Por favor, vuelva atrás y verifique la información ingresada</p></span>

</center></div>


";
die();
}

$email_message = "DEBES ENTREGAR UNA DONACIÓN:\n\n";
$email_message .= "NICK: " . $_POST['first_name'] . "\n";
$email_message .= "MONTO: " . $_POST['telephone'] . "\n\n";



// Ahora se envía el e-mail usando la función mail() de PHP
$headers = 'From: '.$email_from."\r\n".
'Reply-To: '.$email_from."\r\n" .
'X-Mailer: PHP/' . phpversion();
@mail($email_to, $email_subject, $email_message, $headers);

echo "

<!doctype html>
<html>
<head>
<link href='stylecssrank.css' rel='stylesheet' type='text/css' />
</head>

<div id='ranking'><center>
<p>&nbsp;</p>
<span id='titulo'>¡La donación se ha enviado con éxito en los siguientes 30 minutos tendras los puntos depositados en tu personaje!</span>
<p>&nbsp;</p>
<span id='texto'>En caso de que te hayas equivocado en los datos regresa hacia atras y envialos devuelta...</span>
</center></div>

";

?>
