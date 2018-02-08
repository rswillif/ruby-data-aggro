module Jobs
  class Job
    def initialize(title:, location:, description:)
      # only using and storing params needed for assignment deliverable
      @title = title
      @location = location
      @description = description
    end

    def title
      @title
    end

    def location
      location = @location.downcase

      if location.include?('boston')
        location = 'Boston'
      elsif location.include?('san francisco')
        location = 'San_Francisco'.to_sym
      elsif location.include?('los angeles')
        location = 'Los_Angeles'.to_sym
      elsif location.include?('denver')
        location = 'Denver'.to_sym
      elsif location.include?('boulder')
        location = 'Boulder'.to_sym
      elsif location.include?('chicago')
        location = 'Chicago'.to_sym
      elsif location.include?('new york')
        location = 'New_York'.to_sym
      else
        location = nil
      end

      location
    end

    def description
      @description
    end

    # uses basic NLP techniques to try and approximate the experience required
    # for the job ('0-2', '3-5', '5+') being the string returned based on
    # the job's description
    def experience_required
      experience = nil
      description = @description.downcase
      title = @title.downcase

      if description.include?('1+' || '0-2' || 'junior' || 'graduate') ||
         title.include?('junior' || 'entry' || 'graduate')
        experience = 'junior'
      elsif description.include?('3+' || '3-5' || 'mid-level' || 'experienced') ||
            title.include?('mid')
        experience = 'mid'
      elsif description.include?('5+' || '5-7' || 'senior' || 'highly') ||
            title.include?('senior')
        experience = 'senior'
      else
        experience = 'not_specified'
      end

      experience
    end

    # determines whether or not a job's description mentions/uses
    # one of a collection of popular languages
    def languages_required
      possible_languages = {
        java: nil,
        javascript: nil,
        ruby: nil,
        python: nil,
        scala: nil,
        clojure: nil,
        go: nil,
        node: nil
      }
      description = @description.downcase

      possible_languages.each do |language, value|
        if description.include?(language.to_s)
          possible_languages[language] = true
        else
          possible_languages[language] = false
        end
      end

      possible_languages
    end
  end
end
