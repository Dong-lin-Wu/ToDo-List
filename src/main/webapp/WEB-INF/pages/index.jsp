<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
    src="https://code.jquery.com/jquery-3.6.0.js"
    integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
    crossorigin="anonymous">
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>ToDo-List</title>
<style>
	form{
/* 	border:1px solid black; */
	padding:10px 0;
	}
	button, span{
	height:40px;
	}
	.base-button{
	    font-size: 14px;
	    padding: 6px 15px;
	    border: 1px solid #E0E0E0;
	    cursor: pointer;
	    margin-left:5px;
	}
	.input_text{
		height:40px;
		outline:none;
		margin-right:2%;
		width:calc(73% - 5px);
	}
	.redborder{
		border:1px solid red;
	}
	.bgwhite{
		background-color:white;
	}
</style>
</head>
<body>
<br>
<div class="container" style="width:500px">
	<div style="border:1px solid black;padding:15px;margin:20px 0px">
		<h2><b>待辦事項</b></h2>
		<span style="color:red">*</span>項目
		<div>
			<form id="form">
				<input type="text" id="content" name="content" placeholder="請輸入待辦事項" class="input_text">	
				<button type="button" id="button_s" class="base-button" onclick="button_submit()">送出</button>
			</form>
		</div>
		<span id="textCheck" style="color:red"></span>
	</div>
	<div>

		<button id="button_p" class="base-button" onclick="button_pending()">待完成</button>
		<button id="button_d" class="base-button bgwhite" onclick="button_done()">已完成</button>
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">提示</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
		        <button id="modal_confirm" type="button" class="btn btn-primary" data-bs-dismiss="modal">確認</button>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
	<br>
	<div id="result"></div>
<script>
var allData;
$(document).ready(function(){
	updateData();
});
//從資料庫抓取最新資料
function updateData(){
	$.ajax({
		type:'get',
		url:'/ToDo-List/todo',
		success: function(data){
			allData = data;
			button_pending();
		},
		error: function(e){
			console.log('showdata is wrong!');	
		}
	});
	
}
function button_submit(){
	
	var form_obj = Object.fromEntries(new FormData(document.getElementById('form')).entries());
	if(form_obj.content == ''){
		$('#textCheck').text('不得為空值');
		$('#content').addClass('redborder');
		$('#button_s').css('cursor','not-allowed');

	}else{
		$.ajax({
			type:'post',
			url:'/ToDo-List/todo',
			data:form_obj,
			success: function(){
				$("#content").val("");
				updateData();
			},
			error: function(e){
				console.log('insert is wrong!');	
			}
		});
	}
	
}
$(document).on('input', '.redborder', function(e){
	$('#textCheck').text('');
	$('#content').removeClass('redborder');
	$('#button_s').css('cursor','pointer');
});

function button_pending(){
	$('#button_p').removeClass('bgwhite');
	$('#button_d').addClass('bgwhite');
	$('#result').empty();
	$.each(allData,function(index, obj){
		if(obj.finished == 0){
			var div_pending=$('<div/>').css('display','flex');
			$('<span/>').html(obj.content).attr('id','content_'+obj.id).css('width','70%').css('vertical-align','middle').appendTo(div_pending);
			var div_button = $('<div/>').css('width','30%');
			$('<button>').addClass('base-button').attr('onclick','modal_delete('+obj.id+')').text('移除').attr('data-bs-toggle','modal').attr('data-bs-target','#exampleModal').appendTo(div_button);
			$('<button>').addClass('base-button').attr('onclick','modal_complete('+obj.id+')').text('完成').attr('data-bs-toggle','modal').attr('data-bs-target','#exampleModal').appendTo(div_button);
			div_button.appendTo(div_pending);
			div_pending.appendTo($('#result'));
			$('<hr>').appendTo($('#result'));
		}
	})
		
}

function button_done(){
	var dayNow = new Date();
	$('#button_p').addClass('bgwhite');
	$('#button_d').removeClass('bgwhite');
	$('#result').empty();
	$.each(allData,function(index, obj){
		if(obj.finished == 1){
			var div_pending=$('<div/>').css('display','flex').css('justify-content','space-between');
			$('<span/>').html(obj.content).css('vertical-align','middle').appendTo(div_pending);
			var theDate = new Date(obj.finishedTime);
			var diffTime = Math.round((dayNow-theDate)/1000,0);
			var showTime;
			switch(true){
				case diffTime<60:
					showTime = diffTime + '秒前';
					break;
				case diffTime>60 && diffTime < 1440:
					showTime = Math.round(diffTime/60,0) + '分鐘前';
					break;
				case diffTime>1440 && diffTime < 86400:
					showTime = Math.round(diffTime/1440,0) + '小時前';
					break;
				default:
					showTime = obj.finishedTime.substring(0,11);
					break;
			}
			
			$('<span/>').html(showTime).css('vertical-align','middle').appendTo(div_pending);			
			
			div_pending.appendTo($('#result'));
			$('<hr>').appendTo($('#result'));
		}
	})
	
}

function modal_complete(id){
	$('.modal-body').text("是否完成'"+$('#content_'+id).html()+"'?");
	$('#modal_confirm').attr('onclick','button_complete('+id+')');
}

function button_complete(id){
	$.ajax({
		type:'put',
		url:'/ToDo-List/todo/'+id,
		success: function(){
			updateData();
		},
		error: function(e){
			console.log('update is wrong!');	
		}
	});
}

function modal_delete(id){
	$('.modal-body').text("是否移除'"+$('#content_'+id).html()+"'?");
	$('#modal_confirm').attr('onclick','button_delete('+id+')');
}

function button_delete(id){
	$.ajax({
		type:'delete',
		url:'/ToDo-List/todo/'+id,
		success: function(){
			updateData();
		},
		error: function(e){
			console.log('delete is wrong!');	
		}
	});
	
}
</script>
</div>
</body>
</html>