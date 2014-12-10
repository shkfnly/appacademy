class Student
  attr_reader :courses

  def initialize(firstname, lastname)
    @firstname, @lastname = firstname, lastname
    @courses = []
  end

  def name
    @firstname + ' ' + @lastname
  end

  def enroll(course_obj)
    # raise
    unless courses.include?(course_obj) || has_conflict?(course_obj)
      @courses << course_obj
      course_obj.add_student(self)
    end
  end

  def course_load
    schedule_load = Hash.new(0)
    @courses.each do |hash|
      schedule_load[hash.department] += hash.num_credits
    end
    schedule_load
  end

  def has_conflict?(course_obj)
    @courses.any? { |x| x.conflicts_with?(course_obj) }
  end
end

class Course
  attr_reader :name, :department, :num_credits, :time_block, :days_of_week

  def initialize(name, department, num_credits, time_block, days_of_week)
    @course_name, @department, @num_credits, @time_block, @days_of_week =
      name, department, num_credits, time_block, days_of_week
    @enrolled = []
  end

  def add_student(student_obj)
    @enrolled << student_obj unless @enrolled.include?(student_obj)
  end

  def students
    @enrolled
  end

  def conflicts_with?(course)
    if (self.days_of_week & course.days_of_week).empty?
      return false
    end

    self.time_block == course.time_block
  end
end

cs101 = Course.new("Intro to CS", "Computer Science", 3, [8], [:mon, :wed, :fri])
cs201 = Course.new("Intro to CS II", "Computer Science", 3, [8], [:tue, :thu])

puts cs101.conflicts_with?(cs201)
