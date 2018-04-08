<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css">

<title>JSP AJAX Tutorial</title>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.js"></script>

<script type="text/javascript">
	var searchRequest = new XMLHttpRequest();
	var registerRequest = new XMLHttpRequest();

	function searchFunction() {
		searchRequest.open("Post",
				"./UserSearchServlet?userName="
						+ encodeURIComponent(document
								.getElementById("userName").value), true);
		searchRequest.onreadystatechange = searchProcess;
		searchRequest.send(null);

	}

	function searchProcess() {
		var table = document.getElementById("ajaxTable");
		table.innerHTML = "";
		if (searchRequest.readyState == 4 && searchRequest.status == 200) {
			var object = eval('(' + searchRequest.responseText + ')');
			var result = object.result;

			for (var i = 0; i < result.length; i++) {
				var row = table.insertRow(0);
				for (var j = 0; j < result[i].length; j++) {
					var cell = row.insertCell(j);
					cell.innerHTML = result[i][j].value;
				}
			}
		}

	}

	function registerFunction() {
		registerRequest.open("Post",
				"./UserRegisterServlet?userName="
						+ encodeURIComponent(document
								.getElementById("registerName").value)
						+ "&userAge="
						+ encodeURIComponent(document
								.getElementById("registerAge").value)
						+ "&userGender="
						+ encodeURIComponent($(
								'input[name=registerGender]:checked').val())
						+ "&userEmail="
						+ encodeURIComponent(document
								.getElementById("registerEmail").value), true);

		registerRequest.onreadystatechange = registerProcess;
		registerRequest.send(null);
	}

	function registerProcess() {
		if (registerRequest.readyState == 4 && registerRequest.status == 200) {
			var result2 = registerRequest.responseText;
			if (result2 != 1) {
				alter('Failed');
			} else {
				var userName = document.getElementById("registerName");
				var userAge = document.getElementById("registerAge");
				var userEmail = document.getElementById("registerEmail");

				registerName.value = "";
				registerAge.value = "";
				registerEmail.value = "";
				searchFunction();
			}
		}

	}

	window.onload = function() {
		searchFunction();
	}
</script>
</head>


<body>
	<br>
	<div class="container">
		<div class="form-group row pull-right">
			<div class="col-xs-8">
				<input class="form-control" id="userName" onkeyup="searchFunction()"
					type="text" size="20">
			</div>

			<div class="col-xs-2">
				<button class="btn btn-primary" onclick="searchFunction();"
					type="button">검색</button>
			</div>
		</div>

		<table class="table"
			style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #fafafa; text-align: center;">이름</th>
					<th style="background-color: #fafafa; text-align: center;">나이</th>
					<th style="background-color: #fafafa; text-align: center;">성별</th>
					<th style="background-color: #fafafa; text-align: center;">이메일</th>

				</tr>
			</thead>
			<tbody id="ajaxTable">
				<tr>
					<td>테스트</td>
					<td>30</td>
					<td>테스트</td>
					<td>테스트@이메일</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="container">
		<table class="table"
			style="text-align: center; border: 1px solid #dddddd;">
			<thead>
				<tr>
					<td colspan="2" style="text-align: center;">회원등록</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="background-color: #fafafa; text-align: center;"><h5>이름</h5></td>
					<td><input class="form-control" type="text" id="registerName"
						size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align: center;"><h5>나이</h5></td>
					<td><input class="form-control" type="text" id="registerAge"
						size="20"></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align: center;"><h5>성별</h5></td>
					<td><div class="form-group"
							style="text-align: center; margin: 0 auto">

							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active"><input
									type="radio" name="registerGender" autocomplete="off"
									value="남자" checked>남자</label> <label class="btn btn-primary"><input
									type="radio" name="registerGender" autocomplete="off"
									value="여자">여자</label>
							</div>
						</div></td>
				</tr>
				<tr>
					<td style="background-color: #fafafa; text-align: center;"><h5>이메일</h5></td>
					<td><input class="form-control" type="text" id="registerEmail"
						size="50"></td>
				</tr>

				<tr>
					<td colspan="2"><button class="btn btn-primary rull-right"
							onclick="registerFunction();" type="button">등록</button></td>
				</tr>

			</tbody>
		</table>
	</div>


</body>



</html>