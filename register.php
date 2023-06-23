<?php
include 'r.php';
$error = "";

if (isset($_POST['submit']))
{
  $conn = conn();

  $email = trim($_POST['email']);

  $sa = sha1(mt_rand() . time() . "Impossible");

  $command = escapeshellcmd("python verify.py '$email' '$sa'");
  $output = exec($command);

  $sql = "insert into prom_ver (word, email) values ('$sa', '$email');";
  try
  {
    $result = $conn -> query($sql);
  } catch (Exception $e) {
    $sql = "update prom_ver set word='$sa' where email='$email';";
    $result = $conn -> query($sql);
  }
  $conn -> close();
}
?>



<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Sign Up</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    </head>
    <body>
    
    <div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-white border-bottom shadow-sm">
    <h5 class="my-0 mr-md-auto font-weight-normal"></h5>
    <nav class="my-2 my-md-0 mr-md-3">
      <a class="p-2 text-dark" href="reset_pass.php"><h5>Восстановить пароль</h5></a>
    </nav>
    <a class="btn btn-outline-primary" href="login.php"><h5>Вход</h5></a>
    </div>
    
    
    
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1>Регистрация</h1>
                    <br><h3>Пожалуйста, заполните форму.</h3></br>
                    <form action="" method="post">
                        <div class="form-group">
                            <label><h4>Электронный адрес</h4></label>
                            <input type="email" name="email" class="form-control" required />
                        </div>    
                        <div class="form-group">
                            <input type="submit" name="submit" class="btn btn-primary" value="Подтвердить">
                        </div>
                    </form>
                    <?php echo $error; ?>
                </div>
            </div>
        </div>    
    </body>
</html>
