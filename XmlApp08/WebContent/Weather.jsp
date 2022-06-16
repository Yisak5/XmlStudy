<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기상청 중기예보</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" href="https://">
</head>
<body>


<!-- 
stnId=108	전국	
stnId=109	서울,경기
stnId=105	강원
stnId=131	충북
stnId=133	충남
stnId=146	전북
stnId=143	경북
stnId=156	전남	
stnId=184	제주특별자치도
stnId=159	경남
 -->


<div class="container">
	<h2>
		기상 정보 <small>중기 예보</small>
	</h2>
	
	<div class="panel-group" role="group">
		<div class="panel panel-default" role="group">
			<div class="panel-heading">지역 선택</div>
			<div class="panel-body">
				<form action="" method="get" role="form">
					<input type="radio" name="stnId" value="108" checked="checked" />전국
					<input type="radio" name="stnId" value="109" />서울, 경기
					<input type="radio" name="stnId" value="105" />강원
					<input type="radio" name="stnId" value="131" />충북
					<input type="radio" name="stnId" value="133" />충남
					<input type="radio" name="stnId" value="146" />전북
					<input type="radio" name="stnId" value="143" />경북
					<input type="radio" name="stnId" value="156" />전남
					<input type="radio" name="stnId" value="184" />제주특별자치도
					<input type="radio" name="stnId" value="159" />경남
					
					<button type="submit" class="btn btn-default">Submit</button>
				</form>
			</div><!-- close.panel-body -->
		
		</div><!-- close.panel-heading -->
	</div>
	
</div>

</body>
</html>