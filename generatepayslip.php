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

if (isset($_POST['id']) && isset($_POST['month']) && isset($_POST['year'])) {
	if ($_GET['type']=='fac') {
		$sql = "SELECT goe,".$_POST['year']." - YEAR(doj) as exp FROM faculty WHERE id ='".$_POST['id']."'";
		// echo $sql;
		$result = $con->query($sql);
		$row = $result->fetch_assoc();
		$exp = $row['exp'];
		$goe = $row['goe'];
		$sql = "SELECT salary FROM faculty_pay_matrix WHERE goe = ".$goe." AND experience = ".$exp;
		// echo $sql;
		$result = $con->query($sql);
		$row = $result->fetch_assoc();
		$salary = $row['salary'];
		$sql = "SELECT percent FROM faculty_bonus WHERE month = ".$_POST['month']." AND year = ".$_POST['year'];
		$result = $con->query($sql);
		$bonus = 0;
		if ($result->num_rows > 0) {
			$row = $result->fetch_assoc();
			$bonus = $row['percent']*$salary/100;
		}
		
		$sql = "INSERT INTO fac_payslip(id, facultyID, month, YEAR, GOE, salary, bonus, status) VALUES (1234,'".$_POST['id']."',".$_POST['month'].",".$_POST['year'].",".$goe.",".$salary.",".$bonus.",'pending')";
		// echo $sql;
		$con->query($sql);
	}
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
			<h2>Generate Payslip</h2>
			<p>Welcome back, <?=$name?>!</p>
		<div>
			<?php
			echo "<form action=\"generatepayslip.php?type=".$_GET['type']."\" method=\"POST\">";
			?>
			<h3>Select Details</h3>
			<select name="id">
				<?php
				if ($_GET['type']=='fac') {
					$sql = "SELECT id,name FROM faculty";
				}
				else {
					$sql = "SELECT id,name FROM staff";		
				}
				$result = $con->query($sql);
				while ($row = $result->fetch_assoc()) {
					echo "<option value=\"".$row['id']."\">".$row['id']." | ".$row['name']."</option>";
				}
				?>
			</select>
			<select name="month">
				<option value="1">Jan</option>
				<option value="2">Feb</option>
				<option value="3">Mar</option>
				<option value="4">Apr</option>
				<option value="5">May</option>
				<option value="6">Jun</option>
				<option value="7">Jul</option>
				<option value="8">Aug</option>
				<option value="9">Sep</option>
				<option value="10">Oct</option>
				<option value="11">Nov</option>
				<option value="12">Dec</option>
			</select>
			<input type="text" name="year" placeholder="Year(YYYY)">
			<input type="submit" value="Generate">
			</form>
		</div>
		</div>
	</body>
</html>