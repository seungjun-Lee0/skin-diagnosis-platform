package lsj.spring.project.dao;

import lsj.spring.project.vo.Event;
import lsj.spring.project.vo.Notice;

import java.util.List;
import java.util.Map;

public interface EventDAO {
    int insertEvent(Event n );

    List<Event> selectEvent(int snum);
    List<Event> selectAllEvent();
    List<Event> findSelectEvent(Map<String, Object> param);
    Event selectOneEvent(String bno);

    int selectCountEvent();
    int selectCountEvent(Map<String, Object> param);
    int viewCountEvent(String bno);
    String readFnames(String bno);
    String readUuid(String bno);

    int modifyEvent(Event n);
    int deleteEvent(String bno);
}
