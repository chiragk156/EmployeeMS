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
		<title>Sign Application</title>
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
				<p>Pending Applications:</p>
				<?php
					if (isset($_SESSION['facultyID'])) {
						$sql1 = "SELECT id FROM path WHERE successor = '".$_SESSION['role']."'";
						// $result1 = $con->query($sql);
						// $row = $result1->fetch_assoc() ;
						// $pathid = $row['id'];
						$sql = "SELECT * FROM path WHERE predecessor = '".$_SESSION['role']."'";
						$result1 = $con->query($sql);
						$row = $result1->fetch_assoc() ;
						$pathid1 = $row['id'];
						$to = $row['successor'];
						$sql = "SELECT dept FROM faculty WHERE id = '".$_SESSION['facultyID']."'";
						$result1 = $con->query($sql);
						$row = $result1->fetch_assoc() ;
						$dept = $row['dept'];
						if ($_SESSION['role']=='hod') {
							$sql = "SELECT * FROM faculty_application WHERE status IN (".$sql1.") AND faculty_id IN (SELECT id FROM faculty WHERE dept = '".$dept."') "."ORDER BY ts DESC";
						}
						else{
							$sql = "SELECT * FROM faculty_application WHERE status IN (".$sql1.") ORDER BY ts DESC";
						}
						
						$result = $con->query($sql);
						while ($row = $result->fetch_assoc()) {
							$sql = "SELECT name FROM faculty WHERE id = '".$row['faculty_id']."'";
							$result1 = $con->query($sql);
							$row1 = $result1->fetch_assoc() ;
							$facname = $row1['name'];
							echo "<div>
							<table>
							<tr>
							<td>Applicant</td> <td>".$facname."</td>
							</tr>
							<tr>
							<td>ID</td> <td>".$row['id']."</td>
							</tr>
							<tr>
							<td>From</td> <td>".$row['start']."</td>
							</tr>
							<tr>
							<td>No. of days</td> <td>".$row['noofdays']."</td>
							</tr>
							<tr>
							<td><a href=\"status.php?id=".$row['id']."\">More info</a></td>
							</tr>
							</table>
							<form action = \"approve.php?type=fac&id=".$row['id']."&pid=".$pathid1."\" method = \"POST\">
							<input type=\"text\" name=\"comment\" placeholder=\"Comment\" id=\"comment\" required>
							<select name=\"status\" required>
							<option value=\"app\">Approve</option>
							<option value=\"rej\">Reject</option>
							</select>
							<input type=\"submit\" value=\"Submit\">
							</form>
							</div>";
						}
					}
					elseif (isset($_SESSION['staffID'])) {
						$sql = "SELECT dept FROM staff WHERE id = '".$_SESSION['staffID']."'";
						$result = $con->query($sql);
						$row = $result->fetch_assoc();
						$dept = $row['dept'];
						if ($dept == 'Establishment Office' && $_SESSION['role']=='staff') {
							$sql1 = "SELECT id FROM path WHERE successor = 'staffEO'";
						}
						else{
							$sql1 = "SELECT id FROM path WHERE successor = '".$_SESSION['role']."'";
						}
						if ($dept == 'Establishment Office' && $_SESSION['role']=='staff') {
							$sql = "SELECT * FROM path WHERE predecessor = 'staffEO'";
						}
						else{
							$sql = "SELECT * FROM path WHERE predecessor = '".$_SESSION['role']."'";	
						}
						$result1 = $con->query($sql);
						$row = $result1->fetch_assoc() ;
						$pathid1 = $row['id'];
						$to = $row['successor'];
						if (($_SESSION['role']=='asst_reg' || $_SESSION['role']=='staff') && $dept == 'Establishment Office') {
							$sql = "SELECT * FROM faculty_application WHERE status IN (".$sql1.") ORDER BY ts DESC";
						}
						
						$result = $con->query($sql);
						while ($row = $result->fetch_assoc()) {
							$sql = "SELECT name,remaningLeaves FROM faculty WHERE id = '".$row['faculty_id']."'";
							// echo $sql;
							$result1 = $con->query($sql);
							$row1 = $result1->fetch_assoc() ;
							$facname = $row1['name'];
							$remainingleaves = $row1['remaningLeaves'];
							echo "<div>
							<table>
							<tr>
							<td>Applicant</td> <td>".$facname."</td>
							</tr>
							<tr>
							<td>Remaining Leaves</td> <td>".$remainingleaves."</td>
							</tr>
							<tr>
							<td>ID</td> <td>".$row['id']."</td>
							</tr>
							<tr>
							<td>From</td> <td>".$row['start']."</td>
							</tr>
							<tr>
							<td>No. of days</td> <td>".$row['noofdays']."</td>
							</tr>
							<tr>
							<td><a href=\"status.php?id=".$row['id']."\">More info</a></td>
							</tr>
							</table>
							<form action = \"approve.php?type=fac&id=".$row['id']."&pid=".$pathid1."\" method = \"POST\">
							<input type=\"text\" name=\"comment\" placeholder=\"Comment\" id=\"comment\" required>
							<select name=\"status\" required>
							<option value=\"app\">Approve</option>
							<option value=\"rej\">Reject</option>
							</select>
							<input type=\"submit\" value=\"Submit\">
							</form>
							</div>";
						}
					}
				?>
		</div>
	</body>
</html>