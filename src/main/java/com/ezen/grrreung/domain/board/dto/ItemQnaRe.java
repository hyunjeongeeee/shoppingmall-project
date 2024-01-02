package com.ezen.grrreung.domain.board.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ItemQnaRe {
  private int qnaCode;
  private int reCode;
  private String reCont;
  private String reDate;

}
