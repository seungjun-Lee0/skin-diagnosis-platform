package lsj.spring.project.dao;

import lsj.spring.project.vo.Inquiry;

import java.util.List;
import java.util.Map;

public interface InquiryDAO {

    int insertInquiry(Inquiry iq);

    List<Inquiry> selectInquiry(int snum);
    List<Inquiry> selectInquiry(int snum, String bno);
    List<Inquiry> selectAllInquiry();
    List<Inquiry> findSelectInquiry(Map<String, Object> param);
    Inquiry selectOneInquiry(String bno);

    int selectCountInquiry();
    int selectCountInquiryByUid(String uid);
    int selectCountInquiry(Map<String, Object> param);
    int checkSecretInquiry(String bno, String pwd);

    int viewCountInquiry(String bno);
    int modifyInquiry(Inquiry n);
    int deleteInquiry(String bno);

    String readFnames(String bno);
    String readUuid(String bno);

    void updateComment(int bno, int countComment);
    void updateStatus(String bno);
}
