package tw.donglin.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import tw.donglin.model.IToDoListService;
import tw.donglin.model.ToDoList;


@Controller
public class ToDoListController {
	
	@Autowired
	private IToDoListService tService;
	
	@Autowired
	private ToDoList tBean;
	
	@RequestMapping(path = "/index")
	public String processMainAction() {
		return "index";
	}
	
	@PostMapping("/todo")
	@ResponseBody
	public void processInsertAction(@RequestParam("content") String content) {
		tBean.setContent(content);
		tBean.setFinished(0);
		tService.insert(tBean);
	}
	
	@GetMapping("/todo")
	@ResponseBody
	public List<ToDoList> processSelectAllAction() {
		return tService.selectAll();
	}
	
	@PutMapping("/todo/{id}")
	@ResponseBody
	public void processUpdateAction(@PathVariable("id") int id) {
		ToDoList resultBean = tService.findById(id);
		resultBean.setFinished(1);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		String fTime = simpleDateFormat.format(now);
		resultBean.setFinishedTime(fTime);
		tService.update(resultBean);
	}
	
	@DeleteMapping("/todo/{id}")
	@ResponseBody
	public void processDeleteAction(@PathVariable("id") int id) {
		tService.deleteById(id);
	}
}
