require 'json'
require 'net/http'
require 'socket'
require './modules/process_data'
require './modules/jobs_test'


# performs GET request on jobs endpoint
def get_job_data
  url = 'https://jobs.github.com/positions.json'
  uri = URI(url)
  response = Net::HTTP.get(uri)

  return JSON.parse(response) # returns array of job hashes
end

# executes all "sub-tasks" of program
def run_all_the_things
  include JobsTest

  jobs_data = get_job_data
  frequencies = ProcessData.process_response(jobs_data)
  # print_all_data(frequencies)
  # print test results

  server = TCPServer.new('localhost', 8080)

  loop do
    socket = server.accept
    request = socket.gets
    STDERR.puts(request)

    socket.print(ProcessData.print_all_data(frequencies))
    socket.print("\n")
    socket.print("Sourced: #{jobs_data.length} job postings\n")
    socket.print("------------------------------------------------------------")
    socket.print("\n")
    socket.print("\n")
    if assert_tests_success
      socket.print("Testing: All tests passed.")
    else
      socket.print("Testing: One or more tests failed.")
    end
    socket.print("\n")
    socket.print("\n")
  end
end

# runs the program
run_all_the_things
