package lsj.spring.project.service;

import lsj.spring.project.dao.NoticeDAO;
import lsj.spring.project.vo.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("nsrv")
public class NoticeServiceImpl implements  NoticeService{

    @Autowired
    private NoticeDAO ndao;

    @Override
    public boolean newNotice(Notice n) {
        return false;
    }

    @Override
    public List<Notice> readNotice(String cp) {
        return null;
    }

    @Override
    public List<Notice> readNotice(String cp, String ftype, String fkey) {
        return null;
    }

    @Override
    public Notice readOneNotice(String bno) {
        return null;
    }

    @Override
    public int countNotice() {
        return 0;
    }

    @Override
    public int countNotice(String ftype, String fkey) {
        return 0;
    }

    @Override
    public boolean viewCountNotice(String bno) {
        return false;
    }

    @Override
    public String readPrvbno(String bno) {
        return null;
    }

    @Override
    public String readNxtbno(String bno) {
        return null;
    }
}
