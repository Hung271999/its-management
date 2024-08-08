package com.sharp.vn.its.management.repositories;

import com.sharp.vn.its.management.data.TaskData;

import java.util.List;

/**
 * The interface Task repository custom.
 */
public interface TaskRepositoryCustom {
    /**
     * Find task group by system name and status list.
     *
     * @param SystemIds the system ids
     * @param years     the years
     * @return the list
     */
    List<TaskData> findTaskBySystem(List<Long> SystemIds, List<Integer> years);
    List<TaskData> findTaskSystemByWeek(List<Long> systemIds, List<Integer> weeks);
    List<TaskData> findTotalEffortSystemByWeek(List<Long> systemIds, List<Integer> years, List<Integer> weeks);
}
