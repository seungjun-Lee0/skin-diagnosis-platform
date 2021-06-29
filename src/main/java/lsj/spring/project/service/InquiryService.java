package lsj.spring.project.service;


import lsj.spring.project.vo.Inquiry;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface InquiryService {

    boolean newInquiry(Inquiry iq, MultipartFile[] img);

    List<Inquiry> readInquiry(String cp);
    List<Inquiry> readInquiry(String cp, String bno);
    List<Inquiry> readInquiry(String cp, String ftype, String fkey);
    List<Inquiry> readAllInquiry();
    Inquiry readOneInquiry(String bno);

    int countInquiry();
    int countInquiry(String uid);
    int countInquiry(String ftype, String fkey);
    int checkSecretInquiry(String bno, String pwd);

    boolean viewCountInquiry(String bno);

    void modifyInquiry(Inquiry iq, String bno, MultipartFile[] img);
    void deleteInquiry(String bno);
    void updateComment(int bno, int countComment);
    void updateStatus(String bno);
}
