<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!--
<!%
    String strReferer = request.getHeader("referer");

    if(strReferer == null){
%>
<script language="javascript">
    alert("정상적인 경로를 통해 다시 접근해 주세요.");
    document.location.href="/";
</script>
<!%
        return;
    }
%>
-->

<div id="contents">

    <div class="titleArea">
        <h2><a href="/event/list?cp=1">EVENT</a></h2>
        <p>저희 피부과가 준비한 다양하고 풍성한 이벤트를 확인하세요.</p>
    </div>

    <form id="eventfrm" name="eventfrm">
        <div class="the3-base-table writeType">
            <table border="0" summary="">
                <caption>이벤트 글쓰기</caption>
                <colgroup>
                    <col style="width:130px;"/>
                    <col style="width:auto;"/>
                </colgroup>
                <tbody>
                <tr style="border-bottom: 1px solid #ddd;">
                    <td colspan="2" style="border-bottom:0;color:#000;">
                        제&nbsp;&nbsp;목&nbsp;:&nbsp;<input name="title" id="title" title="글제목" maxlength="30" type="text" placeholder="제목을 입력하세요." style="width: 90%; margin-left: 20px;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="fr-view fr-view-article">
                            내&nbsp;&nbsp;용&nbsp;:&nbsp;<textarea name="content" id="content" style="width: 89.6%; height: 250px; margin-left: 20px;"></textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="fr-view fr-view-article">
                            기간&nbsp;선택&nbsp;:&nbsp;<input type="text" name="sdate" id="sdate" readonly> ~ <input type="text" name="edate" id="edate" readonly>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="img" id="img1" onchange="efileTypeCheck1(this)" accept="image/*">
                        <label for="img1">&nbsp; &blacktriangleleft;썸네일 이미지 (사이즈 : 580 x 210)</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        첨부&nbsp;파일&nbsp;:&nbsp;<input type="file" name="img" id="img2" onchange="efileTypeCheck2(this)" accept="image/*">
                        <label for="img2">&nbsp; &blacktriangleleft;컨텐츠 이미지 (사이즈 : 1280 x &divonx;)</label>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="button_pos">
            <div class="btnArea M b_left">
                <a href="/event/list?cp=1" class="black_s">작성취소</a>
            </div>

            <div class="btnArea M b_right">
                <a id="ewritefrm" class="white_s">작성완료</a>
            </div>
        </div>
        <input type="hidden" id="ftype1" name="ftype1">
        <input type="hidden" id="ftype2" name="ftype2">
    </form>
</div>