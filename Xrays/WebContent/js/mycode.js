function mysubmExam()
{
	if (document.getElementById('patient_id').value == "")
	{
		alert('Θα πρέπει να επιλέξετε ασθενή.');
		document.getElementById('patient_id').focus();
		return;
	}
	if (document.getElementById('exam').value == "")
	{
		alert('Θα πρέπει να επιλέξετε κάποια ακτινολογική εντολή.');
		document.getElementById('exam').focus();
		return;
	}
	document.getElementById('action').value = "new_command";
	document.getElementById('examform').submit();
}

function mysubmCommand()
{
	document.getElementById('action').value = "edit_command";
	document.getElementById('editform').submit();
}
