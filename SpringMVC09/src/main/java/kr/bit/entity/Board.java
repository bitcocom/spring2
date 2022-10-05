package kr.bit.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	  private int idx; // 번호
	  private String memID; // 회원ID
	  private String title; // 제목
	  private String content; // 내용
	  private String writer; // 작성자
	  private Date indate; // 작성일
	  private int count; // 조회수
	  private int boardGroup; // 부모글과 답글을 묶는 역할
	  private int boardSequence; // 답글의 순서
	  private int boardLevel; // 답글의 레벨(들여쓰기)
	  private int boardAvailable; // 삭제된 글인지 여부
}
