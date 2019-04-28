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
if (isset($_GET['type']) && isset($_GET['id']) && isset($_GET['month']) && isset($_GET['year'])) {
	if ($_GET['type']=='fac') {
		$sql = "UPDATE fac_payslip SET status = 'approved' WHERE facultyID = '".$_GET['id']."' AND month = ".$_GET['month']." AND year = ".$_GET['year'];
	}
	if ($_GET['type']=='staff') {
		$sql = "UPDATE staff_payslip SET status = 'approved' WHERE facultyID = '".$_GET['id']."' AND month = ".$_GET['month']." AND year = ".$_GET['year'];
	}
	// echo $sql;
	$con->query($sql);
}
?>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Sign Payslip</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
	</head>
	<body class="loggedin">
		<nav class="navtop">
			<div>
				<h1>Employee Management System</h1>
				<a href="index.php"><i class="fas fa-home"></i>Home</a>
				<a href="payslip.php"><i class="fas fa-sticky-note"></i>Payslips</a>
				<a href="logout.php"><i class="fas fa-sign-out-alt"></i>Logout</a>
			</div>
		</nav>
		<div class="content">
			<p>Welcome back, <?=$name?>!</p>
				<p>Pending Payslips:</p>
				<h2>Faculty:</h2>
				<?php
				$sql = "SELECT * FROM fac_payslip WHERE status = 'pending'";
				$result = $con->query($sql);
				while ($row = $result->fetch_assoc()) {
					$sql = "SELECT name FROM faculty WHERE id = '".$row['facultyID']."'";
					$result1 = $con->query($sql);
					$row1 = $result1->fetch_assoc() ;
					$facname = $row1['name'];
					echo "<div>
					<table>
					<tr>
					<td>Name</td> <td>".$facname."</td>
					</tr>
					<tr>
					<td>Month</td> <td>".$row['month']."</td>
					</tr>
					<tr>
					<td>Year</td> <td>".$row['YEAR']."</td>
					</tr>
					<tr>
					<td>GOE</td> <td>".$row['GOE']."</td>
					</tr>
					<tr>
					<td>Salary</td> <td>".$row['salary']."</td>
					</tr>
					<tr>
					<td>Bonus</td> <td>".$row['bonus']."</td>
					</tr>
					</table>
					<a href = \"signpayslip.php?type=fac&id=".$row['facultyID']."&year=".$row['YEAR']."&month=".$row['month']."\">Approve</a>
					</div>";
				}
				?>
				<h2>Staff:</h2>
				<?php
				$sql = "SELECT * FROM staff_payslip WHERE status = 'pending'";
				$result = $con->query($sql);
				while ($row = $result->fetch_assoc()) {
					$sql = "SELECT name FROM staff WHERE id = '".$row['staffID']."'";
					$result1 = $con->query($sql);
					$row1 = $result1->fetch_assoc() ;
					$facname = $row1['name'];
					echo "<div>
					<table>
					<tr>
					<td>Name</td> <td>".$facname."</td>
					</tr>
					<tr>
					<td>Month</td> <td>".$row['month']."</td>
					</tr>
					<tr>
					<td>Year</td> <td>".$row['year']."</td>
					</tr>
					<tr>
					<td>GOE</td> <td>".$row['goe']."</td>
					</tr>
					<tr>
					<td>Salary</td> <td>".$row['salary']."</td>
					</tr>
					<tr>
					<td>Bonus</td> <td>".$row['bonus']."</td>
					</tr>
					</table>
					<a href = \"signpayslip.php?type=staff&id=".$row['staffID']."&year=".$row['year']."&month=".$row['month'].">Approve</a>
					</div>";
				}
				?>
		</div>
	</body>
</html>