package tw.donglin.model;

import java.util.List;

public interface IToDoListService {
	public void insert(ToDoList tBean);
	public ToDoList findById(int id);
	public List<ToDoList> selectAll();
	public void update(ToDoList tBean);
	public void deleteById(int id);
}
