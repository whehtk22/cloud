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
				<label for="writer">�ۼ���</label>
				<input type="text" name="writer" required/>
				<%--  <input type="text" name="bName" size="10"> --%>
				<%-- ${user_name}(${user_id}) --%>
				<%-- input�� ������ �Ķ���Ͱ� ���������� �������� �̸������� DB�� �Ѱܾ�--%>
			</p>
			<p>
				<label for="title">�� ����</label>
				<select id="titleHeader">
					<option>�Ӹ��� ����</option>
					<option value="buy">��ϴ�.</option>
					<option value="sell">�˴ϴ�.</option>
				</select>
				<!-- <input type="text" name="title" size="20" required/> -->
			</p>
			<p>
				<label>�ۼ��ð�</label>
				<span class="wTime">�ۼ��ð�</span>
			</p>
			<hr/>
			<p>
				<label class="hide">����</label>
				<textarea name="content"></textarea>
				<!-- <textarea name="content" rows="10" cols="50"></textarea> -->
			</p>
		</div>
		<hr/>
		<div class="attachFiles">
			<p>
				<label for="file">����÷��</label><!--
			 --><input type="file" name="upload"/><!--
			 --><button class="btn fileUpBtn">���Ͼ��ε�</button>
			</p>
		</div>
		<div class="btnArea">
			<p>
				<button class="btn btnTempSave">�ӽ�����</button><!--
			 --><input type="submit" class="btn btn-default" value="�ۼ��Ϸ�" ><!--
			 --><a class="goListBtn" href="/board/list" title="�� ��� ����">�۸��</a>
			</p>
		</div>
	</fieldset>
</body>
</html>