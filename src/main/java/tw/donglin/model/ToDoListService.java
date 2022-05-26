package tw.donglin.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ToDoListService implements IToDoListService{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void insert(ToDoList tBean) {
		Session session = sessionFactory.getCurrentSession();
		session.save(tBean);
	}

	@Override
	public List<ToDoList> selectAll() {
		Session session = sessionFactory.getCurrentSession();
		Query<ToDoList> query = session.createQuery("from ToDoList", ToDoList.class);
		if(query != null) {
			List<ToDoList> qlist = query.list();
			return qlist;
		}else {
			return new ArrayList<ToDoList>();
		}
		
	}

	@Override
	public void update(ToDoList tBean) {
		Session session = sessionFactory.getCurrentSession();
		session.update(tBean);
	}

	@Override
	public void deleteById(int id) {
		Session session = sessionFactory.getCurrentSession();
		ToDoList resultBean = session.get(ToDoList.class, id);
		session.delete(resultBean);
		
	}

	@Override
	public ToDoList findById(int id) {
		Session session = sessionFactory.getCurrentSession();
		ToDoList resultBean = session.get(ToDoList.class, id);
		return resultBean;
	}

}
