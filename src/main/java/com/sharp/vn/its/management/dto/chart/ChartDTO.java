package com.sharp.vn.its.management.dto.chart;

import lombok.Data;

import java.util.List;

/**
 * The type Data dto.
 */
@Data
public class ChartDTO {
    private List<DataItemChart> data;
    private TotalItemChart total;

    public ChartDTO(TotalItemChart total, List<DataItemChart> data) {
        this.total = total;
        this.data = data;
    }
}