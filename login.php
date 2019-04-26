<?php
require 'config.php';
// We need to use sessions, so you should always start sessions using the below code.
session_start();
$WrongPass = FALSE;
$WrongUser = FALSE;
// If the user is not logged in redirect to the login page...
if (isset($_SESSION['loggedin'])) {
	header('Location: index.php');
	exit();
}

if (isset($_POST['username'], $_POST['password']) ) {
	// Prepare our SQL, preparing the SQL statement will prevent SQL injection.
	if ($stmt = $con->prepare('SELECT password FROM login WHERE username = ?')) {
		// Bind parameters (s = string, i = int, b = blob, etc), in our case the username is a string so we use "s"
		$stmt->bind_param('s', $_POST['username']);
		$stmt->execute();
		// Store the result so we can check if the account exists in the database.
		$stmt->store_result();
	}

	if ($stmt->num_rows > 0) {
		$stmt->bind_result($password);
		$stmt->fetch();
		// Account exists, now we verify the password.
		// Note: remember to use password_hash in your registration file to store the hashed passwords.
		if ($_POST['password'] == $password) {
			// Verification success! User has loggedin!
			// Create sessions so we know the user is logged in, they basically act like cookies but remember the data on the server.
			session_regenerate_id();
			$_SESSION['loggedin'] = TRUE;
			
			$sql = "SELECT facultyID FROM login_faculty WHERE username = "."'".$_POST['username']."'";
			$result = $con->query($sql);

			if ($result->num_rows > 0) {
			    // output data of each row
			    $row = $result->fetch_assoc();
			    $_SESSION['facultyID'] = $row['facultyID'];
			    $_SESSION['role'] = 'faculty';
			    $sql = "SELECT * FROM hod WHERE facultyID = "."'".$_SESSION['facultyID']."'";
			    $result = $con->query($sql);
			    if ($result->num_rows > 0) {
			    	$_SESSION['role'] = 'hod';
			    }
			    else {
			    	$sql = "SELECT role FROM crossfac WHERE facultyID = "."'".$_SESSION['facultyID']."'";
			    	$result = $con->query($sql);
			    	if ($result->num_rows > 0) {
			    		$row = $result->fetch_assoc();
			    		$_SESSION['role'] = $row['role'];
			    	}
			    }
			    header('Location: index.php');
			} else {
			   $sql = "SELECT staffID FROM login_staff WHERE username = "."'".$_POST['username']."'";
			   $result = $con->query($sql);

			   if ($result->num_rows > 0) {
			       // output data of each row
			       $row = $result->fetch_assoc();
			       $_SESSION['staffID'] = $row['staffID'];
			       $_SESSION['role'] = 'staff';
			       $sql = "SELECT * FROM asst_reg WHERE staffID = "."'".$_SESSION['staffID']."'";
			       $result = $con->query($sql);
			       if ($result->num_rows > 0) {
			       	$_SESSION['role'] = 'asst_reg';
			       }
			       else {
			       	$sql = "SELECT id FROM crossstaff WHERE staffID = "."'".$_SESSION['staffID']."'";
			       	$result = $con->query($sql);
			       	if ($result->num_rows > 0) {
			       		$row = $result->fetch_assoc();
			       		$id = $row['id'];
			       		$sql = "SELECT * FROM deansecy WHERE crossstaffID = "."'".$id."'";
			       		$result = $con->query($sql);
			       		if ($result->num_rows > 0) {
			       			$_SESSION['role'] = 'deansecy';
			       		}
			       		else{
			       			$sql = "SELECT * FROM deptsecy WHERE crossstaffID = "."'".$id."'";
			       			$result = $con->query($sql);
			       			if ($result->num_rows > 0) {
			       				$_SESSION['role'] = 'deptsecy';
			       			}
			       		}
			       	}
			       }
			       header('Location: index.php');
			   }
			   else{
			   	echo "<h3 style=\"color:red\">ERROR</h3>";
			   	session_destroy();
			   }
			}

		} else {
			$WrongPass = TRUE;
		}
	} else {
		$WrongUser = TRUE;
	}
	$stmt->close();
}
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Login</title>
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
		<link href="style.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div class="login">
			<h1>Login</h1>
			<form action="login.php" method="post">
				<label for="username">
					<i class="fas fa-user"></i>
				</label>
				<input type="text" name="username" placeholder="Username" id="username" required>
				<label for="password">
					<i class="fas fa-lock"></i>
				</label>
				<input type="password" name="password" placeholder="Password" id="password" required>
				<h3><a href="signup.php">Signup</a></h3>
				<?php
				if ($WrongUser) {
					echo "<h3 style=\"color:red\">Wrong Username</h3>";
				}
				elseif ($WrongPass) {
					echo "<h3 style=\"color:red\">Wrong Password</h3>";
				}
				?>
				<input type="submit" value="Login">
			</form>
		</div>
	</body>
</html>