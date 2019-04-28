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
		<title>Home Page</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
	</head>
	<body class="loggedin">
		<nav class="navtop">
			<div>
				<h1>Employee Management System</h1>
				<a href="payslip.php"><i class="fas fa-sticky-note"></i>Payslips</a>
				<a href="application.php"><i class="fas fa-edit"></i>Leave Application</a>
				<a href="logout.php"><i class="fas fa-sign-out-alt"></i>Logout</a>
			</div>
		</nav>
		<div class="content">
			<h2>Home Page</h2>
			<p>Welcome back, <?=$name?>!</p>
			<div>
				<p>Details:</p>
				<table>
					<tr>
						<td>Role:</td>
						<td><?=$_SESSION['role'] ?></td>
					</tr>
					<tr>
						<td>Department:</td>
						<td><?=$dept ?></td>
					</tr>
					<tr>
						<td>No. of remaining leaves:</td>
						<td><?=$remainingleaves ?></td>
					</tr>
				</table>
				<?php
				$sql = "SELECT * FROM crossfac WHERE role = "."'".$_SESSION['role']."'";
				$result = $con->query($sql);
				$sql = "SELECT * FROM crossstaff WHERE role = "."'".$_SESSION['role']."'";
				$result1 = $con->query($sql);
				if ($_SESSION['role']=='hod' || $_SESSION['role']=='hod' || $result->num_rows > 0 || $result1->num_rows > 0 || $_SESSION['role'] == 'asst_reg' || ($_SESSION['role'] == 'staff' && $dept=='Establishment Office')) {
					echo "<a href=\"signleave.php\">Leave Requests</a>";
				}
				if ($_SESSION['role'] == 'staff' AND $dept == 'Accounts') {
					echo "<a href=\"generatepayslip.php?type=fac\">Generate Faculty Payslip</a><br>";
					echo "<a href=\"generatepayslip.php?type=staff\">Generate Staff Payslip</a>";
				}
				if ($_SESSION['role'] == 'asst_reg' AND $dept == 'Accounts'){
					echo "<br><a href=\"signpayslip.php\">Payslip Requests</a>";
				}
				?>
			</div>
		</div>
	</body>
</html>