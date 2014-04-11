module RandomData

  def self.project_names
    project_names = ["Building a 21st Century Veterans Experience", "Data Innovation", "Crowdsourcing"]
    some_projects = project_names.dup
    remove_projects = rand(3)
    while (remove_projects > 0) do
      len = some_projects.length
      some_projects.delete_at(rand(len))
      remove_projects -= 1
    end
    some_projects
  end

  def self.project_reasons
    reasons = []
    self.project_names.each do |name|
      reasons << {name => "#{Faker::Company.bs} and #{Faker::Company.bs}.".capitalize!}
    end
    reasons
  end

end
