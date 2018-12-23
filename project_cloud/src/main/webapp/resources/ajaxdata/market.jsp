<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<fieldset id="write_form">
		<div class="formInner">
			<h4 class="hide">Storage Share Market</h4>
			<p>
				<label for="writer">작성자</label>
				<input type="text" name="writer" required/>
				<%--  <input type="text" name="bName" size="10"> --%>
				<%-- ${user_name}(${user_id}) --%>
				<%-- input을 가려서 파라미터가 없어졌으니 히든으로 이름정보를 DB에 넘겨야--%>
			</p>
			<p>
				<label for="title">글 제목</label>
				<select id="titleHeader">
					<option>머릿말 선택</option>
					<option value="buy">삽니다.</option>
					<option value="sell">팝니다.</option>
				</select>
				<!-- <input type="text" name="title" size="20" required/> -->
			</p>
			<p>
				<label>작성시간</label>
				<span class="wTime">작성시간</span>
			</p>
			<hr/>
			<p>
				<label class="hide">내용</label>
				<textarea name="content"></textarea>
				<!-- <textarea name="content" rows="10" cols="50"></textarea> -->
			</p>
		</div>
		<hr/>
		<div class="attachFiles">
			<p>
				<label for="file">파일첨부</label><!--
			 --><input type="file" name="upload"/><!--
			 --><button class="btn fileUpBtn">파일업로드</button>
			</p>
		</div>
		<div class="btnArea">
			<p>
				<button class="btn btnTempSave">임시저장</button><!--
			 --><input type="submit" class="btn btn-default" value="작성완료" ><!--
			 --><a class="goListBtn" href="/board/list" title="글 목록 보기">글목록</a>
			</p>
		</div>
	</fieldset>
</body>
</html>