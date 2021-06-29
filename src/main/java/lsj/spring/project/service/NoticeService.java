package lsj.spring.project.service;

import lsj.spring.project.vo.Notice;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface NoticeService {

    boolean newNotice(Notice n, MultipartFile[] img);

    List<Notice> readNotice(String cp);
    List<Notice> readNotice(String cp, String ftype, String fkey);
    List<Notice> readAllNotice();
    Notice readOneNotice(String bno);

    int countNotice();
    int countNotice(String ftype, String fkey);
    boolean viewCountNotice(String bno);

    void modifyNotice(Notice n, String bno, MultipartFile[] img);
    void deleteNotice(String bno);
}
