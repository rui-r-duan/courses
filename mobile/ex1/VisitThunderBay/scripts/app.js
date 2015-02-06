function checkForm()
{
    console.log(document.feedback.name.value);
    console.log(document.feedback.selectmenu.options[document.feedback.selectmenu.selectedIndex].value);
    if (document.feedback.name.value == ''
	|| document.feedback.selectmenu.options[document.feedback.selectmenu.selectedIndex].value == '') {
	alert('Please complete the form before submission.');
	return false;
    }
    return true;
}
