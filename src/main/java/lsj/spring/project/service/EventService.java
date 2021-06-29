package lsj.spring.project.service;

import lsj.spring.project.vo.Event;
import lsj.spring.project.vo.Notice;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface EventService {
    boolean newEvent(Event e, MultipartFile[] img);

    List<Event> readEvent(String cp);
    List<Event> readEvent(String cp, String ftype, String fkey);
    List<Event> readAllEvent();
    Event readOneEvent(String bno);

    int countEvent();
    int countEvent(String ftype, String fkey);
    boolean viewCountEvent(String bno);

    void modifyEvent(Event e, String bno, MultipartFile[] img);
    void deleteEvent(String bno);
}
