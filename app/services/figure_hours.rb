class FigureHours

  def self.call(grouped_jobs)

    @total_hours = {}

    grouped_jobs.each do |month, jobs|
      total_hours = 0
      jobs.each do |job|
        total_hours += job.job_actual_hours
      end
      @total_hours[month] = total_hours
    end

    return @total_hours
  end
end
