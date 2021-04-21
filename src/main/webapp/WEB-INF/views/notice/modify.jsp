<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="contents">

    <div class="titleArea">
        <h2>NOTICE</h2>
        <p>Dr.Wellmadeone의 공지사항입니다.</p>
    </div>

    <form id="BoardDelForm" name="" action="/exec/front/Board/del/1" method="post" target="_self" enctype="multipart/form-data" >
        <div class="the3-base-table writeType">
            <table border="0" summary="">
                <caption>공지사항 글쓰기</caption>
                <colgroup>
                    <col style="width:130px;"/>
                    <col style="width:auto;"/>
                </colgroup>
                <tbody>
                <tr style="border-bottom: 1px solid #ddd;">
                    <td colspan="2" style="border-bottom:0;color:#000;">
                        제&nbsp;&nbsp;목&nbsp;:&nbsp;<input name="Ntitle" id="Ntitle" title="글제목" maxlength="30" type="text" placeholder="제목을 입력하세요." style="width: 1134px; margin-left: 20px;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="fr-view fr-view-article">
                            내&nbsp;&nbsp;용&nbsp;:&nbsp;<textarea name="Ncontent" id="Ncontent" style="width: 1130px; height: 250px; margin-left: 20px;"></textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="Nimg1" id="Nimg1" accept="image/*">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="Nimg2" id="Nimg2" accept="image/*">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="Nimg3" id="Nimg3" accept="image/*">
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="button_pos">
            <div class="btnArea M b_left">
                <a href="/notice/list" class="black_s">수정취소</a>
            </div>

            <div class="btnArea M b_right">
                <a href="#none" onclick="BOARD_READ.article_delete('BoardDelForm','1');" class="white_s">수정완료</a>
            </div>
        </div>
    </form>
</div>