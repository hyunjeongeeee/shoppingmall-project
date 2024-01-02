package com.ezen.grrreung.domain.board.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ItemQna {
  private int qnaCode;
  private int itemId;
  private String qnaTitle;
  private String qnaCont;
  private String qnaDate;
  private String memberId;


}
