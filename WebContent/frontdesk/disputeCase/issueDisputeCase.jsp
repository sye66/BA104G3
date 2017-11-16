<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	
		<script type="text/javascript">
			$(function (){
			 
			    function format_float(num, pos)
			    {
			        var size = Math.pow(10, pos);
			        return Math.round(num * size) / size;
			    }
			 
			    function preview(input) {
			 
			        if (input.files && input.files[0]) {
			            var reader = new FileReader();
			            
			            reader.onload = function (e) {
			                $('.preview').attr('src', e.target.result);
			                var KB = format_float(e.total / 1024, 2);
			                $('.size').text("檔案大小：" + KB + " KB");
			            }
			 
			            reader.readAsDataURL(input.files[0]);
			        }
			    }
			 
			    $("body").on("change", "#dispute_Attachment", function (){
			        preview(this);
			    })
			    
			})
		</script>	
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-8 col-sm-offset-2">
					<div class="form-group">
						<label for="dispute_Content">申訴內容</label>
						<input type="text" name="dispute_Content" id="dispute_Content" placeholder="臣等恭營聖旨" class="form-control">
					</div>
					<div class="form-group">
						<label for="dispute_Attachment">申訴附件</label>
						<input type="file" name="dispute_Attachment" id="dispute_Attachment" class="form-control" multiple="true">
        				<img class="preview" style="max-width: 600px; max-height: 600px;">
					</div>
					<input type="submit" name="" class=" btn btn-primary">
				</div>
			</div>
		</div>

	</body>
</html>