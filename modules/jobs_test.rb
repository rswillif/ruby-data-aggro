require './modules/jobs'

module JobsTest
  include Jobs

  def test_job_initialize
    job = Job.new(title: 'Junior Developer',
                  location: 'New York, NY',
                  description: 'Python node scala stuff junior 1+ years')

    return job.title.eql?('Junior Developer') &&
           job.location == :New_York &&
           job.description.eql?('Python node scala stuff junior 1+ years')
  end

  # this test is redundant to the test above, but is included for testing
  # each function outside of those returning exlicit instance vars for more
  # 'complete' coverage
  def test_job_location
    job = Job.new(title: 'Senior Developer',
                  location: 'San Francisco, CA',
                  description: 'Python node scala stuff senior 5+ years')

    return job.location == :San_Francisco
  end

  def test_job_experience_required
    job = Job.new(title: 'Senior Developer',
                  location: 'San Francisco, CA',
                  description: 'Python node scala stuff senior 5+ years')

    return job.experience_required.eql?('senior')
  end

  def test_job_languages_required
    job = Job.new(title: 'Senior Developer',
                  location: 'San Francisco, CA',
                  description: 'Python node scala stuff senior 5+ years')

    return job.languages_required[:python] == true &&
           job.languages_required[:node] == true &&
           job.languages_required[:scala] == true
  end

  def assert_tests_success
    return test_job_initialize && test_job_location &&
           test_job_experience_required && test_job_languages_required
  end

  module_function :test_job_initialize
  module_function :test_job_location
  module_function :test_job_experience_required
  module_function :test_job_languages_required
  module_function :assert_tests_success
end
