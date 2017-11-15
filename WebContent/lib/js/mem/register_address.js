var nDefCity = "<?=$rowMember->city?>";
var nDefArea = "<?=$rowMember->area?>";


$(function() {
	$("#Birthday_Y").change(function() {
		setBirthday_Day($(this).val(),$("#Birthday_M").val());
	});
	$("#Birthday_M").change(function() {
		setBirthday_Day($("#Birthday_M").val(),$(this).val());
	});
	setBirthday_Day($("#Birthday_Y").val(),$("#Birthday_M").val());
});


function setBirthday_Day(nY, nM) {
	var dDate = new Date(nY, nM, 0);
	nCurDay = $("#Birthday_D").val();
	$("#Birthday_D option").remove();
	for (i=1; i<= dDate.getDate(); i++) $("#Birthday_D").append("<option></option>").children(":last").val(i).text(i).attr("selected", (nCurDay==i));
}


function setCityArea() {
	$("#Area option").remove();
	$("#Area").append("<option value=''>請選擇</option>").append($("#jAllArea option[c="+$("#City").val()+"]").clone());
	if ($("#City").val() == nDefCity && nDefCity !== "") $("#Area option[value='"+nDefArea+"']").attr("selected",true);
}


function setZip() {
	$("#ZIP").val($("#Area option:selected").attr("z"));
}


$(function() {
	//複製新Area並隱藏
	$("#Area").after('<select name="jAllArea" id="jAllArea"></select>');
	$("#jAllArea").hide().append($("#Area option").clone());
	
	$("#City").change(function() {
		setCityArea($(this).val());
		setZip();
	});
	$("#Area").change(function() {
		setZip();
	});
	
	setCityArea();
});

