package lsj.spring.project.dao;

import lsj.spring.project.vo.InquiryReply;

import java.util.List;

public interface InquiryReplyDAO {

    List<InquiryReply> selectReply(String bdno);

    int insertComment(InquiryReply ir);
    int updateComment(InquiryReply ir);
    int deleteComment(InquiryReply ir);
    int countComment(String bno);
}
