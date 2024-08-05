package com.sharp.vn.its.management.repositories;

import com.sharp.vn.its.management.data.ChartData;
import com.sharp.vn.its.management.entity.SystemEntity;
import com.sharp.vn.its.management.entity.TaskEntity;
import com.sharp.vn.its.management.entity.UserEntity;
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
    public List<ChartData> findTaskBySystem(List<Long> systemIds, List<Integer> years) {
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
            ChartData chartData = new ChartData();
            chartData.setId(((Number) row[0]).longValue());
            chartData.setSystemName((String) row[1]);
            chartData.setStatus(((Number) row[2]).intValue());
            chartData.setTotal(((Number) row[3]).intValue());
            return chartData;
        }).collect(Collectors.toList());
    }

    //findTotalEffortSystemByWeek
    @Override
    public List<ChartData> findTotalEffortSystemByWeek(List<Long> systemIds, List<Integer> years, List<Integer> weeks) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);
        Root<SystemEntity> systemRoot = cq.from(SystemEntity.class);
        Join<SystemEntity, TaskEntity> taskJoin = systemRoot.join("tasks");

        Expression<Integer> week = cb.function("date_part", Integer.class, cb.literal("week"), taskJoin.get("expiredDate"));
        // Select clause
        cq.multiselect(
                        systemRoot.get("id"),
                        systemRoot.get("systemName"),
                        week,
                        cb.sum(systemRoot.get("id"))

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
            predicates.add(weekPredicate);
        }
        cq.where(cb.and(predicates.toArray(new Predicate[0])));
        cq.groupBy(systemRoot.get("systemName"),systemRoot.get("id"), week);
        cq.orderBy(
                cb.asc(systemRoot.get("id")),
                cb.asc(week)
        );

        TypedQuery<Object[]> query = entityManager.createQuery(cq);
        query.getResultList();
        return query.getResultList().stream().map(row -> {
            ChartData chartData = new ChartData();
            chartData.setId(((Number) row[0]).longValue());
            chartData.setSystemName((String) row[1]);
            chartData.setWeek(row[2] != null ? ((Number) row[2]).intValue() : 0);
            chartData.setTotal(row[3] != null ? ((Number) row[3]).intValue() : 0);
            return chartData;
        }).collect(Collectors.toList());
    }


    @Override
    public List<ChartData> findTaskSystemByWeek(List<Long> systemIds, List<Integer> weeks) {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> cq = cb.createQuery(Object[].class);
        Root<SystemEntity> systemRoot = cq.from(SystemEntity.class);
        Join<SystemEntity, TaskEntity> taskJoin = systemRoot.join("tasks");

        // Extract week from expiredDate
        Expression<Integer> week = cb.function("date_part", Integer.class, cb.literal("week"), taskJoin.get("expiredDate"));

        // Select clause
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
        if (!weeks.isEmpty()) {
            List<Predicate> weekPredicates = new ArrayList<>();
            weeks.forEach(w -> {
                Predicate weekPredicate = cb.equal(week, w);
                weekPredicates.add(weekPredicate);
            });
            predicates.add(cb.or(weekPredicates.toArray(new Predicate[0])));
        }

        cq.where(cb.and(predicates.toArray(new Predicate[0])));
        cq.groupBy(systemRoot.get("systemName"), systemRoot.get("id"), week);
        cq.orderBy(
                cb.asc(systemRoot.get("id")),
                cb.asc(week)
        );

        TypedQuery<Object[]> query = entityManager.createQuery(cq);
        return query.getResultList().stream().map(row -> {
            ChartData chartData = new ChartData();
            chartData.setId(((Number) row[0]).longValue());
            chartData.setSystemName((String) row[1]);
            chartData.setWeek(row[2] != null ? ((Number) row[2]).intValue() : 0);
            chartData.setTotal(row[3] != null ? ((Number) row[3]).intValue() : 0);
            return chartData;
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
}