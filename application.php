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

	if (isset($_POST['start']) && isset($_POST['comment']) && isset($_POST['noofdays'])) {
		$start = $_POST['start'];
		$comment = $_POST['comment'];
		$noofdays = $_POST['noofdays'];
		$sql = "SELECT * FROM path WHERE predecessor = '".$_SESSION['role']."'";
		if ($_SESSION['role']=='hod' || $_SESSION['role']=='dean_fac' || $_SESSION['role']=='Asso_dean_fac') {
			$sql = "SELECT * FROM path WHERE predecessor = 'HodDean'";
		}
		$result1 = $con->query($sql);
		$row = $result1->fetch_assoc() ;
		$status = $row['id'];
		$sql = "INSERT INTO faculty_application(status, faculty_id, noofdays, start) VALUES('".$status."','".$_SESSION['facultyID']."',".$noofdays.",'".$start."')";
		$con->query($sql);
		$sql = "SELECT id FROM faculty_application WHERE status = '".$status."' AND faculty_id = '".$_SESSION['facultyID']."' AND noofdays = ".$noofdays." AND start = '".$start."'";
		$result = $con->query($sql);
		$row = $result->fetch_assoc();
		$sql = "INSERT INTO faculty_comments(comment, application_id, path_id) VALUES('".$comment."',".$row['id'].",'".$status."')";
		$con->query($sql);
	}
	$newflag = TRUE;
	$sql = "SELECT * FROM faculty_application WHERE faculty_id = "."'".$_SESSION['facultyID']."' "."ORDER BY ts DESC";
	$result = $con->query($sql);
	while ($row = $result->fetch_assoc()) {
		if ($row['status']=='reject') {
			$status1 = 'Rejected';
		}
		else{
			$sql = "SELECT successor FROM path WHERE id = '".$row['status']."'";
			$result1 = $con->query($sql);
			$row1 = $result1->fetch_assoc();
			if ($row1['successor']=='applicant') {
				$status1 = 'Approved';
			}
			else{
				$status1 = 'Pending';
				$newflag = FALSE;
			}
		}
	}
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
				<a href="payslip.php"><i class="fas fa-sticky-note"></i>Payslips</a>
				<a href="logout.php"><i class="fas fa-sign-out-alt"></i>Logout</a>
			</div>
		</nav>
		<div class="content">
			<h2>Leave Application</h2>
			<p>Welcome back, <?=$name?>!</p>
				<?php
				if ($newflag) {
					echo "<div>
				<form action=\"application.php\" method=\"POST\">
					<input type=\"text\" name=\"start\" placeholder=\"Start Date(YYYY-MM-DD)\" id=\"start\" required>
					<input type=\"text\" name=\"comment\" placeholder=\"Comment\" id=\"comment\" required>
					<input type=\"text\" name=\"noofdays\" placeholder=\"No of days\" id=\"noofdays\" required>
					<input type=\"submit\" value=\"Raise new application\">
				</form>
				</div>";
				}
				?>
				<p>Leave Applications:</p>
				<?php
					if (isset($_SESSION['facultyID'])) {
						$sql = "SELECT * FROM faculty_application WHERE faculty_id = "."'".$_SESSION['facultyID']."' "."ORDER BY ts DESC";
						$result = $con->query($sql);
						while ($row = $result->fetch_assoc()) {
							if ($row['status']=='reject') {
								$status1 = 'Rejected';
							}
							else{
								$sql = "SELECT successor FROM path WHERE id = '".$row['status']."'";
								$result1 = $con->query($sql);
								$row1 = $result1->fetch_assoc();
								if ($row1['successor']=='applicant') {
									$status1 = 'Approved';
								}
								else{
									$status1 = 'Pending';
								}
							}
							echo "<div>
							<table>
							<tr>
							<td>ID</td> <td>".$row['id']."</td>
							</tr>
							<tr>
							<td>From</td> <td>".$row['start']."</td>
							</tr>
							<tr>
							<td>No. of days</td> <td>".$row['noofdays']."</td>
							<tr>
							<td>Status</td> <td>".$status1."</td>
							</tr>
							</tr>
							<tr>
							<td><a href=\"status.php?id=".$row['id']."\">More info</a></td>
							</tr>
							</table>
							</div>";
						}
					}
				?>
		</div>
	</body>
</html>