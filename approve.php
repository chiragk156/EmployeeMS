<?php
require 'config.php';
session_start();
if ($_GET['type']=='fac') {
	$pid = $_GET['pid'];
	if ($_POST['status']=='rej') {
		$pid = 'reject';
	}
	$sql = "UPDATE faculty_application SET status = '".$pid."' WHERE id = ".$_GET['id'];
	// echo $sql;
	$con->query($sql);
	$sql = "INSERT INTO faculty_comments(comment, application_id, path_id) VALUES ('".$_POST['comment']."',".$_GET['id'].",'".$pid."')";
	// echo $sql;
	$con->query($sql);

	$sql = "SELECT faculty_id,noofdays FROM faculty_application WHERE id = ".$_GET['id'];
	$result = $con->query($sql);
	$row = $result->fetch_assoc();
	$faculty_id = $row['faculty_id'];
	$noofdays = $row['noofdays'];

	$sql = "SELECT * FROM path WHERE id = '".$pid."'";
	$result = $con->query($sql);
	$row = $result->fetch_assoc();
	if ($row['successor'] == 'applicant' && $_POST['status']=='app') {
		$sql = "UPDATE faculty SET remaningLeaves = remaningLeaves - ".$noofdays." WHERE id = '".$faculty_id."'";
		$con->query($sql);
	}
}

header('Location: signleave.php');
?>