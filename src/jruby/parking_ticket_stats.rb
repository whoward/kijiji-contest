# add the source directory to the load path
$:.unshift File.expand_path(File.dirname(__FILE__))

require 'threaded_runner'
require 'threadsafe_group_counter'
require 'summarize_fines_by_street_name'
require 'chunked_io_line_reader'

counter = ThreadsafeGroupCounter.new

reader = ChunkedIoLineReader.new(STDIN)

runner = ThreadedRunner.new(reader, SummarizeFinesByStreetName.new(counter), pool_size: 8)

runner.run!

counter.map