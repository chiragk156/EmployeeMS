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
		<title>Payslips</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
	</head>
	<body class="loggedin">
		<nav class="navtop">
			<div>
				<h1>Employee Management System</h1>
				<a href="index.php"><i class="fas fa-home"></i>Home</a>
				<a href="application.php"><i class="fas fa-edit"></i>Leave Application</a>
				<a href="logout.php"><i class="fas fa-sign-out-alt"></i>Logout</a>
			</div>
		</nav>
		<div class="content">
			<h2>Payslips</h2>
			<p>Welcome back, <?=$name?>!</p>
				<p>List of Payslips:</p>
				<?php
					if (isset($_SESSION['facultyID'])) {
						$sql = "SELECT * FROM fac_payslip WHERE facultyID = "."'".$_SESSION['facultyID']."' "."AND status = 'approved' "."ORDER BY year,month DESC";
						// echo $sql;
						$result = $con->query($sql);
						while ($row = $result->fetch_assoc()) {
							echo "<div>
							<table>
							<tr>
							<td>ID</td> <td>".$row['id']."</td>
							</tr>
							<tr>
							<td>Month</td> <td>".$row['month']."</td>
							</tr>
							<tr>
							<td>Year</td> <td>".$row['YEAR']."</td>
							</tr>
							<tr>
							<td>Amount</td> <td>".$row['salary']."</td>
							</tr>
							<tr>
							<td>Bonus</td> <td>".$row['bonus']."</td>
							</tr>
							<tr>
							<td>GOE</td> <td>".$row['GOE']."</td>
							</tr>
							</table>
							</div>";
						}
					}
				?>
		</div>
	</body>
</html>