CREATE DATABASE haebeop_personal;

USE haebeop_personal;

CREATE TABLE member(
	id VARCHAR(20) PRIMARY KEY,							-- 회원 아이디
	pw VARCHAR(500) NOT NULL,								-- 회원 비밀번호
	nm VARCHAR(50) NOT NULL,								-- 회원 이름
	email VARCHAR(50) NOT NULL,							-- 회원 이메일
	tel VARCHAR(20) NOT NULL,								-- 회원 전화번호
	addr1 VARCHAR(200),										-- 회원 주소
	addr2 VARCHAR(100),										-- 회원 상세 주소
	postcode VARCHAR(10),									-- 회원 우편 번호
	regDate DATETIME DEFAULT CURRENT_TIMESTAMP(),	-- 회원 등록일
	birth DATE,													-- 회원 생일
	pt INT DEFAULT 0,											-- 회원 포인트
	visited INT DEFAULT 0,									-- 회원 방문수
	useYn BOOLEAN DEFAULT TRUE,							-- 회원 사용 여부
	grade INT DEFAULT 2										-- 회원 등급 [ 0 : 관리자, 1 : 미정, 2 : 일반사용자]
);

INSERT INTO MEMBER VALUES('admin', '$2a$10$HwmRQwO14K/q/8/PeqWrXepqcA9PGnOvhy2uINmX8xi418.JlAvMW', '관리자', 'admin@haebeop.ed.kr', '010-2121-2121', '', '', '', DEFAULT, NULL, DEFAULT, DEFAULT, DEFAULT, 0);

CREATE TABLE boardMgn(
	bmNo INT AUTO_INCREMENT PRIMARY KEY,	-- 게시판 번호 : 자동 발생
	boardNm VARCHAR(100) NOT NULL,			-- 게시판 이름
	aboutAuth INT NOT NULL,						-- 게시판 글쓰기, 수정, 삭제 관련 권한 (일반사용자 기본)
	commentUse BOOLEAN DEFAULT FALSE,		-- 게시판 댓글 사용 유무
	fileUse BOOLEAN DEFAULT FALSE				-- 게시판 파일 사용 유무
);

SELECT * FROM boardmgn;

CREATE TABLE board(
	bno INT PRIMARY KEY AUTO_INCREMENT,   							-- 게시글 번호 : 자동 발생
	bmNo INT NOT NULL,   												-- 게시글 타입 
	title VARCHAR(200) NOT NULL,   									-- 게시글 제목
	content VARCHAR(1000),   											-- 게시글 내용
	author VARCHAR(20) NOT NULL,   									-- 작성자
	resDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,   	-- 등록일
	visited INT DEFAULT 0   											-- 조회수
);

CREATE VIEW boardList AS (SELECT b.bno AS bno, b.bmNo AS bmNo, b.title AS title, b.content AS content, b.author AS author, b.resDate AS resDate, b.visited as visited,bm.boardNm AS boardNm, m.nm AS nm, bm.aboutAuth AS aboutAuth, bm.commentUse AS commentUse, bm.fileUse AS fileUse FROM board b, member m, boardMgn bm WHERE b.author = m.id AND bm.bmNo = b.bmNo order BY b.bno ASC);

CREATE TABLE comment(
   cno INT PRIMARY KEY AUTO_INCREMENT,   							-- 댓글번호: 자동발생
	author VARCHAR(20) NOT NULL,   									-- 댓글 작성자
	content VARCHAR(1000) NOT NULL,   								-- 댓글 내용
	resDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,   	-- 댓글 등록일
	par INT NOT NULL   													-- 해당 게시글 번호
);

CREATE VIEW commentList AS (SELECT c.cno AS cno, c.author AS author, c.content AS content, c.resDate AS resDate, c.par AS par, m.nm AS nm FROM comment c, member m WHERE c.author = m.id order BY c.cno ASC);

CREATE TABLE files(
	fno INT PRIMARY KEY AUTO_INCREMENT,   							-- 파일번호: 자동발생
	par INT NOT NULL,   													-- 해당 게시글 번호
	saveFolder VARCHAR(1000) NOT NULL,								-- 파일 저장 폴더
	originNm VARCHAR(500) NOT NULL,									-- 파일 원래 이름
	saveNm VARCHAR(500) NOT NULL,										-- 파일 저장 이름
	fileType VARCHAR(100) NOT NULL,									-- 파일 확장자
	uploadDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP	-- 파일 업로드 일자
);

CREATE TABLE qna(
	qno INT PRIMARY KEY AUTO_INCREMENT,   					-- 문의번호 : 자동발생
	title VARCHAR(100) NOT NULL,   							-- 문의 제목
	content VARCHAR(1000) NOT NULL,   						-- 문의 내용
	answer VARCHAR(1000),   									-- 답변 내용
	author VARCHAR(20) NOT NULL,   							-- 문의 작성자
	resDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),   	-- 문의 등록일자
	answerDate TIMESTAMP,   									-- 답변 등록일자
	answerYn BOOLEAN DEFAULT FALSE 							-- 질문(0), 답변(1)
);

CREATE VIEW qnaList AS (SELECT q.qno AS qno, q.title AS title, q.content AS content, q.answer AS answer, q.author AS author, q.resDate AS resDate, q.answerDate AS answerDate, q.answerYn AS answerYn, m.nm AS nm FROM qna q, member m WHERE q.author = m.id order BY q.qno ASC);