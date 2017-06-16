class Student
  attr_reader :first_name, :last_name, :courses
    
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end
  
  def name
    "#{first_name} #{last_name}"  
  end
  
  def enroll(course)
    raise "conflicts with other courses" if has_conflict?(course)
    unless courses.include?(course)
      courses << course
      course.students << self
    end
  end
  
  def course_load
    creds_by_dept = Hash.new(0)
    courses.each { |course| creds_by_dept[course.department] += course.credits }
    creds_by_dept
  end
  
  def has_conflict?(new_course)
    courses.any? { |old_course| new_course.conflicts_with?(old_course) }
  end
  
end
