package lsj.spring.project.dao;

import lsj.spring.project.vo.Event;
import lsj.spring.project.vo.Notice;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository("edao")
public class EventDAOImpl implements EventDAO{

    @Autowired private SqlSession sqlSession;

    @Override
    public int insertEvent(Event e) { return sqlSession.insert("event.insertEvent", e); }

    @Override
    public List<Event> selectEvent(int snum) {
        return sqlSession.selectList("event.selectEvent", snum);
    }

    @Override
    public List<Event> selectAllEvent() {
        return sqlSession.selectList("event.selectEventAll");
    }

    @Override
    public List<Event> findSelectEvent(Map<String, Object> param) {
        return sqlSession.selectList("event.findSelect", param);
    }

    @Override
    public Event selectOneEvent(String bno) {
        return sqlSession.selectOne("event.selectOne", bno);
    }

    @Override
    public int selectCountEvent() {
        return sqlSession.selectOne("event.countEvent");
    }

    @Override
    public int selectCountEvent(Map<String, Object> param) {
        return sqlSession.selectOne("event.findSelectCount", param);
    }

    @Override
    public int viewCountEvent(String bno) {
        return sqlSession.update("event.viewEvent", bno);
    }

    @Override
    public String readFnames(String bno) { return sqlSession.selectOne("event.readFnames", bno); }

    @Override
    public String readUuid(String bno) { return sqlSession.selectOne("event.readUuid", bno); }

    @Override
    public int modifyEvent(Event e) { return sqlSession.update("event.modifyEvent", e);}

    @Override
    public int deleteEvent(String bno) { return sqlSession.delete("event.deleteEvent", Integer.parseInt(bno)); }
}
