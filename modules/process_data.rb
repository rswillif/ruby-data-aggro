require './modules/jobs'

module ProcessData
  include Jobs

  # this funcion operates on the value of a hash of programming language/frequency pairs
  # to return the percentage using the job total and frequency as a string
  def job_percentage(frequency, total)
    (frequency.to_f / total.to_f * 100.0).to_i.to_s << '%'
  end

  # explicit hash definitions used for readability and outlining of
  # data processing breakdown
  def language_frequencies
    return {
      java: { junior: 0, mid: 0, senior: 0, total: 0 },
      javascript: { junior: 0, mid: 0, senior: 0, total: 0 },
      ruby: { junior: 0, mid: 0, senior: 0, total: 0 },
      python: { junior: 0, mid: 0, senior: 0, total: 0 },
      scala: { junior: 0, mid: 0, senior: 0, total: 0 },
      clojure: { junior: 0, mid: 0, senior: 0, total: 0 },
      go: { junior: 0, mid: 0, senior: 0, total: 0 },
      node: { junior: 0, mid: 0, senior: 0, total: 0 }
    }
  end

  # explicit hash definition used for same reasons as above :P
  def language_distributions
    return {
      Boston: language_frequencies,
      San_Francisco: language_frequencies,
      Los_Angeles: language_frequencies,
      Denver: language_frequencies,
      Boulder: language_frequencies,
      Chicago: language_frequencies,
      New_York: language_frequencies
    }
  end

  # processes json response as hash and returns hash of language/frequency
  # pairs for a particular location
  def process_response(jobs_data)
    location_distributions = language_distributions

    jobs_data.each do |job_hash|
      job = Job.new(title: job_hash['title'],
                    location: job_hash['location'],
                    description: job_hash['description'])
      job_languages = job.languages_required
      job_experience = job.experience_required.to_sym

      # iterate through job_hash and determine if the location
      # is one of the locations of interest
      if location_distributions[job.location]
        # determine languages and update data for location
        # if location is a city of interest
        job_languages.each do |key, value|
          if value == true
            # checking if experience level was found
            if location_distributions[job.location][key][job_experience]
              location_distributions[job.location][key][job_experience] += 1
            end

            location_distributions[job.location][key][:total] += 1
          end
        end
      end
    end

    # now we have the jobs per location broken down by language and experience levels
    location_distributions
  end

  # prints distribution data for a city
  # meant to be executed on city data for each city
  # in the process_response's return value
  def print_city_data(location, location_sub_hash)
    return_string = "#{location.to_s}: \n"
    # print with new lines each city's info
    location_sub_hash.each do |key, value|
      return_string << "\t- #{key.to_s} \n"

      if value[:junior] > 0
        return_string << "\t\t- 0-2 years of experience: #{job_percentage(value[:junior], value[:total])}\n"
      else
        return_string << "\t\t- 0-2 years of experience: 0%\n"
      end
      if value[:mid] > 0
        return_string << "\t\t- 3-5 years of experience: #{job_percentage(value[:mid], value[:total])}\n"
      else
        return_string << "\t\t- 3-5 years of experience: 0%\n"
      end
      if value[:senior] > 0
        return_string << "\t\t- 5+ years of experience: #{job_percentage(value[:senior], value[:total])}\n"
      else
        return_string << "\t\t- 5+ years of experience: 0%\n"
      end
    end

    return_string
  end

  # iterates through location location_distributions and executes
  # print_city_data on each city/key of the hash
  def print_all_data(location_distributions)
    return_string = "\n"
    location_distributions.each do |key, value|
      return_string << print_city_data(key, value)
    end

    return_string
  end

  module_function :job_percentage
  module_function :language_frequencies
  module_function :language_distributions
  module_function :process_response
  module_function :print_city_data
  module_function :print_all_data
end
