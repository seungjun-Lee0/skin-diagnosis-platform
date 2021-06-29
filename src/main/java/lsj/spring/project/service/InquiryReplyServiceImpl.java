package lsj.spring.project.service;

import lsj.spring.project.dao.InquiryReplyDAO;
import lsj.spring.project.vo.InquiryReply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("irsrv")
public class InquiryReplyServiceImpl implements InquiryReplyService{

    @Autowired private InquiryReplyDAO irdao;

    @Override
    public List<InquiryReply> readReply(String bno) {
        return irdao.selectReply(bno);
    }

    @Override
    public boolean newComment(InquiryReply ir) {
        boolean isIncerted = false;
        if(irdao.insertComment(ir) > 0){
            isIncerted = true;
        }
        return isIncerted;
    }

    @Override
    public boolean modifyComment(InquiryReply ir) {
        boolean isModified = false;
        if(irdao.updateComment(ir) > 0){
            isModified = true;
        }
        return isModified;
    }

    @Override
    public boolean deleteComment(InquiryReply ir) {
        boolean isDeleted = false;
        if(irdao.deleteComment(ir) > 0){
            isDeleted = true;
        }
        return isDeleted;
    }

    @Override
    public int countComment(String bno) {
        return irdao.countComment(bno);
    }
}
