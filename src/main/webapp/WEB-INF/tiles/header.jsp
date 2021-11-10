<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- header -->
<div id="header">
    <!-- 헤더 이너 -->
    <div class="header_inner">

        <!-- 메인 카테고리 메뉴 -->
        <div class="util_left">
            <div id="category" class="xans-element- xans-layout xans-layout-category">
                <div class="position">
                    <ul>
                        <li><a id="skinDiagnosis" href="/diagnosis/intro">SKIN DIAGNOSIS</a></li>
                        <li><a id="event" href="/event/list?cp=1">EVENT</a></li>
                        <li><a id="notice" href="/notice/list?cp=1">NOTICE</a></li>
                        <li><a id="inquiry" href="/inquiry/list?cp=1">1:1 문의</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 회원 -->
        <div class="util_right">
            <style>
                #chk1 { position: absolute; left: 3000%}
                #chk1 + #chk1Label { overflow: hidden; display: inline-block; position: relative; width: 60px;
                height: 30px; background: #749DFF; box-shadow: 1px 1px 0.5px 1px; border-radius: 30px; transition: all 0.5s; }
                #chk1 + #chk1Label:before { content: url("https://img.cafe24.com/img/common/global/ko_KR_16x12.png"); position: absolute; right: 3px; top: 3px; width: 24px;
                height: 24px; background: #fff; border-radius: 30px; line-height: 26px; text-indent: -26px; transition: all 0.5s; }
                #chk1:checked + #chk1Label:before { right: 33px;}
                #chk1:checked + #chk1Label {background: #a36c6c;}
                #chk1 + #chk1Label:after { content: url("https://img.cafe24.com/img/common/global/zh_CN_16x12.png"); position: absolute; right: -100px; top: 2px; color: #fff; line-height: 28px; transition: all 0.5s;}
                #chk1:checked + #chk1Label:after { right: 6px;}
            </style>
            <div class="loginoff "><ul>
                <div style="position: absolute; bottom: 21px; left: -70px">
                    <input type="checkbox" id="chk1"><label id="chk1Label" for="chk1"></label>
                </div>
                <li>
                    <a href="/admin/main">VALUE LOG</a>
                </li>
                <c:if test="${empty sessionScope.MyInfo}">
                    <li><a href="/member/login">LOGIN</a></li>
                    <li><a href="/member/regAgree">JOIN US</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.MyInfo}">
                    <li><a href="/mypage/myInfo">MY PAGE</a></li>
                    <li><a href="/member/logout">LOGOUT</a></li>
                </c:if>
            </ul>
            </div>
        </div>

        <!-- 상단 로고 -->
        <div><a href="/"><img src="/images/logo/main_logo.png" style="margin-top:20px;max-height:60px;" alt="the 3.0"/></a>
        </div>


    </div>
</div>

