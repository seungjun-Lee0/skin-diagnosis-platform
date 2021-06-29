package lsj.spring.project.service;

import lsj.spring.project.vo.InquiryReply;

import java.util.List;

public interface InquiryReplyService {

    List<InquiryReply> readReply(String bno);

    boolean newComment(InquiryReply ir);
    boolean modifyComment(InquiryReply ir);
    boolean deleteComment(InquiryReply ir);
    int countComment(String bno);
}
