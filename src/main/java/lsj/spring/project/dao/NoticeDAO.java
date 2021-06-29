package lsj.spring.project.dao;

import lsj.spring.project.vo.Notice;

import java.util.List;
import java.util.Map;

public interface NoticeDAO {

    int insertNotice(Notice n);

    List<Notice> selectNotice(int snum);
    List<Notice> selectAllNotice();
    List<Notice> findSelectNotice(Map<String, Object> param);
    Notice selectOneNotice(String bno);

    int selectCountNotice();
    int selectCountNotice(Map<String, Object> param);
    int viewCountNotice(String bno);
    int modifyNotice(Notice n);
    int deleteNotice(String bno);

    String readFnames(String bno);
    String readUuid(String bno);
}
