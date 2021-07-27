package gz.sw.mapper.write;

import gz.sw.entity.write.RainRun;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RainRunDao {
	RainRun select(Integer id);
	int insert(RainRun rainRun);
	int update(RainRun rainRun);
	int delete(Integer id);

	int selectCount(@Param("sttp") String sttp, @Param("stcd") String stcd, @Param("name") String name);
    List selectList(@Param("page") Integer page, @Param("limit") Integer limit, @Param("sttp") String sttp, @Param("stcd") String stcd, @Param("name") String name);
	List selectListByStcd(String stcd);
	List selectRainRunPoint(Integer rainRun);
	List selectPointList(Integer pid);
}
