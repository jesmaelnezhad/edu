$(document).foundation()

function validateSelectors(form){
	var price = form.querySelector("#NewExamPrice").value;
	if(price.isNaN()){
		return false;
	}
	return true;
}