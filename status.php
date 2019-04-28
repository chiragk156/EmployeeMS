<?php
require 'config.php';
// We need to use sessions, so you should always start sessions using the below code.
session_start();
// If the user is not logged in redirect to the login page...
if (!isset($_SESSION['loggedin'])) {
	header('Location: login.php');
	exit();
}
if (isset($_SESSION['facultyID'])) {
	$sql = "SELECT name, remaningLeaves, dept FROM faculty WHERE id = "."'".$_SESSION['facultyID']."'";
	$result = $con->query($sql);
	$row = $result->fetch_assoc();
	$name = $row['name'];
	$remainingleaves = $row['remaningLeaves'];
	$dept = $row['dept'];
}
if (isset($_SESSION['staffID'])) {
	$sql = "SELECT name, remaningLeaves, dept FROM staff WHERE id = "."'".$_SESSION['staffID']."'";
	$result = $con->query($sql);
	$row = $result->fetch_assoc();
	$name = $row['name'];
	$remainingleaves = $row['remaningLeaves'];
	$dept = $row['dept'];
}
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Leave Application</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
	</head>
	<body class="loggedin">
		<nav class="navtop">
			<div>
				<h1>Employee Management System</h1>
				<a href="index.php"><i class="fas fa-home"></i>Home</a>
				<a href="application.php"><i class="fas fa-edit"></i>Leave Application</a>
				<a href="payslip.php"><i class="fas fa-sticky-note"></i>Payslips</a>
				<a href="logout.php"><i class="fas fa-sign-out-alt"></i>Logout</a>
			</div>
		</nav>
		<div class="content">
			<h2>Leave Application Status</h2>
			<p>Welcome back, <?=$name?>!</p>
				<div>
					<h3>ID: <?=$_GET['id'] ?></h3>
							<table>
							<tr>
							<td><h3>From</h3></td> <td><h3>To</h3></td> <td><h3>Comment</h3></td> <td><h3>Time</h3></td>
							</tr>
				<?php
					if (isset($_SESSION['facultyID'])) {
						$sql = "SELECT * FROM faculty_comments WHERE application_id = "."'".$_GET['id']."' "."ORDER BY ts DESC";
						$result = $con->query($sql);
						while ($row = $result->fetch_assoc()) {
							$sql = "SELECT * FROM path WHERE id = '".$row['path_id']."'";
							$result1 = $con->query($sql);
							$row1 = $result1->fetch_assoc();
							echo "
							<tr>
							<td>".$row1['predecessor']."</td> <td>".$row1['successor']."</td> <td>".$row['comment']."</td> <td>".$row['ts']."</td>
							</tr>
							";
						}
					}
				?>
				</table>
							</div>
		</div>
	</body>
</html>