<!-- mobile header -->
<header class="mob_header">
    <h1 class='logo'><a href="/"><img src="/images/logo/main_logo.png" alt="" style="width: 65%"/></a></h1>
    <div class="mo_right" style="display: none;">
        <p onclick="ShowMenu()"></p>
        <div class="menu_opacity">
            <div class="menu_bg">
                <div class="menu">
                    <div onclick="HideMenu()" class="closeBtn"><img src="" alt="닫기" /></div>
                    <div class="menuAll">
                        <ul>
                            <li class="li_1"><a href="#none">솔루션 프라이빗 클리닉</a>
                                <div class="subMenu hide">
                                    <ul>
                                        <li><a href="/ck_Sub/Menu_1.php?hCode=subMenu_1_1"><span class="txtDeco">Dr. Sollution</span></a></li>
                                        <li><a href="/ckBoard/ckBoard.php?boIdx=6%2FajqK1IPxB08jffavUxgA%3D%3D"><span class="txtDeco">Dr. Sollution의 유튜브</span></a></li>
                                        <li><a href="/ck_Sub/Menu_1.php?hCode=subMenu_1_2"><span class="txtDeco">프라이빗 시스템</span></a></li>
                                        <li><a href="/ck_Sub/Menu_1.php?hCode=subMenu_1_3"><span class="txtDeco">진료시간</a></li>
                                        <li><a href="/ck_Sub/Menu_1.php?hCode=subMenu_1_4"><span class="txtDeco">솔루션소식 & 이벤트솔루션</span></a></li>
                                    </ul>
                                </div>
                            </li>
                            <!-- <li class="li_2"><a href="#none">안티에이징 밸런스 시스템</a>
                                <div class="subMenu hide">
                                    <ul>
                                        <li><a href="/ck_Sub/Menu_2.php?hCode=subMenu_2_1"><span class="txtDeco">안티에이징 밸런스 시스템이란?</span></a></li>
                                    </ul>
                                </div>
                            </li> -->
                            <li class="li_3"><a href="#none">시그니처 프로그램</a>
                                <div class="subMenu hide">
                                    <ul>
                                        <li><a href="/ck_Sub/Menu_3.php?hCode=subMenu_3_1#tab1"><span class="txtDeco">비대칭 교정 프로그램</span></a></li>
                                        <li><a href="/ck_Sub/Menu_3.php?hCode=subMenu_3_1#tab2"><span class="txtDeco">탄력 & 리프팅 프로그램</span></a></li>
                                        <li><a href="/ck_Sub/Menu_3.php?hCode=subMenu_3_1#tab3"><span class="txtDeco">줄기세포 & 항노화 프로그램</span></a></li>
                                        <li><a href="/ck_Sub/Menu_3.php?hCode=subMenu_3_1#tab4"><span class="txtDeco">갸르미 주사</span></a></li>
                                        <li><a href="/ck_Sub/Menu_3.php?hCode=subMenu_3_1#tab5"><span class="txtDeco">마르니 주사</span></a></li>
                                        <li><a href="/ck_Sub/Menu_3.php?hCode=subMenu_3_1#tab6"><span class="txtDeco">목주름 프로그램</span></a></li>
                                    </ul>
                                </div>
                            </li>
                            <li class="li_4"><a href="#none">리프팅 탄력 프로그램</a>
                                <div class="subMenu hide">
                                    <ul>
                                        <li><a href="/ck_Sub/Menu_4.php?hCode=subMenu_4_1_1"><span class="txtDeco">밸런스 리프팅 시스템</span></a></li>
                                        <li><a href="/ck_Sub/Menu_4.php?hCode=subMenu_4_1_3"><span class="txtDeco">리프팅 레이저</span></a></li>
                                        <li><a href="/ck_Sub/Menu_4.php?hCode=subMenu_4_1_2"><span class="txtDeco">실 리프팅</span></a></li>
                                        <li><a href="void(0)" onclick="alert('준비중입니다.');return false;"><span class="txtDeco">필러 · 보톡스</span></a></li>
                                        <li><a href="/ck_Sub/Menu_4.php?hCode=subMenu_4_2_1"><span class="txtDeco">스킨 부스터</span></a></li>
                                        <li><a href="/ck_Sub/Menu_4.php?hCode=subMenu_4_2_4"><span class="txtDeco">스킨 케어</span></a></li>
                                    </ul>
                                </div>
                            </li>
                            <li class="li_5"><a href="#none">피부과시술</a>
                                <div class="subMenu hide">
                                    <div class="half left one">
                                        <h3><span>쁘띠 솔루션</span></h3>
                                        <ul>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_1_2"><span class="txtDeco">입꼬리 · 입술 · 턱끝 필러</span></a></li>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_1_3"><span class="txtDeco">하이코</span></a></li>
                                        </ul>
                                    </div>
                                    <div class="half">
                                        <h3><span>safe 줄기세포 솔루션</span></h3>
                                        <ul>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_2_1"><span class="txtDeco">safe 줄기세포 안티에이징</span></a></li>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_2_2"><span class="txtDeco">지방 줄기세포</span></a></li>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_2_3"><span class="txtDeco">혈액 줄기세포</span></a></li>
                                        </ul>
                                    </div>
                                    <div class="half left">
                                        <h3><span>레이저 솔루션</span></h3>
                                        <ul>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_3_1"><span class="txtDeco">색소 침착</span></a></li>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_3_2"><span class="txtDeco">여드름</span></a></li>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_3_3"><span class="txtDeco">모공 · 흉터</span></a></li>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_3_4"><span class="txtDeco">홍조 · 혈관</span></a></li>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_3_5"><span class="txtDeco">제모</span></a></li>
                                        </ul>
                                    </div>
                                    <div class="half">
                                        <h3><span>바디 다이어트 솔루션</span></h3>
                                        <ul>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_4_1"><span class="txtDeco">슬리밍 프로그램</span></a></li>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_4_2"><span class="txtDeco">지방 분해 주사</span></a></li>
                                            <li><a href="void(0);" onclick="alert('준비중입니다.');return false;"><span class="txtDeco">바디 보톡스</span></a></li>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_4_3"><span class="txtDeco">복합 바디 관리</span></a></li>
                                        </ul>
                                    </div>
                                    <div class="half left">
                                        <h3><span>옴므 솔루션</span></h3>
                                        <ul>
                                            <li><a href="/ck_Sub/Menu_5.php?hCode=subMenu_5_5_1"><span class="txtDeco">옴므 솔루션</span></a></li>
                                        </ul>
                                    </div>
                                    <div class="half">
                                        <h3><span>수액 솔루션</span></h3>
                                        <ul>
                                            <li><a href="void(0);" onclick="alert('준비중입니다.');return false;"><span class="txtDeco">안티에이징 수액 치료</span></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li class="li_6"><a href="#none">후기 · 상담</a>
                                <div class="subMenu hide">
                                    <ul>
                                        <li><a href="/ck_Sub/Menu_6.php?hCode=subMenu_6_1"><span class="txtDeco">전후 사진 비교</span></a></li>
                                        <li><a href="javascript:quickConsultOpen()"><span class="txtDeco">솔루션클리닉 빠른상담</span></a></li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        // mobile 전체메뉴
        $(".menuAll li a").click(function() {

            if($(this).next(".subMenu").hasClass('hide')) {
                $(".subMenu").addClass('hide').slideUp();

            }

            var subMenu =$(this).next(".subMenu").slideToggle();
            if($(subMenu).hasClass('hide')) {

                $(subMenu).removeClass('hide').slideDown();

            }
            else {
                $(subMenu).addClass('hide').slideUp();

            }

        });
    </script>
</header>