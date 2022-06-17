<%@page import="com.test.WeatherDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.test.WeatherDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// 사용자가 선택한 지역 데이터 수신
	String stnId = request.getParameter("stnId");

	if (stnId==null)
		stnId = "108";		//-- 전국 날씨 정보
		
	StringBuffer sb = new StringBuffer();
	WeatherDAO dao = new WeatherDAO(stnId);
	
	// 타이틀
	String title = dao.weatherTitle();
	
	// 육상 중기 예보
	String weatherInfo = dao.weatherInfo();
	
	// 도시 정보 및 날짜 시간 별 날씨 정보
	ArrayList<String> cityList = dao.weatherCityList();
	for (int i=0; i<cityList.size(); i++)
	{
		sb.append(String.format("<h3>%s</h3>", cityList.get(i)));
		
		ArrayList<WeatherDTO> weatherList = dao.weatherList(String.valueOf(i+1));
		
		// 테이블 동적 생성
		sb.append("<table class='table'>");
		sb.append("<tr>");
		sb.append("<th>날짜</th>");
		sb.append("<th>날씨</th>");
		sb.append("<th>최저/최고 기온</th>");
		sb.append("<th>강수확률</th>");
		sb.append("</tr>");
		
		
		for(WeatherDTO w : weatherList)
		{
			sb.append("<tr>");
			sb.append(String.format("<td>%s</td>", w.getTmEf()));									// 날짜
			sb.append(String.format("<td><img src='images/%s'/> %s</td>" ,w.getImg(), w.getWf()));	// 날씨
			sb.append(String.format("<td>%s℃ / %s</td>", w.getTmn(), w.getTmx()));					// 최저 / 최고 기온
			sb.append(String.format("<td>%s</td>", w.getRnSt()));									// 강수확률
			sb.append("</tr>");
		}
		sb.append("</table>");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기상청 중기예보(WeatherInfo.jsp)</title>
<link rel="stylesheet" type="text/css" href="css/main.css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function()
	{
		//확인
		//alert("확인");
		
		//선택한 라디오 버튼의 상태를 선택된 상태(checked)로 유지할 수 있도록 처리
		// $(":radio:eq(0)");
		
		/* $(":radio:[value='184']").attr("checked", "checked"); */
		
		<%-- $(:radio:[value=<%=stnId%>]).attr("checked", "checked"); --%>
		
		$(":radio:[value='<%=stnId%>']").attr("checked", "checked");
		
	})
</script>
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
			
				<!-- 액션 속성 생략 → 요청 및 수신처는 자기 자신 -->
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
		
		<div class="panel panel-default" rolde="group">
		
			<div class="panel-heading">기상 정보 출력</div>
			<div class="panel-body">
				<p>
					<!-- <b>서울,경기도 육상 중기예보 - 2022년 06월 16일 (목)요일 06:00 발표</b> -->
					<b><%=title %></b>
				</p>
				<p>
				<%=weatherInfo %>
				<!-- 
					○ (하늘상태) 이번 예보기간은 대체로 흐리겠습니다.<br />
					○ (기온) 이번 예보기간 아침 기온은 18~22도, 낮 기온은 25~31도로 어제(15일, 아침최저기온 14~15도, 낮최고기온 17~25도)보다 높겠습니다.<br />
					○ (해상) 서해중부해상의 물결은 21일(화)과 22일(수)는 1.0~2.5m로 일겠고, 그 밖의 날은 0.5~2.0m로 일겠습니다.<br />
					○ (주말전망) 18일(토)~19일(일)은 대체로 흐리겠고, 아침 기온은 19~21도, 낮 기온은 26~31도가 되겠습니다.<br /><br />
					
					* 20일(월) 이후 우리나라 주변의 기압계 변화에 따라 강수 시점과 지역의 변동성이 매우 크겠으니, 앞으로 발표되는 예보와 기상정보를 참고하기 바랍니다.
				 -->
				</p>
				<%=sb.toString() %>
				<!-- 
				<h3>인천</h3>
				<table class="table">
					<thead>
					<tr>
						<th>날짜</th>
						<th>날씨</th>
						<th>최저/최고 기온</th>
						<th>강수확률</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>2022-06-19 00:00</td>
						<td>흐림</td>
						<td>21 ~ 29</td>
						<td>40</td>
					</tr>
					<tr>
						<td>2022-06-19 12:00</td>
						<td>구름많음</td>
						<td>21 ~ 29</td>
						<td>20</td>
					</tr>
					<tr>
						<td>2022-06-20 00:00</td>
						<td>흐림</td>
						<td>22 ~ 30</td>
						<td>40</td>
					</tr>
					<tr>
						<td>2022-06-20 12:00</td>
						<td>구름많음</td>
						<td>22 ~ 30</td>
						<td>30</td>
					</tr>
					</tbody>
				</table>
				 -->

			</div>
		
		</div>
		
		
		
	</div>
	
</div>

</body>
</html>