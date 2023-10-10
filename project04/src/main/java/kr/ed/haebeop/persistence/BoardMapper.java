package kr.ed.haebeop.persistence;

import kr.ed.haebeop.domain.Board;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    public List<Board> boardList();

}