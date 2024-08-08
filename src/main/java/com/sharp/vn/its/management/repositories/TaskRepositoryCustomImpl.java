package com.sharp.vn.its.management.repositories;

import com.sharp.vn.its.management.data.TaskData;
import com.sharp.vn.its.management.entity.SystemEntity;
import com.sharp.vn.its.management.entity.TaskEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.*;

import java.time.LocalDateTime;
import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * The type Task repository custom.
 */
public class TaskRepositoryCustomImpl implements TaskRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<TaskData> findTaskBySystem(List<Long> systemIds, List<Integer> years) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);
        Root<SystemEntity> systemRoot = cq.from(SystemEntity.class);
        Join<SystemEntity, TaskEntity> taskJoin = systemRoot.join("tasks");

        cq.multiselect(
                systemRoot.get("id"),
                systemRoot.get("systemName"),
                taskJoin.get("status"),
                cb.count(taskJoin.get("status"))
        );

        List<Predicate> predicates = new ArrayList<>();
        if (!systemIds.isEmpty()) {
            predicates.add(systemRoot.get("id").in(systemIds));
        }
        if (!years.isEmpty()) {
            predicates.add(createYearPredicate(cb, taskJoin, years));
        }

        cq.where(cb.and(predicates.toArray(new Predicate[0])));
        cq.groupBy(systemRoot.get("systemName"), taskJoin.get("status"), systemRoot.get("id"));

        TypedQuery<Object[]> query = entityManager.createQuery(cq);
        return query.getResultList().stream().map(row -> {
            TaskData taskData = new TaskData();
            taskData.setId(((Number) row[0]).longValue());
            taskData.setSystemName((String) row[1]);
            taskData.setStatus(((Number) row[2]).intValue());
            taskData.setTotal(((Number) row[3]).intValue());
            return taskData;
        }).collect(Collectors.toList());
    }

    private Predicate createYearPredicate(CriteriaBuilder cb, Join<?, TaskEntity> taskJoin, List<Integer> years) {
        List<Predicate> yearPredicates = new ArrayList<>();
        years.forEach(t -> {
            final Year year = Year.of(t);
            LocalDateTime startDateTime = year.atDay(1).atStartOfDay();
            LocalDateTime endDateTime = year.atDay(year.length()).atStartOfDay();
            Predicate datePredicate = cb.between(
                    taskJoin.get("expiredDate").as(LocalDateTime.class),
                    startDateTime,
                    endDateTime
            );
            yearPredicates.add(datePredicate);
        });
        return cb.or(yearPredicates.toArray(new Predicate[0]));
    }

    @Override
    public List<TaskData> findTaskSystemByWeek(List<Long> systemIds, List<Integer> years, List<Integer> weeks) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);
        Root<SystemEntity> systemRoot = cq.from(SystemEntity.class);
        Join<SystemEntity, TaskEntity> taskJoin = systemRoot.join("tasks");

        Expression<Integer> week = cb.function("date_part", Integer.class, cb.literal("week"), taskJoin.get("expiredDate"));

        cq.multiselect(
                systemRoot.get("id"),
                systemRoot.get("systemName"),
                week,
                cb.count(systemRoot.get("id"))
        );
        List<Predicate> predicates = new ArrayList<>();
        if (!systemIds.isEmpty()) {
            predicates.add(systemRoot.get("id").in(systemIds));
        }
        if (!years.isEmpty()) {
            predicates.add(createYearPredicate(cb, taskJoin, years));
        }
        if (!weeks.isEmpty()) {
            Predicate weekPredicate = week.in(weeks);
            if (weeks.contains(0)) {
                weekPredicate = cb.or(weekPredicate, cb.isNull(week));
            }
            predicates.add(weekPredicate);
        }
        cq.where(cb.and(predicates.toArray(new Predicate[0])));
        cq.groupBy(systemRoot.get("systemName"), systemRoot.get("id"), week);
        cq.orderBy(
                cb.asc(systemRoot.get("id")),
                cb.asc(week)
        );

        TypedQuery<Object[]> query = entityManager.createQuery(cq);
        return query.getResultList().stream().map(row -> {
                TaskData taskData = new TaskData();
                taskData.setId(((Number) row[0]).longValue());
                taskData.setSystemName((String) row[1]);
                if(row[2] != null)taskData.setWeek(((Number) row[2]).intValue());
                taskData.setTotal(((Number) row[3]).intValue());
                return taskData;
        }).collect(Collectors.toList());
    }
}
